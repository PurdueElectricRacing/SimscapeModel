%% Setup
addpath(genpath(pwd))

data_table = table();
data_table.model = ["Master"];

%% Get Model
varCAR = varModel_master_6DOF;

%% Initial Conditions
s0 = [0; 0; 0; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0];

%% Boundary Conditions
tau = [0; 0; 5; 5];
CCSA = 100;

%% Configure Solver
optionsODE = odeset('MaxStep', 0.5, 'AbsTol', 1e-6, 'RelTol', 1e-6);

%% Simulate
t0 = tic;
[t,s] = ode23tb(@compute_ds_master_6DOF, [0 0.5], s0, optionsODE, tau, CCSA, varCAR);
tau = (tau.*ones(4,length(t)))';
CCSA = (CCSA.*ones(1,length(tau)))';
t1 = toc(t0);

%% Pack output
v_master = compute_v_master_6DOF(t, s, tau, CCSA, varCAR);

%% plot data
plot_master_6DOF(v_master, data_table.model(1), varCAR);