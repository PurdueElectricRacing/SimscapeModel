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
[t,s] = ode23tb(@compute_ds_no_slip_3DOF, [0 10], s0, optionsODE, tau, varCAR);
tau = (tau.*ones(2,length(t)))';

%% Pack output
v_no_slip = compute_v_no_slip_3DOF(t, s, tau, varCAR);