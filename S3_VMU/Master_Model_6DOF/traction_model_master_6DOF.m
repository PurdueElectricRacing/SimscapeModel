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

function [Fx_T, Fy, Fz, wt, tau, toe, z, dz, SR, SA, Fx_max, Fy_max, res] = traction_model_master_6DOF(s, CCSA, model)
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
    SA = -tanh(abs(dxCOG)).*atan((dyCOG + dyaw.*model.Cy)./(dxCOG + dyaw.*model.Cx + model.eps)) + toe;

    % compute slip ratio [unitless]
    SR = [0; 0; 0; 0];
    SR(1) = get_S(dw(1), SR(1), SA(1), Fz(1), P(1), dxCOG, model);
    SR(2) = get_S(dw(2), SR(2), SA(2), Fz(2), P(2), dxCOG, model);
    SR(3) = get_S(dw(3), SR(3), SA(3), Fz(3), P(3), dxCOG, model);
    SR(4) = get_S(dw(4), SR(4), SA(4), Fz(4), P(4), dxCOG, model);

    % get torque and tractive force
    [Fx_t, Fy, Fx_max, Fy_max, tau, wt, res, Fx_T] = get_val_6DOF(SR, SA, Fz, P, dxCOG, model);
end

function SR = get_S(dw, S0, SA, Fz, P, dxCOG,  model)
    if abs(dw) >= 0.1
        SR = (dw*model.r0 + model.Sm*dxCOG) / dxCOG;
    else
        [Fx_tp, ~, ~, ~, ~, ~, ~, Fx_Tp] = get_val_6DOF(model.Sm, SA, Fz, P, dxCOG, model);
        [Fx_tz, ~, ~, ~, ~, ~, ~, Fx_Tz] = get_val_6DOF(0, SA, Fz, P, dxCOG, model);
        [Fx_tm, ~, ~, ~, ~, ~, ~, Fx_Tm] = get_val_6DOF(-model.Sm, SA, Fz, P, dxCOG, model);
        if (Fx_Tp > Fx_tp) || (Fx_Tm < Fx_tm)
            SR = model.Sm;
        elseif (abs(Fx_tz - Fx_Tz) < model.tolX)
            SR = 0;
        else
            if (Fx_Tz > 0)
                current_bracket = [0 model.Sm 0; 0 Fx_tp Fx_Tz];
            elseif (Fx_Tz < 0)
                current_bracket = [-model.Sm 0 0; Fx_tm 0 Fx_Tz];
            end

            SR = fzero_bracket(SA, Fz, P, dxCOG, model, current_bracket);
            SR = fzero_better(SR, SA, Fz, P, dxCOG, model);
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

        % if not good enough, compute next step
        dres = (res - get_res_6DOF(S0-model.epsS, SA, Fz, P, dxCOG, model)) / model.epsS;
        S0 = S0 - (res / dres);
    end
    SR = S0;
    disp("max iterations B!")
end

function SR = fzero_bracket(SA, Fz, P, dxCOG, model, initial_bracket)
    % initialize bracket
    current_bracket = initial_bracket;

    for i = 1:model.imax
        % pick slip ratio
        r = (current_bracket(2,3) - current_bracket(2,1)) ./ (current_bracket(2,2) - current_bracket(2,1));
        S1 = r.*current_bracket(1,2) + (1 - r).*current_bracket(1,1);

        % check residual
        [Fx, ~, ~, ~, ~, ~, ~, Fx_T] = get_val_6DOF(S1, SA, Fz, P, dxCOG, model);
        res = Fx - Fx_T;

        if abs(res) < model.tolB
            SR = S1;
            return;
        end

        % if not good enough, shrink the bracket
        if res > 0
            current_bracket(1,2) = S1;
            current_bracket(2,2) = Fx;
        elseif res < 0
            current_bracket(1,1) = S1;
            current_bracket(2,1) = Fx;
        end
    end
    SR = S1;
    disp("max iterations A!")
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

    res = rx.*Fx0 - Fx;
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