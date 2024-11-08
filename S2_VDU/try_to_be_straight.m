%% Optimize random steering angle and throttle with straight line
% 10/22 Position is optimized but not throttle and steering angle
clear;
clc;
close all;
load Tracks/Tracks_Mat/acceleration.mat
addpath("MATLAB_Functions\")
% [Dr(slop) Ypos Xpos TurnRad TurnDr(L/R) InstCY InstCX yaw]
trackXY = [track_data_acceleration(:,3) track_data_acceleration(:,2)];

lf = 1.17;
lr = 1.77;
steerlimit = 60;
max_acc = 20;
timestep = 0.1;

steerdeg = -1*steerlimit + (2*steerlimit) * rand(1,100);    % Random Steering angle in Degrees
thrtl = 1 * rand(1,100);                                    % Throttle depth 0 ~ 1
u1 = thrtl * max_acc;
u2 = deg2rad(steerdeg);

% Initial Condition [X, Y, V, psi]
inicon = [0, 5, 10, 0];
sol = inicon;
pos_opt = trackXY(1,:);
t = timestep*(0:100);

for i = 1:10
    error = [];
    for j = 0:4
        % Use the original input tp predict for five more time step
        [t_j, sol_j] = ode23tb(@(t, state) bicycle_model(t, state, u1(i), u2(i), lf, lr), [t(i+j), t(i+j+1)], inicon);
        sol = [sol; sol_j(end,:)];
        inicon = sol(end,:);
        % error = [error, calc_error(sol_j(end,1:2), trackXY(i+j,:), trackXY(i+j+1,:), "acceleration")];
        % Use fmincon to find the minimum error
        % In fmincon it should be bicycle model and output the 
    end

    % Calculate target position
    % [pos_opt_i, fval] = fmincon(@(currentpos)calc_error(currentpos, trackXY(i,:), trackXY(i+1,:)), inicon(1:2), [], []);
    % pos_opt = [pos_opt; pos_opt_i];
    % fmincon could not be efficient -> see ref_gen.m


end 


figure;
plot(trackXY(:,1), trackXY(:,2), "Color", 'k')
xlabel('X Position (m)');
ylabel('Y Position (m)');
title('Track Map')
grid on;
hold on;

plot(sol(:,1), sol(:,2), 'b-', 'Marker','o', 'MarkerFaceColor', 'b', 'MarkerSize', 3)
% plot(pos_opt(:,1), pos_opt(:,2), 'ro-', 'Marker','o', 'MarkerFaceColor', 'r', 'MarkerSize', 3)
% scatter(sol(:,1), sol(:,2), 30,'filled',"Color", 'b')

for i = 1:10
    objective = @(u2)next_error(u1(i),u2(i), inicon, t(i), timestep, lf, lr);
    [u2_opt, fval] = fmincon(objective, u2(i), [], [], [], [], -steerlimit, steerlimit, [])
    % 11/7 need to update the steering angle
end


function error = next_error(u1, u2, inicon, initime, timestep, lf, lr)
    [t_j, sol_j] = ode23tb(@(t, state) bicycle_model(t, state, u1, u2, lf, lr), [initime, initime+timestep], inicon);
    nextcon = sol_j(end,:);
    error = calc_error(nextcon(end,1:2), "acceleration");
end
