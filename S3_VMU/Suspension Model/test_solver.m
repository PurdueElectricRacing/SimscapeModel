a = [0 1 0];
b = [0 -1 0];
c = [0 1 4];
d = [0 -1 4];
e = [2 -4 2];
fixed_pts = [a; b; c; d; e];

l(1) = 3.1623;
l(2) = 3.1623;
l(3) = 3.1623;
l(4) = 3.1623;
l(5) = 4;
l(6) = 2.5;
l(7) = 2.8284;
l(8) = 4.5;
l(9) = 4.5;
l(10) = 2.2;
l(11) = 6.0828;

alpha = 0;

pitch = 0;
roll = 0;
h = 1;

n1 = cross([cos(roll), 0, sin(roll)], [0, cos(pitch), sin(pitch)]);
p1 = -n1(3) * h;

alpha_sol = fzero(@(alpha)(residual(fixed_pts, l, alpha, n1, p1)), [-pi/4, pi/4]);

solved_pts = solveSusPoints(fixed_pts, l, alpha_sol);

scatter3(fixed_pts(:,1), fixed_pts(:,2), fixed_pts(:,3), 40, "red", "filled")
hold on;
RGB = orderedcolors("glow");
scatter3(solved_pts(:, 1), solved_pts(:, 2), solved_pts(:, 3), 40, RGB(1:4,:), "filled")
rod_segments = [1 5; 1 6; 4 7; 4 8; 1 4; 1 3; 1 2; 4 3; 4 2; 3 9; 3 2];
rods = plotSegments([solved_pts; fixed_pts],rod_segments);
plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)
set(gcf, "Theme", "Light")
xlabel("x")
ylabel("y")
zlabel("z")
xlim([0,6])
ylim([-4,2])

function error = residual(f, l, alpha, n1, p1)
    pts = solveSusPoints(f, l, alpha);
    error = dot(pts(2,:), n1) - p1;
    
end