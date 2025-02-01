function y = get_PT(p,y)
    %% Get Maximum Torque subject to inherent motor characteristics and nominal behaviour
    w_motor = y.WT_CF * p.gr; % motor shaft velocity [left right]
    v_bat = y.VB_sf; % battery voltage
    motor_max_T = min(p.torque_interpolant(w_motor, [v_bat v_bat])); % smallest of motor max torque limited by voltage and velocity
    eff_motor_max_T = clip(motor_max_T, 0, p.MAX_TORQUE_NOM); % absolute max torque is capped

    % derate for motor temp, inverter igbt temp, inverter cold plate temp, batt temp, bat current
    mT_derated = p.MAX_TORQUE_NOM * clip(interp1([p.mT_derating_full_T, p.mT_derating_zero_T], [1, 0], y.motor_T), 0, 1);
    cT_derated = p.MAX_TORQUE_NOM * clip(interp1([p.cT_derating_full_T, p.cT_derating_zero_T], [1, 0], y.motor_controller_T), 0, 1);
    bT_derated = p.MAX_TORQUE_NOM * clip(interp1([p.bT_derating_full_T, p.bT_derating_zero_T], [1, 0], y.batt_T), 0, 1);
    bI_derated = p.MAX_TORQUE_NOM * clip(interp1([p.bI_derating_full_T, p.bI_derating_zero_T], [1, 0], y.batt_I), 0, 1);
    
    max_T_derated = min([mT_derated, cT_derated, bT_derated, bI_derated]); % max T after derating
    y.TO_PT = min(eff_motor_max_T * y.TH_CF, max_T_derated) * [1 1]; % overall max torque

end