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
   
    Vb_derated = p.MAX_TORQUE_NOM * clip(interp1([p.Vb_derating_full_T, p.Vb_derating_zero_T], [1,0], y.Vb_T), 0, 1);
    Tcp_derated = p.MAX_TORQUE_NOM * clip(interp1([p.Tcp_derating_full_T, p.Tcp_derating_zero_T], [1,0], y.Tcp_T), 0, 1);
    Cigbt_derated = p.MAX_TORQUE_NOM * clip(interp1([p.Cigbt_derating_full_T, p.Cigbt_derating_zero_T], [1,0], y.Cigbt_T), 0, 1);
    Cmot_derated = p.MAX_TORQUE_NOM * clip(interp1([p.Cmot_derating_full_T, p.Cmot_derating_zero_T], [1,0], y.Cmot_T), 0, 1);

    y.TO_DR_MX = min([mT_derated, cT_derated, bT_derated, bI_derated, Vb_derated, Tcp_derated, Cigbt_derated, Cmot_derated]); % max T after derating
    y.TO_PT = min(motor_max_T * y.TH_CF, max_T_derated) * [1 1]; % overall max torque

    % compute overall maximum torque
    y.TO_PT = min(y.TO_AB_MX * y.TH_CF, y.TO_DR_MX) * [1 1];
end