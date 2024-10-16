%% Get Model
varCAR = varModel_master;

%% Initial Conditions
s = [0.0001; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; varCAR.v0; 0];

%% Boundary Conditions
tau = [0; 25];

%% Configure Solver
optionsODE = odeset('MaxStep',0.001);

%% Simulate
[t,s] = ode23tb(@compute_ds_no_slip, [0 10], s, optionsODE, tau, varCAR);
tau = (tau.*ones(2,length(t)))';

%% Pack output
v_no_slip = compute_v_no_slip(t, s, tau, varCAR);