%% Function Description
% This function computes the bulk vehicle dynamics stuff.
%
% Input: 
% s: state vector [22 1]
% model: vehicle model constants
%
% Output:
% Fx: longitudinal force applied at tire contact patch [4 1]
% Fy: lateral force applied at tire contact patch [4 1]
% Fz: normal force of tires [4 1]
% z: height of each corner of the vehicle [4 1]
% dz: derivative of height of each corner of the vehicle [4 1]
% wt: tire angular velocity [4 1]
% tau: torque applied onto tire [4 1]
% S: tire slip ratio [4 1]
% alpha: tire slip angle [4 1]
% Fx_max: maximum possible longitudinal force applied onto tire contact patch in the current state [4 1]
% Fy_max: maximum possible lateral force applied onto tire contact patch in the current state [4 1]
%
% Authors:
% Demetrius Gulewicz
% Youngshin Choi
%
% Last Modified: 11/23/24
% Last Author: Youngshin Choi

function [Fx_T, Fxv, Fyv, Fz, wt, tau, toe, Fx, Fy, z, dz, SR, SA, Fx_max, Fy_max, res] = traction_model_master_6DOF(s, CCSA, model)
    % states
    dxCOG = s(1);
    dyCOG = s(3);
    dzCOG = s(5);
    zCOG = s(6);
    dpitch = s(7);
    pitch = s(8);
    droll = s(9);
    roll = s(10);
    dyaw = s(11);
    dw = s(13:16);

    % DC power to each motor [W]
    P = s(17).*s(19:22);

    % suspension compression [m]
    zFL = zCOG + model.wb(1)*sin(pitch) + model.ht(1)*sin(roll);
    zFR = zCOG + model.wb(2)*sin(pitch) - model.ht(2)*sin(roll);
    zRL = zCOG - model.wb(3)*sin(pitch) + model.ht(3)*sin(roll);
    zRR = zCOG - model.wb(4)*sin(pitch) - model.ht(4)*sin(roll);
    z = [zFL; zFR; zRL; zRR];

    % suspension compression velocity [m/s]
    dzFL = dzCOG + model.wb(1)*cos(pitch)*dpitch + model.ht(1)*cos(roll)*droll;
    dzFR = dzCOG + model.wb(2)*cos(pitch)*dpitch - model.ht(2)*cos(roll)*droll;
    dzRL = dzCOG - model.wb(3)*cos(pitch)*dpitch + model.ht(3)*cos(roll)*droll;
    dzRR = dzCOG - model.wb(4)*cos(pitch)*dpitch - model.ht(4)*cos(roll)*droll;
    dz = [dzFL; dzFR; dzRL; dzRR];

    % tire normal force [N]
    Fz = -(model.k.*(z - model.z0) + (model.ct(dz).*dz));

    % slip angle [rad]
    toe = sign(CCSA).*abs(polyval(model.p, [-CCSA;CCSA;0;0])) + model.st;

    dxT = dxCOG + dyaw.*model.Cx;
    dyT = dyCOG + dyaw.*model.Cy;
    SA = toe - atan(dyT./ (abs(dxT) + model.eps));

    % compute slip ratio [unitless]
    SR = [0; 0; 0; 0];
    SR(1) = get_S(dw(1), SA(1), Fz(1), P(1), dxCOG, model);
    SR(2) = get_S(dw(2), SA(2), Fz(2), P(2), dxCOG, model);
    SR(3) = get_S(dw(3), SA(3), Fz(3), P(3), dxCOG, model);
    SR(4) = get_S(dw(4), SA(4), Fz(4), P(4), dxCOG, model);

    % get torque and tractive force
    [Fx_t, Fy, Fx_max, Fy_max, tau, wt, res, Fx_T] = get_val_6DOF(SR, SA, Fz, P, dxCOG, model);

    % tractive Force [N] (force at contact patch, minus rolling resistance at the axle)
    Fx = Fx_T - model.rr.*Fz.*tanh(model.ai.*wt);

    % vehicle forces
    Fxv = Fx .* cos(toe) + sign(-dxT).*abs(Fy.*sin(toe));
    Fyv = Fx .* sin(toe) + sign(-dyT).*abs(Fy.*cos(toe));
end

function SR = get_S(dw, SA, Fz, P, dxCOG,  model)
    if abs(dw) >= 0.1
        SR = (dw*model.r0 + model.Sm*dxCOG) / dxCOG;
    else
        res_p = get_res_6DOF(model.Sm, SA, Fz, P, dxCOG, model);
        res_z = get_res_6DOF(0, SA, Fz, P, dxCOG, model);
        res_m = get_res_6DOF(-model.Sm, SA, Fz, P, dxCOG, model);

        if (abs(res_p) < model.tolX) || (res_p < 0)
            SR = model.Sm;
        elseif abs(res_z) < model.tolX
            SR = 0;
        elseif abs(res_m) < model.tolX || (res_m > 0)
            SR = -model.Sm;
        else
            S0 = -((2/3)*(res_p + res_z + res_m)) / ((res_p - res_m) / model.Sm);
            SR = fzero_better(S0, SA, Fz, P, dxCOG, model);
        end
    end
