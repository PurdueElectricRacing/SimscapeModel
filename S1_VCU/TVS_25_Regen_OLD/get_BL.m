%% Function Description
% This function computes the baseline control setpoints, which are not
% actually sent to main. These are for reference only and are intended to
% reflect what happens in the baseline control mode.
%
% Input      :  p - struct of all constant controller parameters
%               y - struct of BL processed controller data at time t-1
% 
% Return     :  y - struct of BL processed controller data at time t

function y = get_BL(p,y)
    % max torque allowed in either torque control or speed control modes
    y.TO_ET = snip(y.TH_CF, 0, 1) * p.MAX_TORQUE_NOM .* [1 1]; % only allow postive torques

    % max speed setpoint allowed in speed control mode
    y.WM_CS = p.MAX_SPEED_NOM .* [1 1];
end