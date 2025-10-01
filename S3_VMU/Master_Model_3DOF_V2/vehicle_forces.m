%% This function computes the forces on applied to a 4 wheeled vehicle

% Inputs:
% s:      The state vector
% SR:     Slip ratio of each tire [unitless] [FL FR RL RR]
%         Positive slip angle corresponds to positive Fx
%         Positive Fx corresponds to forward acceleration
% zS:     Signed vertical distance from ground to shock fixed point [FL FR RL RR] [m]
%         Positive distance corresponds to above ground
% dzS:    Signed derivative of vertical distance from ground to shock fixed point [FL FR RL RR] [m]
%         Positive distance corresponds to above ground
% model:  Vehicle parameter structure

% Outputs:
% sum_Fxa:    The sum force forces in X of the fixed coordinate system [N]
% sum_Fza:    The sum force forces in Z of the fixed coordinate system [N]
% sum_My:     The sum of the moment about the y-axis vehicle COG [Nm]
% res_torque: The torque residual between tractive torque and motor torque [Nm]
% Fxv:        Forces in the vehicle x direction [N]
% Fz:         Forces in the vehicle z direction [N]

function [sum_Fxa, sum_Fza, sum_My, res_torque, Fxv, Fz, tire_tau_from_tire, dxv] = vehicle_forces(s, P, w, xT, zS, dzS, model)
    % interp functions for simulink :(
    ct = @(x1) (interp1(model.ct_in, model.ct_out, x1));

    % get states
    dxa = s(1);
    za = s(4);
    SR = [s(11); s(11); s(12); s(12)];
    tau = min(max(s(9:10), model.T_min), model.T_max);
    tau = [tau(1); tau(1); tau(2); tau(2)];

    % transform abolute velocity into vehicle frame velocity
    dxv = dxa;

    % normal force on tire [N] positive force is tire touching the ground - vertical shock
    Fz = -(model.k.*(zS - model.L0 - model.z0) + (ct(dzS).*dzS));

    % Longitudinal force on tire [N] - positive slip is positive force
    Fx = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*SR - model.Ex.*(model.Bx.*SR - atan(model.Bx.*SR))));

    % rolling resistance on each tire [N] - Positive velocity is negative rolling resistance
    Fr = -model.rr.*Fz.*tanh(model.ai.*w);

    % brake pad torque [Nm]
    mu_i = (2/pi).*atan(abs(w)).*model.mu_k;
    Tb = sign(-w).*P.*(mu_i.*pi.*model.D_b.^2.*model.R_m.*model.N_p ./ 4);
    Fb = Tb ./ model.r0;

    % tractive Force [N] (force at contact patch, minus rolling resistance at the axle)
    FxT = Fx + Fr + Fb;

    % vehicle tire forces [N] - Positive tire angle is clockwise
    Fxv = FxT;

    % force due to gravity, acting on COG [N]
    Fg = -model.m_s*model.g;

    % aerodynamic Drag [N] (at the center of pressure) - Positive velocity is negative force
    Fdx = sign(-dxv)*model.cd*dxv^2;

    % aerodynamic Lift [N] (at the center of pressure) - Positive velocity is negative force
    Fdz = -model.cl*dxa^2;

    % suspension forces acting on chassis [N] - Positive is upward vertical acceleration
    Fs = Fz;

    % sum of forces in vehicle [x,y,z] direction [N]
    sum_Fxv = sum(Fxv) + Fdx; 
    sum_Fzv = sum(Fs) + Fg + Fdz;

    % sum of forces in absolute [x,y,z] direction [N] - positive yaw is clockwise
    sum_Fxa = sum_Fxv;
    sum_Fza = sum_Fzv; % vehicle is assumed to be on a level plane

    % sum of moments about vehicle COG [Nm]
    S_pitch = [1 1 -1 -1];
    sum_My = za*sum(Fxv) + S_pitch*(Fs .* abs(xT)) - Fdx*(model.zp) + Fdz*(model.xp);

    % Tractive force residual
    tire_tau_from_motor = (tau - model.gm.*w).*model.gr; % tractive torque due to motor current [Nm]
    tire_tau_from_tire = Fx.*model.r0; % tractive torque due to tire slip [Nm]

    res_torque = tire_tau_from_tire - tire_tau_from_motor; % residual torque
end