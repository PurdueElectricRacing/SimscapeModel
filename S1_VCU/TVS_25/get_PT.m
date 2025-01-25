function y = get_PT(p,y)
    %% Get Maximum Torque


    w_motor = y.WT_CF * p.gr; % motor shaft velocity [left right]
    v_bat = y.VB_sf; % battery voltage
    motor_max_T = min(p.torque_interpolant(w_motor, [v_bat v_bat])); % smallest of motor max toqrue limited by voltage and velocity

    % derate for motor temp, motor contoller temo, batt t, bat I
    mT_derated = p.MAX_TORQUE_NOM * clip(interp1([p.mT_derating_full_T, p.mT_derating_zero_T], [1, 0], y.motor_T), 0, 1);
    mcT_derated = p.MAX_TORQUE_NOM * clip(interp1([p.mcT_derating_full_T, p.mcT_derating_zero_T], [1, 0], y.motor_controller_T), 0, 1);
    bT_derated = p.MAX_TORQUE_NOM * clip(interp1([p.bT_derating_full_T, p.bT_derating_zero_T], [1, 0], y.batt_T), 0, 1);
    bI_derated = p.MAX_TORQUE_NOM * clip(interp1([p.bI_derating_full_T, p.bI_derating_zero_T], [1, 0], y.batt_I), 0, 1);
    
    max_T_derated = min([mT_derated, mcT_derated, bT_derated, bI_derated]); % max T after derating
    y.TO_PT = min(motor_max_T * y.TH_CF, max_T_derated) * [1 1]; % overall max torque

end