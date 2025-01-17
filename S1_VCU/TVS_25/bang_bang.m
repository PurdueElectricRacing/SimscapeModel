% requested_throttle: throttle value from pedal position [unitless]
% vel_COG: forward velocity of center of gravity of vehicle [m/s]
% omega: angular velocity of tires [left, right] [rad/s]
% r: radius of tire [m]
% sl: slip ratio [unitless]
% SLIP_THRESHOLD: slip ratio at which throttle is reduced [unitless]
% THROTTLE_MULT: value to multiply reduced throttle by [unitless]
function [throttle] = bang_bang(requested_throttle, vel_COG, omega, r, SLIP_THRESHOLD, THROTTLE_MULT)
    
    % average tire angular velocity
    omega_avg = (omega(1) + omega(2)) / 2;

    % compute slip ratio
    sl = (omega_avg * r / vel_COG) - 1;

    % check if slipping
    if sl >= SLIP_THRESHOLD
        throttle = requested_throttle * THROTTLE_MULT;
    else
        throttle = requested_throttle;
    end
end