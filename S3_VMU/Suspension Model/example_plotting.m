temp = readmatrix("sus_data_FL.csv",Range="B:end");
fixed_pts = temp;
lengths = readmatrix("lengths_FL.csv");

alpha = 0;

solved_pts = solveSusPoints(fixed_pts, lengths, alpha);

RGB = orderedcolors("glow");
scatter3(fixed_pts(:,1), fixed_pts(:,2), fixed_pts(:,3), 40, "red", "filled")
hold on
scatter3(solved_pts(:, 1), solved_pts(:, 2), solved_pts(:, 3), 40, RGB(1:4,:), "filled")
rod_segments = [1 5; 1 6; 4 7; 4 8; 1 4; 1 3; 1 2; 4 3; 4 2; 3 9; 3 2];
rods = plotSegments([solved_pts; fixed_pts],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)

xlabel("x")
ylabel("y")
zlabel("z")