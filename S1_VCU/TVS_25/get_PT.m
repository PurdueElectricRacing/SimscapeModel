function y = get_PT(p,y)
    % compute max torque subject to motor characteristics
    w_motor = y.WT_CF * p.gr; % motor shaft velocity [left right]
    motor_max_T = min(p.torque_interpolant(w_motor, [y.VB_CF y.VB_CF])); % smallest of motor max torque limited by voltage and velocity

    y.TO_AB_MX = clip(motor_max_T, 0, p.MAX_TORQUE_NOM);

    % derate for motor temp, inverter igbt temp, inverter cold plate temp, batt temp, bat current
    mT_derated = p.MAX_TORQUE_NOM * clip(interp1([p.mT_derating_full_T, p.mT_derating_zero_T], [1, 0], y.motor_T), 0, 1);
    cT_derated = p.MAX_TORQUE_NOM * clip(interp1([p.cT_derating_full_T, p.cT_derating_zero_T], [1, 0], y.motor_controller_T), 0, 1);
    bT_derated = p.MAX_TORQUE_NOM * clip(interp1([p.bT_derating_full_T, p.bT_derating_zero_T], [1, 0], y.batt_T), 0, 1);
    bI_derated = p.MAX_TORQUE_NOM * clip(interp1([p.bI_derating_full_T, p.bI_derating_zero_T], [1, 0], y.batt_I), 0, 1);
    
    y.TO_DR_MX = min([mT_derated, cT_derated, bT_derated, bI_derated]); % max T after derating

    % compute overall maximum torque
    y.TO_PT = min(y.TO_AB_MX * y.TH_CF, y.TO_DR_MX) * [1 1];
end