end

function SR = fzero_better(S0, SA, Fz, P, dxCOG, model)
    for i = 1:model.imax
        % determine if good enough
        res = get_res_6DOF(S0, SA, Fz, P, dxCOG, model);
        if abs(res) < model.tolX
            SR = S0;
            return;
        end

        if (S0 >= 0.95*model.Sm)
            dres = (res - get_res_6DOF(S0-model.epsS, SA, Fz, P, dxCOG, model)) / model.epsS;
        elseif (S0 <= -0.95*model.Sm)
            dres = (get_res_6DOF(S0+model.epsS, SA, Fz, P, dxCOG, model) - res) / model.epsS;
        else
            dres = (get_res_6DOF(S0+model.epsS, SA, Fz, P, dxCOG, model) - get_res_6DOF(S0-model.epsS, SA, Fz, P, dxCOG, model)) / (2*model.epsS);
        end

        if abs(S0) > 0
            dS = max(-0.5.*abs(S0), min(0.5.*abs(S0), res / dres));
        else
            dS = max(-model.dS_max, min(model.dS_max, res / dres));
        end
        S0 = max(-model.Sm, min(model.Sm, S0 - dS));
    end
    SR = S0;
    disp("max iterations B!")
end

function res = get_res_6DOF(SR, SA, Fz, P, dxCOG, model)
    % wheel speed [rad/s]
    wt = (SR + 1).*(dxCOG ./ model.r0);

    % limit slip
    SR = max(min(SR,1),-1);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = model.tt(wt.*model.gr, P) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    Fx = (tau.*model.gr./model.r0);

    % find maximum Fx and Fy forces, ratio, magnitude between them [N N rad none]
    Fx0 = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*SR - model.Ex.*(model.Bx.*SR - atan(model.Bx.*SR))));
    Fy0 = Fz.*model.Dy.*sin(model.Cy.*atan(model.By.*SA - model.Ey.*(model.By.*SA - atan(model.By.*SA))));

    xr = SR./model.Sm;
    yr = SA./model.Am;
    Br = sqrt(1 + ((model.bR.*xr.^(2*model.aR).*yr.^(2*model.aR))./((xr.^(2*model.aR)+yr.^(2*model.aR)).^2)));
    X = abs(Br.*xr.^model.aR) ./ (sqrt(xr.^(2*model.aR)+yr.^(2*model.aR)));
    Y = abs(Br.*yr.^model.aR) ./ (sqrt(xr.^(2*model.aR)+yr.^(2*model.aR)));
    rx = max(0,min(X,1));
    ry = max(0,min(Y,1));

    res = model.r0.*rx.*Fx0 - tau.*model.gr;
end

function [Fx, Fy, Fx0, Fy0, tau, wt, res, Fx_T] = get_val_6DOF(SR, SA, Fz, P, dxCOG, model)
    % wheel speed [rad/s]
    wt = (SR + 1).*(dxCOG ./ model.r0);

    % limit slip
    SR = max(min(SR,1),-1);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = model.tt(wt.*model.gr, P) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    Fx_T = (tau.*model.gr./model.r0);

    % find maximum Fx and Fy forces, ratio, magnitude between them [N N rad none]
    Fx0 = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*SR - model.Ex.*(model.Bx.*SR - atan(model.Bx.*SR))));
    Fy0 = Fz.*model.Dy.*sin(model.Cy.*atan(model.By.*SA - model.Ey.*(model.By.*SA - atan(model.By.*SA))));

    xr = SR./model.Sm;
    yr = SA./model.Am;
    Br = sqrt(1 + ((model.bR.*xr.^(2*model.aR).*yr.^(2*model.aR))./(xr.^(2*model.aR)+yr.^(2*model.aR))));
    X = abs(Br.*xr.^model.aR) ./ (sqrt(xr.^(2*model.aR)+yr.^(2*model.aR)));
    Y = abs(Br.*yr.^model.aR) ./ (sqrt(xr.^(2*model.aR)+yr.^(2*model.aR)));
    rx = max(0,min(X,1));
    ry = max(0,min(Y,1));

    Fx = rx.*Fx0;
    Fy = ry.*Fy0;

    % get residual
    res = get_res_6DOF(SR, SA, Fz, P, dxCOG, model);
end