%% Get Model
varCAR = varModel;

%% Initial Conditions
x0 = [0.1; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0];

%% Boundary Conditions
tau = [0; 5];

%% Configure Solver
optionsODE = odeset('MaxStep',0.5);

%% Simulate
[t,x0] = ode23tb(@compute_ds, [0 1.4], x0, optionsODE, tau, varCAR);


plot(t, x0(:,1))