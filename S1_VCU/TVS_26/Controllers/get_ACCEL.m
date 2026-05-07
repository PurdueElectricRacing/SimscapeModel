%% Function Description
% calculates speed for accel
% torque limit is baseline torque GET_BL_PO
% speed limit is based on vehicle_speed -> wheelspeed map
% map is constant non-zero wheelspeed at low vehicle speed,
%   transitions to target slip ratio at higher speeds
% Inputs
%   p   vehicle paramater struct. constant
%   y   Function input and output struct. contains all clipped and
%           filtered variables, variable buffers, and output from
%           this function.
% Outputs
%   y   modified version of input y

function y = get_ACCEL(p, y)
    % clip wheelspeed to table
    WW_snipped = snip(y.WW, p.AC_brkpt_lb, p.AC_brkpt_ub);

    % lookup in table, apply same speed to all wheels
    AC_WW = interp1(p.AC_speed_brkpt, p.AC_speed_table, WW_snipped) .* [1 1 1 1];
    y.AC_MW = AC_WW .* p.gr;
end