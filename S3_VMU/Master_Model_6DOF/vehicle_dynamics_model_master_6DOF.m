% Function Description
% This function computes the bulk vehicle dynamics stuff.
%
% Input: 
% s: state vector [23 1]
% Fx_t: longitudinal force applied at tire contact patch [4 1]
% Fz: normal force of each tire [4 1]
% wt: tire angular velocities [4 1]
% tau: torque applied onto tire [4 1]
% model: vehicle model constants
% steer: steering inputs on the front wheels
%
% Output:
% ddx: time derivative of longitudinal velocity
% ddy: time derivaiive of lateral velocity
% ddz: time derivative of vertical velocity
% ddyaw: time derivative of yaw angular velocity
% ddpitch: time derivative of pitch angular velocity
% ddroll: time derivative of roll angular velocity
% dw: time derivative of tire angular velocity
%
% Authors:
% Youngshin Choi
% Demetrius Gulewicz
%
% Last Modified: 11/21/24
% Last Author: Youngshin Choi

function [ddx, ddy, ddz, ddpitch, ddroll, ddyaw, dw] = vehicle_dynamics_model_master_6DOF(s, Fx_t, Fy, Fz, wt, tau, toe, model)
    % states [FIX]
    dxCOG = s(1);
    dyCOG = s(3);
    zCOG = s(6);
    % pitch_ang = s(8);
    % roll_ang = s(10);

    % aerodynamic Drag [N] (at the center of pressure)
    Fdx = sign(-dxCOG)*model.cd*dxCOG^2;
    Fdy = sign(-dyCOG)*model.cd*dyCOG^2;
    
    % aerodynamic Lift [N] (at the center of pressure) [FIX]
    Fl = model.cl*(dxCOG^2+dyCOG^2);

    % tractive Force [N] (force at contact patch, minus rolling resistance at the axle)
    Fx = Fx_t - model.rr.*Fz.*tanh(model.ai.*wt);

    % Independent tire forces
    % FxFL = Fx(1); FyFL = Fy(1); FzFL = Fz(1);
    % FxFR = Fx(2); FyFR = Fy(2); FzFR = Fz(2);
    % FxRL = Fx(3); FyRL = Fy(3); FzRL = Fz(3);
    % FxRR = Fx(4); FyRR = Fy(4); FzRR = Fz(4);
    
    % steering angle of the front tires
    % thetaFL = toe(1);
    % thetaFR = toe(2);
    % thetaRL = toe(3);
    % thetaRR = toe(4);
    
    % sign vectors
    S_yaw_x = [1 -1 1 -1];
    S_yaw_y = [1 1 -1 -1];
    S_pitch = [1 1 -1 -1];
    S_roll = [1 -1 1 -1];
    
    % vehicle forces
    Fxv = Fx .* cos(toe) - Fy .* sin(toe);
    Fyv = Fx .* sin(toe) + Fy .* cos(toe);

    % derivatives
    ddx = (1/model.m)*(sum(Fxv) - Fdx);
    ddy = (1/model.m)*(sum(Fyv) - Fdy);
    ddz = (1/model.m)*(sum(Fz) - Fl - model.m*model.g);
    ddyaw = (1/(model.Izz))*(S_yaw_x*(model.ht.*Fxv) + S_yaw_y*(model.wb.*Fyv) - Fdy*model.xp);
    ddpitch = (1/(model.Iyy))*(zCOG*sum(Fxv) + S_pitch*(Fz .* model.wb) + Fdx*(model.zp) - Fl*(model.xp));
    ddroll = (1/(model.Ixx))*(-zCOG*sum(Fyv) + S_roll*(Fz .* model.ht) - Fdy*(model.zp));
    dw = (1/model.Jw)*round(tau.*model.gr - model.r0.*Fx_t, 4);
end
