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

%% Generate Ground Plane
roll = 0*pi/180;
pitch = 2*pi/180;
h_cog = 203/1000;
n_ground = cross([cos(-pitch), 0, sin(-pitch)], [0, cos(roll), sin(roll)]);
p_ground = n_ground(3) * -h_cog;

a = [cos(-pitch), 0, sin(-pitch)];
b = [0, cos(roll), sin(roll)];
    
%n_ground = cross(a,b);
%p_ground = n_ground(3) * -s(6);

n = n_ground / norm(n_ground);
rotation_og = [a; b; n];

%% Solving
% Upper and lower bounds for the A - arm angle for the fzero function
F_lb = -25*pi/180;
F_ub = 25*pi/180;
R_lb = -25*pi/180;
R_ub = 25*pi/180;

% solve FL
res = @(alpha)(distance(FL_fixed, FL_lengths, alpha, n_ground, p_ground));
FL_alpha_sol = fzero(res, [F_lb F_ub]);

% solve RL
res = @(alpha)(distance(FR_fixed, FR_lengths, alpha, n_ground, p_ground));
FR_alpha_sol = fzero(res, [F_lb F_ub]);

% solve RL
res = @(alpha)(distance(RL_fixed, RL_lengths, alpha, n_ground, p_ground));
RL_alpha_sol = fzero(res, [R_lb R_ub]);

% solve RR
res = @(alpha)(distance(RR_fixed, RR_lengths, alpha, n_ground, p_ground));
RR_alpha_sol = fzero(res, [R_lb R_ub]);

%% Calculate from solutions
% FL
FL_lower_solved = calculate_lower(FL_fixed, FL_lengths, FL_alpha_sol);
FL_upper_solved = calculate_upper(FL_fixed, FL_lengths, FL_planes, FL_lower_solved(4,:));
FL_solved = [FL_lower_solved; FL_upper_solved];
% RL
RL_lower_solved = calculate_lower(RL_fixed, RL_lengths, RL_alpha_sol);
RL_upper_solved = calculate_upper(RL_fixed, RL_lengths, RL_planes, RL_lower_solved(4,:));
RL_solved = [RL_lower_solved; RL_upper_solved];
% FR
FR_lower_solved = calculate_lower(FR_fixed, FR_lengths, FR_alpha_sol);
FR_upper_solved = calculate_upper(FR_fixed, FR_lengths, FR_planes, FR_lower_solved(4,:));
FR_solved = [FR_lower_solved; FR_upper_solved];
% RR
RR_lower_solved = calculate_lower(RR_fixed, RR_lengths, RR_alpha_sol);
RR_upper_solved = calculate_upper(RR_fixed, RR_lengths, RR_planes, RR_lower_solved(4,:));
RR_solved = [RR_lower_solved; RR_upper_solved];

rotation_go = rotation_og';
x0 = -(p_ground ./ dot(n, n)) .* n;
FL_solved_car = x0 + FL_solved * rotation_go;
FR_solved_car = x0 + FR_solved * rotation_go;
RL_solved_car = x0 + RL_solved * rotation_go;  
RR_solved_car = x0 + RR_solved * rotation_go;
FR_fixed_car = x0 + FR_fixed * rotation_go;
RR_fixed_car = x0 + RR_fixed * rotation_go;
FL_fixed_car = x0 + FL_fixed * rotation_go;
RL_fixed_car = x0 + RL_fixed * rotation_go;


