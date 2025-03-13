%% Import data
file_name = "TVS_5_10_24_N3";
folder_name = "Testing_Data/";
X = table2array(readtable(file_name + ".xlsx", "Sheet", "Data"));

%% Get raw data
t = X(:,1);
wLR = X(:,5:6);
gs = X(:,9);

figure(1)
plot(t_FIT, wLR(:,1))
hold on
plot(t_FIT, wLR(:,2))

xlabel("Time (s)")
ylabel("Tire angular velocity (rad/s)")
legend("Left", "Right")

figure(2)
plot(t_FIT, gs)

xlabel("Time (s)")
ylabel("Chassis ground speed (m/s)")

%% Get filtered model
N = 1;
dN = 10000;
n = 21;
dt = 0.015;
t_FIT = linspace(0,(n-1)*dt,n)';
A = [t_FIT.^2 t_FIT ones(n,1)];

gs_LP = ones(dN,1);
gs_LS = ones(dN,1);
ga_LP = ones(dN,1);
ga_LS = ones(dN,1);

opts = optimoptions('linprog','Algorithm','dual-simplex','display','none');

for i = N:N+dN
    bLi = gs(i:i+n-1,1);
    xLP = lad_regression(A, bLi, opts);
    xLS = polyfit(t_FIT, bLi, 2);

    % figure(2)
    % plot(t, bLi)
    % hold on
    % plot(t, polyval(xLP,t))
    % hold on
    % plot(t, polyval(xLS,t))
    % 
    % xlabel("Time (S)")
    % ylabel("Chassis ground speed (m/s)")
    % legend("Data","LP", "LS")

    % evaluate curve fit
    gs_LP(i-N+1,1) = polyval(xLP, t_FIT(ceil(n/2)));
    gs_LS(i-N+1,1) = polyval(xLS, t_FIT(ceil(n/2)));

    ga_LP(i-N+1,1) = polyval(polyder(xLP), ceil(n*dt/2));

    disp(i)
end

%% Visualize Smoothening
figure(3)
plot(t(N:N+dN), gs(N+ceil(n/2):N+dN+ceil(n/2)))
hold on
plot(t(N:N+dN), gs_LP)
hold on
plot(t(N:N+dN), gs_LS)

xlabel("Time (S)")
ylabel("Chassis ground speed (m/s)")
legend("Data","LP", "LS")

figure(4)
plot(t(N:N+dN), ga_LP)

xlabel("Time (S)")
ylabel("Chassis Acceleration (m/s^2)")

%% Function Bank
function x = lad_regression(A, b, opts)
    % Number of variables (columns in A)
    n = size(A, 2);
    m = size(A, 1);
    
    % Decision variables: x (n variables) + r (m residuals)
    f = [zeros(n,1); ones(m,1)]; % Minimize sum of residuals

    % Constraints
    I = eye(m); % Identity matrix for residuals
    A_eq = [A, -I; -A, -I]; % Enforce Ax - b <= r and -Ax + b <= r
    b_eq = [b; -b];

    % Bounds: residuals must be non-negative
    lb = [-inf(n,1); zeros(m,1)];
    ub = [];

    % Solve LP
    x_r = linprog(f, A_eq, b_eq, [], [], lb, ub, opts);
    
    % Extract solution for x
    x = x_r(1:n);
end