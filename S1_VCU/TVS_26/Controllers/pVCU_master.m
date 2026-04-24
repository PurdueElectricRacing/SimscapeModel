classdef pVCU_master < handle
    % Constant properties of the car and controller
properties
    % Physical car properties
    r;  % tire radius Unit: [m] Size: [1 1]
    ht; % half-track Unit: [m] Size [1 2] Order: [front rear]
    wb; % length of wheelbase Unit: [m] Size[1]
    gr; % gear ratio: tire speed * gr = motor shaft speed Unit: [unitless] Size: [1 1]
    MAX_ABS_WM; % absolaute maximum motor speed Units: [rad/s] Size [1 1];

    % clip and filter raw signal parameters
    IB_AVG_length; % length of moving average window for battery current draw Unit: [# elements] Size: [1 1]
    
    % Power Baseline (get_BL_PO) parameters
    MAX_TO_ABS_PO; % absolute maxium torque Unit: [Nm] Size: [1 1]
    PB_derating_full_T;    % battery power draw when torque derating starts Unit: [kW] Size: [1 1]
    PB_derating_half_T;    % battery power draw when torque derates to half Unit: [kW] Size: [1 1]
    PB_derating_FR;       % 80kW limit derating F:R bias, 0 = only derate front, 1 = only derate rear Unit:[] Size: [1 1]
    VB_derating_full_T;    % Battery voltage when torque derating starts Unit: [V] Size: [1 1]
    VB_derating_zero_T;    % Battery voltage when torque derates to zero Unit: [V] Size: [1 1]
    IB_derating_full_T;    % Battery current when torque derating starts Unit: [A] Size: [1 1]
    IB_derating_zero_T;    % Battery current when torque derates to zero Unit: [A] Size: [1 1]
    OV_MOT_derating_full_T;% Motor Overload when torque starts derating Unit: [%] Size [1 1]
    OV_MOT_derating_zero_T;% Motor Overload when torque derates to zero Unit: [%] Sie [1 1]
    OV_INV_derating_full_T;% Inverter Overload when torque starts derating Unit: [%] Size [1 1]
    OV_INV_derating_zero_T;% Inverter Overload when torque derates to zero Unit: [%] Sie [1 1]

    % Regen Baseline (get_BL_RG) parameters
    MAX_TO_ABS_RG; % absolute maxium torque Unit: [Nm] Size: [1 1]
    VB_RG_derating_full_T;    % Battery voltage when torque derating starts Unit: [V] Size: [1 1]
    VB_RG_derating_zero_T;    % Battery voltage when torque derates to zero Unit: [V] Size: [1 1]
    IB_RG_derating_full_T;    % Battery current when torque derating starts Unit: [A] Size: [1 1]
    IB_RG_derating_zero_T;    % Battery current when torque derates to zero Unit: [A] Size: [1 1]
    GS_RG_derating_zero;      % Ground Speed when regen torque derated to zero Unit: [m/s] Size: [1 1]
    GS_RG_derating_full;      % Ground Speed when regen torque start Unit: [m/s] Size: [1 1]
    RG_split_FR;              % Front:Rear split for derating torque Unit: [] Size: [1 1]
                              % 1 = regen only front, 0 = regen only rear; split is always kept, so only front or rear reaches MAX_TO_ABS_RG

    % Common Derating Parameters (get_BL_PO & get_BL_RG)
    INV_T_derating_full_T; % inverter temperature when torque derating starts Unit: [C] Size: [1 1]
    INV_T_derating_zero_T;   % inverter temperature when torque derates to zero Unit: [C] Size: [1 1]
    IGBT_T_derating_full_T;  % IGBT temperature when torque derating starts Unit: [C] Size: [1 1]
    IGBT_T_derating_zero_T;  % IGBT temperature when torque derates to zero Unit: [C] Size: [1 1]
    MT_derating_full_T;    % Motor temperature when torque derating starts Unit: [C] Size: [1 1]
    MT_derating_zero_T;    % Motor temperature when torque derates to zero Unit: [C] Size: [1 1]
    BT_derating_full_T;    % Battery temperature when torque derating starts Unit: [C] Size: [1 1]
    BT_derating_zero_T;    % Battery temperature when torque derates to zero Unit: [C] Size: [1 1]

    % Accel controller parameters
    % 1d look table for accel speed control
    AC_speed_brkpt; % Input: groundspeed Units: [m/s]
    AC_speed_table; % Output: wheelspeed Units: [rad/s]
    AC_brkpt_lb; % min value of wheelspeed breakpoints Units: [rad/s]
    AC_brkpt_ub; % max value of wheelspeed breakpoints Units: [rad/s]

    % Skidpad controller parameters
    SK_YAW_des;       % 'desire best' steady state yaw rate for skidpad Units: [rad/s]
    SK_LR_split_des;  % desired Left:Right torque split at that desired yaw rate
                          % 1 = all torque on left during right turn; 0.5 = no TV
    SK_FR_split;      % static Front:Rear torque split; 1 = all torque front
    SK_LR_gain;       % gain of proporational controller Units: [1/(rad/s)]
    SK_ST_ZERO_TV;    % steering angle below which no TV Units: [deg]
    SK_ST_FULL_TV;    % steering angle above which full TV Units: [deg]
end

methods
function p = pVCU_master()
    % Physical car properties
    p.r = 0.2;
    p.ht = [0.6490, 0.6210];
    p.wb = 2;
    p.gr = 12.51;
    p.MAX_ABS_WM = 500;

    % clip and filter raw signal parameters
    p.IB_AVG_length = 10;

    % Baseline (get_BL) parameters
    p.MAX_TO_ABS_PO = 21;
    p.PB_derating_full_T = 75;
    p.PB_derating_half_T = 80;
    p.PB_derating_FR = 0.75;
    p.VB_derating_full_T = 400;
    p.VB_derating_zero_T = 340;
    p.IB_derating_full_T = 200;
    p.IB_derating_zero_T = 230;
    p.OV_MOT_derating_full_T = 50;
    p.OV_MOT_derating_zero_T = 100;
    p.OV_INV_derating_full_T = 50;
    p.OV_INV_derating_zero_T = 100;
    
    % Regen Baseline (get_BL_RG) parameters
    p.MAX_TO_ABS_RG = 5;
    p.VB_RG_derating_full_T = 340; % !!!! change this to current safe limit !!!!
    p.VB_RG_derating_zero_T = 400; % !!!! change this to current safe limit !!!!
    p.IB_RG_derating_full_T = -145; % !!!! change this to current safe limit !!!!
    p.IB_RG_derating_zero_T = -160; % !!!! change this to current safe limit !!!!
    p.GS_RG_derating_full = 10 * 1000/3600; % 10 kmph
    p.GS_RG_derating_zero = 5 * 1000/3600; % 5 kmph
    p.RG_split_FR = 0.7;

    % Common Derating Parameters (get_BL_PO & get_BL_RG)a
    p.INV_T_derating_full_T = 50;
    p.INV_T_derating_zero_T = 60;
    p.IGBT_T_derating_full_T = 115;
    p.IGBT_T_derating_zero_T = 125;
    p.MT_derating_full_T = 125;
    p.MT_derating_zero_T = 140;
    p.BT_derating_full_T = 55;
    p.BT_derating_zero_T = 60;

    % Accel controller parameters
    % 1d look table for accel speed control
    AC_low_WW = 70; % constant wheelspeed at low speeds Units: [rad/s]
    AC_high_SR = 1.1; % Slip ratio at high speeds Units: []
    AC_high_offset = 0; % Vertical offset of slip ratio at high speeds Units: [rad/s]

        AC_corner_GS = (AC_low_WW-AC_high_offset) / AC_high_SR; % groundspeed at transistion
        AC_top_GS = p.MAX_ABS_WM / p.gr * p.r; % groundpseed at max motor speed
        AC_top_WW = AC_top_GS * AC_high_SR / p.r + AC_high_offset; % calculated wheelspeed at max motor speed
        p.AC_speed_brkpt = [0, AC_corner_GS, AC_top_GS];
        p.AC_speed_table = [AC_low_WW, AC_low_WW, AC_top_WW];
        p.AC_brkpt_lb = min(p.AC_speed_brkpt);
        p.AC_brkpt_ub = max(p.AC_speed_brkpt);
    
    % skidpad controller parameters
    SK_vel_des = 11.4; % desired 'best' velocity for skidpad Units: [m/s]
    SK_rad_des = 9.125; % radius of skidpad circle (9.125 = skidpad center;
    p.SK_YAW_des = SK_vel_des / SK_rad_des; % CALCED
    p.SK_LR_split_des = 0.6;
    p.SK_FR_split = 0.4;
    p.SK_LR_gain = 1;
    p.SK_ST_ZERO_TV = 10;
    p.SK_ST_FULL_TV = 25;
end
end
end