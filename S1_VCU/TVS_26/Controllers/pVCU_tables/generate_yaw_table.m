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
function x = xfy_func(y, p1, p4, yfx)
    % if y < p4(2) || y > p1(2)
        % x = NaN;
    % else
    y = snip(y, p4(2), p1(2));
    x = fzero(@(x)(yfx(x)-y), [p1(1), p4(1)]);
    % end
end
% xfy = @(yarr) (arrayfun(@(y)(fzero(@(x)(yfx(x)-y), [p1(1), p4(1)])), yarr));
xfy = @(yarr) (arrayfun(@(y) (xfy_func(y, p1, p4, yfx)), yarr));


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
[xf,  yf] = meshgrid(linspace(0, ST_max, 25), linspace(0, GS_max, 25));
figure(6)
[x1, y1] = meshgrid(linspace(0, p4(1), 40), linspace(0, p1(2), 40));
outside1 = yf > yfx(xf);
% z1 = aofx .* y1;
% z1 = afx(x1(1,:)) .* y1;
% z1(outside1) = NaN;
% z2 = bofy' .* x1;
% z2 = bfy(y1(:,1)) .* x1;
% z2(outside1) = NaN;
% zavg = (z1 + z2) / 2;
zavg = @(x,y)( ((afx(x).*y)+(bfy(y).*x)) / 2 );

% hold off
% surf(x1, y1, z1, FaceAlpha=.5);
% hold on
% surf(x1, y1, z2, FaceAlpha=.5);
hold off
plot3(xcurve, ycurve, zcurve)
hold on
zavg_plot = zavg(xf, yf);
% zavg_plot(outside1) = NaN;
surf(xf, yf, zavg_plot)
xlabel("ST")
ylabel("GS")
zlabel("yaw")
xlim([0, ST_max])
ylim([0, GS_max])
zlim([0, 2])


%% High GS region
hgsx = @(x) (interp1([0 p1(1), p4(1)], [0, p1(3), 0.5*p1(3)], x));
hgsxy = @(x, y) (interp1([GS_max, p1(2)], [0, hgsx(x)], y));
[x2, y2] = meshgrid(linspace(0, p4(1), 40), linspace(p1(2), GS_max, 20));
zhgs = arrayfun(hgsxy, x2, y2);
surf(x2, y2, zhgs)

%% Loss of traction region
function z = notr_func(x, y, hgsx, yfx, zfx, p1)
    if p1(1) >= x
        z = p1(3);
    else
        z = interp1([p1(2), yfx(x)], [hgsx(x), zfx(x)], y, "linear", "extrap");
    end
end

% notr = @(x,y) (interp1([p1(2), yfx(x)], [hgsx(x), zfx(x)], y));
notr = @(x,y) (notr_func(x, y, hgsx, yfx, zfx, p1));
[x3, y3] = meshgrid(linspace(0, p4(1), 40), linspace(p1(2), p4(2), 40));
znotr = arrayfun(notr, x3, y3);
% outside2 = y3 < yfx(x3);
% znotr(outside) = NaN;
% figure(7)
surf(x3, y3, znotr)
% zlim([0,2]);

% figure(7)
% surf(x1, y1, zavg);
% xlabel("ST")
% ylabel("GS")
% zlabel("yaw")
% xlim([0, ST_max])
% ylim([0, GS_max])
% zlim([0, 1.2])

%%
% xfy = @(y) (interp1(cpts(:,2), cpts(:,1), y, "pchip"));
% zfy = @(y) (interp1(cpts(:,2), cpts(:,3), y, "pchip"));
% ycurve2 = linspace(p4(2),p1(2),100);
% xcurve2 = xfy(ycurve2);
% zcurve2 = zfx(xcurve2);