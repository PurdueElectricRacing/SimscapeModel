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

function [ddx, ddy, ddz, ddyaw, ddpitch, ddroll, dw] = vehicle_dynamics_model_master_6DOF(s, Fx_t, Fz, wt, tau, toe, model)
    % states [FIX]
    dxCOG = s(1);
    dyCOG = s(2);
    zCOG = s(6);

    % aerodynamic Drag [N] (at the center of pressure)
    Fdx = -model.cd*dxCOG^2;
    Fdy = -model.cd*dyCOG^2;
    
    % aerodynamic Lift [N] (at the center of pressure) [FIX]
    Fl = -model.cl*(dxCOG^2+dyCOG^2);

    % tractive Force [N] (force at contact patch, minus rolling resistance at the axle)
    Fx = Fx_t - model.rr.*Fz.*tanh(model.ai.*wt);

    % Independent tire forces
    FxFL = Fx(1); FyFL = Fy(1);
    FxFR = Fx(2); FyFR = Fy(2);
    FxRL = Fx(3); FyRL = Fy(3);
    FxRR = Fx(4); FyRR = Fy(4);

    % Independent supsension Forces [N] (spring and damper forces)
    FsFL = -Fz(1);
    FsFR = -Fz(2);
    FsRL = -Fz(3);
    FsRR = -Fz(4);
    
    % steering angle of the front tires
    thetaFL = toe(1);
    thetaFR = toe(2);
  
    % Sum of forces
    sumFx = FxFL*cos(thetaFL) + FxFR*cos(thetaFR) + FxRL + FxRR - FyFL*sin(thetaFL) - FyFR*sin(thetaFR) + Fdx;
    sumFy = FyFL*cos(thetaFL) + FyFR*cos(thetaFR) + FyRL + FyRR - FxFL*sin(thetaFL) - FxFR*sin(thetaFR) + Fdy;
    sumFz = FsFL + FsFR + FsRL + FsRR + Fl;
    
    % derivatives
    ddx = (1/model.m)*(sumFx);
    ddy = (1/model.m)*(sumFy);
    ddz = (1/model.m)*(-2*sum(Fs) + Fl - model.m*model.g);
    ddyaw = (1/(model.Izz))*(model.ht(1)*FxFL*sin(thetaFL) + model.ht(2)*FxFR*sin(thetaFR) ...
                            - model.ht(3)*FxRL - model.ht(4)*FxRR ...
                            + model.wb(1)*FyFL*cos(thetaFL) + model.wb(2)*FyFL*cos(thetaFR) ...
                            - model.wb(3)*FyRR*cos(90) + model.wb(4)*FyRL*cos(90) ...
                            + Fdx);
    ddpitch = (1/(model.Iyy))*(sumFx*(zCOG) + Fl*(model.xp) - sumFz - Fdx*(model.zp));
    ddroll = (1/(model.Ixx))*(sumFy*(zCOG) + Fl*(model.xp) - sumFz - Fdy*(model.zp));
    dw = (1/model.Jw)*round(tau.*model.gr - model.r0.*Fx_t, 4);
end
