%% Find slip ratio at peak traction
p.B = 10;
p.C = 1.9;
p.D = 1;
p.E = 0.97 - 0.2;

SL = 0:0.01:1;
Fz = 100:25:5500;
nFz = length(Fz);
[sl_grid, Fz_grid] = meshgrid(SL, Fz);

Fx = Fz_grid.*p.D.*sin(p.C.*atan(p.B.*sl_grid - p.E.*(p.B.*sl_grid - atan(p.B.*sl_grid))));

figure(1)
for i = 1:nFz
    plot(sl_grid(i,:),Fx(i,:))
    hold on
end
hold off

fun = @(x)compute_Fx1(x,p);
sl_fx_max = fmincon(fun, 0.15);
sl_fx_max_rounded = floor(sl_fx_max*100)/100;
fx_max = -compute_Fx1(sl_fx_max, p);

%% Make bijective force function
SL = 0:0.01:sl_fx_max;
Fz = 100:25:5500;
nFz = length(Fz);
nSL = length(SL);
[sl_grid, Fz_grid] = meshgrid(SL, Fz);

Fx = Fz_grid.*p.D.*sin(p.C.*atan(p.B.*sl_grid - p.E.*(p.B.*sl_grid - atan(p.B.*sl_grid))));

figure(2)
for i = 1:nFz
    plot(sl_grid(i,:),Fx(i,:))
    hold on
end
hold off

figure(3)
scatter3(Fx, Fz_grid, sl_grid)

%% Find optimal bijective function for slip
p.x_min_total = 0;
p.x_max_total = sl_fx_max;
p.Fz = 800;
e_ref = 0.0005;

opts = optimoptions('fsolve','Display','none');
fun = @(e)compute_x_max_all(e,p);
e_opt = fsolve(fun, e_ref, opts);

x_max = compute_x_max_all2(e_opt, p);
[sl_grid, Fz_grid] = meshgrid(x_max, Fz);
Fx = Fz_grid.*p.D.*sin(p.C.*atan(p.B.*sl_grid - p.E.*(p.B.*sl_grid - atan(p.B.*sl_grid))));
S_tbl = scatteredInterpolant(Fx(:), Fz_grid(:), sl_grid(:));

figure(4)
scatter3(Fx, Fz_grid, sl_grid)

%% Find optimal function for force
p.x_min_total = sl_fx_max;
p.x_max_total = 1;
p.Fz = 800;
e_ref = 0.0001;

opts = optimoptions('fsolve','Display','none');
fun = @(e)compute_x_max_all(e,p);
e_opt = fsolve(fun, e_ref, opts);

p.x_min_total = 0;
x_max = compute_x_max_all2(e_opt, p);
[sl_grid, Fz_grid] = meshgrid(x_max, Fz);
Fx = Fz_grid.*p.D.*sin(p.C.*atan(p.B.*sl_grid - p.E.*(p.B.*sl_grid - atan(p.B.*sl_grid))));
F_tbl = griddedInterpolant(sl_grid', Fz_grid', Fx');

figure(5)
scatter3(sl_grid, Fz_grid, Fx)

%% Save results
clearvars -except S_tbl F_tbl sl_fx_max_rounded
save('SL_table', 'S_tbl', 'F_tbl', 'sl_fx_max_rounded')

%% Function Definitions
function J = compute_Fx1(x, p)
    J = -p.D.*sin(p.C.*atan(p.B.*x - p.E.*(p.B.*x - atan(p.B.*x))));
end

function e_pid = compute_Fx2(x, p)
    Fx_ref = p.Fz*p.D.*sin(p.C.*atan(p.B.*x - p.E.*(p.B.*x - atan(p.B.*x))));
    Fx_pid = p.m*x + p.b;

    e_pid = -abs(Fx_ref - Fx_pid);
end

function de_pid = compute_x_max(x_max, p)
    x = [p.x_min; x_max];
    z = p.Fz.*p.D.*sin(p.C.*atan(p.B.*x - p.E.*(p.B.*x - atan(p.B.*x))));
    p.m = (z(1) - z(2)) / (p.x_min - x_max);
    p.b = z(2) - (p.m*x_max);

    fun2 = @(y)compute_Fx2(y,p);
    opts = optimoptions('fmincon','Algorithm','sqp','Display','none');
    x_e_max = fmincon(fun2, mean(x), [], [], [], [], x(1), x(2),[],opts);
    z_e_max = -p.Fz*compute_Fx1(x_e_max, p);
    z_e_pid = p.m*x_e_max + p.b;
    e = abs(z_e_max - z_e_pid) / z_e_max;

    de_pid = e - p.e_pid;
end

function x_max_all = compute_x_max_all(e_pid, p)
    x_max = p.x_min_total;
    p.e_pid = e_pid;

    while x_max < p.x_max_total
        p.x_min = x_max;
        fun1 = @(x)compute_x_max(x,p);
        opts = optimoptions('fsolve','Display','none');
        x_max = fsolve(fun1, x_max+0.01,opts);
    end
    x_max_all = x_max - p.x_max_total;
    disp(x_max)
end

function x_max = compute_x_max_all2(e_pid, p)
    p.e_pid = e_pid;
    x_max = p.x_min_total;

    while x_max < p.x_max_total
        p.x_min = x_max(end);
        fun1 = @(x)compute_x_max(x,p);
        opts = optimoptions('fsolve','Display','none');
        x_max = [x_max fsolve(fun1, x_max(end)+0.01,opts)];
    end
end