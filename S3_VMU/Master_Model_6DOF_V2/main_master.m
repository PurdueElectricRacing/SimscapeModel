%% Setup
addpath(genpath(pwd))
data_table = table();
data_table.model = ["Master"];

%% Get Model
varCAR = class2struct(vehicle_parameters);

%% Initial Conditions - SPLIT THIS UP LATER
s0 = load("s0.mat").s1(1:26);
% s0 = [0; 0; 0; 0; 0; varCAR.z0(1) + varCAR.L0(1) - varCAR.LN - 0.01; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

%% Boundary Conditions
tau = [1; 1; 1; 1] .* 21;
CCSA = 0;
P = 0;

%% Configure Solver
M = eye(26,26);
M(23,23) = 0;
M(24,24) = 0;
M(25,25) = 0;
M(26,26) = 0;

optsODE = odeset('Mass',M, 'AbsTol', 1e-3, 'RelTol', 1e-3);

%% Simulate
t0 = tic;
[t,s] = ode15s(@vehicle_ds, [0 6], s0, optsODE, tau, CCSA, P, varCAR);
tau = (tau.*ones(4,length(t)))';
CCSA = (CCSA.*ones(1,length(t)))';
P = (P.*ones(1,length(t)))';
t1 = toc(t0);

%% Pack output
v_master = vehicle_output(t, s, tau, CCSA, P, varCAR);

%% plot data
vehicle_plot(v_master, data_table.model(1), varCAR);