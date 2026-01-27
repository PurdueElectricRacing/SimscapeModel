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

%% Run cost function over 