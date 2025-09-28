% This function is an event function to be used with odexx functions. When
% residual = 0, the simulation ends. The residual is between the distance 
% that the vehicle has traveled in the longitudinal direction vs some
% specified distance. This residual can be used to simulate the
% acceleration event, and have the simulation end exactly at 75m.

% Inputs:
% t:      Time (s)
% s:      The state vector
% tauRaw: The torque setpoint for each motor [Nm]
%         Positive is positive Fx s positive acceleration
% CCSA:   The center column steering angle [deg]
%         Positive is clockwise
% model:  Vehicle parameter structure

% Outputs:
% residual:   Event is triggered when residual is 0
% isterminal: If this flag is 1, then integration stops when residual is 0
% direction:  If direction is 0, then numerical method can find the exact 0 point however it wants to

function [residual,isterminal,direction] = accel_complete(t, s, tauRaw, CCSA, P, model)
    residual = s(2) - model.sN;
    isterminal = 1;
    direction = 0;   % The zero can be approached from either direction
end