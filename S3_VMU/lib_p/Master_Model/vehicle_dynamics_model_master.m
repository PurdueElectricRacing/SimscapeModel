%% Function Description
% This function computes the bulk vehicle dynamics stuff.
%
% Input: 
% s: state vector [11 1]
% tau: torque applied onto tire [2 1]
% FxFR: force applied at tire contact patch [2 1]
% zFR: height of front and rear of the vehicle [2 1]
% dzFR: derivative of height of front and rear [2 1]
% FzFR: normal force of front and rear tires [2 1]
% wt: tire angular velocities [2 1]
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
% Last Modified: 11/16/24
% Last Author: Demetrius Gulewicz

function [ddx, ddz, ddo, dw] = vehicle_dynamics_model_master(s, tau, FxFR, zFR, dzFR, FzFR, wt, model)
    % states
    dxCOG = s(1);
    zCOG = s(4);
    o = s(6);

    % aerodynamic Drag [N] (at the center of pressure)
    Fd = -model.cd*dxCOG^2;

    % aerodynamic Lift [N] (at the center of pressure)
    Fl = -model.cl*dxCOG^2;

    % supsension Forces [N] (spring and damper forces)
    model.c = model.ct(dzFR);
    Fs = model.k.*(zFR - model.z0) + model.c.*dzFR;

    % tractive Force [N] (force at contact patch, minus rolling resistance at the axle)
    Fx = FxFR - model.rr.*FzFR.*tanh(model.ai.*wt);

    % derivatives
    ddx = (1/model.m)*(Fd + 2*sum(Fx));
    ddz = (1/model.m)*(-2*sum(Fs) + Fl - model.m*model.g);
    ddo = (1/(model.Jv))*(2*sum(Fx)*zCOG + 2*cos(o)*(Fs(2)*model.wb(2) - Fs(1)*model.wb(1)) + Fl*model.xp*cos(o));
    dw = (1/model.Jw)*round(tau.*model.gr - model.r0.*FxFR, 4);
end