%% Plotting Solutions
figure(1); hold off
RGB = orderedcolors("glow12");
% FL plotting
scatter3(FL_fixed(:,1), FL_fixed(:,2), FL_fixed(:,3), 40, "red", "filled"); hold on
scatter3(FL_lower_solved(:, 1), FL_lower_solved(:, 2), FL_lower_solved(:, 3), 40, RGB(1:4,:), "filled")
scatter3(FL_upper_solved(:, 1), FL_upper_solved(:, 2), FL_upper_solved(:, 3), 40, RGB(5:9,:), "filled")
rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([FL_solved; FL_fixed],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

% RL Plotting
scatter3(RL_fixed(:,1), RL_fixed(:,2), RL_fixed(:,3), 40, "red", "filled"); hold on
scatter3(RL_lower_solved(:, 1), RL_lower_solved(:, 2), RL_lower_solved(:, 3), 40, RGB(1:4,:), "filled")
scatter3(RL_upper_solved(:, 1), RL_upper_solved(:, 2), RL_upper_solved(:, 3), 40, RGB(5:9,:), "filled")
rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([RL_solved; RL_fixed],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

% FR Plotting
scatter3(FR_fixed(:,1), FR_fixed(:,2), FR_fixed(:,3), 40, "red", "filled"); hold on
scatter3(FR_lower_solved(:, 1), FR_lower_solved(:, 2), FR_lower_solved(:, 3), 40, RGB(1:4,:), "filled")
scatter3(FR_upper_solved(:, 1), FR_upper_solved(:, 2), FR_upper_solved(:, 3), 40, RGB(5:9,:), "filled")
rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([FR_solved; FR_fixed],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

% RR Plotting
scatter3(RR_fixed(:,1), RR_fixed(:,2), RR_fixed(:,3), 40, "red", "filled"); hold on
scatter3(RR_lower_solved(:, 1), RR_lower_solved(:, 2), RR_lower_solved(:, 3), 40, RGB(1:4,:), "filled")
scatter3(RR_upper_solved(:, 1), RR_upper_solved(:, 2), RR_upper_solved(:, 3), 40, RGB(5:9,:), "filled")
rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([RR_solved; RR_fixed],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

% labels
xlabel("x")
ylabel("y")
zlabel("z")
xlim([-2 1])
ylim([-.700 .700])
zlim([-.400 .400])

% Plot Planes
o1 = [-5 -2 0];
o1(3) = (dot(n_ground, o1) - p_ground) / -n_ground(3);
o2 = [2.5 -10 0];
o2(3) = (dot(n_ground, o2) - p_ground) / -n_ground(3);
o3 = [0 10 0];
o3(3) = (dot(n_ground, o3) - p_ground) / -n_ground(3);
o4 = [-.100 -.100 0];
o4(3) = (dot(n_ground, o4) + p_ground) / n_ground(3);
fill1 = fill3([o1(1), o2(1), o3(1)], [o1(2), o2(2), o3(2)], [o1(3), o2(3), o3(3)], RGB(1,:));
fill1(1).FaceAlpha = 0.3;

set(gcf, "Theme", "Light")

figure(2); hold off
RGB = orderedcolors("glow12");
% FL plotting
scatter3(FL_fixed_car(:,1), FL_fixed_car(:,2), FL_fixed_car(:,3), 40, "red", "filled"); hold on
scatter3(FL_solved_car(:, 1), FL_solved_car(:, 2), FL_solved_car(:, 3), 40, RGB(1:9,:), "filled")
%scatter3(FL_upper_solved(:, 1), FL_upper_solved(:, 2), FL_upper_solved(:, 3), 40, RGB(5:9,:), "filled")
rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([FL_solved_car; FL_fixed_car],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

% RL Plotting
scatter3(RL_fixed_car(:,1), RL_fixed_car(:,2), RL_fixed_car(:,3), 40, "red", "filled"); hold on
scatter3(RL_solved_car(:, 1), RL_solved_car(:, 2), RL_solved_car(:, 3), 40, RGB(1:9,:), "filled")
%scatter3(RL_upper_solved(:, 1), RL_upper_solved(:, 2), RL_upper_solved(:, 3), 40, RGB(5:9,:), "filled")
rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([RL_solved_car; RL_fixed_car],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

% FR Plotting
scatter3(FR_fixed_car(:,1), FR_fixed_car(:,2), FR_fixed_car(:,3), 40, "red", "filled"); hold on
scatter3(FR_solved_car(:, 1), FR_solved_car(:, 2), FR_solved_car(:, 3), 40, RGB(1:9,:), "filled")
%scatter3(FR_upper_solved(:, 1), FR_upper_solved(:, 2), FR_upper_solved(:, 3), 40, RGB(5:9,:), "filled")
rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([FR_solved_car; FR_fixed_car],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

% RR Plotting
scatter3(RR_fixed_car(:,1), RR_fixed_car(:,2), RR_fixed_car(:,3), 40, "red", "filled"); hold on
scatter3(RR_solved_car(:, 1), RR_solved_car(:, 2), RR_solved_car(:, 3), 40, RGB(1:9,:), "filled")
%scatter3(RR_upper_solved(:, 1), RR_upper_solved(:, 2), RR_upper_solved(:, 3), 40, RGB(5:9,:), "filled")
rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([RR_solved_car; RR_fixed_car],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

% labels
xlabel("x")
ylabel("y")
zlabel("z")
xlim([-2 1])
ylim([-.700 .700])
zlim([-.100 .700])

% Plot Planes
o1 = [-5 -2 0] * rotation_og + ((p_ground ./ dot(n, n)) .* n);
o1(3) = (dot(n_ground, o1) - p_ground) / -n_ground(3);
o2 = [2.5 -10 0] * rotation_og + ((p_ground ./ dot(n, n)) .* n);
o2(3) = (dot(n_ground, o2) - p_ground) / -n_ground(3);
o3 = [0 10 0] * rotation_og + ((p_ground ./ dot(n, n)) .* n);
o3(3) = (dot(n_ground, o3) - p_ground) / -n_ground(3);
o4 = [-.100 -.100 0] * rotation_og + ((p_ground ./ dot(n, n)) .* n);
o4(3) = (dot(n_ground, o4) + p_ground) / n_ground(3);
fill1 = fill3([o1(1), o2(1), o3(1)], [o1(2), o2(2), o3(2)], [o1(3), o2(3), o3(3)], RGB(1,:));
fill1(1).FaceAlpha = 0.3;

set(gcf, "Theme", "Light")
%% Functions
% takes fixed points, lengths, alpha, and ground plane normal and distance
% ground plane is in the from x dot n_ground = p_ground
% computes z distance between ground plane and tire (point 2)
function error = distance(fixed, lengths, alpha, n_ground, p_ground)
    pts = calculate_lower(fixed, lengths, alpha);
    error = dot(pts(2,:), n_ground) - p_ground;
end