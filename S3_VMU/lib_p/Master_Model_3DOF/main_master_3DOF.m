%% Cursed Global Variable
global S
S = [0; 0];

%% Get Model
varCAR = varModel_master_3DOF;

%% Initial Conditions
s0 = [0.001; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; varCAR.v0; 0; 0; 0];

%% Boundary Conditions
tau = [0; 25];

%% Configure Solver
optionsODE = odeset('MaxStep', 0.0005, 'AbsTol', 100, 'RelTol', 100);

%% Simulate
[t,s] = ode23tb(@compute_ds_master_3DOF, [0 1000], s0, optionsODE, tau, varCAR);
tau = (tau.*ones(2,length(t)))';

%% Pack output
v_master = compute_v_master_3DOF(t, s, tau, varCAR);