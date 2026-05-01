% x = ST
% y = GS
% z = yaw

%% Params
ST_max = 130;
GS_max = 30;

%% pick 4 points
p1 = [20 21.5 0.5693];
p2 = [35 12.5 .7437];
p3 = [80 7.5 1.054];
p4 = [130 5.5 1.1522];
cpts = [p1; p2; p3; p4];

%% curve fit
% curve fit z=f(x)
zfx = @(x) (interp1(cpts(:,1), cpts(:,3), x, "pchip"));
% curve fit y = f(x)
yfx = @(x) (interp1(cpts(:,1), cpts(:,2), x, "pchip"));
% invert curve fit y = f(x) to get x = f(y);
xfy = @(yarr) (arrayfun(@(y)(fzero(@(x)(yfx(x)-y), [p1(1), p4(1)])), yarr));

% plotting
xcurve = linspace(p1(1),ST_max,100);
zcurve = zfx(xcurve);
ycurve = yfx(xcurve);

figure(3)
hold off 
plot(xcurve, zcurve);
hold on
scatter(cpts(:,1), cpts(:,3))
xlim([0, ST_max])
xlabel("ST")
ylabel("yaw")

figure(4)
hold off 
plot(xcurve, ycurve);
hold on
scatter(cpts(:,1), cpts(:,2))
xlim([0, ST_max])
xlabel("GS")
ylabel("yaw")

figure(5)
hold off
plot3(xcurve, ycurve, zcurve)
hold on
scatter3(cpts(:,1), cpts(:,2), cpts(:,3))
xlim([0, ST_max])
ylim([0, GS_max])
zlim([0, inf])
xlabel("ST")
ylabel("GS")
zlabel("yaw")
grid

%% secant lines in x and y
% secant from x to curve
xlin1 = linspace(p1(1), p4(1), 20);
ylin1 = yfx(xlin1);
zlin1 = zfx(xlin1);
aofx = zlin1 ./ ylin1;
function a = afx_func(x, p1, yfx, zfx)
    a = zeros(size(x));
    cond = x >= p1(1);
    a1 = zfx(x(cond)) ./ yfx(x(cond));
    a2 = interp1([0,p1(1)], [0, zfx(p1(1)) ./ yfx(p1(1))], x(~cond));
    a(cond) = a1;
    a(~cond) = a2;
end
afx = @(x)(afx_func(x, p1, yfx, zfx));

% secant from y to curve
ylin2 = linspace(p1(2), p4(2), 20);
xlin2 = zeros(size(ylin2));
for i = 1:length(ylin2)
    xlin2(i) = fzero(@(x)(yfx(x)-ylin2(i)), [xlin1(1), xlin1(end)]);
end
zlin2 = zfx(xlin2);
bofy = zlin2 ./ xlin2;
function b = bfy_func(y, p4, xfy, zfx)
    b = zeros(size(y));
    cond = y >= p4(2);
    b1 = zfx(xfy(y(cond))) ./ xfy(y(cond));
    b2 = interp1([0,p4(2)], [0, zfx(p4(1)) / xfy(p4(2))], y(~cond));
    b(cond) = b1;
    b(~cond) = b2;
end
bfy = @(y)(bfy_func(y, p4, xfy, zfx));


% plot test
figure(6)
[x1, y1] = meshgrid(linspace(0, xlin1(end), 20), linspace(0, ylin2(1), 20));
% z1 = aofx .* y1;
z1 = afx(x1(1,:)) .* y1;
% z2 = bofy' .* x1;
% zavg = (z1 + z2) / 2;
hold off
surf(x1, y1, z1, FaceAlpha=.5);
hold on
% surf(x1, y1, z2, FaceAlpha=.5);
plot3(xcurve, ycurve, zcurve)
xlabel("ST")
ylabel("GS")
zlabel("yaw")
xlim([0, ST_max])
ylim([0, GS_max])
zlim([0, 1.2])

% figure(7)
% surf(x1, y1, zavg);
% xlabel("ST")
% ylabel("GS")
% zlabel("yaw")
% xlim([0, ST_max])
% ylim([0, GS_max])
% zlim([0, 1.2])
%% 

%%
% xfy = @(y) (interp1(cpts(:,2), cpts(:,1), y, "pchip"));
% zfy = @(y) (interp1(cpts(:,2), cpts(:,3), y, "pchip"));
% ycurve2 = linspace(p4(2),p1(2),100);
% xcurve2 = xfy(ycurve2);
% zcurve2 = zfx(xcurve2);