%% Optimize of SkidPad
% basic idea is to check the turnning radias and direction to determine
% how to calculate error
% 
%% Setup
clear;
clc;
close all;

%% Data
load Tracks/Tracks_Mat/skidpad.mat
addpath("MATLAB_Functions\")
trackname = "skidpad";
% [Dr(slop) Ypos Xpos TurnRad TurnDr(L/R) InstCY InstCX yaw]
track_data = track_data_skidpad;
trackXY = [track_data_skidpad(:,3) track_data_skidpad(:,2)];
turn_direction = track_data(:,5);  % L = 1, R = -1

%% Draw the track
figure;
plot(trackXY(:,1), trackXY(:,2),"color", 'k')
xlabel('X Position (m)');
ylabel('Y Position (m)');
title('Track Map');
grid on;
hold on;
visualize = true;

%% Initial setup
N = 8; % n step ahead
total_points_num = 50;
startpoint = [0, 1]; % Start position [X, Y] [m, m]
lapcount = 0;
lf = 0.8289; % [m]
lr = 0.7061; % [m]  
steerlimit = 60; % [deg]
max_acc = 20; % [m/s^2]
timestep = 0.1; % [s]
% steerdeg = -1*steerlimit + (2*steerlimit) * rand(1,100);    % Random Steering angle in Degrees
% thrtl = ones(1, N); % 1 * rand(1,100);                    % Throttle depth 0 ~ 1
u1_guess = ones(1, N) * max_acc; % Throttle guess
u2_guess = zeros(1, N); % Steering guess

% Initial Condition [X, Y, V, psi]
inicon = [startpoint(1), startpoint(2), 0, 0];
sol = inicon;
sol_opt = inicon;
t = timestep*(0:100);
index_L_start = find(turn_direction == 1, 1);
index_R_start = find(turn_direction == -1, 1);
index_R_end   = find(turn_direction == -1, 'last');
indices = [index_L_start, index_R_start, index_R_end];

if visualize
    actual_plot = plot(inicon(1), inicon(2), 'ro-', 'LineWidth', 1, 'DisplayName', 'Actual Trajectory');
    predicted_plot = plot(inicon(1), inicon(2), 'b--o', 'LineWidth', 0.5, 'DisplayName', 'Predicted Horizon');
    legend('track', 'best');
end

%% Do optimization

% n step
for k = 1:total_points_num
    % Optimize u1 first
    u_guess = [u1_guess,u2_guess];
    lb = [zeros(1, N), deg2rad(-steerlimit) * ones(1, N)];
    ub = [max_acc * ones(1, N), deg2rad(steerlimit) * ones(1, N)];

    objective = @(u) n_step_error(u, N, inicon, lf, lr, timestep, indices, trackXY, trackname);
    [u_opt, ~] = fmincon(objective, u_guess, [], [], [], [], lb, ub, []);

    % Extract optimal throttle and steering sequences
    u1_opt = u_opt(1:N); % Optimal throttle
    u2_opt = u_opt(N+1:end); % Optimal steering

    % Optimize u2 first (remember to change the total error func)
    % u_guess = [u2_guess, u1_guess];
    % lb = [deg2rad(-steerlimit) * ones(1, N),zeros(1, N),];
    % ub = [deg2rad(steerlimit) * ones(1, N),max_acc * ones(1, N)];
    % 
    % objective = @(u) n_step_error(u, N, inicon, lf, lr, timestep, trackXY, trackname);
    % [u_opt, ~] = fmincon(objective, u_guess, [], [], [], [], lb, ub, []);
    % 
    % % Extract optimal throttle and steering sequences
    % u1_opt = u_opt(N+1:end); % Optimal throttle
    % u2_opt = u_opt(1:N); % Optimal steering

    % Propagate dynamics for one time step using first control
    [~, sol_one_step] = ode23tb(@(t, state) bicycle_model(t, state, u1_opt(1), u2_opt(1), lf, lr), [0, timestep], inicon);
    sol_opt = [sol_opt; sol_one_step(end, :)];
    
    % Extra for visualize the process
    if visualize
        % Predict N-step trajectory for visualization
        predicted_path = inicon; % Store predicted points
        current_state = inicon;
        for n = 1:N
            [~, sol] = ode23tb(@(t, state) bicycle_model(t, state, u1_opt(n), u2_opt(n), lf, lr), [0, timestep], current_state);
            current_state = sol(end, :); % Update state
            predicted_path = [predicted_path; current_state];
        end
        % Update visualization
        set(actual_plot, 'XData', sol_opt(:, 1), 'YData', sol_opt(:, 2)); % Update actual trajectory
        set(predicted_plot, 'XData', predicted_path(:, 1), 'YData', predicted_path(:, 2)); % Update predicted path
        pause(0.2); % Pause for visualization
    end

    % Update initial condition for next loop
    inicon = sol_one_step(end, :);
    % if inicon(1) > trackXY(end, 1)
    %     break;
    % end
    % Update guesses for next optimization
    u1_guess = [u1_opt(2:end), u1_opt(end)]; % Shift forward and repeat last value
    u2_guess = [u2_opt(2:end), u2_opt(end)]; % Shift forward and repeat last value
end

%% Plot Solution
if visualize
    delete(predicted_plot);
    delete(actual_plot);
end
plot(sol_opt(:,1), sol_opt(:,2), 'ro-', 'LineWidth', 1);
legend('Track','Car Trajectory');


%% Function Bank
% function error = next_error(u1, u2, lf, lr, initime, timestep, inicon)
%     [t, sol] = ode23tb(@(t, state) bicycle_model(t, state, u1, u2, lf, lr), [initime, initime+timestep], inicon);
%     nextcon = sol(end,:);
%     error = calc_error(nextcon(end,1:2), "acceleration");
% end

function total_error = n_step_error(u, N, current_state, lf, lr, timestep, indicies,  trackXY, turn_direction, trackname)
    % Optimize u1 first
    u1 = u(1:N);
    u2 = u(N+1:end);
    % Optimize u2 first
    % u1 = u(N+1:end);
    % u2 = u(1:N);
    distances = [];

    total_error = 0;

    for i = 1:N
        [~, sol] = ode23tb(@(t, state) bicycle_model(t, state, u1(i), u2(i), lf, lr), ...
                           [0, timestep], current_state);
        current_state = sol(end, :); % Update state

        if current_state(1) >= trackXY(indicies(1), 1) && (current_state(2) < trackXY(indicies(1), 2) + 0.25 || current_state(2) < trackXY(indicies(1), 2) - 0.25)
            turn_direction = "straight";
        elseif 
        end

        % Calculate total position error till this step
        total_error = total_error + calc_error(current_state(1:2), trackXY, turn_setting);
    end
end