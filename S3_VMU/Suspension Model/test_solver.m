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
l(6) = 2.8284;
l(7) = 2.8284;
l(8) = 5;
l(9) = 4.5;
l(10) = 2.5;
l(11) = 6.0828;

close all

for ey  = -4
fixed_pts(5,2) = ey;

for alpha = linspace(-pi/8, pi/8, 9);

% z1 = -1;

solved_pts = solveSusPoints(fixed_pts, l, alpha);

scatter3(fixed_pts(:,1), fixed_pts(:,2), fixed_pts(:,3), 40, "red", "filled")
hold on;
RGB = orderedcolors("glow");
scatter3(solved_pts(:, 1), solved_pts(:, 2), solved_pts(:, 3), 40, RGB(1:4,:), "filled")

end
end

% hold off;
xlabel("x")
ylabel("y")
zlabel("z")
% xlim([-5,5])
% ylim([-2,6])
% zlim([-4,6])