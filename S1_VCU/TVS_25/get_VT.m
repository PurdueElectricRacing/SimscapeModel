function y = get_VT(p,x,y)
    % determine VT mode - PT, TC, TV
    y = get_VT_mode(p,x,y);

    % based on VT mode, execute appropriate function
    if y.sigma_VT == 1
        y = get_PT(p,x,y); % Proportional Torque (PT)
    elseif y.sigma_VT == 2
        y = get_TC(p,x,y);  % Traction Control (TC)
    elseif y.sigma_VT == 3
        y = get_VT(p,x,y);  % Torque Vectoring (TV)
    end
end