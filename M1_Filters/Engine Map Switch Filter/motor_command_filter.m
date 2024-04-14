%% Function Description
% This function smoothens motor command whenever the control mode switches
% between TVS command and Equal command. Once the smoothened command is
% close enough to the target control mode, the smoothening stops.

%% The Function
function [smoothed_command, TVS_PERMIT, FINISHED_SMOOTHING] = motor_command_filter(TVS_command_in, Equal_command_in, TVS_STATE, LAST_TVS_PERMIT, command_last_sent, FINISHED_SMOOTHING,alpha,dk_thresh)

% Initialize true motor command
smoothed_command = zeros(1,2);

% If TVS is enabled, then use TVS Command, otherwise use Equal Command
if TVS_STATE
    command_in = TVS_command_in;
else
    command_in = Equal_command_in;
end

% If TVS enabled state changed, then start applying filter
if TVS_STATE ~= LAST_TVS_PERMIT % TVS changed
    FINISHED_SMOOTHING = 0;
end

% determine which motor has lower command
if command_last_sent(1) > command_last_sent(2)
    % Compute the low command, which is subject to filtering
    low_command = command_last_sent(2);
    low_dif = min(command_in) - low_command;

    % If smooth and target command is close enough, stop smoothening
    if abs(low_dif) < dk_thresh % signals are close enough
        FINISHED_SMOOTHING = 1;
    end

    % Otherwise, continue smoothening
    if FINISHED_SMOOTHING == 0 % continue smoothing
        filt_dif = alpha * low_dif + (1-alpha) * 0;
        smoothed_command(2) = min(low_command + filt_dif, max(command_in));
        smoothed_command(1) = max(command_in);
    else
        smoothed_command = command_in;
    end
else
    % Compute the low command, which is subject to filtering
    low_command = command_last_sent(1);
    low_dif = min(command_in) - low_command;

    % If smooth and target command is close enough, stop smoothening
    if abs(low_dif) < dk_thresh % signals are close enough
        FINISHED_SMOOTHING = 1;
    end

    % Otherwise, continue smoothening
    if FINISHED_SMOOTHING == 0 % continue smoothing
        filt_dif = alpha * low_dif + (1-alpha) * 0;
        smoothed_command(1) = min(low_command + filt_dif, max(command_in));
        smoothed_command(2) = max(command_in);
    else
        smoothed_command = command_in;
    end
end

% If not smoothening, permit is unchanged, otherwise permit is opposite
if FINISHED_SMOOTHING
    TVS_PERMIT = logical(TVS_STATE);
else
    TVS_PERMIT = ~logical(TVS_STATE);
end