%% Cursed Global Variable
global S
S = [0; 0; 0; 0];

%% Get Model
varCAR = varModel_master_6DOF;

%% Initial Conditions
s0 = [0.001; 0; 0; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; 0; 0; 0; 0; 0; 0; varCAR.v0; varCAR.v0; 0; 0; 0; 0; 0];

%% Boundary Conditions
tau = [0; 0; 25; 25];

%% Configure Solver
optionsODE = odeset('MaxStep', 0.005, 'AbsTol', 100, 'RelTol', 100);

%% Simulate
[t,s] = ode23tb(@compute_ds_master, [0 10], s0, optionsODE, tau, varCAR);

%% Pack output
v_master = compute_v_master_6DOF(t, s, varCAR);