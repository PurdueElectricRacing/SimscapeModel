%% Setup
addpath(genpath(pwd))

data_table = table();
data_table.model = ["Master"];

%% Cursed Global Variable
global S
S = [0; 0];

%% Get Model
varCAR = varModel_master_3DOF;

%% Initial Conditions
s0 = [0.001; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; varCAR.v0; 0; 0];

%% Boundary Conditions
tau = [0; 25];

%% Configure Solver
optionsODE = odeset('MaxStep', 1, 'AbsTol', 1e-6, 'RelTol', 1e-6);

%% Simulate
t0 = tic;
[t,s] = ode23tb(@compute_ds_master_3DOF, [0 5], s0, optionsODE, tau, varCAR);
tau = (tau.*ones(2,length(t)))';
t1 = toc(t0);

%% Pack output
v_master = compute_v_master_3DOF(t, s, tau, varCAR);

%% plot data
plot_master_3DOF(v_master, data_table.model(1), varCAR);