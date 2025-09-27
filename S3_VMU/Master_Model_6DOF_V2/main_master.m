%% Setup
addpath(genpath(pwd))
data_table = table();
data_table.model = ["Master"];

%% Get Model
varCAR = class2struct(vehicle_parameters);

%% Initial Conditions - SPLIT THIS UP LATER
s0 = [0; 0; 0; 0; 0; varCAR.z0(1) + varCAR.L0(1) - varCAR.LN - 0.01; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];

%% Boundary Conditions
tau = [5.5; 5.5; 5.5; 5.5] .* 0;
CCSA = 10 * 0;

%% Configure Solver
M = eye(26,26);
M(19,19) = 0;
M(20,20) = 0;
M(21,21) = 0;
M(22,22) = 0;
M(23,23) = 0; % FL
M(24,24) = 0; % FR
M(25,25) = 0; % RL
M(26,26) = 0; % RR

optsODE = odeset('Mass',M,'RelTol',1e-6, 'AbsTol', 1e-6);

%% Simulate
t0 = tic;
[t,s] = ode15s(@vehicle_ds, [0 30], s0, optsODE, tau, CCSA, varCAR);
tau = (tau.*ones(4,length(t)))';
CCSA = (CCSA.*ones(1,length(tau)))';
t1 = toc(t0);

%% Pack output
v_master = vehicle_output(t, s, tau, CCSA, varCAR);

%% plot data
vehicle_plot(v_master, data_table.model(1), varCAR);