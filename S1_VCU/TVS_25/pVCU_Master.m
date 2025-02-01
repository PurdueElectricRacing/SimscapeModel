%Last Edited by: Prakhar Drolia
%Last Edited at: 1/18/2025 1:35:011PM

classdef pVCU_Master < handle
    %% p properties
    properties
        % Car Properties
        r; % wheel radius [m]
        ht; % half-track [m]
        gr; % gear ratio: wheel * gr = motor [unitless]

        % Battery Properties
        series; % number of battery cells in series
        Batt_cell_zero_SOC_voltage; % cell voltage that is considered to be zero state of charge [V]
        Batt_cell_zero_SOC_capacity; % capacity drained from cell at zero SOC, calculated from Batt_cell_zero_SOC_voltage [amp-seconds]

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
        WM_lb; % minimum allowed motor shaft angular velocity Unit: [rad/s] Size: [1 2] Order: [Left Right]
        GS_lb; % minimum allowed vehicle ground speed Unit: [m/s] Size: [1 1]
        AV_lb; % minimum allowed chassis angular velocity Unit: [rad/s] Size: [1 3] Order: [x y z]
        IB_lb; % minimum allowed battery current Unit: [A] Size: [1 1]
        MT_lb; % minimum allowed max motor temperature Unit: [C] Size: [1 1]
        CT_lb; % minimum allowed max inverter igbt temperature Unit: [C] Size: [1 1]
        IT_lb; % minimum allowed max inverter cold plate temperature Unit: [C] Size: [1 1]
        MC_lb; % minimum allowed motor overload percentage Unit: [%] Size [1 1]
        IC_lb; % minimum allowed inverter overload percentage Unit: [%] Size [1 1]
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
        WM_ub; % minimum allowed motor shaft angular velocity Unit: [rad/s] Size: [1 2] Order: [Left Right]
        GS_ub; % maximum allowed vehicle ground speed Unit: [m/s] Size: [1 1]
        AV_ub; % maximum allowed chassis angular velocity Unit: [rad/s] Size: [1 3] Order: [x y z]
        IB_ub; % maximum allowed battery current Unit: [A] Size: [1 1]
        MT_ub; % maximum allowed max motor temperature Unit: [C] Size: [1 1]
        CT_ub; % maximum allowed max inverter igbt temperature Unit: [C] Size: [1 1]
        IT_ub; % maximum allowed max inverter cold plate temperature Unit: [C] Size: [1 1]
        MC_ub; % maximum allowed motor overload percentage Unit: [%] Size [1 1]
        IC_ub; % maximum allowed inverter overload percentage Unit: [%] Size [1 1]
        BT_ub; % maximum allowed max battery cell temperature Unit: [C] Size: [1 1]
        AG_ub; % maximum allowed chassis acceleration Unit: [m/s^2] Size: [1 3] Order: [x y z]
        TO_ub; % maximum allowed motor torque Unit: [Nm] Size: [1 2] Order: [Left Right]
        DB_ub; % maximum allowed torque vectoring steering angle deadband Unit: [degree] Size: [1 1]
        PI_ub; % maximum allowed torque vectoring intensity Unit: [unitless] Size: [1 1]
        PP_ub; % maximum allowed torque vectoring proportional gain Unit: [unitless] Size: [1 1]

        % Clip and filter (CF) variables
        CF_IB_filter; % the number of data points to use for battery current moving mean filter
        R; % the transformation matrix from sensor NED to vehicle NED for IMU

        % Equal Torque (ET) Parameters
        MAX_TORQUE_NOM; % nominal maximum allowed torque to be sent to motors Unit: [Nm]

        % Proportional Torque (PT) Parameters
        torq_interpolant; % Interpolant for maximum Torque

        mT_derating_full_T; % motor temp [C] when torque derating starts
        mT_derating_zero_T; % motor temp [C] when torque derates to 0
        mcT_derating_full_T; % motor controller temp [C] when torque deratin
        mcT_derating_zero_T; % motor controller temp when [C] torque derates
        bT_derating_full_T; % battery temp when torque [C] derating starts
        bT_derating_zero_T; % battery temp when torque [C] derates to 0
        bI_derating_full_T; % battery current when torque [A] derating start
        bI_derating_zero_T; % battery current when torque [A] derates to 0
        
        % VT mode Properties
        dST_DB; % Steering angle hysteresis [degree]

        % Torque Vectoring (TV) Parameters
        rb; %saturation limits
        r_power_sat; %gain for the max power limit

        TV_yaw_table;
        TV_vel_brkpt;
        TV_phi_brkpt;

        % Traction Control (TC) Parameters
        TC_eps; % value added to denominator of sl calculation to  avoid asymptote
        TC_sl_threshold; % slip ratio threshold above which wheel is considered slipping
        TC_throttle_mult; % value to multiply throttle by when TC is engaged [0, 1]
        TC_highs_to_engage; % number of consecutive high (sl >= TC_sl_threshold) sl values before engaging TC
        TC_lows_to_disengage; % number of consecutive low (sl < TC_sl_threshold) sl values before engaging TC

        % Batttery SOC Estimation
        Batt_Voc_brk; % single cell battery voltage at Batt_AsDischarged_tbl amp-seconds of capacity used
        Batt_As_Discharged_tbl % capacity drained from single cell [amp-seconds]
        zero_currents_to_update_SOC; % number of consecutive zero battery current measurements before using battery voltage to update SOC
    end

    %% p methods
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
            p.WM_lb = [0 0];
            p.GS_lb = 0;
            p.AV_lb = [-2.5 -2.5 -2.5];
            p.IB_lb = 0;
            p.MT_lb = 15;
            p.CT_lb = 15;
            p.IT_lb = 15;
            p.MC_lb = 0;
            p.IC_lb = 0;
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
            p.WM_ub = [2200 2200];
            p.GS_ub = 40;
            p.AV_ub = [2.5 2.5 2.5];
            p.IB_ub = 200;
            p.MT_ub = 140;
            p.CT_ub = 75;
            p.IT_lb = 60;
            p.MC_ub = 100;
            p.IC_ub = 100;
            p.BT_ub = 60;
            p.AG_ub = [30 30 30];
            p.TO_ub = [25 25];
            p.DB_ub = 25;
            p.PI_ub = 10;
            p.PP_ub = 10;

            % Car Properties
            p.r = 0.2;
            p.ht = [0.6490, 0.6210];
            g.gr = 11.34;

            % Saturation and filter (SF) variables
            p.CF_IB_filter = 10;
            p.R = load("Construct_pVCU\Processed Data\R.mat").R;

            % VT mode Properties
            p.dST_DB = 5;

            % Equal Torque (ET) Parameters
            p.MAX_TORQUE_NOM = 21;

            % Proportional Torque (PT) Parameters
            load("TorqueTable.mat");
            p.torq_interpolant = torqInterpolant;
            p.mT_derating_full_T = 120;
            p.mT_derating_zero_T = 130;
            p.mcT_derating_full_T = 120;
            p.mcT_derating_zero_T = 130;
            p.bT_derating_full_T = 55;
            p.bT_derating_zero_T = 65;
            p.bI_derating_full_T = 145;
            p.bI_derating_zero_T = 160;

            % Torque Vectoring (TV) Parameters
            p.rb = [0,1];
            p.r_power_sat = 0.5000;
            
            var = load("Construct_pVCU\Processed Data\yaw_table.mat");
            p.TV_yaw_table = var.yaw_table;        
            p.TV_vel_brkpt = var.v;
            p.TV_phi_brkpt = var.s;
            
            % Traction Control (TC) Parameters
            p.TC_eps = 1;
            p.TC_sl_threshold = 0.2;
            p.TC_throttle_mult = 0.5;
            p.TC_highs_to_engage = 5;
            p.TC_lows_to_disengage = 2;

            % Battery SOC Estimation
            [Batt_SOC_table] = load("Construct_pVCU\Processed Data\battery_SOC_Tbl.mat");
            p.Batt_Voc_brk = Batt_SOC_table.Voc;
            p.Batt_As_Discharged_tbl = Batt_SOC_table.AsDischarged;
            p.zero_currents_to_update_SOC = 60;

            % Battery Properties
            p.series = 150;
            p.Batt_cell_zero_SOC_voltage = 2; 
            p.Batt_cell_zero_SOC_capacity = interp1(p.Batt_Voc_brk, p.Batt_As_Discharged_tbl, p.Batt_cell_zero_SOC_capacity);
        end
    end
end