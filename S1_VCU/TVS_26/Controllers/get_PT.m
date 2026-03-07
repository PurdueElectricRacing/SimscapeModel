%% Function Description
% This function computes the proportional torque control setpoints, which
% are used for further calculations. 
% First, the largest allowed torque setpoint due to motor
% characteristics is computed. Next, the maximum torque subject to derating
% considerations is computed. The minimum from both of these is
% combined to compute the actual propotional torque setpoint.
%
% Input      :  p - struct of all constant controller parameters
%               y - struct of PT processed controller data at time t-1
% 
% Return     :  y - struct of PT processed controller data at time t

%% Required Sensor Values
% 

function y = get_PT(p,y)

    % derate due to motor, inverter temperature

    % derate due to battery temeprature, current, voltage

    % derate due to power draw

    % derate due to 

end