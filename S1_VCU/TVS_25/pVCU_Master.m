%Last Edited by: Prakhar Drolia
%Last Edited at: 1/18/2025 1:35:011PM

classdef pVCU_Master < handle
    %% Controller Properties
    properties
        % Car Properties
        r; % wheel radius [m]
        ht; % half-track [m]

        % Signal Properties
        F_True; % the value of the integer flag for true output
        D_lb;   % lower bound allowable measured value such that proper sensor function is occuring
        D_ub;   % upper bound allowable measured value such that proper sensor function is occuring

        % Proportional Throttle (PT) Parameters
        torq_interpolant; % Interpolant for maximum Torque

        % Torque Vectoring (TV) Parameters
        sys_bias; %collection array of the gains
        sys_gain; % collection array of the gains
        add_gain; % general gain for mT_mcT_bT_bI
        rb; %saturation limits
        r_power_sat; %gain for the max power limit
        mT_mcT_bT_bI_maxupp;
        mT_mcT_bT_bI_maxlow;
        yaw_table;
        velocity;
        distance;

        % Traction Control (TC) Parameters
        TC_eps; % value added to denominator of sl calculation to  avoid asymptote
        TC_sl_threshold; % slip ratio threshold above which wheel is considered slipping
        TC_throttle_mult; % value to multiply throttle by when TC is engaged [0, 1]
        TC_highs_to_engage; % number of consecutive high (sl >= TC_sl_threshold) sl values before engaging TC
        TC_lows_to_disengage; % number of consecutive low (sl < TC_sl_threshold) sl values before engaging TC
    end

    %% Controller Methods
    methods
        function varVCU = pVCU_Master()
            % Signal Properties
            varVCU.F_True = [0 0 0 0 0 0 0 0 0 1 1 3 1];
            varVCU.D_lb = [0 -170 150 0 0 0 -2.5 -2.5 -2.5 0 15 15 15 15 15 -30 -30 -30 0 0 0 0.5 0.1];
            varVCU.D_ub = [1  170 600 2000 2000 40 2.5 2.5 2.5 200 140 140 75 75 60 30 30 30 25 25 25 10 10];

            % Car Properties
            varVCU.r = 0.2;
            varVCU.ht = [0.6490, 0.6210];

            % VT mode selection

            % Proportional Throttle (PT) Parameters
            load("TorqueTable.mat");
            varVCU.torq_interpolant = torqInterpolant;

            % Torque Vectoring (TV) Parameters
            varVCU.rb = [0,1];
            varVCU.r_power_sat = 0.5000;

            varVCU.mT_mcT_bT_bI_maxlow = [-50,-50,-50,-1];
            varVCU.mT_mcT_bT_bI_maxupp = [130, 130, 65, 160];

            var = load("tvs_vars.mat");
            varVCU.yaw_table = var.yaw_table;        
            varVCU.velocity = var.v;
            varVCU.distance = var.s;
            
            mT_bias = -90; 
            mT_gain = -0.1000;
            mcT_bias = -60;
            mcT_gain = -0.1000;
            bT_bias = -50;
            bT_gain = -0.1000;
            bI_bias = -130;
            bI_gain = -0.1000;
            bI_current = [-1;160];

            varVCU.sys_bias = [mT_bias, mcT_bias, bT_bias, bI_bias];
            varVCU.sys_gain = [mT_gain, mcT_gain, bT_gain, bI_gain];
            varVCU.add_gain = [1,1,1,1];
            
            % Traction Control (TC) Parameters
            varVCU.TC_eps = 1;
            varVCU.TC_sl_threshold = 0.2;
            varVCU.TC_throttle_mult = 0.5;
            varVCU.TC_highs_to_engage = 5;
            varVCU.TC_lows_to_disengage = 2;
        end
    end
end