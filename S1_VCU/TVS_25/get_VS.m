function y = get_VS(p,y)
    % compute reference wheel speed
    y.WM_VS = [0, 0]
    
    if (y.GS_CF < p.REF_low_shaftspeed)
        y.WM_VS = [p.REF_shaftspeed, p.REF_shaftspeed];
    else
        y.WM_VS = [(p.REF_slip_ratio .* y.GS_CF + y.GS_CF) / p.r, ...
                    ((p.REF_slip_ratio .* y.GS_CF + y.GS_CF) / p.r];
    end
end
