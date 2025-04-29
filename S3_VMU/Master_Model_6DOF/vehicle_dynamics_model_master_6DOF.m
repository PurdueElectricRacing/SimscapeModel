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

function [ddx, dX, ddy, dY, ddz, ddpitch, ddroll, ddyaw, dw] = vehicle_dynamics_model_master_6DOF(s, Fx_t, Fxv, Fyv, Fz, tau, model)
    % states
    dxCOG = s(1);
    dyCOG = s(3);
    zCOG = s(6);
    dyaw = s(11);
    psi = s(12);

    % aerodynamic Drag [N] (at the center of pressure)
    Fdx = sign(-dxCOG)*model.cd*dxCOG^2;
    Fdy = sign(-dyCOG)*model.cd*dyCOG^2;
    
    % aerodynamic Lift [N] (at the center of pressure)
    Fl = model.cl*(dxCOG^2+dyCOG^2);
    
    % sign vectors
    S_yaw_x = [1 -1 1 -1];
    S_roll = [1 -1 1 -1];
    S_yaw_y = [1 1 -1 -1];
    S_pitch = [1 1 -1 -1];
    
    % derivatives
    ddx = (1/model.m)*(sum(Fxv) + Fdx) + dyaw*dyCOG;
    dX = dxCOG.*cos(psi) - dyCOG.*sin(psi);
    ddy = (1/model.m)*(sum(Fyv) + Fdy) - dyaw*dxCOG;
    dY =  dxCOG.*sin(psi) + dyCOG.*cos(psi);
    ddz = (1/model.m)*(sum(Fz) - Fl - model.m*model.g);
    ddyaw = (1/(model.Izz))*(S_yaw_x*(model.ht.*Fxv) + S_yaw_y*(model.wb.*Fyv) + Fdy*model.xp);
    ddpitch = (1/(model.Iyy))*(zCOG*sum(Fxv) + S_pitch*(Fz .* model.wb) - Fdx*(model.zp) - Fl*(model.xp));
    ddroll = (1/(model.Ixx))*(-zCOG*sum(Fyv) + S_roll*(Fz .* model.ht) + Fdy*(model.zp));
    dw = (1/model.Jw)*round(tau.*model.gr - model.r0.*Fx_t, 1);
end
