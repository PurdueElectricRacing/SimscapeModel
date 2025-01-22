%Last Edited by: Prakhar Drolia
%Last Edited at: 1/18/2025 1:35:011PM

classdef varController_Master_TVS < handle
    %% Controller Properties
    properties
        var;
        yaw_table;
        velocity;
        distance;
        p; % some example property
        ht; %half-track       
        sys_bias; %collection array of the gains
        sys_gain; % collection array of the gains
        add_gain; % general gain for mT_mcT_bT_bI
        rb; %saturation limits
        r_power_sat; %gain for the max power limit
        mT_mcT_bT_bI_maxupp;
        mT_mcT_bT_bI_maxlow;

        % Car Properties
        r; % wheel radius [m]

        % Traction Control (TC) Parameters
        TC_eps; % value added to denominator of sl calculation to  avoid asymptote
        TC_sl_threshold; % slip ratio threshold above which wheel is considered slipping
        TC_throttle_mult; % value to multiply throttle by when TC is engaged [0, 1]
        TC_highs_to_engage; % number of consecutive high (sl >= TC_sl_threshold) sl values before engaging TC
        TC_higs; % counter to track number of consecutive high sl values
        TC_lows_to_disengage; % number of consecutive low (sl < TC_sl_threshold) sl values before engaging TC
        TC_lows; % counter to track number of consecutive low sl values




    end

    %% Controller Methods
    methods
        function varController = varController_Master_TVS()
            varController.p = 1; % assignment of example property

            varController.ht = [0.6490, 0.6210];
            varController.rb = [0,1];
            varController.r_power_sat = 0.5000;

            %maxlimits
            varController.mT_mcT_bT_bI_maxlow = [-50,-50,-50,-1];
            varController.mT_mcT_bT_bI_maxupp = [130, 130, 65, 160];

            var = load("tvs_vars.mat");
            varController.yaw_table = var.yaw_table;        
            varController.velocity = var.v;
            varController.distance = var.s;
            
            mT_bias = -90; 
            mT_gain = -0.1000;
            mcT_bias = -60;
            mcT_gain = -0.1000;
            bT_bias = -50;
            bT_gain = -0.1000;
            bI_bias = -130;
            bI_gain = -0.1000;
            bI_current = [-1;160];

            %constantval arrays
            varController.sys_bias = [mT_bias, mcT_bias, bT_bias, bI_bias];
            varController.sys_gain = [mT_gain, mcT_gain, bT_gain, bI_gain];
            varController.add_gain = [1,1,1,1];

            
        

        end
    end
end