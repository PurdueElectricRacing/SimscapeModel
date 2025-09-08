%% Setup
addpath(genpath(pwd))
data_table = table();
data_table.model = ["Master"];

%% Get Model
varCAR = vehicle_parameters;

%% Initial Conditions
s0 = [0; 0; 0; 0; 0; varCAR.z0(1) + varCAR.L0(1) - varCAR.LN - 0.01; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0];

%% Boundary Conditions
tau = [15.5; 15.5; 5.5; 5.5];
CCSA = 0;

%% Configure Solver
M = eye(22,22);
M(13,13) = 0;
M(14,14) = 0;
M(15,15) = 0;
M(16,16) = 0;

optsODE = odeset('Mass',M,'RelTol',1e-6, 'AbsTol', 1e-6);

%% Simulate
t0 = tic;
[t,s] = ode15s(@vehicle_ds, [0 400], s0, optsODE, tau, CCSA, varCAR);
tau = (tau.*ones(4,length(t)))';
CCSA = (CCSA.*ones(1,length(tau)))';
t1 = toc(t0);

%% Pack output
v_master = vehicle_output(t, s, tau, CCSA, varCAR);

%% plot data
vehicle_plot(v_master, data_table.model(1), varCAR);