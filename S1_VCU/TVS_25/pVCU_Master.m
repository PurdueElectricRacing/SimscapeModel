classdef pVCU_Master < handle

    %% Controller Properties
    properties
        % Car Properties
        r;  % tire radius Unit: [m] Size: [1 1]
        ht; % half-track Unit: [m] Size [1 2] Order: [front rear]
        gr; % gear ratio: tire speed * gr = motor shaft speed Unit: [unitless] Size: [1 1]
        Ns; % number of battery cells in series Unit: [Count] Size [1 1]

        % Vehicle Control Unit (VCU) mode Properties: each is Unit: [count] Size: [1 1]
        PT_permit_N; % number of past PT_permits to store for filtering
        VS_permit_N; % number of past VS_permits to store for filtering
        VT_permit_N; % number of past VT_permits to store for filtering

        % value of each flag indicating proper sensor function: each is Unit: [bool] Size: [1 1]
        CS_SFLAG_True; % Car state CAN signal stale flag
        TB_SFLAG_True; % Throttle-brake CAN signal stale flag
        SS_SFLAG_True; % steering sensor CAN signal stale flag
        WT_SFLAG_True; % Wheel speed sensor CAN signal stale flag
        IV_SFLAG_True; % battery current and voltage CAN signal stale flag
        BT_SFLAG_True; % max battery cell temperature CAN signal stale flag
        IAC_SFLAG_True; % Inverter A overload and motor torque and speed CAN signal stale flag
        IAT_SFLAG_True; % Inverter A temperatures stale flag
        IBC_SFLAG_True; % Inverter B overload and motor torque and speed CAN signal stale flag
        IBT_SFLAG_True; % Inverter B temperatures stale flag

        SS_FFLAG_True; % steering sensor proper sensor function flag
        AV_FFLAG_True; % angular velocity sensor proper sensor function flag
        GS_FFLAG_True; % gps proper sensor function flag
        VCU_PFLAG_VS;  % value of VCU_PFLAG to allow variable speed (VS) mode
        VCU_PFLAG_VT;  % value of VCU_PFLAG to allow variable torque (VT) mode
        VCU_CFLAG_CS;  % value of VCU_CFLAG to control speed (CS)
        VCU_CFLAG_CT;  % value of VCU_CFLAG to control torque (CT)

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
        VT_DB_lb; % minimum allowed variable torque steering angle deadband Unit: [degree] Size: [1 1]
        TV_PP_lb; % minimum allowed torque vectoring proportional gain Unit: [unitless] Size: [1 1]
        TC_TR_lb; % minimum allowed traction control torque drop ratio Unit: [none] Size: [1 1]
        VS_MAX_SR_lb; % minimum allowed max slip ratio Unit: [none] Size: [1 1]

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
        VT_DB_ub; % maximum allowed variable torque steering angle deadband Unit: [degree] Size: [1 1]
        TV_PP_ub; % maximum allowed torque vectoring proportional gain Unit: [unitless] Size: [1 1]
        TC_TR_ub; % maximum allowed traction control torque drop ratio Unit: [none] Size: [1 1]
        VS_MAX_SR_ub; % maximum allowed max slip ratio Unit: [none] Size: [1 1]

        % Clip and filter (CF) variables
        CF_IB_filter_N; % the number of data points to use for battery current moving mean filter
        R; % The transformation matrix mapping from imu xyz to vehicle xyz coordinate system
        W_CF_SELECTION; % pick which wheel speed measurements are used 0: Tire only, 1: AMK only, 2: both

        % Batttery SOC Estimation
        Batt_Voc_brk; % single cell battery voltage at Batt_AsDischarged_tbl amp-seconds of capacity USED
        Batt_As_Discharged_tbl % capacity DRAINED from single cell [amp-seconds]
        zero_currents_to_update_SOC; % number of consecutive zero battery current measurements before using battery voltage to update SOC

        Batt_cell_zero_SOC_voltage;  % cell voltage that is considered to be zero state of charge Unit: [V]
        Batt_cell_zero_SOC_capacity; % capacity DRAINED from cell at zero SOC, calculated from Batt_cell_zero_SOC_voltage Unit: [amp-seconds]
        Batt_cell_full_SOC_voltage;  % cell voltage that is considered to be full state of charge Unit: [V]
        Batt_cell_full_SOC_capacity; % capacity DRAINED from cell at full SOC, calculated from Batt_cell_zero_SOC_voltage Unit: [amp-seconds]

        % Baseline (BL) parameters
        MAX_SPEED_NOM; % nominal maximum allowed speed setpoints to be sent to motors Unit: [rad/s] Size [1 1]
        MAX_TORQUE_NOM; % nominal maximum allowed torque setpoint to be sent to motors Unit: [Nm] Size: [1 1]

        % Proportional Torque (PT) Parameters
        PT_WM_brkpt;  % motor shaft angular velocity breakpoints Unit: [rad/s]
        PT_VB_brkpt;  % inverter supply voltage breakpoints Unit: [V]
        PT_TO_table;  % max motor torque table [rad/s, V] -> [Nm]
        PT_WM_lb; % minimum allowed motor shaft angular velocity for max torque table Unit: [rad/s] Size: [1 2] Order: [Left Right]
        PT_WM_ub; % maximum allowed motor shaft angular velocity for max torque table Unit: [rad/s] Size: [1 2] Order: [Left Right]
        PT_VB_lb; % minimum allowed battery voltage for max torque table Unit: [V] Size: [1 1]
        PT_VB_ub; % maximum allowed battery voltage for max torque table Unit: [V] Size: [1 1]

        mT_derating_full_T; % motor temperature when torque derating starts Unit: [C] Size: [1 1]
        mT_derating_zero_T; % motor temperature when torque derates to 0 Unit: [C] Size: [1 1]
        cT_derating_full_T; % inverter igbt temperature when torque derating starts Unit: [C] Size: [1 1]
        cT_derating_zero_T; % inverter igbt temperature when torque derates to 0 Unit: [C] Size: [1 1]
        bT_derating_full_T; % battery temperature when torque derating starts Unit: [C] Size: [1 1]
        bT_derating_zero_T; % battery temp when torque derates to 0 Unit: [C] Size: [1 1]
        bI_derating_full_T; % battery current when torque derating starts Unit: [A] Size: [1 1]
        bI_derating_zero_T; % battery current when torque derates to 0 Unit: [A] Size: [1 1]
        Vb_derating_full_T; % battery voltage when torque derating starts Unit: [V] Size: [1 1]
        Vb_derating_zero_T; % battery voltage when torque derates to 0 Unit: [V] Size: [1 1]
        Ci_derating_full_T; % inverter igbt overload when torque derating starts Unit: [%] Size: [1 1]
        Ci_derating_zero_T; % inverter igbt overload when torque derates to 0 Unit: [%] Size: [1 1]
        Cm_derating_full_T; % motor overload when torque derating starts Unit: [%] Size: [1 1]
        Cm_derating_zero_T; % motor overload when torque derates to 0 Unit: [%] Size: [1 1]
        iT_derating_full_T; % inverter Cold Plate temperature when torque derating starts Unit: [C] Size: [1 1]
        iT_derating_zero_T; % inverter Cold PLate temperature when torque derates to 0 Unit: [C] Size: [1 1]
        
        % Variable Torque (VT) mode Properties
        dST_DB; % Steering angle hysteresis [degree]

        % Torque Vectoring (TV) Parameters
        MAX_r;       % gain for torque difference between left and right
        TV_GS_brkpt; % velocity breakpoints for yaw rate table
        TV_ST_brkpt; % steering angle breakpoints for yaw rate table
        TV_AV_table; % steady-state yaw rate as function of velocity and steering angle
        TV_ST_lb;    % minimum allowed steering angle for yaw table Unit: [degree] Size: [1 1]
        TV_ST_ub;    % maximum allowed steering angle for yaw table Unit: [degree] Size: [1 1]
        TV_GS_lb;    % maximum allowed vehicle ground speed for yaw table Unit: [m/s] Size: [1 1]
        TV_GS_ub;    % maximum allowed vehicle ground speed for yaw table Unit: [m/s] Size: [1 1]
        TV_PI;       % Torque vectoring intensity Unit: [unitless] Size: [1 1] Normal Behaviour = 1, Always go straight = 0

        % Traction Control (TC) Parameters
        TC_eps;               % value added to denominator of sl calculation to  avoid asymptote
        TC_SR_threshold;      % slip ratio threshold above which wheel is considered slipping
        TC_highs_to_engage;   % number of consecutive high (sl >= TC_sl_threshold) sl values before engaging TC
        TC_lows_to_disengage; % number of consecutive low (sl < TC_sl_threshold) sl values before engaging TC

        % Variable Speed (VS) Parameters
        WM_VS_LS; % reference motor shaft speed for low speed scenarios Unit: [rad/s] Size: [1 1]
    end

    %% Controller Methods
    methods
        function p = pVCU_Master()
            % Car Properties
            p.r = 0.2;
            p.ht = [0.6490, 0.6210];
            p.gr = 11.34;
            p.Ns = 145;

            % Vehicle Control Unit (VCU) mode Properties
            p.PT_permit_N = 5;
            p.VS_permit_N = 5;
            p.VT_permit_N = 5;

            p.CS_SFLAG_True = 0;
            p.TB_SFLAG_True = 0;
            p.SS_SFLAG_True = 0;
            p.WT_SFLAG_True = 0;
            p.IV_SFLAG_True = 0;
            p.BT_SFLAG_True = 0;
            p.IAC_SFLAG_True = 0;
            p.IAT_SFLAG_True = 0;
            p.IBC_SFLAG_True = 0;
            p.IBT_SFLAG_True = 0;

            p.SS_FFLAG_True = 1;
            p.AV_FFLAG_True = 1;
            p.GS_FFLAG_True = 3;
            p.VCU_PFLAG_VS = 3;
            p.VCU_PFLAG_VT = 4;
            p.VCU_CFLAG_CS = 1;
            p.VCU_CFLAG_CT = 2;

            p.TH_lb = -0.01;
            p.ST_lb = -170;
            p.VB_lb = 150;
            p.WT_lb = [-2 -2];
            p.WM_lb = [-22 -22];
            p.GS_lb = -0.40;
            p.AV_lb = [-2.5 -2.5 -2.5];
            p.IB_lb = -2;
            p.MT_lb = 0;
            p.CT_lb = 0;
            p.IT_lb = 0;
            p.MC_lb = -1;
            p.IC_lb = -1;
            p.BT_lb = 0;
            p.AG_lb = [-30 -30 -30];
            p.TO_lb = [-0.25 -0.25];
            p.VT_DB_lb = 0;
            p.TV_PP_lb = 0.1;
            p.TC_TR_lb = 0;
            p.VS_MAX_SR_lb = 0;

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
            p.IT_ub = 60;
            p.MC_ub = 100;
            p.IC_ub = 100;
            p.BT_ub = 60;
            p.AG_ub = [30 30 30];
            p.TO_ub = [25 25];
            p.VT_DB_ub = 25;
            p.TV_PP_ub = 10;
            p.TC_TR_ub = 1.0;
            p.VS_MAX_SR_ub = 1.0;

            % Clip and filter (CF) variables
            p.CF_IB_filter_N = 10;

            p.R = load("Construct_pVCU/Processed_Data/R.mat").R;

            p.W_CF_SELECTION = 1;

            % Battery SOC Estimation
            [Batt_SOC_table] = load("Construct_pVCU/Processed_Data/battery_SOC_Tbl.mat");
            p.Batt_Voc_brk = Batt_SOC_table.Voc;
            p.Batt_As_Discharged_tbl = Batt_SOC_table.AsDischarged;

            p.Batt_cell_zero_SOC_voltage = 2;
            p.Batt_cell_zero_SOC_capacity = interp1(p.Batt_Voc_brk, p.Batt_As_Discharged_tbl, p.Batt_cell_zero_SOC_voltage);
            p.Batt_cell_full_SOC_voltage = 4;
            p.Batt_cell_full_SOC_capacity = interp1(p.Batt_Voc_brk, p.Batt_As_Discharged_tbl, p.Batt_cell_full_SOC_voltage);

            p.zero_currents_to_update_SOC = 60;

            % Baseline (BL) parameters
            p.MAX_SPEED_NOM = 2000;
            p.MAX_TORQUE_NOM = 21;

            % Proportional Torque (PT) Parameters
            var = load("Construct_pVCU/Processed_Data/torque_table.mat");
            p.PT_WM_brkpt = var.speedT_brk;
            p.PT_VB_brkpt = var.voltageT_brk;
            p.PT_TO_table = var.maxT_tbl;
            p.PT_WM_lb = min(p.PT_WM_brkpt);
            p.PT_WM_ub = max(p.PT_WM_brkpt);
            p.PT_VB_lb = min(p.PT_VB_brkpt);
            p.PT_VB_ub = max(p.PT_VB_brkpt);

            p.mT_derating_full_T = 120;
            p.mT_derating_zero_T = 130;
            p.cT_derating_full_T = 120;
            p.cT_derating_zero_T = 130;
            p.bT_derating_full_T = 55;
            p.bT_derating_zero_T = 65;
            p.bI_derating_full_T = 145;
            p.bI_derating_zero_T = 160;
            p.Vb_derating_full_T = 400;
            p.Vb_derating_zero_T = 300;
            p.Ci_derating_full_T = 0;
            p.Ci_derating_zero_T = 1;
            p.Cm_derating_full_T = 0;
            p.Cm_derating_zero_T = 1;
            p.iT_derating_full_T = 55;
            p.iT_derating_zero_T = 65;

            % Variable Torque (VT) mode Properties
            p.dST_DB = 5;

            % Torque Vectoring (TV) Parameters
            p.MAX_r = 0.5;
            
            var = load("Construct_pVCU/Processed_Data/yaw_table.mat");
            p.TV_AV_table = var.yaw_table;       
            p.TV_GS_brkpt = var.v;
            p.TV_ST_brkpt = var.s;
            p.TV_ST_lb = min(p.TV_ST_brkpt);
            p.TV_ST_ub = max(p.TV_ST_brkpt);
            p.TV_GS_lb = min(p.TV_GS_brkpt);
            p.TV_GS_ub = max(p.TV_GS_brkpt);
            p.TV_PI = 1;
            
            % Traction Control (TC) Parameters
            p.TC_eps = 1;
            p.TC_SR_threshold = 0.2;
            p.TC_highs_to_engage = 5;
            p.TC_lows_to_disengage = 2;

            % Variable Speed (VS) Parameters
            p.WM_VS_LS = 10;
        end
    end
end
