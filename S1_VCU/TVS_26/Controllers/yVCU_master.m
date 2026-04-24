YUclassdef yVCU_master < handle
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
    OV_MOT; % Motor overload percentage Unit: [%] Size [1 1]
              % Full torque available = 0%, Only nominal available = 100%
    OV_INV; % Inverter overload percentage Unit: [%] Size [1 1]
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
    TO_BL_RG; % baseline (regen) controller output torques Unit: [Nm] Size: [1 4]

% Acceleration Event (get_ACCEL)
    AC_MW; % Motor speed request Unit: [rad/s] Size: [1 4] Order: [FL FR RL RR]
% Skidpad Event (get_SKID)
    SK_TO; % Motor torque request Unit: [Nm] Size: [1 4] Order: [FL FR RL RR]

% Output
    TORQUE_LIM_NEG; % Speed control negative torque limit Unit: [Nm] Size: [1 4] Order: [FL FR RL RR]
            % Torque to move forward = positive value, No torque = 0, regen = negative
    TORQUE_LIM_POS; % Speed control upper torque limit Unit: [Nm] Size: [1 4] Order: [FL FR RL RR]
            % Torque to move forward = positive value, No torque = 0, regen = negative
    SPEED_OUT; % Motor speed request Unit: [RPM] Size: [1 4] Order: [FL FR RL RR]
            % all calculations are done in rad/s, 
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
    y.MC = 0;
    y.IC = 0;
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
    y.TO_BL_RG = [0 0 0 0];

% Acceleration Event
    y.AC_MW = [0 0 0 0];

% Skidpad Event
    y.SK_TO = [0 0 0 0];

% Output
    y.TORQUE_LIM_NEG = [0 0 0 0];
    y.TORQUE_LIM_POS = [0 0 0 0];
    y.SPEED_OUT = [0 0 0 0];

end
end
end