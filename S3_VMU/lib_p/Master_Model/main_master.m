%% Get Model
varCAR = varModel_master;

%% Initial Conditions
x0 = [0.1; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; varCAR.v0; 0];

%% Boundary Conditions
tau = [0; 25];

%% Configure Solver
optionsODE = odeset('MaxStep',0.01);

%% Simulate
[t,x0] = ode23tb(@compute_ds_master, [0 7], x0, optionsODE, tau, varCAR);