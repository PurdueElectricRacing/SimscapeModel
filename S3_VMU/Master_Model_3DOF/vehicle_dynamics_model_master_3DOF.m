%% Function Description
% This function computes the bulk vehicle dynamics derivatives.
%
% Input: 
% s: state vector [12 1]
% Fx_t: per tire force applied at tire contact patch [2 1]
% Fz: per tire normal force of front and rear tires [2 1]
% z: height of front and rear of the vehicle [2 1]
% dz: derivative of height of front and rear [2 1]
% wt: tire angular velocities [2 1]
% tau: per tire torque applied onto tire [2 1]
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
% Last Modified: 04/28/25
% Last Author: Demetrius Gulewicz

function [ddx, ddz, ddo, dw] = vehicle_dynamics_model_master_3DOF(s, Fx_t, Fz, wt, tau, model)
    % states
    dxCOG = s(1);
    zCOG = s(4);
    o = s(6);

    % aerodynamic Drag [N] (at the center of pressure)
    Fd = sign(-dxCOG)*model.cd*dxCOG^2;

    % aerodynamic Lift [N] (at the center of pressure)
    Fl = -model.cl*dxCOG^2;

    % gravitational force (at center of gravity)
    Fg = -model.m*model.g;

    % supsension Forces [N] (spring and damper forces)
    Fs = Fz;

    % tractive Force [N] (at drive axle, which includes rolling resistance at the axle)
    Frr = -model.rr.*Fz.*tanh(model.ai.*wt);
    Fx = Fx_t + Frr ;

    % derivatives
    ddx = (1/model.m)*(2*sum(Fx) + Fd);
    ddz = (1/model.m)*(2*sum(Fs) + Fl + Fg);
    ddo = (1/(model.Jv))*(2*sum(Fx)*zCOG - 2*sum(Frr)*model.r0 + cos(o)*(2*Fs(1)*model.wb(1) - 2*Fs(2)*model.wb(2) + Fl*model.xp - Fd*model.zp));
    dw = (1/model.Jw)*round(tau.*model.gr - model.r0.*Fx_t, 4);
end