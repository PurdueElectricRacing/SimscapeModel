%% Load data
% FL 
[FL_fixed, FL_planes, FL_lengths] = preprocess("FL_sus_data.csv");
% FR is FL with negative y-coord
FR_fixed = FL_fixed.*[1 -1 1];
FR_planes = FL_planes.*[1 -1 1 1];
FR_lengths = FL_lengths;
% RL
[RL_fixed, RL_planes, RL_lengths] = preprocess("RL_sus_data.csv");
% RR is RL with negative y-coord
RR_fixed = RL_fixed.*[1 -1 1];
RR_planes = RL_planes.*[1 -1 1 1];
RR_lengths = RL_lengths;

%% FL Solving
FL_alpha = 5*pi/180;
FL_lower_solved = calculate_lower(FL_fixed, FL_lengths, FL_alpha);
FL_upper_solved = calculate_upper(FL_fixed, FL_lengths, FL_planes, FL_lower_solved(4,:));
FL_solved = [FL_lower_solved; FL_upper_solved];

%% FL Plotting
figure(1); hold off
RGB = orderedcolors("glow12");
scatter3(FL_fixed(:,1), FL_fixed(:,2), FL_fixed(:,3), 40, "red", "filled")
hold on
scatter3(FL_lower_solved(:, 1), FL_lower_solved(:, 2), FL_lower_solved(:, 3), 40, RGB(1:4,:), "filled")
scatter3(FL_upper_solved(:, 1), FL_upper_solved(:, 2), FL_upper_solved(:, 3), 40, RGB(5:9,:), "filled")

rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([FL_solved; FL_fixed],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

xlim([-400 400])
ylim([-100 700])
zlim([-400 400])
xlabel("x")
ylabel("y")
zlabel("z")

%% FR Solving
FR_alpha = -10*pi/180;
FR_lower_solved = calculate_lower(FR_fixed, FR_lengths, FR_alpha);
FR_upper_solved = calculate_upper(FR_fixed, FR_lengths, FR_planes, FR_lower_solved(4,:));
FR_solved = [FR_lower_solved; FR_upper_solved];

%% FR Plotting
figure(2); hold off
RGB = orderedcolors("glow12");
scatter3(FR_fixed(:,1), FR_fixed(:,2), FR_fixed(:,3), 40, "red", "filled")
hold on
scatter3(FR_lower_solved(:, 1), FR_lower_solved(:, 2), FR_lower_solved(:, 3), 40, RGB(1:4,:), "filled")
scatter3(FR_upper_solved(:, 1), FR_upper_solved(:, 2), FR_upper_solved(:, 3), 40, RGB(5:9,:), "filled")

rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([FR_solved; FR_fixed],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

xlim([-400 400])
ylim([-700 100])
zlim([-400 400])
xlabel("x")
ylabel("y")
zlabel("z")

%% RL Solving
RL_alpha = -10.106*pi/180;
RL_lower_solved = calculate_lower(RL_fixed, RL_lengths, RL_alpha);
RL_upper_solved = calculate_upper(RL_fixed, RL_lengths, RL_planes, RL_lower_solved(4,:));
RL_solved = [RL_lower_solved; RL_upper_solved];

%% RL Plotting
figure(3); hold off
RGB = orderedcolors("glow12");
scatter3(RL_fixed(:,1), RL_fixed(:,2), RL_fixed(:,3), 40, "red", "filled")
hold on
scatter3(RL_lower_solved(:, 1), RL_lower_solved(:, 2), RL_lower_solved(:, 3), 40, RGB(1:4,:), "filled")
scatter3(RL_upper_solved(:, 1), RL_upper_solved(:, 2), RL_upper_solved(:, 3), 40, RGB(5:9,:), "filled")

rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([RL_solved; RL_fixed],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

% xlim([-400 400])
% ylim([-100 700])
% zlim([-400 400])
xlabel("x")
ylabel("y")
zlabel("z")

