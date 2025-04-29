%% Setup
addpath(genpath(pwd))

%% Get Model
varCAR = varModel_master_3DOF;

%% Initial Conditions
s0 = [0; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; varCAR.v0; 0; 0];

%% Boundary Conditions
tau = [0; 25];

%% Configure Solver
optionsODE = odeset('MaxStep', 5, 'AbsTol', 1e-4, 'RelTol', 1e-4);

%% Simulate
t0 = tic;
[t,s] = ode23tb(@compute_ds_master_3DOF, [0 10], s0, optionsODE, tau, varCAR);
tau = (tau.*ones(2,length(t)))';
t1 = toc(t0);

%% Pack output
v_master = compute_v_master_3DOF(t, s, tau, varCAR);

%% plot data
plot_master_3DOF(v_master);