%% Get Model
varCAR = varModel;

%% Initial Conditions
x0 = [0; 0; 0; varCAR.z0; 0; varCAR.O0; 0; 0];

%% Boundary Conditions
tau = [10; 10];

%% Configure Solver
optionsODE = odeset('MaxStep',0.5);

%% Simulate
[~,x0] = ode23(@compute_ds, [0 1], x0, optionsODE, tau, varCAR);