classdef yVCU_Master < handle
    %% y properties
    properties
    % VCU mode variables
        PT_permit_buffer; % vector of the past N PT_permits
        VS_permit_buffer; % vector of the past N VS_permits
        VT_permit_buffer; % vector of the past N VT_permits
        VCU_mode; % vcu mode; 1 = equal throttle (ET), 2 = proportional toruq (PT), 3 = variable speed (VS), 4 = variable torque (VT)

    % Clip and filter (CF) variables
        IB_CF_buffer; % vector of the past N battery current measurements

        TH_CF; % Throttle sensor Unit: [unitless] Size: [1 1]
               % Max Torque = 1, No Torque = 0
        ST_CF; % Steering angle sensor Unit: [degree] Size: [1 1]
               % Right turn  = positive value, Left turn = negative value
        VB_CF; % Battery voltage Unit: [V] Size: [1 1]
               % Always positive number
        WT_CF; % Tire angular velocity, measured by brake disc sensor Unit: [rad/s] Size: [1 2] Order: [Left Right]
               % Moving forward = positive value, Not moving = 0
        WM_CF; % Motor shaft angular velocity, measured by brake disc sensor Unit: [rad/s] Size: [1 2] Order: [Left Right]
               % Moving forward = positive value, Not moving = 0
        W_CF;  % The official tire angular velcity Unit: [rad/s] Size: [1 2] Order: [Left Right]
               % Moving forward = positive value, Not moving = 0
        GS_CF; % Vehicle ground speed Unit: [m/s] Size: [1 1]
               % Moving forward = positive value, Not moving = 0
        AV_CF; % Chassis angular velocity Unit: [rad/s] Size: [1 3] Order: [x y z] Axis: Vehicle XYZ
               % Right turn = positive value, Left turn = Negative value
        IB_CF; % Battery current Unit: [A] Size: [1 1]
               % Positive torque = Positive current, No torque = 0
        MT_CF; % Max motor temperature Unit: [C] Size: [1 1]
               % Temperature for each motor is mesured, only max is recieved
        CT_CF; % Max inverter igbt temperature Unit: [C] Size: [1 1]
               % Temperature for each motor controller is mesured, only max is recieved
        IT_CF; % Max inverter cold plate temperature Unit: [C] Size: [1 1]
               % Temperature for each inverter cold plate is mesured, only max is recieved
        MC_CF; % Motor overload percentage Unit: [%] Size [1 1]
               % Full torque = 0%, No torque = 100%
        IC_CF; % Inverter overload percentage Unit: [%] Size [1 1]
               % Full torque = 0%, No torque = 100%
        BT_CF; % Max battery cell temperature Unit: [C] Size: [1 1]
               % Temperature for each battery cell is mesured, only max is recieved
        AG_CF; % Chassis acceleration Unit: [m/s^2] Size: [1 3] Order: [x y z] Axis: Vehicle XYZ
               % Increasing velocity = positive value, No acceleration = 0
        TO_CF; % Motor torque Unit: [Nm] Size: [1 2] Order: [Left Right]
               % Torque to move forward = positive value, No torque = 0
        VT_DB_CF; % Variable torque steering angle deadband Unit: [degree] Size: [1 1]
                  % Deadband = positive number, No deadband = 0
        TV_PP_CF; % Torque vectoring proportional gain Unit: [unitless] Size: [1 1]
                  % Normal behaviour = 0.4, Always go straight = 0
        TC_TR_CF; % Traction control torque drop ratio when doing slip ratio control Unit: [none] Size: [1 1]
                  % 0: drop torque to 0, 1: no change to torque
        VS_MAX_SR_CF; % Variable speed maximum allowed slip ratio Unit: [none] Size: [1 1]
                      % 0: No slip = maintain current speed 1: double the ground speed

       zero_current_counter; % consecutive zero battery current readings

        Batt_SOC; % estimated state of charge of battery [0 to 1], only updated when battery current is 0
        Batt_Voc; % estimated open circuit voltage of battery [300 600], only updated when battery current is 0

    % Equal Torque under Speed Control, or constant speed (CS)
        WM_CS; % Maximum allowed speed setpoint in SC mode Unit: [rad/s] Size [1 2]

    % Equal Torque (ET) variables
        TO_ET; % Torque setpoint for motors in ET mode Unit: [Nm] Size: [1 2]

    % Proportional Torque (PT) variables
        TO_AB_MX; % Max torque due to inherent motor characteristics and nominal behaviour Unit: [Nm] Size: [1 1]
        TO_DR_MX; % Max torque due to derating functions Unit: [Nm] Size: [1 1]
        TO_PT; % Torque setpoint for motors in PT mode Unit: [Nm] Size: [1 2]

    % Variable Torque (VT) variables
        VT_mode; % variable torque mode; 1 = traction control, 2 = torque vectoring
        TO_VT;   % Torque setpoint for motors in variable torque mode Unit: [Nm] Size: [1 2]

    % Torque Vectoring (TV) variables
        TV_AV_ref; % Yaw rate reference Unit: [rad/s] Size: [1 1]
        TV_delta_torque; % Actual delta torque between left and right Unit: [Nm] Size: [1 1]

    % Traction Control (TC) variables
        TC_highs; % counter to track number of consecutive high sl values
        TC_lows; % counter to track number of consecutive low sl values
        SR; % slip ratio of tires Unit: [(m/s)/(m/s)] Size: [1 1]

    % Variable Speed (VS) variables
        WM_VS; % Reference motor shaft angular velocity Unit: [rad/s] Size: [1 2]
        SR_VS; % Reference slip ratio Unit: [none] Size: [1 1]
    end

    %% y methods
    methods
        function y = yVCU_Master(p)
        % VCU mode variables
            y.PT_permit_buffer = zeros(1,p.PT_permit_N);
            y.VS_permit_buffer = zeros(1,p.VS_permit_N);
            y.VT_permit_buffer = zeros(1,p.VT_permit_N);
            y.VCU_mode = 1;

        % Clip and filter (CF) variables
            y.IB_CF_buffer = zeros(1,p.CF_IB_filter_N);

            y.TH_CF = 0;
            y.ST_CF = 0;
            y.VB_CF = 595;
            y.WT_CF = [0 0];
            y.WM_CF = [0 0];
            y.W_CF = [0 0];
            y.GS_CF = 0;
            y.AV_CF = [0 0 0];
            y.IB_CF = 0;
            y.MT_CF = 20;
            y.CT_CF = 20;
            y.IT_CF = 20;
            y.MC_CF = 0;
            y.IC_CF = 0;
            y.BT_CF = 20;
            y.AG_CF = [0 0 9.81];
            y.TO_CF = [0 0];
            y.VT_DB_CF = 12;
            y.TV_PP_CF = 0.4;
            y.TC_TR_CF = 0.5;
            y.VS_MAX_SR_CF = 0.5;

        % Battery SOC variables
            y.zero_current_counter = 0;

            y.Batt_SOC = 1;
            y.Batt_Voc = 595;

        % Equal Torque under Speed Control, or constant speed (CS) variables
            y.WM_CS = [0 0];

        % Equal Torque (ET) variables
            y.TO_ET = [0 0];
    
        % Proportional Torque (PT) variables
            y.TO_AB_MX = 21;
            y.TO_DR_MX = 21;
            y.TO_PT = [0 0];

        % Variable Torque (VT) variables
            y.VT_mode = 1;
            y.TO_VT = [0 0];

        % Torque Vectoring (TV) variables
            y.TV_AV_ref = 0;
            y.TV_delta_torque = 0;

        % Traction Control (TC) variables
            y.TC_highs = 0;
            y.TC_lows = 0;
            y.SR = 0;

        % Variable Speed (VS) variables
            y.WM_VS = [0 0];
            y.SR_VS = 0;
        end
    end
end