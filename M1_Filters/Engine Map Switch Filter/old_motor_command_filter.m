function [smoothed_command, FINISHED_SMOOTHING] = old_motor_command_filter(command_in, command_last_sent, TVS_PERMIT, LAST_TVS_PERMIT, FINISHED_SMOOTHING)
% Filters motor comands during TVS mode changes
%   Detailed explanation goes here
alpha = 0.1; % easing function coeffficient
close = .05; % how close signals should be to stop smoothing

[low_command, low_index] = min(command_last_sent);
high_command = max(command_last_sent);
high_index = 3 - low_index;
low_dif = min(command_in) - low_command;

if TVS_PERMIT ~= LAST_TVS_PERMIT % TVS changed
    FINISHED_SMOOTHING = 0;
end

if abs(low_dif) < close % signals are close enough
    FINISHED_SMOOTHING = 1;
end

if FINISHED_SMOOTHING == 0 % continue smoothing
    filt_dif = alpha * low_dif + (1-alpha) * 0;
    smoothed_command(low_index) = low_command + filt_dif;
    smoothed_command(high_index) = max(command_in);
else
    smoothed_command = command_in;
end
