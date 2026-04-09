%% Function Description
% calculates torque and speed for accel
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
    
end