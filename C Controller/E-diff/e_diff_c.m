function [torque_output_left, torque_output_right] = e_diff_c(t_req, sensor_left_wheel_speed, sensor_right_wheel_speed, sensor_steering_wheel_angle)
% force single instead of MATLAB default double
torque_output_left = single(0);
torque_output_right = single(0);

coder.cinclude("eDiff.h");

% use pass by address to output Tx
coder.ceval("eDiff", t_req, sensor_left_wheel_speed, sensor_right_wheel_speed, ...
    sensor_steering_wheel_angle, coder.ref(torque_output_left), coder.ref(torque_output_right));

end