function y = get_ET(p,y)
    y.TO_ET = y.TH_CF * p.MAX_TORQUE_NOM .* [1 1];
end