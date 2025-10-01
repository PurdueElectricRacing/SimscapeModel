%% Setup
addpath(genpath(pwd))
data_table = table();
data_table.model = ["Master"];

%% Get Model
varCAR = class2struct(vehicle_parameters);

%% Initial Conditions - SPLIT THIS UP LATER
s0 = load("s0.mat").s0';
% s0 = [0; 0; 0; varCAR.z0(1) + varCAR.L0(1) - varCAR.LN - 0.01; 0; 0; varCAR.v0; 0; 0; 0; 0; 0; 0; 0];

%% Boundary Conditions
tau = [1; 1] .* 18;
P = 0;

%% Configure Solver
M = eye(14,14);
M(13,13) = 0;
M(14,14) = 0;

optsODE = odeset('Mass',M, 'AbsTol', 1e-6, 'RelTol', 1e-6);

%% Simulate
t0 = tic;
[t,s] = ode15s(@vehicle_ds, [0 30], s0, optsODE, tau, P, varCAR);
tau = ([tau(1); tau(1); tau(2); tau(2)].*ones(4,length(t)))';
P = (P.*ones(1,length(t)))';
t1 = toc(t0);

%% Pack output
v_master = vehicle_output(t, s, tau, P, varCAR);

%% plot data
vehicle_plot(v_master, data_table.model(1), varCAR);