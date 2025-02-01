function y = get_y_cf(p,x,y)
    % process individual data and distribute into individual fields

    % throttle sensor: hardware filter & averaging across two independent sensors is sufficient
    y.TH_CF = clip(x.TH_RAW, p.TH_lb, p.TH_ub);

    % steering angle sensor: the GMR sensor accuracy is good enough
    y.ST_CF = clip(x.ST_RAW, p.ST_lb, p.ST_ub);

    % battery voltage: the voltage sensor accuracy is good enough
    y.VB_CF = clip(x.VB_RAW, p.VB_lb, p.VB_ub);

    % tire wheel speed: the hall effect sensor accuracy is good enough
    y.WT_CF = clip(x.WT_RAW, p.WT_lb, p.WT_ub);

    % chassis ground speed: GPS sensor accuracy is good enough
    y.GS_CF = clip(x.GS_RAW, p.GS_lb, p.GS_ub);

    % chassis angular velocity: the control scheme acts as a filter
    y.AV_CF = clip(p.R*x.AV_RAW, p.AV_lb, p.AV_ub);

    % battery current: filtering is needs for the purpose of averaging
    y.IB_CF_vec = [y.IB_CF_vec(2:end) clip(x.IB_RAW, p.IB_lb, p.IB_ub)];
    y.IB_CF = mean(y.IB_CF_vec);

    % max motor temperature: the thermocouple sensor accuracy is good enough
    y.MT_CF = clip(x.MT_RAW, p.MT_lb, p.MT_ub);

    % max inverter igbt temperature: the thermocouple sensor accuracy is good enough
    y.CT_CF = clip(x.CT_RAW, p.CT_lb, p.CT_ub);

    % max inverter cold plate temperature: the thermocouple sensor accuracy is good enough
    y.IT_CF = clip(x.IT_RAW, p.IT_lb, p.IT_ub);

    % motor overload percentage:
    y.MC_CF = clip(x.MC_RAW, p.MC_lb, p.MC_ub);

    % inverter overload percentage: 
    y.IC_CF = clip(x.IC_RAW, p.IC_lb, p.IC_ub);

    % max battery cell temperature: the thermocouple sensor accuracy is good enough
    y.BT_CF = clip(x.BT_RAW, p.BT_lb, p.BT_ub);

    % chassis acceleration: the sensor is bad, but this sensor is not used in controller
    y.AG_CF = clip(p.R*x.AG_RAW, p.AG_lb, p.AG_ub);

    % motor torque: the unfiltered values are desired
    y.TO_CF = clip(x.TO_RAW, p.TO_lb, p.TO_ub);

    % steering deadband: the potentiometer sensor is good enough
    y.DB_CF = clip(x.DB_RAW, p.DB_lb, p.DB_ub);

    % torque vectoring intensity: the potentiometer sensor is good enough
    y.PI_CF = clip(x.PI_RAW, p.PI_lb, p.PI_ub);

    % torque vectoring proportional gain: the potentiometer sensor is good enough
    y.PP_CF = clip(x.PP_RAW, p.PP_lb, p.PP_ub);

    % battery state of charge (SOC):
    y.zero_current_counter = (y.zero_current_counter + 1) * (y.IB_CF == 0); % if zero, reset counter, otherwise increment by one
    if y.zero_current_counter >= p.zero_currents_to_update_SOC % is above threshold, update VOC otherwise do nothing
        capacity_used = interp1(p.Batt_Voc_brk, p.Batt_As_Discharged_tbl, y.VB_CF / p.series);
        y.Batt_SOC = clip(interp1([p.Batt_cell_zero_SOC_capacity, p.Batt_cell_full_SOC_capacity], [0, 1], capacity_used), 0, 1);
    end
end