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

% simulation time
simtime = 0:.01:30;

%% Setup parametric sweep
% paramaters to sweep
tau_sum = linspace(0,40,10); % sum of all motor requested torques
split_FR = linspace(.2, .5, 10); % fraction of total torque to front motors
split_LR = linspace(.5, .8, 10); % fraction of total torque to left motors
CCSA = linspace(0, 50, 10); % steering wheel angle (positive to right)

% generate all combinations of intputs
input_combinations = table2array(combinations(tau_sum, split_FR, split_LR, CCSA));
num_runs = size(input_combinations,1);

% preallocate output
result_array = repmat(analyze_sim(), num_runs, 1);

%% Run parametric sweep
% setup progress monitoring
parforProgress(0, num_runs); % reset counter to 0
D = parallel.pool.DataQueue; % setup data
afterEach(D, @parforProgress); % after each client finishes, call parforProgress

tic
parfor i = 1:num_runs
    % get inputs
    inputs = input_combinations(i,:);
    tau_sum_run = inputs(1);
    split_FR_run = inputs(2);
    split_LR_run = inputs(3);
    CCSA_run = inputs(4);
    P_run = [0; 0; 0; 0];

    % convert torque split to 4 motor torques
    tau_run = split2tau(tau_sum_run, split_FR_run, split_LR_run);
    
    % run sim
    [t,s] = ode15s(@vehicle_ds, simtime, s0, optsODE, tau_run, CCSA_run, P_run, varCAR);
    % if length(t) ~= length(simtime)
    %     fprintf("error in iteration %d\n", i)
    % end
    % process results
    result_array(i) = analyze_sim(t, s, [10 30]);
    %send(D,[]);
end

%% Functions
tf = @split2tau;
function tau = split2tau(tau_sum, split_FR, split_LR)
    tau = zeros(4,1);
    tau(1) = tau_sum * split_FR * split_LR; % FL
    tau(2) = tau_sum * split_FR * (1-split_LR); % FR
    tau(3) = tau_sum * (1-split_FR) * split_LR; % RL
    tau(4) = tau_sum * (1-split_FR) * (1-split_LR); % RR
end
