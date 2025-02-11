%% Cursed Global Variable
global S
S = [0; 0; 0; 0];

%% Get Model
varCAR = varModel_master_6DOF;

%% Initial Conditions
s0 = [0.001; 0; 0; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; 0; 0; 0; 0; 0; 0; varCAR.v0; varCAR.v0; 0; 0; 0; 0; 0];

%% Boundary Conditions
tau = [0; 0; 5; 5];
CCSA = 0;

%% Configure Solver
optionsODE = odeset('MaxStep', 0.005, 'AbsTol', 100, 'RelTol', 100);

%% Solve steady state
opts = optimoptions('fsolve', 'FiniteDifferenceType','central');
X = fsolve(@compute_res_master_6DOF, s0, opts, tau, CCSA, varCAR);

%% Simulate
[t,s] = ode23tb(@compute_ds_master_6DOF, [0 1], s0, optionsODE, tau, CCSA, varCAR);

%% Pack output
v_master = compute_v_master_6DOF(t, s, varCAR);