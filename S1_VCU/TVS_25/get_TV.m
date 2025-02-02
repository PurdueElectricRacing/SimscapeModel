function y = get_TV(p, y)
    % compute raw delta torque
    ST_TV = snip(y.ST_CF, p.TV_ST_lb, p.TV_ST_ub);
    GS_TV = snip(y.GS_CF, p.TV_GS_lb, p.TV_GS_ub);
    yaw_ref = interp2(p.TV_ST_brkpt, p.TV_GS_brkpt, p.TV_AV_table, ST_TV, GS_TV);
    raw_delta_torque = (yaw_ref * y.PI_CF - y.AV_CF(3)) * y.PP_CF * p.ht(2);

    % compute limited delta torque
    lower = -y.TO_PT(1) * p.r_power_sat;
    upper = y.TO_PT(1) * p.r_power_sat;
    delta_torque = snip(raw_delta_torque, lower, upper);

    % compute individual torques
    if delta_torque > 0
        y.TO_VT = [y.TO_PT(1), y.TO_PT(1) - delta_torque];
    else
        y.TO_VT = [y.TO_PT(1) + delta_torque, y.TO_PT(1)];
    end
end