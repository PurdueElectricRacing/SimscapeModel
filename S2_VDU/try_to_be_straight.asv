%% Optimize random steering angle and throttle with straight line
% 11/9 The car can go straight but take a bit longer
% 
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
thrtl = 0.5*ones(100);% 1 * rand(1,100);                                    % Throttle depth 0 ~ 1
u1 = thrtl * max_acc;
u2 = deg2rad(steerdeg);

% Initial Condition [X, Y, V, psi]
startpoint = [0, 0];
inicon = [startpoint(1), startpoint(2), 10, 0];
sol = inicon;
sol_opt = inicon;
t = timestep*(0:100);

% Original Random Acc, Steer
for i = 1:50
    [t_i, sol_i] = ode23tb(@(t, state) bicycle_model(t, state, u1(i), u2(i), lf, lr), [t(i), t(i+1)], inicon);
    sol = [sol; sol_i(end,:)];
    inicon = sol(end,:);
end 

clear inicon;
inicon = [startpoint(1), startpoint(2), 10, 0];


for i = 1:50 
    % Get Next Condition (sol_i(end)) [X, Y, V, psi]
    [t_i, sol_i] = ode23tb(@(t, state) bicycle_model(t, state, u1(i), u2(i), lf, lr), [t(i), t(i+1)], inicon);
    % Define dynamic bounds for steering (u2) based on psi
    u2_lb = max(deg2rad(-steerlimit), sol_i(end,4) - deg2rad(10)); 
    u2_ub = min(deg2rad(steerlimit), sol_i(end,4) + deg2rad(10)); % Currently making it worse

    % Define Objective
    objective = @(u2)next_error(u1(i), u2, lf, lr, t(i), timestep, inicon);
    % Use fmincon to find steering angle for minimum error
    [u2_opt, fval] = fmincon(objective, u2(i), [], [], [], [], deg2rad(-5), deg2rad(5), [])
    if abs(fval)>= abs(sol_i(end,2))
        u2_opt = u2(i);
    end
    if abs(fval) <= 8 && abs(fval) >3
        u2_opt = u2_opt*0.25
    elseif abs(fval) <= 5

    end
    % Get optimized Next Condition
    [t_i_new, sol_opt_new] = ode23tb(@(t, state) bicycle_model(t, state, u1(i), u2_opt, lf, lr), [t(i), t(i+1)], inicon);
    % Record optimized solution 
    sol_opt = [sol_opt; sol_opt_new(end,:)];
    % Update input for next point
    u2(i+1) = u2_opt(end,:);
    inicon = sol_opt(end,:);
end

figure;
plot(trackXY(:,1), trackXY(:,2), "Color", 'k')
xlabel('X Position (m)');
ylabel('Y Position (m)');
title('Track Map')
grid on;
hold on;

plot(sol(:,1), sol(:,2), 'b-', 'Marker','o', 'MarkerFaceColor', 'b', 'MarkerSize', 3)
plot(sol_opt(:,1), sol_opt(:,2), 'ro-', 'Marker','o', 'MarkerFaceColor', 'r', 'MarkerSize', 3)
legend('Track', 'Random', 'The Driver')
% scatter(sol(:,1), sol(:,2), 30,'filled',"Color", 'b')


function error = next_error(u1, u2, lf, lr, initime, timestep, inicon)
    [t, sol] = ode23tb(@(t, state) bicycle_model(t, state, u1, u2, lf, lr), [initime, initime+timestep], inicon);
    nextcon = sol(end,:);
    error = calc_error(nextcon(end,1:2), "acceleration");
end

