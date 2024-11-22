%% Optimize random steering angle and throttle with straight line
% 11/21 Make sure the car won't go backward, but
% 1. have some ripple
% 2. at bigger or smaller N than 10, it'll be unstable and diverge
%% Setup
clear;
clc;
close all;

%% Data
load Tracks/Tracks_Mat/acceleration.mat
addpath("MATLAB_Functions\")
trackname = "acceleration";
% [Dr(slop) Ypos Xpos TurnRad TurnDr(L/R) InstCY InstCX yaw]
trackXY = [track_data_acceleration(:,3) track_data_acceleration(:,2)];


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
N = 10; % n step ahead
total_points_num = 50;
startpoint = [0, 1]; % Start position [X, Y] [m, m]
lf = 1.17; % [m]
lr = 1.77; % [m]
steerlimit = 60; % [deg]
max_acc = 20; % [m/s^2]
timestep = 0.1; % [s]
% steerdeg = -1*steerlimit + (2*steerlimit) * rand(1,100);    % Random Steering angle in Degrees
% thrtl = ones(1, N); % 1 * rand(1,100);                    % Throttle depth 0 ~ 1
u1_guess = ones(1, N) * max_acc; % Throttle guess
u2_guess = zeros(1, N); % Steering guess

% Initial Condition [X, Y, V, psi]
inicon = [startpoint(1), startpoint(2), 0, -2*pi/3];
sol = inicon;
sol_opt = inicon;
t = timestep*(0:100);

if visualize
    actual_plot = plot(inicon(1), inicon(2), 'ro-', 'LineWidth', 1, 'DisplayName', 'Actual Trajectory');
    predicted_plot = plot(inicon(1), inicon(2), 'b--o', 'LineWidth', 0.5, 'DisplayName', 'Predicted Horizon');
    legend('track', 'best');
end

%% Do optimization
% for i = 1:50
%     % Get Random Next Condition (sol_i(end)) [X, Y, V, psi]
%     [t_i, sol_i] = ode23tb(@(t, state) bicycle_model(t, state, u1(i), u2(i), lf, lr), [t(i), t(i+1)], inicon);
%     sol_rand = sol_i(end,:);
% 
%     % Define dynamic bounds for steering (u2) based on psi
%     %u2_lb = max(deg2rad(-steerlimit), sol_i(end,4) - deg2rad(10)); u2_ub =
%     %min(deg2rad(steerlimit), sol_i(end,4) + deg2rad(10)); % Currently
%     %making it worse
% 
%     % Define Objective
%     objective = @(u2)next_error(u1(i), u2, lf, lr, t(i), timestep, inicon);
%     % Use fmincon to find steering angle for minimum error
%     [u2_opt, fval] = fmincon(objective, u2(i), [], [], [], [], deg2rad(-60), deg2rad(60), []);
% 
%     % Adjust the steering according to Ypos works like damper and more
%     % human if abs(fval)>= abs(sol_i(end,2))
%     %     u2_opt = u2(i);
%     % end
% 
%     % if fval ~= 0
%     %     if abs(fval) <= 0.9*startpoint(2) && abs(fval) > 0.2 *
%     %     startpoint(2) u2_opt = u2_opt*0.25; elseif abs(fval) <= 0.2*
%     %     startpoint(2) u2_opt = u2_opt; end
%     % end
% 
%     % Get optimized Next Condition
%     [t_i_new, sol_opt_new] = ode23tb(@(t, state) bicycle_model(t, state, u1(i), u2_opt, lf, lr), [t(i), t(i+1)], inicon);
%     % Record optimized solution
%     sol_opt = [sol_opt; sol_opt_new(end,:)];
%     % Update input for next point
%     u2(i+1) = u2_opt(end,:);
%     inicon = sol_opt(end,:);
% 
%     % Visualize the process
%     random_point = plot([inicon(1),sol_rand(1)], [inicon(2), sol_rand(2)], 'b-', 'Marker','o', 'MarkerFaceColor', 'b', 'MarkerSize', 3);
%     plot(sol_opt(end,1), sol_opt(end,2), 'r-', 'Marker','o', 'MarkerFaceColor', 'r', 'MarkerSize', 3);
%     pause(0.1);
%     delete(random_point);
% end

% n step
for k = 1:total_points_num
    % Optimize u1 first
    u_guess = [u1_guess,u2_guess];
    lb = [zeros(1, N), deg2rad(-steerlimit) * ones(1, N)];
    ub = [max_acc * ones(1, N), deg2rad(steerlimit) * ones(1, N)];

    objective = @(u) n_step_error(u, N, inicon, lf, lr, timestep, trackXY, trackname);
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
    if inicon(1) > trackXY(end, 1)
        break;
    end
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

function total_error = n_step_error(u, N, inicon, lf, lr, timestep, trackXY, trackname)
    % Optimize u1 first
    u1 = u(1:N);
    u2 = u(N+1:end);
    % Optimize u2 first
    % u1 = u(N+1:end);
    % u2 = u(1:N);

    current_state = inicon;
    total_error = 0;

    for i = 1:N
        [~, sol] = ode23tb(@(t, state) bicycle_model(t, state, u1(i), u2(i), lf, lr), ...
                           [0, timestep], current_state);
        current_state = sol(end, :); % Update state

        if current_state(1) > trackXY(end, 1)
            % print("hit the barrier");
            break;
        end

        % Calculate total position error till this step
        total_error = total_error + calc_error(current_state(1:2), trackXY, trackname);
    end
end