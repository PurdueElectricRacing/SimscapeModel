% Fx=f(κ,Fz)=Fz⋅D⋅sin(C⋅arctan{Bκ−E[Bκ−arctan(Bκ)]}).

%% View Function
p.B = 10;
p.C = 1.9;
p.D = 1;
p.E = 0.97;

SL = 0:0.01:1;
Fz = 100:100:1500;
nFz = length(Fz);
nSL = length(SL);
[sl_grid, Fz_grid] = meshgrid(SL, Fz);

Fx = Fz_grid.*p.D.*sin(p.C.*atan(p.B.*sl_grid - p.E.*(p.B.*sl_grid - atan(p.B.*sl_grid))));

% figure(1)
% for i = 1:nFz
%     plot(sl_grid(i,:),Fx(i,:))
%     hold on
% end
% hold off

%% Find slip ratio at max traction
fun = @(x)compute_Fx1(x,p);
sl_fx_max = fmincon(fun, 0.15);
fx_max = -compute_Fx1(sl_fx_max, p);

%% Make bijective force function
SL = 0:0.01:sl_fx_max;
Fz = 100:100:1500;
nFz = length(Fz);
nSL = length(SL);
[sl_grid, Fz_grid] = meshgrid(SL, Fz);

Fx = Fz_grid.*p.D.*sin(p.C.*atan(p.B.*sl_grid - p.E.*(p.B.*sl_grid - atan(p.B.*sl_grid))));

% figure(2)
% for i = 1:nFz
%     plot(sl_grid(i,:),Fx(i,:))
%     hold on
% end
% hold off
% 
% figure(3)
% scatter3(Fx, Fz_grid, sl_grid)

%% Find optimal bijective function
p.B = 10;
p.C = 1.9;
p.D = 1;
p.E = 0.97;
p.x_max_total = sl_fx_max;
e_ref = 0.0005;

SL_all = [];
Fz_all = [];
Fx_all = [];

for i = 1:nFz
    p.Fz = Fz(i);
    opts = optimoptions('fsolve','Display','none');
    fun = @(e)compute_x_max_all(e,p);
    e_opt = fsolve(fun, e_ref, opts);
    
    % e_sweep = 0.0005:0.0005:0.005;
    % ne = length(e_sweep);
    % e_max_sweep = zeros(1, ne);
    % 
    % for i = 1:ne
    %     e_max_sweep(1,i) = compute_x_max_all(e_sweep(1,i), p);
    %     disp(i)
    % end
    % 
    % scatter(e_sweep, e_max_sweep)
    
    x_max = compute_x_max_all2(e_opt, p);
    z_max = -p.Fz.*compute_Fx1(x_max, p);
    nx = length(x_max);

    SL_all = [SL_all x_max];
    Fx_all = [Fx_all z_max];
    Fz_all = [Fz_all Fz(i)*ones(1,nx)];
end


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
    x_max = 0;
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
    x_max = [0];

    while x_max < p.x_max_total
        p.x_min = x_max(end);
        fun1 = @(x)compute_x_max(x,p);
        opts = optimoptions('fsolve','Display','none');
        x_max = [x_max fsolve(fun1, x_max(end)+0.01,opts)];
    end
end