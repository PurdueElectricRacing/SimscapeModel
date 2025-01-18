% A direct translation of the simulink model:
% Torque_Vectoring_2WD_NO_FILTER_NO_REGEN

% please fill in varController_Master_TVS.m with parameters
var = load("tvs_vars.mat");



inp = [50, 50, 50, 50];%mT_mcT_bT_bI =  %inp currently is initialised still even though final will be the mT... to still be able to test logic in program

m_temp_max = [-50; 130];
mc_temp_max = [-50; 130];
bt_temp_max = [-50; 65];
bI_current = [-1; 160];

inp(1) = clip(inp(1), m_temp_max(1), m_temp_max(2))


% this block of code should be in varController_Master_TVS.m
sys_bias = [-90, -60, -50, -130];
sys_gain = [-0.1000, 0.1000, 0.1000, 0.1000];
add_gain = [1,1,1,1];

%paraminp = [mT_mcT_bT_bI]

measures = [] %should be a struct
% a single variable should contain all parameters, and a single struct should contain all time varying inputs
% as in, you should only be passing in two inputs to this function
r_TVS = compute_r_TVS(inp, sys_bias, sys_gain, add_gain, var,1, 0, [1, 1, 1], 15, 120, 13, 1, 1)

function r_TVS = compute_r_TVS(inp, sys_bias, sys_gain, add_gain, var, r_EQUAL, lo_constant, ang_vel,vel_gs, phi, dphi, TVS_I, TVS_P)
%function r_TVS = compute_r_TVS(inp, model, measures)
    minT_safety = min(((inp+sys_bias).*sys_gain) + add_gain);

    min_saturation_out = clip(minT_safety, var.rb(1), var.rb(2)); %brought in clip

    powerlimit = clip(r_EQUAL, 0, min_saturation_out) %0 was lo_constant, should it be constant input or a variable

    phi_sat = clip(phi, -130, 130); %brought in clip instead of if else

    % this code looks like a computer generated it, please make it compact like I did for computing the variable minT_safety 
    
    % wtf if with the constant 3 

    raw_dR = (-(ang_vel(3)))+((var.yaw_table(vel_gs, 3)).*TVS_I).*TVS_P.*var.half_track;    

    lo = (powerlimit.*var.r_power_sat).*-1;  %variable name
    up = (powerlimit.*var.r_power_sat);

    %arrcheck = [up, raw_dR, lo]; %variable removed to be edited - up
    e = clip(raw_dR, lo, up) %brought in clip

    function_inp_u = e.*(abs(phi_sat) > dphi);

    if function_inp_u > 0
        r_TVS = [powerlimit powerlimit-abs(function_inp_u)];
    else
        r_TVS = [powerlimit-abs(function_inp_u) powerlimit];
    end
end
                

