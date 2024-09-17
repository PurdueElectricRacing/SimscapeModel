%% Get Model
varCAR = varModel_master;

%% Initial Conditions
s = [0.1; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; varCAR.v0; 0];

%% Boundary Conditions
tau = [0; 25];

%% Configure Solver
optionsODE = odeset('MaxStep',0.01);

%% Simulate
[t,s] = ode23tb(@compute_ds_master, [0 6], s, optionsODE, tau, varCAR);

%% Pack output
v_master = compute_v_master(t, s, tau, varCAR);