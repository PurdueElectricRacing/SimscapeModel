classdef pVCU_master < handle
    % Constant properties of the car and controller
properties
    % Physical car properties
    r;  % tire radius Unit: [m] Size: [1 1]
    ht; % half-track Unit: [m] Size [1 2] Order: [front rear]
    wb; % length of wheelbase Unit: [m] Size[1]
    gr; % gear ratio: tire speed * gr = motor shaft speed Unit: [unitless] Size: [1 1]

    % clip and filter raw signal parameters
    IB_AVG_length; % length of moving average window for battery current draw Unit: [# elements] Size: [1 1]
    
    % Power Baseline (get_BL_PO) parameters
    MAX_TO_ABS_PO; % absolute maxium torque Unit: [Nm] Size: [1 1]
    MAX_ABS_WM; % absolaute maximum motor speed Units: [rad/s] Size [1 1];
    PB_derating_full_T;    % battery power draw when torque derating starts Unit: [kW] Size: [1 1]
    PB_derating_half_T;    % battery power draw when torque derates to half Unit: [kW] Size: [1 1]
    PB_derating_FR;       % 80kW limit derating F:R bias, 0 = only derate front, 1 = only derate rear Unit:[] Size: [1 1]
    VB_derating_full_T;    % Battery voltage when torque derating starts Unit: [V] Size: [1 1]
    VB_derating_zero_T;    % Battery voltage when torque derates to zero Unit: [V] Size: [1 1]
    IB_derating_full_T;    % Battery current when torque derating starts Unit: [A] Size: [1 1]
    IB_derating_zero_T;    % Battery current when torque derates to zero Unit: [A] Size: [1 1]
    

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

end

methods
function p = pVCU_master()
    % Physical car properties
    p.r = 0.2;
    p.ht = [0.6490, 0.6210];
    p.wb = 2;
    p.gr = 12.51;

    % clip and filter raw signal parameters
    p.IB_AVG_length = 10;

    % Baseline (get_BL) parameters
    p.MAX_TO_ABS_PO = 21;
    p.MAX_ABS_WM = 500;
    p.PB_derating_full_T = 75;
    p.PB_derating_half_T = 80;
    p.PB_derating_FR = 0.75;
    p.VB_derating_full_T = 400;
    p.VB_derating_zero_T = 340;
    p.IB_derating_full_T = 200;
    p.IB_derating_zero_T = 230;
    
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
    AC_low_GS = 10;
    AC_high_GS = 50;
    AC_high_slip = 1.2;
    AC_low_W = AC_low_GS / p.r * AC_high_slip;
    p.AC_speed_brkpt = [0, AC_low_GS, AC_high_GS];
    p.AC_speed_table = [AC_low_W, AC_low_W, AC_high_slip * AC_high_GS / p.r];
    p.AC_brkpt_lb = min(p.AC_speed_brkpt);
    p.AC_brkpt_ub = max(p.AC_speed_brkpt);
end
end
end