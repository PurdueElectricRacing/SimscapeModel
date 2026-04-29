classdef xVCU_master < handle
% Raw sensor values
properties
% Raw dashboard controls
    VCU_MODE_REQ; % requested vcu mode from dashboard
        % 0 = accel; 1 = skidpad; 2 = autocross; 3 = endurance

% Raw Sensor Values
    THROT_RAW; % Throttle sensor Unit: [unitless] Size: [1 1]
              % Full throttle = 1, No throttle = 0
    BRAKE_RAW; % Brake sensor Unit: [unitless] Size: [1 1]\
              % Full brake = 1, No brake = 0
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
    IGBT_T_RAW; % Max inverter igbt temperature Unit: [C] Size: [1 1]
              % Temperature for each motor controller is mesured, only max is recieved
    INV_T_RAW; % Max inverter cold plate temperature Unit: [C] Size: [1 1]
              % Temperature for each inverter cold plate is mesured, only max is recieved
    MC_RAW; % Motor overload percentage Unit: [%] Size [1 4]
              % Full torque available = 0%, Only nominal available = 100%
    IC_RAW; % Inverter overload percentage Unit: [%] Size [1 4]
              % Full torque available = 0%, No torque available = 100%
    BT_RAW; % Max battery cell temperature Unit: [C] Size: [1 1]
              % Temperature for each battery cell is mesured, only max is recieved
    TO_RAW; % Motor torque Unit: [Nm] Size: [1 4] Order: [FL FR RL RR]
              % Torque to move forward = positive value, No torque = 0, regen = negative
% Driver Set Values
  % Regen
    RG_split_FR_RAW; % Front:Rear split for derating torque Unit: [] Size: [1 1]
                     % 1 = regen only front, 0 = regen only rear
  % Skidpad
    SK_FR_split_RAW;  % Skidpad static Front:Rear Torque split Unit: [unitless] Size: [1 1]
                      % 1 = all torque front, 0 = all torque rear, 0.5 = full split
    SK_LR_gain_RAW;       % Skidpad gain of proporational controller Unit: [1/(rad/s)] Size: [1 1]
  % Auto-X
    AX_FR_split_RAW;  % Autocross static Front:Rear Torque split Unit: [unitless] Size: [1 1]
                        % 1 = all torque front, 0 = all torque rear, 0.5 = full split
    AX_LR_gain_RAW;       % Skidpad gain of proporational controller Unit: [1/(rad/s)] Size: [1 1]
    end

methods
function x = xVCU_master()
% Raw Dashboard Values
    x.VCU_MODE_REQ = 0;
% Raw Sensor Values
    x.THROT_RAW = 0;
    x.BRAKE_RAW = 0;
    x.ST_RAW = 0;
    x.VB_RAW = 600;
    x.WM_RAW = [0 0 0 0];
    x.GS_RAW = 0;
    x.AV_RAW = [0 0 0];
    x.IB_RAW = 0;
    x.MT_RAW = 0;
    x.IGBT_T_RAW = 0;
    x.INV_T_RAW = 0;
    x.MC_RAW = [0 0 0 0];
    x.IC_RAW = [0 0 0 0];
    x.BT_RAW = 0;
    x.TO_RAW = [0 0 0 0];
% Driver Set Values
% Regen
    x.RG_split_FR_RAW = 0.7;
% Skidpad
    x.SK_FR_split_RAW = 0.4;
    x.SK_LR_gain_RAW = 1;
% Autocross
    x.AX_FR_split_RAW = 0;
    x.AX_LR_gain_RAW = 0;
end
end
end