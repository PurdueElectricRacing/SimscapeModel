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

function [Fx_t, Fy, Fz, wt, tau, toe, z, dz, S, alpha, Fx_max, Fy_max] = traction_model_master_6DOF(s, CCSA, model)
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
    model.c = model.ct(dz);
    Fz = -(model.k.*(z - model.z0) + (model.c.*dz));

    % slip angle
    toe = sign([CCSA;-CCSA;0;0]).*abs(polyval(model.p, [CCSA;-CCSA;0;0])) + model.st;
    alpha = slip_angle_model_master_6DOF(dxCOG, dyCOG, dyaw, toe, model);

    % compute slip ratio
    S = [0; 0; 0; 0];
    S(1) = get_S(dw(1), S(1), alpha(1), Fz(1), P(1), dxCOG, model);
    S(2) = get_S(dw(2), S(2), alpha(2), Fz(2), P(2), dxCOG, model);
    S(3) = get_S(dw(3), S(3), alpha(3), Fz(3), P(3), dxCOG, model);
    S(4) = get_S(dw(4), S(4), alpha(4), Fz(4), P(4), dxCOG, model);

    % get torque and tractive force
    [Fx_t, Fy, tau, wt, Fx_max, Fy_max] = get_val_6DOF(S, alpha, Fz, P, dxCOG, model);
end

function S = get_S(dw, S0, alpha, Fz, P, dxCOG,  model)
    if abs(dw) >= 0.1
        S = (dw*model.r0 + model.Sm*dxCOG) / dxCOG;
    else
        [Fx_t, Fx] = get_val_6DOF(model.Sm, alpha, Fz, P, dxCOG, model);
        if Fx < Fx_t
            S = model.Sm;
        else
            S = fzero_better(S0, alpha, Fz, P, dxCOG, model);
        end
    end
end

function S = fzero_better(S0, alpha, Fz, P, dxCOG, model)
    for i = 1:model.imax
        res = get_res_6DOF(S0, alpha, Fz, P, dxCOG, model);
        dres = (get_res_6DOF(S0+model.eps, alpha, Fz, P, dxCOG, model) - res) / model.eps;
        if abs(res) < model.tolX
            S = S0;
            return;
        end
        S0 = S0 - (res / dres);
    end
    S = S0;
    disp("max iterations!")
end

function res = get_res_6DOF(S, alpha, Fz, P, dxCOG, model)
    % sign convention stuff
    alpha_abs = abs(alpha);

    % wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = model.tt(wt.*model.gr, P) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    Fx_t = (tau*model.gr/model.r0);

    % find maximum Fx and Fy forces, ratio, magnitude between them [N N rad none]
    Fx0 = Fz*model.Dx*sin(model.Cx*atan(model.Bx*S - model.Ex*(model.Bx*S - atan(model.Bx*S))));
    Fy0 = Fz*model.Dy*sin(model.Cy*atan(model.By*alpha - model.Ey*(model.By*alpha - atan(model.By*alpha))));
    theta = ((pi/4)*exp(model.ao*alpha_abs) + atan(10*alpha_abs))*(exp((model.bo*exp(model.co*alpha_abs) + model.do)*S) + (1/pi)*atan(model.fo*S*alpha_abs));
    
    % get smoothened traction radius
    r = tanh(model.r_traction_scale*(S^2 + alpha^2));

    % get Fy
    Fy = sqrt((Fy0^2)*(r^2 - min((Fx_t/Fx0)^2,r^2)));

    % compute residual
    res = theta - atan2(abs(Fy)+model.eps,abs(Fx_t)+model.eps);
end

function [Fx_t, Fy, tau, wt, Fx0, Fy0] = get_val_6DOF(S, alpha, Fz, P, dxCOG, model)
    % wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % limit slip
    S = max(min(S, 1), -1);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = model.tt(wt.*model.gr, P) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    Fx_t = (tau.*model.gr./model.r0);

    % find maximum Fx and Fy forces, ratio, magnitude between them [N N rad none]
    Fx0 = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));
    Fy0 = Fz.*model.Dy.*sin(model.Cy.*atan(model.By.*alpha - model.Ey.*(model.By.*alpha - atan(model.By.*alpha))));

    % get smoothened traction radius
    r = tanh(model.r_traction_scale.*(S.^2 + alpha.^2));

    % get Fy
    Fy = sqrt((Fy0.^2).*(r.^2 - min((Fx_t./Fx0).^2,r.^2)));
end