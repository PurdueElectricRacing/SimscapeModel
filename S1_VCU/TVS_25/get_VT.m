%% Function Description
% This function computes the variable torque control setpoints, which are
% sent to main. First, a schmidt trigger is used to decide is TC or TV
% should be used, depending on the magnitude of the steering angle. Then
% the appropriate control mode is used to determine the variable torque
% setpoint.
%
% Input      :  p - struct of all constant controller parameters
%               y - struct of VT processed controller data at time t-1
% 
% Return     :  y - struct of VT processed controller data at time t

function y = get_VT(p,y)
    % determine and execute VT mode - TC, TV
    if abs(y.ST_CF) < y.VT_DB_CF - p.dST_DB
        y.VT_mode = 1;  % car is going in a straight line; use TC
        y = get_TC(p,y);  % Traction Control (TC)
    elseif abs(y.ST_CF) > y.VT_DB_CF + p.dST_DB
        y.VT_mode = 2;  % car is turning; use TV
        y = get_TV(p,y);  % Torque Vectoring (TV)
    end
end