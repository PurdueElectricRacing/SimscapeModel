% A direct translation of the simulink model:
% Torque_Vectoring_2WD_NO_FILTER_NO_REGEN

% please fill in varController_Master_TVS.m with parameters
var = load("tvs_vars.mat");

% inp is not a super descriptive name mT_mcT_bT_bI
inp = [50, 50, 50, 50];

m_temp_max = [-50; 130];
mc_temp_max = [-50; 130];
bt_temp_max = [-50; 65];
bI_current = [-1; 160];

% this block of code should be in varController_Master_TVS.m
sys_bias = [var.mT_bias, var.mcT_bias, var.bT_bias, var.bI_bias];
sys_gain = [var.mT_gain, var.mcT_gain, var.bT_gain, var.bI_gain];
add_gain = [1,1,1,1];

% a single variable should contain all parameters, and a single struct should contain all time varying inputs
% as in, you should only be passing in two inputs to this function
r_TVS = compute_r_TVS(inp, sys_bias, sys_gain, add_gain, var,1, 0, [1, 1, 1], 15, 120, 13, 1, 1)

function r_TVS = compute_r_TVS(inp, sys_bias, sys_gain, add_gain, var, r_EQUAL, lo_constant, ang_vel,vel_gs, phi, dphi, TVS_I, TVS_P)

    % please write code that is compact and easy to read
    minT_safety = min(((inp+sys_bias).*sys_gain) + add_gain); % [inp(1)+sys_bias(1), inp(2)+sys_bias(2), inp(3)+sys_bias(3), inp(4)+sys_bias(4)];
    % gained_inp = inp.*sys_gain;
    % gained_bias = [gained_inp(1)+add_gain(1), gained_inp(2)+add_gain(2), gained_inp(3)+add_gain(3), gained_inp(4)+add_gain(4)];
    % min_out = min(gained_bias);

    min_saturation_out = min(max(minT_safety, var.rb(1)), var.rb(2)) % always end with a semicolon

    % this is wrong, these two lines should be identical to computing min_saturation_out, but using different variables for the max and min
    arrcheck = [r_EQUAL, lo_constant, min_saturation_out];
    powerlimit = max(arrcheck);
    

    if -130<phi<130 % you should check phi > 130 on first line, -130 > phi next line
        phi_sat = phi;
    elseif -130>phi
        phi_sat = -130;
    else
        phi_sat = 130;
    end

    % this code looks like a computer generated it, please make it compact like I did for computing the variable minT_safety 
    yaw_lookup = var.yaw_table(vel_gs, 3); % wtf if with the constant 3

    ref_yaw = yaw_lookup.*TVS_I;

    ang_z = ang_vel(3); 

    yaw_error = (-ang_z)+ref_yaw;
    
    error_prod = yaw_error.*TVS_P;
     
    raw_dR = error_prod.*var.half_track;

    up = powerlimit.*var.r_power_sat;

    lo = up.*-1;  

    % again, this is wrong for the same reason as the above arrcheck
    arrcheck = [up, raw_dR, lo];

    % again, this looks wton
    e = max(arrcheck);

    steering = abs(phi_sat) > dphi;

    function_inp_u = e.*steering;

    if function_inp_u > 0
        r_TVS = [powerlimit powerlimit-abs(function_inp_u)];
    else
        r_TVS = [powerlimit-abs(function_inp_u) powerlimit];
    end
end
                

