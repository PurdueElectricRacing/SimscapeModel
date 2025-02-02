function y = get_VT(p,y)
    % determine VT mode - TC, TV
    y = get_VT_mode(p,y);

    % based on VT mode, execute appropriate function
    if y.VT_mode == 1
        y = get_TC(p,y);  % Traction Control (TC)
    elseif y.VT_mode == 2
        y = get_TV(p,y);  % Torque Vectoring (TV)
    end
end