%% Function Description
% This function computes the bulk vehicle dynamics stuff.
%
% Input: 
% s: state vector [13 1]
% Fx_t: force applied at tire contact patch [2 1]
% Fz: normal force of front and rear tires [2 1]
% z: height of front and rear of the vehicle [2 1]
% dz: derivative of height of front and rear [2 1]
% wt: tire angular velocities [2 1]
% tau: torque applied onto tire [2 1]
% model: vehicle model constants
%
% Output:
% ddx: time derivative of longitudinal velocity
% ddz: time derivative of vertical velocity
% ddo: time derivative of pitch angular velocity
% dw: time derivative of tire angular velocity
%
% Authors:
% Demetrius Gulewicz
%
% Last Modified: 11/17/24
% Last Author: Demetrius Gulewicz

function [ddx, ddz, ddo, dw] = vehicle_dynamics_model_master_3DOF(s, Fx_t, Fz, wt, tau, model)
    % states
    dxCOG = s(1);
    zCOG = s(4);
    o = s(6);

    % aerodynamic Drag [N] (at the center of pressure)
    Fd = model.cd*dxCOG^2;

    % aerodynamic Lift [N] (at the center of pressure)
    Fl = model.cl*dxCOG^2;

    % supsension Forces [N] (spring and damper forces)
    Fs = Fz;

    % tractive Force [N] (force at contact patch, minus rolling resistance at the axle)
    Fx = Fx_t - model.rr.*Fz.*tanh(model.ai.*wt);

    % derivatives
    ddx = (1/model.m)*(2*sum(Fx) - Fd);
    ddz = (1/model.m)*(2*sum(Fs) - Fl - model.m*model.g);
    ddo = (1/(model.Jv))*(2*sum(Fx)*(zCOG-model.r0) + 2*cos(o)*(-Fs(2)*model.wb(2) + Fs(1)*model.wb(1)) - Fl*model.d*cos(model.gamma-o) - Fd*model.d*sin(model.gamma-o));
    dw = (1/model.Jw)*round(tau.*model.gr - model.r0.*Fx_t, 4);
end