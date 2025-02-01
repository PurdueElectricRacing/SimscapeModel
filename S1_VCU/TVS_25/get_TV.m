function y = get_TV(p, y)

    phi_sat = snip(y.ST_CF, -p.ST_lb, ST_ub);
    yaw_ref = interp2(p.TV_phi_brkpt, p.TV_vel_brkpt, p.TV_yaw_table, phi_sat, y.GS_CF);
    raw_delta_torque = (yaw_ref * y.PI_CF - y.AV_CF(3)) * y.PP_CF * p.ht(2);

    lower = -y.TO_PT(1) * p.r_power_sat; 
    upper = y.TO_PT(1) * p.r_power_sat;
    delta_torque = snip(raw_delta_torque, lower, upper);

    if delta_torque > 0
        y.TO_VT = [y.TO_PT(1), y.TO_PT(1) - delta_torque];
    else
        y.TO_VT = [y.TO_PT(1) + delta_torque, y.TO_PT(1)];
    end

end