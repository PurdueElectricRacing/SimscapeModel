function [smoothed_command, TVS_PERMIT, FINISHED_SMOOTHING] = motor_command_filter(TVS_command_in, Equal_command_in, TVS_STATE, LAST_TVS_PERMIT, command_last_sent, FINISHED_SMOOTHING,alpha,dk_thresh)
% Filters motor comands during TVS mode changes
%   Detailed explanation goes here
smoothed_command = zeros(1,2);

% switch between modes
if TVS_STATE
    command_in = TVS_command_in;
else
    command_in = Equal_command_in;
end

if TVS_STATE ~= LAST_TVS_PERMIT % TVS changed
    FINISHED_SMOOTHING = 0;
end

if command_last_sent(1) > command_last_sent(2)
    low_command = command_last_sent(2);
    low_dif = min(command_in) - low_command;

    if abs(low_dif) < dk_thresh % signals are close enough
        FINISHED_SMOOTHING = 1;
    end

    if FINISHED_SMOOTHING == 0 % continue smoothing
        filt_dif = alpha * low_dif + (1-alpha) * 0;
        smoothed_command(2) = min(low_command + filt_dif, max(command_in));
        smoothed_command(1) = max(command_in);
    else
        smoothed_command = command_in;
    end
else
    low_command = command_last_sent(1);
    low_dif = min(command_in) - low_command;

    if abs(low_dif) < dk_thresh % signals are close enough
        FINISHED_SMOOTHING = 1;
    end

    if FINISHED_SMOOTHING == 0 % continue smoothing
        filt_dif = alpha * low_dif + (1-alpha) * 0;
        smoothed_command(1) = min(low_command + filt_dif, max(command_in));
        smoothed_command(2) = max(command_in);
    else
        smoothed_command = command_in;
    end
end

if FINISHED_SMOOTHING && (~TVS_STATE)
    TVS_PERMIT = 0;
else
    TVS_PERMIT = 1;
end






