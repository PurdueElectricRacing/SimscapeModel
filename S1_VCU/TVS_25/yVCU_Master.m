classdef yVCU_Master < handle
    %% y properties
    properties
    % Clip and filter (CF) variables
        IB_CF_vec; % vector of the past N battery current measurements

        TH_CF; % Throttle sensor Unit: [unitless] Size: [1 1]
                % Max Torque = 1, No Torque = 0
        ST_CF; % Steering angle sensor Unit: [degree] Size: [1 1]
                % Right turn  = positive value, Left turn = negative value
        VB_CF; % Battery voltage Unit: [V] Size: [1 1]
                % Always positive number
        WT_CF; % Tire angular velocity Unit: [rad/s] Size: [1 2] Order: [Left Right]
                % Moving forward = positive value, Not moving = 0
        GS_CF; % Vehicle ground speed Unit: [m/s] Size: [1 1]
                % Moving forward = positive value, Not moving = 0
        AV_CF; % Chassis angular velocity Unit: [rad/s] Size: [1 3] Order: [x y z]
                % Right turn = positive value, Left turn = Negative value
        IB_CF; % Battery current Unit: [A] Size: [1 1]
                % Positive torque = Positive current, No torque = 0
        MT_CF; % Max motor temperature Unit: [C] Size: [1 1]
                % Temperature for each motor is mesured, only max is recieved
        CT_CF; % Max motor controller temperature Unit: [C] Size: [1 1]
                % Temperature for each motor controller is mesured, only max is recieved
        BT_CF; % Max battery cell temperature Unit: [C] Size: [1 1]
                % Temperature for each battery cell is mesured, only max is recieved
        AG_CF; % Chassis acceleration Unit: [m/s^2] Size: [1 3] Order: [x y z]
                % Increasing velocity = positive value, No acceleration = 0
        TO_CF; % Motor torque Unit: [Nm] Size: [1 2] Order: [Left Right]
                % Torque to move forward = positive value, No torque = 0
        DB_CF; % Torque vectoring steering angle deadband Unit: [degree] Size: [1 1]
                % Deadband = positive number, No deadband = 0
        PI_CF; % Torque vectoring intensity Unit: [unitless] Size: [1 1]
                % Normal Behaviour = 1, Always go straight = 0
        PP_CF; % Torque vectoring proportional gain Unit: [unitless] Size: [1 1]
                % Normal behaviour = 0.4, Always go straight = 0

    % Traction Control (TC) variables
        TC_highs; % counter to track number of consecutive high sl values
        TC_lows; % counter to track number of consecutive low sl values
    end

    %% y Methods
    methods
        function y = yVCU_Master(p)
            % Clip and filter (CF) variables
            y.IB_CF_vec = ones(1,p.SF_IB_filter);

            y.TH_CF = 0;
            y.ST_CF = 0;
            y.VB_CF = 600;
            y.WT_CF = [0 0];
            y.GS_CF = 0;
            y.AV_CF = [0 0 0];
            y.IB_CF = 0;
            y.MT_CF = 20;
            y.CT_CF = 20;
            y.BT_CF = 20;
            y.AG_CF = [0 0 9.81];
            y.TO_CF = [0 0];
            y.DB_CF = 12;
            y.PI_CF = 1;
            y.PP_CF = 1;

            % Traction Control (TC) variables
            y.TC_highs = 0;
            y.TC_lows = 0;
        end
    end
end