%% Function Description
% vcu_step runs every loop on the TV board
%
% Inputs
%   p   vehicle paramater struct. constant
%   x   Raw sensor data struct. filled with data read from CAN
%           in main.c
%   y   Function input and output struct. contains all clipped and
%           filtered variables, variable buffers, and output from
%           this function.
% Outputs
%   y   modified version of input y



function y = get_BL_RG(p,y)
    % max torque regen allowed by throttle position, subject to F:R balance
    m = max(y.RG_FR_split, 1-y.RG_FR_split);
    split_FR = [y.RG_FR_split / m, y.RG_FR_split / m, (1-y.RG_FR_split) / m, (1-y.RG_FR_split) / m];
    TO_ET_RG = y.TH_RG * p.MAX_TO_ABS_RG .* split_FR;

    % derating due to speed regulations (no regen below 5 km/hr)
    GS_from_WW = min(y.WW * p.r); % estimate groundspeed from wheelspeed, take slowest tire Units: [m/s]
    GS_from_WW_snipped = snip(GS_from_WW, p.GS_RG_derating_full, p.GS_RG_derating_zero);
    GS_RG_derate = [1 1 1 1] * interp1([p.GS_RG_derating_full, p.GS_RG_derating_zero], [1,0], GS_from_WW_snipped);
    
    % Inverter temp safetey derating - derate all motors based on highest inverter temp
    INV_T_snipped = snip(y.INV_T, p.INV_T_derating_full_T, p.INV_T_derating_zero_T);
    INV_T_derate = [1 1 1 1] * interp1([p.INV_T_derating_full_T, p.INV_T_derating_zero_T], [1,0], INV_T_snipped);

    % IGBT temp safety derating - derate all motors based on highest IGBT temp
    IGBT_T_snipped = snip(y.IGBT_T, p.IGBT_T_derating_full_T, p.IGBT_T_derating_zero_T);
    IGBT_T_derate = [1 1 1 1] * interp1([p.IGBT_T_derating_full_T, p.IGBT_T_derating_zero_T], [1,0], IGBT_T_snipped);

    % Motor temp safetey derating - derate all motors based on highest motor temp
    MT_snipped = snip(y.MT, p.MT_derating_full_T, p.MT_derating_zero_T);
    MT_derate = [1 1 1 1] * interp1([p.MT_derating_full_T, p.MT_derating_zero_T], [1,0], MT_snipped);

    % Battery temp safety derating - derate all motors based on highest cell temp
    BT_snipped = snip(y.BT, p.BT_derating_full_T, p.BT_derating_zero_T);
    BT_derate = [1 1 1 1] * interp1([p.BT_derating_full_T, p.BT_derating_zero_T], [1,0], BT_snipped);

    % Battery overvoltage safety derating
    VB_RG_snipped = snip(y.VB, p.VB_RG_derating_full_T, p.VB_RG_derating_zero_T);
    VB_RG_derate = [1 1 1 1] * interp1([p.VB_RG_derating_full_T, p.VB_RG_derating_zero_T], [1,0], VB_RG_snipped);

    % Battery current safety derating
    IB_RG_snipped = snip(y.IB_AVG, p.IB_RG_derating_full_T, p.IB_RG_derating_zero_T);
    IB_RG_derate = [1 1 1 1] * interp1([p.IB_RG_derating_full_T, p.IB_RG_derating_zero_T], [1,0], IB_RG_snipped);
    
    % combine derating, multiply by abs max torque to get maximum torque allowed
    TO_RG_MAX = p.MAX_TO_ABS_RG * min([INV_T_derate; IGBT_T_derate; MT_derate; BT_derate; VB_RG_derate; IB_RG_derate; GS_RG_derate], [], 1);

    % compute overall maximum torque
    y.TO_BL_RG = min(TO_ET_RG, TO_RG_MAX);
    y.TO_BL_RG = -1 * y.TO_BL_RG;




