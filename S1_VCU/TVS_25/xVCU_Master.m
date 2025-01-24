classdef xVCU_Master < handle
    %% x properties
    properties
    % Raw Sensor Values
        TH_RAW; % Throttle sensor [unitless] [1 1]
        ST_RAW; % Steering angle sensor [degree] [1 1]
        VB_RAW; % Battery voltage [V] [1 1]
        TM_RAW; % Tire angular velocity [rad/s] [1 2]
        GS_RAW; % Vehicle ground speed [m/s] [1 1]
        AV_RAW; % Chassis angular velocity [rad/s] [1 3]
        IB_RAW; % Battery current [A] [1 1]
        MT_RAW; % Max motor temperature [C] [1 2]
        CT_RAW; % Max motor controller temperature [C] [1 2]
        BT_RAW; % Max battery cell temperature [C] [1 1]
        AG_RAW; % Chassis acceleration [m/s^2] [1 3]
        TO_RAW; % Motor torque [Nm] [1 2]
        DB_RAW; % Torque vectoring steering angle deadband [degree] [1 1]
        PI_RAW; % Torque vectoring intensity [unitless] [1 1]
        PP_RAW; % Torque vectoring proportional gain [unitless] [1 1]
    end

    %% x Methods
    methods
        function x = xVCU_Master()
            x.TH_RAW = 0;
            x.ST_RAW = 0;
            x.VB_RAW = 600;
            x.TM_RAW = [0 0];
            x.GS_RAW = 0;
            x.AV_RAW = [0 0 0];
            x.IB_RAW = 0;
            x.MT_RAW = 20;
            x.CT_RAW = 20;
            x.BT_RAW = 20;
            x.AG_RAW = [0 0 9.81];
            x.TO_RAW = [0 0];
            x.DB_RAW = 12;
            x.PI_RAW = 1;
            x.PP_RAW = 1;
        end
    end
end