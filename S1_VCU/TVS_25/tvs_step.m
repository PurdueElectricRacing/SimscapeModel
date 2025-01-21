function y = tvs_step(p,x,y)
    % determine VCU mode - ET, PT, VT
    y = get_VCU_mode(p,x,y);

    % compute estimate of states
    y = get_x_estimate(p,x,y);

    % compute maximum allowed torque
    y = get_max_T(p,x,y);

    % based on VCU mode, execute appropriate function
    if y.sigma_VCU == 1     % Equal throttle (ET)
        y = get_ET(p,x,y);
    elseif y.sigma_VCU == 2 % Proportional Torque (PT)
        y = get_PT(p,x,y);
    elseif y.sigma_VCU == 3 % Variable Torque (VT)
        y = get_VT(p,x,y);
    end
end