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

% Process raw inputs from x into y
    % throttle
    y.TH = x.TH_RAW;

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

    % battery current
    y.IB = x.IB_RAW;

    % max motor temp
    y.MT = x.MT_RAW;

    % max inverter IGBT temp
    y.IGBT_T = x.IGBT_T_RAW;

    % max inverter cold plate temp
    y.INV_T = x.INV_T_RAW;

    % motor overload percentage
    y.MC = x.MC_RAW;

    % inverter overload percentage
    y.IC = x.IC_RAW;

    % max battery cell temperature
    y.BT = x.BT_RAW;

    % motor torque
    y.TO = x.TO_RAW;

% Update Buffers
    % Moving average battery current
    y.IB_AVG_buffer = [y.IB_AVG_buffer(2:end), y.IB];
    y.IB_AVG = mean(y.IB_AVG_buffer);

% Calculate values
    % battery power draw
    y.PB = y.VB * y.IB;
    

    
end