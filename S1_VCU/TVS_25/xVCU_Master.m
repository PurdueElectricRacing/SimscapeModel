classdef xVCU_Master < handle
    %% x properties
    properties
    % Raw Sensor Values
        TH_RAW; % Throttle sensor Unit: [unitless] Size: [1 1]
                % Max Torque = 1, No Torque = 0
        ST_RAW; % Steering angle sensor Unit: [degree] Size: [1 1]
                % Right turn  = positive value, Left turn = negative value
        VB_RAW; % Battery voltage Unit: [V] Size: [1 1]
                % Always positive number, Fully Discharged: 400V Fully charged: 595V
        WT_RAW; % Tire angular velocity, measured by brake disc sensor Unit: [rad/s] Size: [1 2] Order: [Left Right]
                % Moving forward = positive value, Not moving = 0
        WM_RAW; % Motor shaft angular velocity, measured by AMK sensor Unit: [rad/s] Size: [1 2] Order: [Left Right]
                % Moving forward = positive value, Not moving = 0
        GS_RAW; % Vehicle ground speed Unit: [m/s] Size: [1 1]
                % Moving forward = positive value, Not moving = 0
        AV_RAW; % Chassis angular velocity Unit: [rad/s] Size: [1 3] Order: [x y z] Axis: Sensor XYZ
                % Right turn = positive value, Left turn = Negative value
        IB_RAW; % Battery current Unit: [A] Size: [1 1]
                % Positive torque = Positive current, No torque = 0
        MT_RAW; % Max motor temperature Unit: [C] Size: [1 1]
                % Temperature for each motor is mesured, only max is recieved
        CT_RAW; % Max inverter igbt temperature Unit: [C] Size: [1 1]
                % Temperature for each motor controller is mesured, only max is recieved
        IT_RAW; % Max inverter cold plate temperature Unit: [C] Size: [1 1]
                % Temperature for each inverter cold plate is mesured, only max is recieved
        MC_RAW; % Motor overload percentage Unit: [%] Size [1 1]
                % Full torque = 0%, No torque = 100%
        IC_RAW; % Inverter overload percentage Unit: [%] Size [1 1]
                % Full torque = 0%, No torque = 100%
        BT_RAW; % Max battery cell temperature Unit: [C] Size: [1 1]
                % Temperature for each battery cell is mesured, only max is recieved
        AG_RAW; % Chassis acceleration Unit: [m/s^2] Size: [1 3] Order: [x y z] Axis: Sensor XYZ
                % Increasing velocity = positive value, No acceleration = 0
        TO_RAW; % Motor torque Unit: [Nm] Size: [1 2] Order: [Left Right]
                % Torque to move forward = positive value, No torque = 0
        VT_DB_RAW; % Torque vectoring steering angle deadband Unit: [degree] Size: [1 1]
                   % Deadband = positive number, No deadband = 0
        VT_PP_RAW; % Torque vectoring proportional gain Unit: [unitless] Size: [1 1]
                   % Normal behaviour = 0.4, Always go straight = 0
        TC_TR_RAW; % Traction control torque drop ratio when doing slip ratio control Unit: [none] Size: [1 1]
                   % 0: drop torque to 0, 1: no change to torque
        VS_MAX_SR_RAW; % Variable speed maximum allowed slip ratio Unit: [none] Size: [1 1]
                       % 0: No slip = no positive torque 1: double the ground speed
    end

    %% x methods
    methods
        function x = xVCU_Master()
            x.TH_RAW = 0;
            x.ST_RAW = 0;
            x.VB_RAW = 595;
            x.WT_RAW = [0 0];
            x.WM_RAW = [0 0];
            x.GS_RAW = 0;
            x.AV_RAW = [0 0 0];
            x.IB_RAW = 0;
            x.MT_RAW = 20;
            x.CT_RAW = 20;
            x.IT_RAW = 20;
            x.MC_RAW = 0;
            x.IC_RAW = 0;
            x.BT_RAW = 20;
            x.AG_RAW = [0 0 9.81];
            x.TO_RAW = [0 0];
            x.VT_DB_RAW = 12;
            x.VT_PP_RAW = 0.4;
            x.TC_TR_RAW = 0.5;
            x.VS_MAX_SR_RAW = 0.5;
        end
    end
end