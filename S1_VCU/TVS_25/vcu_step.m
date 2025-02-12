function y = vcu_step(p,f,x,y)
    % determine VCU mode - ET, PT, VT, VS
    y = get_VCU_mode(p,f,x,y);

    % compute clip and filtered measurements
    y = get_y_cf(p,x,y);

    % if permissible, get Equal throttle (ET)
    if y.VCU_mode >= 1
        y = get_ET(p,y);
    end

    % if permissible, get Proportional Torque (PT)
    if y.VCU_mode >= 2
        y = get_PT(p,y);
    end

    % if permissible, get Variable Speed (VS)
    if y.VCU_mode == 3
        y = get_VS(p,y);
    end

    % if permissible, get Variable Torque (VT)
    if y.VCU_mode == 4
        y = get_VT(p,y);
    end
end