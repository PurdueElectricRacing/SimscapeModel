function y = tvs_step(p,f,x,y)
    % determine VCU mode - ET, PT, VT
    y = get_VCU_mode(p,f,x,y);

    % compute saturated and filtered measurements
    y = get_x_sf(p,x,y);

    % compute maximum allowed torque
    y = get_max_T(p,y);

    % if permissible, get Equal throttle (ET)
    if y.sigma_VCU >= 1
        y = get_ET(p,y);
    end

    % if permissible, get Proportional Torque (PT)
    if y.sigma_VCU >= 2
        y = get_PT(p,y);
    end

    % if permissible, get Variable Torque (VT)
    if y.sigma_VCU == 3
        y = get_VT(p,y);
    end
end