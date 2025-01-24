function y = get_PT(p,y)
    %% Get Maximum Torque
    speed_query = y.w_sf;
    voltage_query = y.VB_sf;
    maxT = p.torq_tbl(speed_query, voltage_query);
end