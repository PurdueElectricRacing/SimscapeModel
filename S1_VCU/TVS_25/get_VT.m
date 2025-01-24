function y = get_VT(p,y)
    % determine VT mode - TC, TV
    y = get_VT_mode(y);

    % based on VT mode, execute appropriate function
    if y.sigma_VT == 1
        y = get_TC(p,y);  % Traction Control (TC)
    elseif y.sigma_VT == 2
        y = get_TV(p,y);  % Torque Vectoring (TV)
    end

    % convert throttle to torque
    y = convert_T_tau(p,y);
end
