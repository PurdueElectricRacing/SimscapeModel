classdef pVCU_master < handle
    % Constant properties of the car and controller
properties
    % Physical car properties
    r;  % tire radius Unit: [m] Size: [1 1]
    ht; % half-track Unit: [m] Size [1 2] Order: [front rear]
    wb; % length of wheelbase Unit: [m] Size[1]
    gr; % gear ratio: tire speed * gr = motor shaft speed Unit: [unitless] Size: [1 1]
    
    % Baseline (get_BL) parameters
    MAX_TO_ABS; % absolute maxium torque Unit: [Nm] Size: [1 1]

    % derating parameters
    PB_derating_full_T;    % battery power draw when torque derating starts Unit: [kW] Size: [1 1]
    PB_derating_half_T;    % battery power draw when torque derates to half Unit: [kW] Size: [1 1]
    PB_derate_front;       % 80kW limit derating F:R bias, 0 = only derate front, 1 = only derate rear Unit:[] Size: [1 1]
    INV_T_derating_full_T; % inverter temperature when torque derating starts Unit: [C] Size: [1 1]
    INV_derating_zero_T;   % inverter temperature when torque derates to zero Unit: [C] Size: [1 1]
    IGBT_derating_full_T;  % IGBT temperature when torque derating starts Unit: [C] Size: [1 1]
    IGBT_derating_zero_T;  % IGBT temperature when torque derates to zero Unit: [C] Size: [1 1]
    MT_derating_full_T;    % Motor temperature when torque derating starts Unit: [C] Size: [1 1]
    MT_derating_zero_T;    % Motor temperature when torque derates to zero Unit: [C] Size: [1 1]
    BT_derating_full_T;    % Battery temperature when torque derating starts Unit: [C] Size: [1 1]
    BT_derating_zero_T;    % Battery temperature when torque derates to zero Unit: [C] Size: [1 1]
    VB_derating_full_T;    % Battery voltage when torque derating starts Unit: [V] Size: [1 1]
    VB_derating_zero_T;    % Battery voltage when torque derates to zero Unit: [V] Size: [1 1]
    IB_derating_full_T;    % Battery current when torque derating starts Unit: [A] Size: [1 1]
    IB_derating_zero_T;    % Battery current when torque derates to zero Unit: [A] Size: [1 1]

end

methods
function p = pVCU_master()
    % Physical car properties
    p.r = 0.2;
    p.ht = [0.6490, 0.6210];
    p.wb = 2;
    p.gr = 11.34;

    % Baseline (get_BL) parameters
    p.MAX_TO_ABS = 21;
    
    % derating parameters
    p.PB_derating_full_T = 70;
    p.PB_derating_half_T = 75;
    p.PB_derate_front = 0.75;
    p.INV_T_derating_full_T = 50; % !! change this to current safe limit !!
    p.INV_derating_zero_T = 60; % !! change this to current safe limit !!
    p.IGBT_derating_full_T = 115; % !! change this to current safe limit !!
    p.IGBT_derating_zero_T = 125; % !! change this to current safe limit !!
    p.MT_derating_full_T = 125; % !! change this to current safe limit !!
    p.MT_derating_zero_T = 140; % !! change this to current safe limit !!
    p.BT_derating_full_T = 60; % !! change this to current safe limit !!
    p.BT_derating_zero_T = 55; % !! change this to current safe limit !!
    p.VB_derating_full_T = 430; % !!!! change this to current safe limit !!!!
    p.VB_derating_zero_T = 370; % !!!! change this to current safe limit !!!!
    p.IB_derating_full_T = 145; % !!!! change this to current safe limit !!!!
    p.IB_derating_zero_T = 160; % !!!! change this to current safe limit !!!!
end
end
end