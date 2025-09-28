%% This function computes the forces on applied to a 4 wheeled vehicle

% Inputs:
% s:      The state vector
% CCSA:   The center column steering angle [deg]
%         Positive is clockwise
% SA:     Slip angle of each tire [rad] [FL FR RL RR]
%         Positive slip angle corresponds to positive Fy
%         Positive Fy corresponds to acceleration to the right
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
% sum_Fya:    The sum force forces in Y of the fixed coordinate system [N]
% sum_Fza:    The sum force forces in Z of the fixed coordinate system [N]
% sum_Mx:     The sum of the moment about the x-axis vehicle COG [Nm]
% sum_My:     The sum of the moment about the y-axis vehicle COG [Nm]
% sum_Mz:     The sum of the moment about the z-axis vehicle COG [Nm]
% res_torque: The torque residual between tractive torque and motor torque [Nm]
% Fxv:        Forces in the vehicle x direction [N]
% Fyv:        Forces in the vehicle y direction [N]
% Fz:         Forces in the vehicle z direction [N]

function [sum_Fxa, sum_Fya, sum_Fza, sum_Mx, sum_My, sum_Mz, res_torque, res_power, Fxv, Fyv, Fz, tire_tau_from_tire, dxv, dyv] = vehicle_forces(s, CCSA, P, SR, SA, xT, yT, zS, dzS, tauRaw, model)
    % interp functions for simulink :(
    pt = @(x1,x2) (interp2(model.pt_in1, model.pt_in2, model.pt_out', x1, x2));
    ct = @(x1) (interp1(model.ct_in, model.ct_out, x1));

    % get states
    dxa = s(1);
    dya = s(3);
    za = s(6);
    roll = s(8);
    yaw = s(12);
    w = s(19:22);
    Vb = s(13);
    Im = s(15:18);
    tau = min(max(s(23:26), model.T_min), model.T_max);

    % transform abolute velocity into vehicle frame velocity
    dxv = dya*sin(yaw) + dxa*cos(yaw);
    dyv = dya*cos(yaw) - dxa*sin(yaw);

    % normal force on tire [N] positive force is tire touching the ground - vertical shock
    Fz = -(model.k.*(zS - model.L0 - model.z0) + (ct(dzS).*dzS) + model.kL.*roll.*[-1;1;-1;1]);

    % Longitudinal force on tire [N] - positive slip is positive force
    Fx = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*SR - model.Ex.*(model.Bx.*SR - atan(model.Bx.*SR))));

    % Lateral force on tire [N] - positive slip is positive force
    Fy = Fz.*model.Dy.*sin(model.Cy.*atan(model.By.*SA - model.Ey.*(model.By.*SA - atan(model.By.*SA))));

    % rolling resistance on each tire [N] - Positive velocity is negative rolling resistance
    Fr = -model.rr.*Fz.*tanh(model.ai.*w);

    % brake pad torque [Nm]
    mu_i = (2/pi).*atan(abs(w)).*model.mu_k;
    Tb = sign(-w).*P.*(mu_i.*pi.*model.D_b.^2.*model.R_m.*model.N_p ./ 4);
    Fb = Tb ./ model.r0;

    % tractive Force [N] (force at contact patch, minus rolling resistance at the axle)
    FxT = Fx + Fr + Fb;

    % vehicle tire forces [N] - Positive tire angle is clockwise
    toe = sign(CCSA).*abs(polyval(model.p, [-CCSA;CCSA;0;0])) + model.st;
    Fxv = FxT .* cos(toe) - Fy.*sin(toe);
    Fyv = FxT .* sin(toe) + Fy.*cos(toe);

    % force due to gravity, acting on COG [N]
    Fg = -model.m_s*model.g;

    % aerodynamic Drag [N] (at the center of pressure) - Positive velocity is negative force
    Fdx = sign(-dxv)*model.cd*dxv^2;

    % aerodynamic Drag [N] (at the center of pressure) - Positive velocity is negative force
    Fdy = sign(-dyv)*model.cd*dyv^2;

    % aerodynamic Lift [N] (at the center of pressure) - Positive velocity is negative force
    Fdz = -model.cl*(dxa^2+dya^2);

    % suspension forces acting on chassis [N] - Positive is upward vertical acceleration
    Fs = Fz;

    % sum of forces in vehicle [x,y,z] direction [N]
    sum_Fxv = sum(Fxv) + Fdx; 
    sum_Fyv = sum(Fyv) + Fdy;
    sum_Fzv = sum(Fs) + Fg + Fdz;

    % sum of forces in absolute [x,y,z] direction [N] - positive yaw is clockwise
    sum_Fxa = sum_Fxv.*cos(yaw) - sum_Fyv.*sin(yaw);
    sum_Fya = sum_Fxv.*sin(yaw) + sum_Fyv*cos(yaw);
    sum_Fza = sum_Fzv; % vehicle is assumed to be on a level plane

    % sum of moments about vehicle COG [Nm]
    S_yaw_x = [1 -1 1 -1];
    S_roll = [-1 1 -1 1];
    S_yaw_y = [1 1 -1 -1];
    S_pitch = [1 1 -1 -1];

    sum_Mx = za*sum(Fyv) + S_roll*(Fs .* abs(yT)) + Fdy*(model.zp);
    sum_My = za*sum(Fxv) + S_pitch*(Fs .* abs(xT)) - Fdx*(model.zp) + Fdz*(model.xp);
    sum_Mz = S_yaw_x*(abs(yT).*Fxv) + S_yaw_y*(abs(xT).*Fyv) + Fdy*model.xp;

    % Tractive force residual
    tire_tau_from_motor = (tau - model.gm.*w).*model.gr; % tractive torque due to motor current [Nm]
    tire_tau_from_tire = Fx.*model.r0; % tractive torque due to tire slip [Nm]

    res_torque = tire_tau_from_tire - sign(tauRaw).*abs(tire_tau_from_motor); % residual torque

    % power residual
    w = min(max(s(19:22), model.w_min), model.w_max);
    res_power = (Im.*Vb) - pt(w.*model.gr, tau);

    if sum(isnan(res_torque)) || sum(isinf(res_torque))
        s = 0;
    end
end