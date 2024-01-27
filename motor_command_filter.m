function [smoothed_command] = motor_command_filter(command_in, command_last_sent, TVS_ENABLE)
% Filters motor comands during TVS mode changes
%   Detailed explanation goes here
alpha = 0.1; % easing function coeffficient
close = .05; % how close signals should be to stop smoothing

[low_command, low_index] = min(command_last_sent);
[high_command, high_index] = max(command_last_sent);
low_dif = min(command_in) - low_command;

% TVS enabled -> disabled
if TVS_ENABLE == 0 && low_dif > close
    filt_dif = alpha * low_dif + (1-alpha) * 0;
    smoothed_command(low_index) = low_command + filt_dif;
    smoothed_command(high_index) = max(command_in);

% TVS disabled -> enabled
elseif TVS_ENABLE == 1 && low_dif > close
    
else
    smoothed_command = command_in;
end