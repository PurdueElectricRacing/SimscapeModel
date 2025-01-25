function y = get_PT(p,y)
    %% Get Maximum Torque


    w_motor = y.WT_CF * p.gr; % motor shaft velocity [left right]
    v_bat = y.VB_sf; % battery voltage
    min_motor_max_T = min(p.torque_interpolant(w_motor, [v_bat v_bat]); % smallest of motor max toqrue limited by voltage and velocity

    % derate for motor t, motor contol t, bat t, bat I
    clip(interp1([p.mT_derating_full_T, p.mT_derating_zero_T], [1, 0], y.motor_T), 0, 1);
    clip(interp1([p.mcT_derating_full_T, p.mcT_derating_zero_T], [1, 0], y.motor_controller_T), 0, 1);
    clip(interp1([p.bT_derating_full_T, p.bT_derating_zero_T], [1, 0], y.batt_T), 0, 1);
    clip(interp1([p.bI_derating_full_T, p.bI_derating_zero_T], [1, 0], y.batt_I), 0, 1);

mT_derating_full_T; 
mT_derating_zero_T; 
mcT_derating_full_T;
mcT_derating_zero_T;
bT_derating_full_T; 
bT_derating_zero_T; 
bI_derating_full_T; 
bI_derating_zero_T; 

    y.T_max = clip(y.r_EQUAL, 0, min_saturation_out);
end

    % y.mT_mcT_bt_bI = clip(y.mT_mcT_bt_bI, p.mT_mcT_bT_bI_maxlow, mT_mcT_bT_bI_maxupp);
    % minT_safety = min(((y.mT_mcT_bT_bI + p.sys_bias) .* p.sys_gain) + p.add_gain);
    % min_saturation_out = clip(minT_safety, p.rb(1), p.rb(2));