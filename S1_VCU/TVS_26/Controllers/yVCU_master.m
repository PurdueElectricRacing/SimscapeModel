classdef yVCU_master < handle
    % filtered sensor values; controller output values; internal states
properties
% vcu properties
    VCU_MODE; % current mode of TV board
        % 0 = baseline fallback; 1 = accel; 2 = skidpad
% clipped and filtered raw inputs
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
    WM; % Motor shaft angular velocity (omega motor), measured by AMK sensor Unit: [rad/s] Size: [1 4] Order: [FL FR RL RR]
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
    OV_MOT; % Motor overload percentage Unit: [%] Size [1 4]
              % Full torque available = 0%, Only nominal available = 100%
    OV_INV; % Inverter overload percentage Unit: [%] Size [1 4]
              % Full torque available = 0%, No torque available = 100%
    BT; % Max battery cell temperature Unit: [C] Size: [1 1]
              % Temperature for each battery cell is mesured, only max is recieved
    TO; % Motor torque Unit: [Nm] Size: [1 2] Order: [Left Right]
              % Torque to move forward = positive value, No torque = 0, regen = negative
% Buffers
    IB_AVG_buffer; % Buffer of battery current moving average Units: [A] Size: [1 p.IB_AVG_length]

% calculated values
    PB; % Power drawn from batter Unit: [kW] Size: [1 1]
              % accelerating = positive, regen = negative
    WW; % Tire/Wheel angular velocity (omega), calculated from motor shaft angular velocity Unit: [rad/s] Size: [1 4] Order: [FL FR RL RR]
              % Moving forward = positive value, Not moving = 0
    IB_AVG; % Battery current moving average Unit: [A] Size: [1 1]
              % Positive torque = Positive current, No torque = 0
      

% Power Baseline (get_BL_PO)
    TO_BL_PO; % baseline (power) controller output torques Unit: [Nm] Size: [1 4]

% Regen Baseline (get_BL_RG)
    RG_FR_split % Front:Rear split for derating torque Unit: [] Size: [1 1]
        % 1 = regen only front, 0 = regen only rear; split is always kept, so only front or rear reaches MAX_TO_ABS_RG
    TO_BL_RG;   % baseline (regen) controller output torques Unit: [Nm] Size: [1 4]

% Acceleration Event (get_ACCEL)
    AC_MW; % Motor speed request Unit: [rad/s] Size: [1 4] Order: [FL FR RL RR]
% Skidpad Event (get_SKID)
    SK_TO;       % Motor torque request Unit: [Nm] Size: [1 4] Order: [FL FR RL RR]
    SK_FR_split; % Front-Rear Motor torque split Unit: [unitless] Size: [1 1]
    SK_LR_gain;  % Gain of proporational controller Unit: [1/(rad/s)] Size: [1 1]
% Auto-X Event (get_AUTOX)
    AX_TO;       % Motor torque request Unit: [Nm] Size: [1 4] Order: [FL FR RL RR]
    AX_FR_split; % Front-Rear Motor Torque split Unit: [unitless] Size: [1 1]
    AX_LR_gain;  % Gain of proporational controller Unit: [1/(rad/s)] Size: [1 1]
% Testing/Tuning Mode
    TS_TO        % Motor torque request Unit: [Nm] Size: [1 4] Order: [FL FR RL RR]
    TS_FR_split  % driver tuned FR split Unit: [unitless] Size: [1 1] 1 = all front, 0 = all rear
    TS_LR_split  % driver tuned LR split limit Unit: [unitless] Size: [1 1] 0 = no TV, 0.5 = all torque on left/right when steering enough
% Output
    TORQUE_LIM_NEG; % Speed control negative torque limit Unit: [Nm] Size: [1 4] Order: [FL FR RL RR]
            % Torque to move forward = positive value, No torque = 0, regen = negative
    TORQUE_LIM_POS; % Speed control upper torque limit Unit: [Nm] Size: [1 4] Order: [FL FR RL RR]
            % Torque to move forward = positive value, No torque = 0, regen = negative
    SPEED_OUT; % Motor speed request Unit: [RPM] Size: [1 4] Order: [FL FR RL RR]
            % all calculations are done in rad/s, 
    TORQUE_OUT; % Torque output b/c no speed control :( Unit: [Nm] Size: [1 4] Order: [FL FR RL RR]
            % Torque to move forward = positive value, No torque = 0, regen = negative
end
    
methods
function y = yVCU_master(p)
% vcu properties
    y.VCU_MODE = 0;
% clipped and filtered variables
    y.TH = 0;
    y.TH_PO = 0;
    y.TH_RG = 0;
    y.ST = 0;
    y.VB = 0;
    y.WM = [0 0 0 0];
    y.GS = 0;
    y.AV = [0 0 0];
    y.IB = 0;
    y.MT = 0;
    y.IGBT_T = 0;
    y.INV_T = 0;
    y.OV_INV = [0 0 0 0];
    y.OV_MOT = [0 0 0 0];
    y.BT = 0;
    y.TO = [0 0 0 0];

% Buffers
    y.IB_AVG_buffer = zeros([1, p.IB_AVG_length]);

% Calculated Values
    y.PB = 0;
    y.WW = [0 0 0 0];
    y.IB_AVG = 0;

% Power Baseline (get_BL_PO)
    y.TO_BL_PO = [0 0 0 0];

% Regen Baseline (get_BL_RG)
    y.RG_FR_split = 0.7;
    y.TO_BL_RG = [0 0 0 0];

% Acceleration Event
    y.AC_MW = [0 0 0 0];

% Skidpad Event
    y.SK_TO = [0 0 0 0];
    y.SK_FR_split = 0.4;
    y.SK_LR_gain = 1;

% Auto-X Event
    y.AX_TO = [0 0 0 0];
    y.AX_FR_split = 0;
    y.AX_LR_gain = 1;
% Testing/Tuning Mode
    y.TS_TO = [0 0 0 0];
    y.TS_FR_split = 0.3;
    y.TS_LR_split = 0.1;
% Output
    y.TORQUE_LIM_NEG = [0 0 0 0];
    y.TORQUE_LIM_POS = [0 0 0 0];
    y.SPEED_OUT = [0 0 0 0];
    y.TORQUE_OUT = [0 0 0 0];

end
end
end