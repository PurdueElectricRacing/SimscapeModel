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
% slipangle = slip = column vector with each slip angle value

function alpha = slip_angle_model_master_6DOF(vx, vy, yaw, wheel_angle, model)
    % get big numbers: body angle, velocity
    body_angle = atan2(vy,vx)*(abs(vx)>1);
    velocity = sqrt(vx^2+vy^2);
    
    % compute slip angle [rad]
    slipsub = (velocity.*body_angle + model.S1.*yaw)./(velocity + model.S2.*yaw + model.eps);
    alpha = wheel_angle - slipsub;
end