%% Function Description
% This function computes the baseline control setpoints, which are not
% actually sent to main. These are for reference only and are intended to
% reflect what happens in the baseline control mode. These reflect the
% maxiumum torque allowed per rules.
%
% Input      :  p - struct of all constant controller parameters
%               y - struct of BL processed controller data at time t-1
% 
% Return     :  y - struct of BL processed controller data at time t

function y = get_BL(p,y)
    % absolute max torque allowed per throttle position
    y.TO_ET = y.TH_CF * p.MAX_TORQUE_NOM .* [1 1 1 1];

end