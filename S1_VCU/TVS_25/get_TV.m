function y = get_TV(p, y)

    phi_sat = clip(y.ST_CF, -130, 130);
    yaw_ref = interp2(p.TV_phi_brkpt, p.TV_vel_brkpt, p.TV_yaw_table, phi_sat, y.GS_CF);
    raw_dR = (yaw_ref * y.PI_CF - y.AV_CF(3)) * y.PP_CF * p.ht(2);

    lower = -y.powerlimit .* p.r_power_sat;
    upper = y.powerlimit .* p.r_power_sat;
    e = clip(raw_dR, lower, upper);

    function_inp_u = e * (abs(phi_sat) > y.dphi);

    if function_inp_u > 0
        y.TH_VT = [y.powerlimit(1) y.powerlimit(1)-abs(function_inp_u)];
    else
        y.TH_VT = [y.powerlimit(1)-abs(function_inp_u) y.powerlimit(1)];
    end


%model.distance = steering angle breakpoints
%model.velocity = vel breakpoints
%model.yaw = yaw table data
end