%% Solving
for alpha = -2.142*pi/180
[FL_fixed, FL_planes, FL_lengths] = preprocess(1);
solved_FL_lower = calculate_lower(FL_fixed, FL_lengths, alpha);
solved_FL_upper = calculate_upper(FL_fixed, FL_lengths, FL_planes, solved_FL_lower(4,:));
solved_FL = [solved_FL_lower; solved_FL_upper];

%% Plotting
hold off
RGB = orderedcolors("glow12");
scatter3(FL_fixed(:,1), FL_fixed(:,2), FL_fixed(:,3), 40, "red", "filled")
hold on
scatter3(solved_FL_lower(:, 1), solved_FL_lower(:, 2), solved_FL_lower(:, 3), 40, RGB(1:4,:), "filled")
scatter3(solved_FL_upper(:, 1), solved_FL_upper(:, 2), solved_FL_upper(:, 3), 40, RGB(5:9,:), "filled")

if 1
rod_segments = [1 10; 1 11; 4 12; 4 13; 1 4; 1 3; 1 2; 4 3; 4 2; 3 14; 3 2; ...
                5 4; 6 15; 15 8; 8 7; 7 6; 7 9; 9 17; 8 16; 5 6; 6 8; 7 15];
rods = plotSegments([solved_FL; FL_fixed],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)
end


end
xlim([-400 400])
ylim([-100 700])
zlim([-400 400])
xlabel("x")
ylabel("y")
zlabel("z")