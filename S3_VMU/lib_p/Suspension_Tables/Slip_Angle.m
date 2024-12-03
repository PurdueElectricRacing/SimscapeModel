% Slip Angle calculation given vehicle parameters
% v =  velocity [x,y]
% yaw = yawrate
% track_width = column vector containing each track width
% slip_output = output of the slip calculation function [rad]
% slip = c_slip_angle = function for slip angle
% body_angle = angle of vehicle [rad]
% velocity = Vcog
% distance = distance from center to each wheel
% wheel_theta = angle of wheel form center [rad]
% s1/s2 = sign vectors
% wheel_angle = static toe angle [rad]
% theta1/theta2 = angle calculations for equation
% slipsub = The equation subtracted from wheel angle
% slipangle = slip = colum vector with each slip angle value

v = [0,0];
yaw = 1.1;
track_width = [1; 1; 1; 1];

slip_output = c_slip_angle(v, yaw, track_width)

function slip = c_slip_angle(v, yaw, track_width)
    body_angle = atan2(v(2),v(1))
    velocity = ((v(1)^2+v(2)^2))^(1/2);
    distance = [2.3; 2.3; 1.2; 1.2];
    wheel_theta = atan(distance./(track_width./2));
    s1 = [1; 1; -1; -1];
    s2 = [-1; 1; -1; 1];
    wheel_angle = [1.23, 1.12, 0, 0];
    theta1 = [cos(wheel_theta(1));sin(wheel_theta(2)); sin(wheel_theta(3));cos(wheel_theta(4))];
    theta2 = [sin(wheel_theta(1));cos(wheel_theta(2)); cos(wheel_theta(3));sin(wheel_theta(4))];
    slipsub = (velocity.*body_angle + s1.*distance.*theta1.*yaw)./(velocity + s2.*distance.*theta2.*yaw)
    slipangle = wheel_angle(:) - slipsub(:);
    slip = slipangle;
    
end
