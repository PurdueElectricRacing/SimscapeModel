classdef xVCU_master < handle
% Raw sensor values
properties
% Raw Sensor Values
    TH_RAW; % Throttle sensor Unit: [unitless] Size: [1 1]
              % Max Torque = 1, No Torque = 0, Full Braking = -1
    ST_RAW; % Steering angle sensor Unit: [degree] Size: [1 1]
              % Right turn  = positive value, Left turn = negative value
    VB_RAW; % Battery voltage Unit: [V] Size: [1 1]
              % Always positive number, Fully Discharged: !!!V Fully charged: !!!V
    WM_RAW; % Motor shaft angular velocity, measured by AMK sensor Unit: [rad/s] Size: [1 4] Order: [FL FR RL RR]
              % Moving forward = positive value, Not moving = 0
    GS_RAW; % Vehicle ground speed Unit: [m/s] Size: [1 1]
              % Moving forward = positive, Not moving = 0
    AV_RAW; % Chassis angular velocity Unit: [rad/s] Size: [1 3] Order: [x y z] Axis: Sensor XYZ
              % Right turn = positive, Left turn = Negative
    IB_RAW; % Battery current Unit: [A] Size: [1 1]
              % Positive torque = Positive current, No torque = 0
    MT_RAW; % Max motor temperature Unit: [C] Size: [1 1]
              % Temperature for each motor is mesured, only max is recieved
    CT_RAW; % Max inverter igbt temperature Unit: [C] Size: [1 1]
              % Temperature for each motor controller is mesured, only max is recieved
    INV_T_RAW; % Max inverter cold plate temperature Unit: [C] Size: [1 1]
              % Temperature for each inverter cold plate is mesured, only max is recieved
    MC_RAW; % Motor overload percentage Unit: [%] Size [1 1]
              % Full torque available = 0%, Only nominal available = 100%
    IC_RAW; % Inverter overload percentage Unit: [%] Size [1 1]
              % Full torque available = 0%, No torque available = 100%
    BT_RAW; % Max battery cell temperature Unit: [C] Size: [1 1]
              % Temperature for each battery cell is mesured, only max is recieved
    TO_RAW; % Motor torque Unit: [Nm] Size: [1 2] Order: [Left Right]
              % Torque to move forward = positive value, No torque = 0, regen = negative
    end

methods
function x = xVCU_master()
    x.TH_RAW = 0;
    x.ST_RAW = 0;
    x.VB_RAW = 600;
    x.WM_RAW = [0 0 0 0];
    x.GS_RAW = 0;
    x.AV_RAW = [0 0 0];
    x.IB_RAW = 0;
    x.MT_RAW = 0;
    x.CT_RAW = 0;
    x.INV_T_RAW = 0;
    x.MC_RAW = 0;
    x.IC_RAW = 0;
    x.BT_RAW = 0;
    x.TO_RAW = 0;
end
end
end