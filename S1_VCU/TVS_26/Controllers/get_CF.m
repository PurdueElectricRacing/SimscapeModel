%% Function Description
% This function applies truncation and filtering to all signals that need
% it. In addition, it distributes signals from x to y.
%
% Input      :  p - struct of all constant controller parameters
%               x - struct of all raw sensor measurements
%               y - struct of CF processed controller data at time t-1
% 
% Return     :  y - struct of CF processed controller data at time t

function y = get_CF(p, x, y)

% VCU_mode

% Process raw inputs from x into y
    % throttle
    if x.REGEN_RAW > 0
        y.TH = -1 * snip(x.REGEN_RAW, 0, 1);
    else
        y.TH = snip(x.THROT_RAW, 0, 1);
    end
    % power throttle
    y.TH_PO = min(max(y.TH, 0), 1);

    % regen throttle
    y.TH_RG = abs(min(max(y.TH, -1), 0));

    % steering angle
    y.ST = x.ST_RAW;

    % battery voltage
    y.VB = x.VB_RAW;

    % motor shaft angular velocity
    y.WM = x.WM_RAW;
    
    % groundspeed
    y.GS = x.GS_RAW;

    % chasis angular velocity
    y.AV = x.AV_RAW;
    y.AV(3) = -y.AV(3);

    % battery current
    y.IB = x.IB_RAW;

    % max motor temp
    y.MT = x.MT_RAW;

    % max inverter IGBT temp
    y.IGBT_T = x.IGBT_T_RAW;

    % max inverter cold plate temp
    y.INV_T = x.INV_T_RAW;

    % motor overload percentage
    y.OV_MOT = x.OV_MOT;

    % inverter overload percentage
    y.OV_INV = x.OV_INV;

    % max battery cell temperature
    y.BT = x.BT_RAW;

    % motor torque
    y.TO = x.TO_RAW;

% Process Raw Steering Wheel inputs
    % Regen brake FR split
    y.RG_FR_split = snip(x.RG_FR_split_RAW, 0, 1);

    % Skidpad gains
    y.SK_FR_split = interp1([0, 100], [p.SK_FR_split_lb, p.SK_FR_split_ub] ,x.SK_FR_split_RAW);
    y.SK_LR_gain = interp1([0, 100], [p.SK_LR_gain_lb, p.SK_LR_gain_ub], x.SK_LR_gain_RAW);

    % Autocross gains
    y.AX_FR_split = interp1([0, 100], [p.AX_FR_split_lb, p.AX_FR_split_ub] ,x.AX_FR_split_RAW);
    y.AX_LR_gain = interp1([0, 100], [p.AX_LR_control_force_lb, p.AX_LR_control_force_ub], x.AX_LR_gain_RAW);

    % Testing/Tuning mode gains
    y.TS_FR_split = interp1([0, 100], [p.TS_FR_split_lb, p.TS_FR_split_ub] ,x.TS_FR_split_RAW);
    y.TS_LR_split = interp1([0, 100], [p.TS_LR_split_lb, p.TS_LR_split_ub], x.TS_LR_split_RAW);
    
% Update Buffers
    % Moving average battery current
    y.IB_AVG_buffer = [y.IB_AVG_buffer(2:end), y.IB];
    y.IB_AVG = mean(y.IB_AVG_buffer);

% Calculate values
    % battery power draw
    y.PB = y.VB * y.IB;
    
    % wheel angualr velocity (rad/s)
    y.WW = y.WM / p.gr;
    
end