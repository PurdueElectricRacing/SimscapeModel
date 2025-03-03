function y = get_BL(p,y)
    y.TO_ET = y.TH_CF * p.MAX_TORQUE_NOM .* [1 1];
    y.WM_ES = p.MAX_SPEED_NOM;
end