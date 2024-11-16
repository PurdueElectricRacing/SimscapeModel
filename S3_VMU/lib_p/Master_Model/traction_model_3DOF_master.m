%% Function Description
% This function computes the bulk vehicle dynamics stuff.
%
% Input: 
% s: state vector [13 1]
% tauRaw: target torque command to motor controller [2 1]
% model: vehicle model constants
%
% model: vehicle model constants
%
% Output:
% FxFR: force applied at tire contact patch [2 1]
% zFR: height of front and rear of the vehicle [2 1]
% dzFR: derivative of height of front and rear [2 1]
% wt: tire angular velocity [2 1]
% tau: torque applied onto tire [2 1]
% FzFR: normal force of front and rear tires [2 1]
% S: tire slip ratio [2 1]
% FxFR_max: maximum tractive force in the current state[2 1]
%
% Authors:
% Demetrius Gulewicz
%
% Last Modified: 11/15/24
% Last Author: Demetrius Gulewicz

%% To do:
% 1. use current to compute motor torque

function [FxFR, zFR, dzFR, wt, tau, FzFR, S, FxFR_max] = traction_model_3DOF_master(s, model)
    % states
    dxCOG = s(1);
    dzCOG = s(3);
    zCOG = s(4);
    do = s(5);
    o = s(6);
    wCOG = s(7:8);

    % DC power to front and rear motors [W]
    P = s(10).*s(12:13);

    % suspension compression [m]
    zF = zCOG + model.wb(1)*sin(o);
    zR = zCOG - model.wb(2)*sin(o);
    zFR = [zF; zR];

    % suspension compression velocity [m/s]
    dzF = dzCOG + model.wb(1)*cos(o)*do;
    dzR = dzCOG - model.wb(2)*cos(o)*do;
    dzFR = [dzF; dzR];

    % tire normal force [N]
    FzFR = -(model.k.*(zFR - model.z0) + (model.c.*dzFR));

    % compute slip ratio
    S = [0;0];
    S(1) = get_S(wCOG(1), dxCOG, FzFR(1), P(1),  model);
    S(2) = get_S(wCOG(2), dxCOG, FzFR(2), P(2),  model);

    % get torque and tractive force
    [~, FxFR, FxFR_max, tau, wt] = get_Fx_3DOF(S, FzFR, P, dxCOG, model);
end

function S = get_S(wCOG, dxCOG, Fz, P,  model)
    if abs(wCOG) >= 0.1
        S = (wCOG*model.r0 + model.Sm*dxCOG) / dxCOG;
    else
        [FxFR_t, FxFR_s] = get_Fx_3DOF(model.Sm, Fz, P, dxCOG, model);
        if FxFR_s <= FxFR_t
            S = model.Sm;
        else
            S = get_S0(FxFR_s, FxFR_t, model.Sm);
            S = fzero(@get_res_3DOF, S, model.opts_fzero, Fz, P, dxCOG, model);
        end
    end
end

function S = get_S0(Fx_max, FxFR_t, S_max)
    % guess the slip ratio
    m = Fx_max / S_max;
    b = - Fx_max + m*S_max;
    S = (FxFR_t - b) / m;
end

function [FxFR_t, FxFR_s, FxFR_max, tau, wt] = get_Fx_3DOF(S, FzFR, P, dxCOG, model)
    % tire wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % limit slip
    S = max(min(S, 1), -1);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = model.tt(wt.*model.gr, P/2) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    FxFR_t = (tau*model.gr/model.r0);

    % applied tractive force [N]
    FxFR_s = FzFR.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));

    % maximum tractive force [N]
    FxFR_max = FzFR.*model.Dx.*sin(model.Cx.*atan(model.Bx.*model.Sm - model.Ex.*(model.Bx.*model.Sm - atan(model.Bx.*model.Sm))));
end

function res = get_res_3DOF(S, FzFR, P, dxCOG, model)
    % tire wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = model.tt(wt.*model.gr, P/2) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    FxFR_t = (tau*model.gr/model.r0);

    % applied tractive force [N]
    FxFR_s = FzFR.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));

    % compute residual
    res = FxFR_t - FxFR_s;
end