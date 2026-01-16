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
lb = [0 0 0]; % lower bound on inputs
ub = [25 1 150]; % upper bound on inputs
J = @(x)(mod_cost_2WD(x, s0, optsODE, varCAR)); % cost function
x0 = [10 .5, 20]; % initial guess

% run optimization
opts = optimoptions(@fmincon, 'Display', 'iter');
[x, fval] = fmincon(J, x0, [], [], [], [], lb, ub, [], opts);


%% Functions
function cost = mod_cost_2WD(x, s0, optsODE, varCAR) % x = [tau_sum, split_LR, CCSA]
    tau = split2tau(x(1), 0, x(2));
    cost = cost_2WD([tau' x(3)], s0, optsODE, varCAR);
end


function tau = split2tau(tau_sum, split_FR, split_LR)
    tau = zeros(4,1);
    tau(1) = tau_sum * split_FR * split_LR; % FL
    tau(2) = tau_sum * split_FR * (1-split_LR); % FR
    tau(3) = tau_sum * (1-split_FR) * split_LR; % RL
    tau(4) = tau_sum * (1-split_FR) * (1-split_LR); % RR
end
