%Last Edited by: Prakhar Drolia
%Last Edited at: 1/18/2025 1:35:011PM

classdef pVCU_Master < handle
    %% Controller Properties
    properties
        % Car Properties
        r; % wheel radius [m]
        ht; % half-track [m]
        gr; % gear ratio: wheel * gr = motor [unitless]

        % VCU mode Properties
        % value of each flag indicating proper sensor function
        CS_SFLAG_True; % Car state CAN signal stale flag
        TB_SFLAG_True; % Throttle-brake CAN signal stale flag
        SS_SFLAG_True; % steering sensor CAN signal stale flag
        WT_SFLAG_True; % Wheel speed sensor CAN signal stale flag
        IV_SFLAG_True; % battery current and voltage CAN signal stale flag
        BT_SFLAG_True; % max battery cell temperature CAN signal stale flag
        MT_SFLAG_True; % max motor temperature CAN signal stale flag
        CT_SFLAG_True; % max motor controller temperature CAN signal stale flag
        MO_SFLAG_True; % motor torque CAN signal stale flag
        SS_FFLAG_True; % steering sensor proper sensor function flag
        AV_FFLAG_True; % angular velocity sensor proper sensor function flag
        GS_FFLAG_True; % gps proper sensor function flag
        VT_PFLAG_True; % variable torque permit flag

        % minimum value for each sensor indicating proper sensor function
        TH_lb; % minimum allowed throttle Unit: [unitless] Size: [1 1]
        ST_lb; % minimum allowed steering angle sensor Unit: [degree] Size: [1 1]
        VB_lb; % minimum allowed battery voltage Unit: [V] Size: [1 1]
        WT_lb; % minimum allowed tire angular velocity Unit: [rad/s] Size: [1 2] Order: [Left Right]
        GS_lb; % minimum allowed vehicle ground speed Unit: [m/s] Size: [1 1]
        AV_lb; % minimum allowed chassis angular velocity Unit: [rad/s] Size: [1 3] Order: [x y z]
        IB_lb; % minimum allowed battery current Unit: [A] Size: [1 1]
        MT_lb; % minimum allowed max motor temperature Unit: [C] Size: [1 1]
        CT_lb; % minimum allowed max motor controller temperature Unit: [C] Size: [1 1]
        BT_lb; % minimum allowed max battery cell temperature Unit: [C] Size: [1 1]
        AG_lb; % minimum allowed chassis acceleration Unit: [m/s^2] Size: [1 3] Order: [x y z]
        TO_lb; % minimum allowed motor torque Unit: [Nm] Size: [1 2] Order: [Left Right]
        DB_lb; % minimum allowed torque vectoring steering angle deadband Unit: [degree] Size: [1 1]
        PI_lb; % minimum allowed torque vectoring intensity Unit: [unitless] Size: [1 1]
        PP_lb; % minimum allowed torque vectoring proportional gain Unit: [unitless] Size: [1 1]

        % maximum value for each sensor indicating proper sensor function
        TH_ub; % maximum allowed throttle indicating proper sensor function Unit: [unitless] Size: [1 1]
        ST_ub; % maximum allowed steering angle sensor Unit: [degree] Size: [1 1]
        VB_ub; % maximum allowed battery voltage Unit: [V] Size: [1 1]
        WT_ub; % maximum allowed tire angular velocity Unit: [rad/s] Size: [1 2] Order: [Left Right]
        GS_ub; % maximum allowed vehicle ground speed Unit: [m/s] Size: [1 1]
        AV_ub; % maximum allowed chassis angular velocity Unit: [rad/s] Size: [1 3] Order: [x y z]
        IB_ub; % maximum allowed battery current Unit: [A] Size: [1 1]
        MT_ub; % maximum allowed max motor temperature Unit: [C] Size: [1 1]
        CT_ub; % maximum allowed max motor controller temperature Unit: [C] Size: [1 1]
        BT_ub; % maximum allowed max battery cell temperature Unit: [C] Size: [1 1]
        AG_ub; % maximum allowed chassis acceleration Unit: [m/s^2] Size: [1 3] Order: [x y z]
        TO_ub; % maximum allowed motor torque Unit: [Nm] Size: [1 2] Order: [Left Right]
        DB_ub; % maximum allowed torque vectoring steering angle deadband Unit: [degree] Size: [1 1]
        PI_ub; % maximum allowed torque vectoring intensity Unit: [unitless] Size: [1 1]
        PP_ub; % maximum allowed torque vectoring proportional gain Unit: [unitless] Size: [1 1]

        % Clip and filter (CF) variables
        CF_IB_filter; % the number of data points to use for battery current moving mean filter

        % Proportional Torque (PT) Parameters
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
        function p = pVCU_Master()
            % VCU mode Properties
            p.CS_SFLAG_True = 0;
            p.TB_SFLAG_True = 0;
            p.SS_SFLAG_True = 0;
            p.WT_SFLAG_True = 0;
            p.IV_SFLAG_True = 0;
            p.BT_SFLAG_True = 0;
            p.MT_SFLAG_True = 0;
            p.CT_SFLAG_True = 0;
            p.MO_SFLAG_True = 0;
            p.SS_FFLAG_True = 1;
            p.AV_FFLAG_True = 1;
            p.GS_FFLAG_True = 3;
            p.VT_PFLAG_True = 1;

            p.TH_lb = 0;
            p.ST_lb = -170;
            p.VB_lb = 150;
            p.WT_lb = [0 0];
            p.GS_lb = 0;
            p.AV_lb = [-2.5 -2.5 -2.5];
            p.IB_lb = 0;
            p.MT_lb = 15;
            p.CT_lb = 15;
            p.BT_lb = 15;
            p.AG_lb = [-30 -30 -30];
            p.TO_lb = [0 0];
            p.DB_lb = 0;
            p.PI_lb = 0.5;
            p.PP_lb = 0.1;

            p.TH_ub = 1;
            p.ST_ub = 170;
            p.VB_ub = 600;
            p.WT_ub = [200 200];
            p.GS_ub = 40;
            p.AV_ub = [2.5 2.5 2.5];
            p.IB_ub = 200;
            p.MT_ub = 140;
            p.CT_ub = 75;
            p.BT_ub = 60;
            p.AG_ub = [30 30 30];
            p.TO_ub = [25 25];
            p.DB_ub = 25;
            p.PI_ub = 10;
            p.PP_ub = 10;

            % Car Properties
            p.r = 0.2;
            p.ht = [0.6490, 0.6210];

            % Saturation and filter (SF) variables
            p.CF_IB_filter = 10;

            % VT mode selection

            % Proportional Torque (PT) Parameters
            load("TorqueTable.mat");
            p.torq_interpolant = torqInterpolant;

            % Torque Vectoring (TV) Parameters
            p.rb = [0,1];
            p.r_power_sat = 0.5000;

            p.mT_mcT_bT_bI_maxlow = [-50,-50,-50,-1];
            p.mT_mcT_bT_bI_maxupp = [130, 130, 65, 160];

            var = load("Construct_pVCU\Processed Data\yaw_table.mat");
            p.yaw_table = var.yaw_table;        
            p.velocity = var.v;
            p.distance = var.s;
            
            mT_bias = -90; 
            mT_gain = -0.1000;
            mcT_bias = -60;
            mcT_gain = -0.1000;
            bT_bias = -50;
            bT_gain = -0.1000;
            bI_bias = -130;
            bI_gain = -0.1000;
            bI_current = [-1;160];

            p.sys_bias = [mT_bias, mcT_bias, bT_bias, bI_bias];
            p.sys_gain = [mT_gain, mcT_gain, bT_gain, bI_gain];
            p.add_gain = [1,1,1,1];
            
            % Traction Control (TC) Parameters
            p.TC_eps = 1;
            p.TC_sl_threshold = 0.2;
            p.TC_throttle_mult = 0.5;
            p.TC_highs_to_engage = 5;
            p.TC_lows_to_disengage = 2;
        end
    end
end