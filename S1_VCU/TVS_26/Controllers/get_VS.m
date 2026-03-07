%% Function Description
% This function computes the speed control setpoint of the motors using a
% target slip ratio. The target slip ratio is used along with the vehicle
% speed and angular velocity to determin the speed setpoint for each tire.
%
% Input      :  p - struct of all constant controller parameters
%               y - struct of VS processed controller data at time t-1
% 
% Return     :  y - struct of VS processed controller data at time t

function y = get_VS(p,y)
    
end