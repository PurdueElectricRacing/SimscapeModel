%% Optimize random steering angle and throttle with straight line
% 11/9 The car can go straight but take a bit longer and is constant throttle
%% Setup
clear;
clc;
close all;


%% Data
load Tracks/Tracks_Mat/acceleration.mat
addpath("MATLAB_Functions\")
% [Dr(slop) Ypos Xpos TurnRad TurnDr(L/R) InstCY InstCX yaw]
trackXY = [track_data_acceleration(:,3) track_data_acceleration(:,2)];


%% Draw the track
figure;
plot(trackXY(:,1), trackXY(:,2), "Color", 'k')
xlabel('X Position (m)');
ylabel('Y Position (m)');
title('Track Map');
grid on;
hold on;


%% Initial setup
startpoint = [0, 1]; % Start position [X, Y] [m, m]
lf = 1.17; % [m]
lr = 1.77; % [m]
steerlimit = 60; % [deg]
max_acc = 20; % [m/s^2]
timestep = 0.1; % [s]
steerdeg = -1*steerlimit + (2*steerlimit) * rand(1,100);    % Random Steering angle in Degrees
thrtl = 0.5*ones(100);% 1 * rand(1,100);                    % Throttle depth 0 ~ 1
u1 = thrtl * max_acc;
u2 = deg2rad(steerdeg);

% Initial Condition [X, Y, V, psi]
inicon = [startpoint(1), startpoint(2), 0, 0];
sol = inicon;
sol_opt = inicon;
t = timestep*(0:100);


%% Do optimization
for i = 1:50
    % Get Random Next Condition (sol_i(end)) [X, Y, V, psi]
    [t_i, sol_i] = ode23tb(@(t, state) bicycle_model(t, state, u1(i), u2(i), lf, lr), [t(i), t(i+1)], inicon);
    sol_rand = sol_i(end,:);

    % Define dynamic bounds for steering (u2) based on psi
    %u2_lb = max(deg2rad(-steerlimit), sol_i(end,4) - deg2rad(10)); 
    %u2_ub = min(deg2rad(steerlimit), sol_i(end,4) + deg2rad(10)); % Currently making it worse

    % Define Objective
    objective = @(u2)next_error(u1(i), u2, lf, lr, t(i), timestep, inicon);
    % Use fmincon to find steering angle for minimum error
    [u2_opt, fval] = fmincon(objective, u2(i), [], [], [], [], deg2rad(-60), deg2rad(60), []);

    % Adjust the steering according to Ypos 
    % works like damper and more human
    % if abs(fval)>= abs(sol_i(end,2))
    %     u2_opt = u2(i);
    % end

    % if fval ~= 0
    %     if abs(fval) <= 0.9*startpoint(2) && abs(fval) > 0.2 * startpoint(2)
    %     u2_opt = u2_opt*0.25;
    %     elseif abs(fval) <= 0.2* startpoint(2)
    %     u2_opt = u2_opt;
    %     end
    % end

    % Get optimized Next Condition
    [t_i_new, sol_opt_new] = ode23tb(@(t, state) bicycle_model(t, state, u1(i), u2_opt, lf, lr), [t(i), t(i+1)], inicon);
    % Record optimized solution 
    sol_opt = [sol_opt; sol_opt_new(end,:)];
    % Update input for next point
    u2(i+1) = u2_opt(end,:);
    inicon = sol_opt(end,:);

    % Visualize the process
    random_point = plot([inicon(1),sol_rand(1)], [inicon(2), sol_rand(2)], 'b-', 'Marker','o', 'MarkerFaceColor', 'b', 'MarkerSize', 3);
    plot(sol_opt(end,1), sol_opt(end,2), 'r-', 'Marker','o', 'MarkerFaceColor', 'r', 'MarkerSize', 3);
    pause(0.1);
    delete(random_point);
end


%% Plot Solution
plot(sol_opt(:,1), sol_opt(:,2), 'r-');


%% Function Bank
function error = next_error(u1, u2, lf, lr, initime, timestep, inicon)
    [t, sol] = ode23tb(@(t, state) bicycle_model(t, state, u1, u2, lf, lr), [initime, initime+timestep], inicon);
    nextcon = sol(end,:);
    error = calc_error(nextcon(end,1:2), "acceleration");
end