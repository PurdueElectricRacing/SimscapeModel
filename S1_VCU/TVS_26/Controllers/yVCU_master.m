classdef yVCU_master < handle
    % filtered sensor values; controller output values; internal states
properties
% clipped and filtered variables
    TH; % Throttle sensor Unit: [unitless] Size: [1 1]
              % Max Torque = 1, No Torque = 0, Full Braking = -1
    TH_PO; % power throttle: possitive throttle Unit: [unitless] Size: [1 1]
              % Max Torque = 1, No Torque = 0, Full Braking = 0
    TH_RG; % regen throttle: positive throttle Unit: [unitless] Size: [1 1]
              % Max Torque = 0, No Torque = 0, Full Braking = 1
    ST; % Steering angle sensor Unit: [degree] Size: [1 1]
              % Right turn  = positive value, Left turn = negative value
    VB; % Battery voltage Unit: [V] Size: [1 1]
              % Always positive number, Fully Discharged: !!!V Fully charged: !!!V
    WM; % Motor shaft angular velocity, measured by AMK sensor Unit: [rad/s] Size: [1 4] Order: [FL FR RL RR]
              % Moving forward = positive value, Not moving = 0
    GS; % Vehicle ground speed Unit: [m/s] Size: [1 1]
              % Moving forward = positive, Not moving = 0
    AV; % Chassis angular velocity Unit: [rad/s] Size: [1 3] Order: [x y z] Axis: Sensor XYZ
              % Right turn = positive, Left turn = Negative
    IB; % Battery current Unit: [A] Size: [1 1]
              % Positive torque = Positive current, No torque = 0
    MT; % Max motor temperature Unit: [C] Size: [1 1]
              % Temperature for each motor is mesured, only max is recieved
    IGBT_T; % Max inverter igbt temperature Unit: [C] Size: [1 1]
              % Temperature for each motor controller is mesured, only max is recieved
    INV_T; % Max inverter cold plate temperature Unit: [C] Size: [1 1]
              % Temperature for each inverter cold plate is mesured, only max is recieved
    MC; % Motor overload percentage Unit: [%] Size [1 1]
              % Full torque available = 0%, Only nominal available = 100%
    IC; % Inverter overload percentage Unit: [%] Size [1 1]
              % Full torque available = 0%, No torque available = 100%
    BT; % Max battery cell temperature Unit: [C] Size: [1 1]
              % Temperature for each battery cell is mesured, only max is recieved
    TO; % Motor torque Unit: [Nm] Size: [1 2] Order: [Left Right]
              % Torque to move forward = positive value, No torque = 0, regen = negative
  % calculated values
    PB; % Power drawn from batter Unit: [kW] Size: [1 1]
              % accelerating = positive, regen = negative

  % Power
    TO_BL_PO; % baseline (power) controiller output torques Unit: [Nm] Size: [1 4]
  % Regen

  % output
  TORQUE_OUT; % Motor torque request Unit: [Nm] Size: [1 4] Order: [FL FR RL RR]
            % Torque to move forward = positive value, No torque = 0, regen = negative
end

methods
function y = yVCU_master(p)
% clipped and filtered variables
    y.TH = 0;
    y.TH_PO = 0;
    y.TH_RG = 0;
    y.ST = 0;
    y.VB = 500;
    y.WM = [0 0 0 0];
    y.GS = 0;
    y.AV = [0 0 0];
    y.IB = 0;
    y.MT = 0;
    y.IGBT_T = 0;
    y.INV_T = 0;
    y.MC = 0;
    y.IC = 0;
    y.BT = 0;
    y.TO = [0 0 0 0];
% calculated values
    y.PB = 0;
% power
    y.TO_BL_PO = [0 0 0 0];
% regen
% output
    y.TORQUE_OUT = [0 0 0 0];
    
end
end
end