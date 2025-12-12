%% Run from Master_Model_6DOF_V2

%% setup ode solver
% Get Model
varCAR = class2struct(vehicle_parameters);

% Initial Conditions
s0 = load("s0.mat").s1(1:26);

% Setup mass matrix
M = eye(26,26);
M(23,23) = 0;
M(24,24) = 0;
M(25,25) = 0;
M(26,26) = 0;

% setup ode options
optsODE = odeset('Mass',M, 'AbsTol', 1e-3, 'RelTol', 1e-3);

%% optimization
% setup
lb = [0 0 0 0 0]; % lower bound on inputs
ub = [9.8 9.8 9.8 9.8 100]; % upper bound on inputs
J = @(x)(cost_2WD(x, s0, optsODE, varCAR)); % cost function
x0 = [5 5 5 5 25]; % initial guess

% run optimization
opts = optimoptions(@fmincon, 'Display', 'iter');
[x, fval] = fmincon(J, x0, [], [], [], [], lb, ub, [], opts);

% run sim of optimization results
