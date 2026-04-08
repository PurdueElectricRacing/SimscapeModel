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

function y = get_BL_PO(p, y)
    % max torque allowed by throttle position
    TO_ET_PO = y.TH_PO * p.MAX_TO_ABS_PO .* [1 1 1 1];

    % 80kW rules limit derating on battery power
    % only derating to 50% total torque, F:R derating split can be changed
    PB_snipped = snip(y.PB, p.PB_derating_full_T, p.PB_derating_half_T);
    PB_derate_front = interp1([p.PB_derating_full_T, p.PB_derating_half_T], [1,1-p.PB_derating_FR], PB_snipped);
    PB_derate_rear = interp1([p.PB_derating_full_T, p.PB_derating_half_T], [1,p.PB_derating_FR], PB_snipped);
    PB_derate = [PB_derate_front, PB_derate_front, PB_derate_rear, PB_derate_rear];

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

    % Battery undervoltage safety derating
    VB_snipped = snip(y.VB, p.VB_derating_full_T, p.VB_derating_zero_T);
    VB_derate = [1 1 1 1] * interp1([p.VB_derating_full_T, p.VB_derating_zero_T], [1,0], VB_snipped);

    % Battery current safety derating
    IB_snipped = snip(y.IB, p.IB_derating_full_T, p.IB_derating_zero_T);
    IB_derate = [1 1 1 1] * interp1([p.IB_derating_full_T, p.IB_derating_zero_T], [1,0], IB_snipped);
    
    % combine derating, multiply by abs max torque to get maximum torque allowed
    TO_DR_MAX = p.MAX_TO_ABS_PO * min([PB_derate; INV_T_derate; IGBT_T_derate; MT_derate; BT_derate; VB_derate; IB_derate], [], 1);

    % compute overall maximum torque
    y.TO_BL_PO = min(TO_ET_PO, TO_DR_MAX);
end