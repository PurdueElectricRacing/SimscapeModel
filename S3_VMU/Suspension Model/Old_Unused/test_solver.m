temp = readmatrix("fixed_points.csv");
fixed_pts = [temp(:,2), temp(:,1), temp(:,3)];

l = readmatrix("length.csv");

alpha = 0;

i = 1;

for pitch = 0%linspace(-pi/8,pi/8,5)
for roll = 0%linspace(-pi/16,pi/16,3)
h = 2;

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



o1 = [-100 -100 0];
o1(3) = (dot(n1, o1) - p1) / -n1(3);
o2 = [100 -100 0];
o2(3) = (dot(n1, o2) - p1) / -n1(3);
o3 = [0 100 0];
o3(3) = (dot(n1, o3) - p1) / -n1(3);
o4 = [-100 -100 0];
o4(3) = (dot(n1, o4) + p1) / n1(3);


plot3(rods(:,1), rods(:,2), rods(:,3), Color="#edb120", LineWidth=1)
% fill1 = fill3([o1(1), o2(1), o3(1)], [o1(2), o2(2), o3(2)], [o1(3), o2(3), o3(3)], RGB(i,:));
% fill1(1).FaceAlpha = 0.3;

i = i+1;
end
end


set(gcf, "Theme", "Light")
xlabel("x")
ylabel("y")
zlabel("z")
% xlim([0,6])
% ylim([-4,2])
% zlim([-4,6])

function error = residual(f, l, alpha, n1, p1)
    pts = solveSusPoints(f, l, alpha);
    error = dot(pts(2,:), n1) - p1;
    
end
