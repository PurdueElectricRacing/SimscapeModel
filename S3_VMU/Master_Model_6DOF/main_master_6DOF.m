%% Setup
addpath(genpath(pwd))

data_table = table();
data_table.model = ["Master"];

%% Get Model
varCAR = varModel_master_6DOF;

%% Initial Conditions
s0 = [0; 0; 0; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0];

%% Boundary Conditions
tau = [25; 25; 25; 25];
CCSA = 0;

%% Configure Solver
varCAR.optsODE = odeset('MaxStep', 0.5, 'AbsTol', 1e-2, 'RelTol', 1e-2);

%% Simulate
t0 = tic;
[t,s] = ode23tb(@compute_ds_master_6DOF, [0 100], s0, varCAR.optsODE, tau, CCSA, varCAR);
tau = (tau.*ones(4,length(t)))';
CCSA = (CCSA.*ones(1,length(tau)))';
t1 = toc(t0);

%% Pack output
v_master = compute_v_master_6DOF(t, s, tau, CCSA, varCAR);

%% plot data
plot_master_6DOF(v_master, data_table.model(1), varCAR);