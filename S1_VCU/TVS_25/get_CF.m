%% Function Description
% This function applies truncation and filtering to all signals that need
% it. In addition, it distributes signals from x to y.
%
% Input      :  p - struct of all constant controller parameters
%               x - struct of all raw sensor measurements
%               y - struct of CF processed controller data at time t-1
% 
% Return     :  y - struct of CF processed controller data at time t

function y = get_CF(p,x,y)
    % process individual data and distribute into individual fields

    % throttle sensor: hardware filter & averaging across two independent sensors is sufficient
    y.TH_CF = snip(x.TH_RAW, p.TH_lb, p.TH_ub);

    % steering angle sensor: the GMR sensor accuracy is good enough
    y.ST_CF = snip(x.ST_RAW, p.ST_lb, p.ST_ub);

    % battery voltage: the voltage sensor accuracy is good enough
    y.VB_CF = snip(x.VB_RAW, p.VB_lb, p.VB_ub);

    % tire wheel speed: the hall effect sensor accuracy is good enough
    y.WT_CF = snip(x.WT_RAW, p.WT_lb, p.WT_ub);

    % motor shaft speed: hopefully AMK is good enough
    y.WM_CF = snip(x.WM_RAW, p.WM_lb, p.WM_ub);

    % estimate of tire angular velocity: selectable
    if p.W_CF_SELECTION == 0 
        y.W_CF = y.WT_CF;
    elseif p.W_CF_SELECTION == 1
        y.W_CF = y.WM_CF./p.gr;
    elseif p.W_CF_SELECTION == 2
        y.W_CF = 0.5*(y.WT_CF + (y.WM_CF./p.gr));
    else
        y.W_CF = 0.5*(y.WT_CF + (y.WM_CF./p.gr));
    end

    % chassis ground speed: GPS sensor accuracy is good enough
    y.GS_CF = snip(x.GS_RAW, p.GS_lb, p.GS_ub);

    % chassis angular velocity: the control scheme acts as a filter
    y.AV_CF = snip((p.R*x.AV_RAW')', p.AV_lb, p.AV_ub);

    % battery current: filtering is needed for the purpose of averaging
    y.IB_CF_buffer = [y.IB_CF_buffer(2:end) snip(x.IB_RAW, p.IB_lb, p.IB_ub)];
    y.IB_CF = mean(y.IB_CF_buffer);

    % max motor temperature: the thermocouple sensor accuracy is good enough
    y.MT_CF = snip(x.MT_RAW, p.MT_lb, p.MT_ub);

    % max inverter igbt temperature: the thermocouple sensor accuracy is good enough
    y.CT_CF = snip(x.CT_RAW, p.CT_lb, p.CT_ub);

    % max inverter cold plate temperature: the thermocouple sensor accuracy is good enough
    y.IT_CF = snip(x.IT_RAW, p.IT_lb, p.IT_ub);

    % motor overload percentage:
    y.MC_CF = snip(x.MC_RAW, p.MC_lb, p.MC_ub);

    % inverter overload percentage: 
    y.IC_CF = snip(x.IC_RAW, p.IC_lb, p.IC_ub);

    % max battery cell temperature: the thermocouple sensor accuracy is good enough
    y.BT_CF = snip(x.BT_RAW, p.BT_lb, p.BT_ub);

    % chassis acceleration: the sensor is bad, but this sensor is not used in controller
    y.AG_CF = snip((p.R*x.AG_RAW')', p.AG_lb, p.AG_ub);

    % motor torque: the unfiltered values are desired
    y.TO_CF = snip(x.TO_RAW, p.TO_lb, p.TO_ub);

    % steering deadband: the potentiometer sensor is good enough
    y.VT_DB_CF = snip(x.VT_DB_RAW, p.VT_DB_lb, p.VT_DB_ub);

    % torque vectoring proportional gain: the potentiometer sensor is good enough
    y.TV_PP_CF = snip(x.TV_PP_RAW, p.TV_PP_lb, p.TV_PP_ub);

    % traction control torque drop ratio: the potentiometer sensor is good enough
    y.TC_TR_CF = snip(x.TC_TR_RAW, p.TC_TR_lb, p.TC_TR_ub);

    % speed control max slip ratio: the potentiometer sensor is good enough
    y.VS_MAX_SR_CF = snip(x.VS_MAX_SR_RAW, p.VS_MAX_SR_lb, p.VS_MAX_SR_ub);

    % battery state of charge (SOC):
    y.zero_current_counter = (y.zero_current_counter + 1) * (y.IB_CF == 0); % if zero, reset counter, otherwise increment by one
    if y.zero_current_counter >= p.zero_currents_to_update_SOC % is above threshold, update VOC otherwise do nothing
        y.Batt_Voc = y.VB_CF;
        capacity_used = interp1(p.Batt_Voc_brk, p.Batt_As_Discharged_tbl, y.VB_CF / p.Ns);
        y.Batt_SOC = snip(interp1([p.Batt_cell_zero_SOC_capacity, p.Batt_cell_full_SOC_capacity], [0, 1], capacity_used), 0, 1);
    end
end