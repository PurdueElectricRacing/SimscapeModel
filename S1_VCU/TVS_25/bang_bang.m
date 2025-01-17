% INPUTS
% requested_throttle:  throttle value from pedal position [unitless]
% vel_COG:             forward velocity of center of gravity of vehicle [m/s]
% omega:               angular velocity of tires [left, right] [rad/s]
% R:                   radius of tire [m] make sure it matches radius in wheelspeed code
% sl:                  slip ratio [unitless]
% SLIP_THRESHOLD:      slip ratio at which throttle is reduced [unitless]
% THROTTLE_MULT:       value to multiply reduced throttle by [unitless]
% TRIGGERS_TO_SWITCH:  number of consecutive triggers to switch to traction control
% trigger_counter_ref: running counter of number of consecuive triggers

% OUTPUTS
% throttle:        normalized throttle value
% trigger_counter: running counter of number of consecuive triggers (DO NOT CHANGE EXTERNALLY)

function [throttle, trigger_counter] = bang_bang(requested_throttle, vel_COG, omega, r, SLIP_THRESHOLD, THROTTLE_MULT, TRIGGERS_TO_SWITCH, trigger_counter_ref)
    
    % average tire angular velocity
    omega_avg = (omega(1) + omega(2)) / 2;

    % compute slip ratio
    sl = (omega_avg * r / vel_COG) - 1;

    % check if slipping
    if sl >= SLIP_THRESHOLD
        trigger_counter = trigger_counter_ref + 1;
    else
        trigger_counter = 0;
    end

    % check if traction control should engage
    if trigger_counter >= TRIGGERS_TO_SWITCH
        throttle = requested_throttle * THROTTLE_MULT;
    else
        throttle = requested_throttle;
    end
end