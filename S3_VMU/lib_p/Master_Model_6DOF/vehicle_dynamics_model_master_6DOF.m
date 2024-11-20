%% Function Description
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
% ddz: time derivative of vertical velocity
% ddo: time derivative of pitch angular velocity
% dw: time derivative of tire angular velocity
%
% Authors:
% Demetrius Gulewicz
%
% Last Modified: 11/19/24
% Last Author: Youngshin Choi

function [ddx, ddz, ddo, dw] = vehicle_dynamics_model_master_6DOF(s, Fx_t, Fz, wt, tau, model, steer)
    % states [FIX]
    dxCOG = s(1);
    dyCOG = s(2);
    dzCOG = s(3);
    zCOG = s(6);
    o = s(8);

    % aerodynamic Drag [N] (at the center of pressure) [FIX]
    Fd = -model.cd*dxCOG^2;

    % aerodynamic Lift [N] (at the center of pressure) [FIX]
    Fl = -model.cl*dxCOG^2;

    % supsension Forces [N] (spring and damper forces)
    Fs = -Fz;

    % Independent tire forces
    FxFL = Fx(1); FyFL = Fy(1);
    FxFR = Fx(2); FyFR = Fy(2);
    FxRL = Fx(3); FyRL = Fy(3);
    FxRR = Fx(4); FyRR = Fy(4);

    % tractive Force [N] (force at contact patch, minus rolling resistance at the axle)
    Fx = Fx_t - model.rr.*Fz.*tanh(model.ai.*wt);

    % steering angle of the front tires
    % deltaFL = steering angle of front left tire
    % deltaFR = steering angle of front right tire
  
    % Sum of tire forces
    sumFx = FxFL*cos(deltaFL) + FxFR*cos(deltaFR) + FxRL + FxRR - FyFL*sin(deltaFL) - FyFR*sin(deltaFR) - Fdx;
    sumFy = FyFL*cos(deltaFL) + FyFR*cos(deltaFR) + FyRL + FyRR - FxFL*sin(deltaFL) - FxFR*sin(deltaFR) - Fdy;
  
    % derivatives [FIX]
    ddx = (1/model.m)*(sumFx);
    ddy = (1/model.m)*(sumFy);
    
    ddz = (1/model.m)*(-2*sum(Fs) + Fl - model.m*model.g);
    ddo = (1/(model.Jv))*(2*sum(Fx)*zCOG + 2*cos(o)*(Fs(2)*model.wb(2) - Fs(1)*model.wb(1)) + Fl*model.xp*cos(o));
    dw = (1/model.Jw)*round(tau.*model.gr - model.r0.*Fx_t, 4);
end
