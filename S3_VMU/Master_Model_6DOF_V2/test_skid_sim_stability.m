%% Setup
addpath(genpath(pwd))
data_table = table();
data_table.model = ["Master"];

%% Get Model
varCAR = class2struct(vehicle_parameters);

%% Initial Conditions - SPLIT THIS UP LATER
s0 = load("s0.mat").s1(1:22)';

%% Boundary Conditions
tau = [5.5; 5.5; 5.5; 5.5] .* 1;
CCSA = 10 * 1;
P = 0;

%% Configure Solver
M = eye(22,22);
M(19,19) = 0;
M(20,20) = 0;
M(21,21) = 0;
M(22,22) = 0;

%% Simulate
abs_tol_brk = -8:1:-2;
rel_tol_brk = -8:1:-2;
[abs_tol_grid, rel_tol_grid] = meshgrid(abs_tol_brk, rel_tol_brk);
abs_tol_brk_ALL = abs_tol_grid(:);
rel_tol_brk_ALL = rel_tol_grid(:);

abs_tol = 10.^(abs_tol_brk);
rel_tol = 10.^(rel_tol_brk);
[abs_tol_grid, rel_tol_grid] = meshgrid(abs_tol, rel_tol);
abs_tol_ALL = abs_tol_grid(:);
rel_tol_ALL = rel_tol_grid(:);

errors = cell(length(abs_tol)*length(rel_tol), 1);
times = zeros(length(abs_tol)*length(rel_tol), 1);

% reset warnings
lastwarn("");

t0 = tic;
for i = 1:length(abs_tol_ALL)
    optsODE = odeset('Mass',M, 'AbsTol', abs_tol_ALL(i), 'RelTol', rel_tol_ALL(i));
    [t,s] = ode15s(@vehicle_ds, [0 30], s0, optsODE, tau, CCSA, P, varCAR);
    times(i) = t(end);

    if lastwarn == ""
        errors{i} = 0;
    else
        errors{i} = lastwarn;
    end

    lastwarn("");
    disp(i)
end
t1 = toc(t0);

%% Plot
scatter3(abs_tol_brk_ALL, rel_tol_brk_ALL, times)
xlabel("Absolute Tolerance")
ylabel("Relative Tolerance")
zlabel("Crash Time (s)")