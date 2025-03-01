function y = get_VS(p,y)
    % compute reference wheel speed
    y.WM_VS = [0, 0];
    
    if (y.GS_CF < p.REF_low_shaftspeed)
        y.WM_VS = [p.REF_shaft_speed, p.REF_shaft_speed];
    else
        y.WM_VS = [(p.REF_slip_ratio .* y.GS_CF + y.GS_CF) / p.r, ...
                    ((p.REF_slip_ratio .* y.GS_CF + y.GS_CF)) / p.r];
    end
end