function y = get_PT(p,y)
    %% Get Maximum Torque
    speed_query = y.w_sf;
    voltage_query = y.VB_sf;
    maxT = p.torq_tbl(speed_query, voltage_query);

    y.mT_mcT_bt_bI = clip(y.mT_mcT_bt_bI, p.mT_mcT_bT_bI_maxlow, mT_mcT_bT_bI_maxupp);
    minT_safety = min(((y.mT_mcT_bT_bI + p.sys_bias) .* p.sys_gain) + p.add_gain);
    min_saturation_out = clip(minT_safety, p.rb(1), p.rb(2));
    
    y.T_max = clip(y.r_EQUAL, 0, min_saturation_out);
end