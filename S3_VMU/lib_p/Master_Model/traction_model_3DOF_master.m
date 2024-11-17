%% Function Description
% This function computes the bulk vehicle dynamics stuff.
%
% Input: 
% s: state vector [13 1]
% model: vehicle model constants
%
% Output:
% Fx: longitudinal force applied at tire contact patch [2 1]
% Fz: normal force of front and rear tires [2 1]
% z: height of front and rear of the vehicle [2 1]
% dz: derivative of height of front and rear [2 1]
% wt: tire angular velocity [2 1]
% tau: torque applied onto tire [2 1]
% S: tire slip ratio [2 1]
% Fx_max: maximum possible longitudinal force applied onto tire contact patch in the current state[2 1]
%
% Authors:
% Demetrius Gulewicz
%
% Last Modified: 11/17/24
% Last Author: Demetrius Gulewicz

%% To do:
% 1. get rid of global variable

function [Fx, Fz, wt, tau, z, dz, S, Fx_max] = traction_model_3DOF_master(s, model)
    global S

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
    z = [zF; zR];

    % suspension compression velocity [m/s]
    dzF = dzCOG + model.wb(1)*cos(o)*do;
    dzR = dzCOG - model.wb(2)*cos(o)*do;
    dz = [dzF; dzR];

    % tire normal force [N]
    model.c = model.ct(dz);
    Fz = -(model.k.*(z - model.z0) + (model.c.*dz));

    % compute slip ratio
    S(1) = get_S(wCOG(1), S(1), dxCOG, Fz(1), P(1),  model);
    S(2) = get_S(wCOG(2), S(2), dxCOG, Fz(2), P(2),  model);

    % get torque and tractive force
    [~, Fx, Fx_max, tau, wt] = get_Fx_3DOF(S, Fz, P, dxCOG, model);
end

function S = get_S(dw, S0, dxCOG, Fz, P,  model)
    if abs(dw) >= 0.1
        S = (dw*model.r0 + model.Sm*dxCOG) / dxCOG;
    else
        [Fx_t, Fx] = get_Fx_3DOF(model.Sm, Fz, P, dxCOG, model);
        if Fx <= Fx_t
            S = model.Sm;
        else
            S = fzero_better(S0, Fz, P, dxCOG, model);
        end
    end
end

function S = fzero_better(S0, Fz, P, dxCOG, model)
    for i = 1:model.imax
        fx = get_res_3DOF(S0, Fz, P, dxCOG, model);
        dfx = (get_res_3DOF(S0+model.eps, Fz, P, dxCOG, model) - fx) / model.eps;
        if abs(fx) < model.tolX
            S = S0;
            return;
        end
        S0 = S0 - (fx / dfx);
    end
    S = S0;
    disp("max iterations!")
end

function [Fx_t, Fx, Fx_max, tau, wt] = get_Fx_3DOF(S, Fz, P, dxCOG, model)
    % tire wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % limit slip
    S = max(min(S, 1), -1);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = model.tt(wt.*model.gr, P/2) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    Fx_t = (tau*model.gr/model.r0);

    % applied tractive force [N]
    Fx = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));

    % maximum tractive force [N]
    Fx_max = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*model.Sm - model.Ex.*(model.Bx.*model.Sm - atan(model.Bx.*model.Sm))));
end

function res = get_res_3DOF(S, Fz, P, dxCOG, model)
    % tire wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % limit slip
    S = max(min(S, 1), -1);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = model.tt(wt.*model.gr, P/2) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    Fx_t = (tau*model.gr/model.r0);

    % applied tractive force [N]
    Fx = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));

    % compute residual
    res = Fx_t - Fx;
end