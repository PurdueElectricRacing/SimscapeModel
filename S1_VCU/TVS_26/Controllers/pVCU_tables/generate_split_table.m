% x = ST
% y = GS
% z = split
%   0 is 50:50, 1 is max split

%% Params
ST_max = 130;
GS_max = 25;

%% pick 4 points
p1 = [20 21.5 0];
p2 = [35 12.5 .3];
p3 = [80 7.5 .7];
p4 = [130 5.5 1];
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

%% contol region - secant lines in only y
% secant from x to curve

% secant from y deadband to curve
function b = bfy_func(y, p4, xfy, zfx)
    b = zeros(size(y));
    cond = y >= p4(2);
    b1 = zfx(xfy(y(cond))) ./ xfy(y(cond));
    b2 = interp1([0,p4(2)], [0, zfx(p4(1)) / xfy(p4(2))], y(~cond));
    b(cond) = b1;
    b(~cond) = b2;
end
bfy = @(yarr)( arrayfun(@(y) (bfy_func(y, p4, xfy, zfx)), yarr) );

maxsty =  @(yarr) ( arrayfun( @(y)(interp1([0, p4(2), p1(2)], [1, 1, 0], y)), yarr));
function z = ctrl_func(x, y, p1, p4, xfy, yfx, zfx, maxsty)
    if y >= p1(2) % high speed 0
        z = 0;
    elseif x <= p1(1) % low ST 0
        z = 0;
    elseif y >= yfx(x)
        z = interp1([p1(1), xfy(y)], [0, zfx(xfy(y))], x, "linear", "extrap");
    else
        % z = interp1([p1(1), xfy(y)], [0, maxsty(y)], x, "linear", "extrap");
        z = zfx(x);
    end
end
ctrl = @(x, y) (ctrl_func(x, y, p1, p4, xfy, yfx, zfx, maxsty));

% plot test
[xf,  yf] = meshgrid(linspace(0, ST_max, 27), linspace(0, GS_max, 51));
[x1, y1] = meshgrid(linspace(0, p4(1), 40), linspace(0, p1(2), 40));
outside1 = yf > yfx(xf);
% z1 = aofx .* y1;
% z1 = afx(x1(1,:)) .* y1;
% z1(outside1) = NaN;
% z2 = bofy' .* x1;
% z2 = bfy(y1(:,1)) .* x1;
% z2(outside1) = NaN;
% zavg = (z1 + z2) / 2;
% zavg = @(x,y)( (bfy(y).*x) );

% hold off
% surf(x1, y1, z1, FaceAlpha=.5);
% hold on
% surf(x1, y1, z2, FaceAlpha=.5);
figure(6)
hold off
plot3(xcurve, ycurve, zcurve, LineWidth=3, Color="red")
hold on
% zavg_plot = zavg(xf, yf);
zavg_plot = arrayfun(ctrl, xf, yf);
% zavg_plot(outside1) = NaN;
surf(xf, yf, zavg_plot)
xlabel("ST")
ylabel("GS")
zlabel("yaw")
xlim([0, ST_max])
ylim([0, GS_max])
zlim([0, 2])

%% Loss of traction region
function z = notr_func(x, y, xfy, zfx, maxsty, p4, ST_max)
    if y <= p4(2)
        z = p4(3);
    else
        z = interp1([xfy(y), ST_max], [zfx(xfy(y)), maxsty(y)], x, "linear", "extrap");
    end
end

notr = @(x,y) (notr_func(x, y, xfy, zfx, maxsty, p4, ST_max));
znotr = arrayfun(notr, xf, yf);

figure(8)
hold on
surf(xf, yf, znotr)
hold on
plot3(xcurve, ycurve, zcurve, LineWidth=3, Color="red")
xlabel("ST")
ylabel("GS")
zlabel("yaw")
xlim([0, ST_max])
ylim([0, GS_max])
zlim([0, 2])

%% Combine
figure(9)
hold off
surf(xf, yf, zavg_plot, FaceAlpha=.5)
hold on
surf(xf, yf, znotr, FaceAlpha=.5)
figure(10)
z_all = zeros([size(xf), 3]);
z_all(:,:,1) = zavg_plot;
z_all(:,:,2) = NaN;
z_all(:,:,3) = znotr;
zplot_half = min(z_all, [], 3);
hold off
surf(xf, yf, zplot_half)
hold on
plot3(xcurve, ycurve, zcurve, LineWidth=3, Color="red")

figure(11)
x_both = [-flip(xf,2), xf(:,2:end)];
y_both = [flip(yf,2), yf(:,2:end)];
zplot_full = [-flip(zplot_half, 2), zplot_half(:,2:end)];
surf(x_both, y_both, zplot_full)

%% Output
ST_brkpt_split = xf(1,:);
GS_brkpt_split = yf(:,1);
save("TV_26_split_table", "ST_brkpt_split", "GS_brkpt", "zplot_half")