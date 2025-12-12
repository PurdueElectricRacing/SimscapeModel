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

%% setup parametric sweep

% parameters to sweep
tau_total = linspace(0, 9.8*2, 20); % total torque
split_LR = linspace(0.5, 1, 20); % left-right split, 0 is no left, 1 is 100% left
steer = linspace(0, 100, 20);

% generate all combinations of inputs
input_array = table2array(combinations(tau_total, split_LR, steer));
num_runs = length(input_array);

% split array of combinations into array for each input, speeds up parfor
tau_total_array = input_array(:, 1);
split_LR_array = input_array(:, 2);
CCSA_array = input_array(:, 3); 

% calculate torque array
tau_FL_array = zeros(size(tau_total_array));
tau_FR_array = zeros(size(tau_total_array));
tau_RL_array = tau_total_array .* split_LR_array;
tau_RR_array = tau_total_array .* (1 - split_LR_array);
tau_array = [tau_FL_array, tau_FR_array, tau_RL_array, tau_RR_array];

% setup timesteps to get results at
simtime = 0:0.01:30;

% preallocate result arrays
output_array = zeros(num_runs, length(simtime), length(s0));

%% run sweep
% progress monitoring
parforProgress(0, num_runs); % reset counter to 0
D = parallel.pool.DataQueue; % setup data
afterEach(D, @parforProgress); % after each client finishes, call parforProgress

% loop
tic
parfor i = 1:num_runs
    CCSA = CCSA_array(i);
    tau = tau_array(i,:)'
    P = 0;
    [t,s] = ode15s(@vehicle_ds, simtime, s0, optsODE, tau, CCSA, P, varCAR);
    output_array(i, :, :) = s;
    send(D,[]);
end
toc

%% process reults

% preallocate results array; must be array fo structs with same fields that
% analyze_sim returns
result_array = repmat(analyze_sim(), num_runs, 1);

% analyze each saved run
parforProgress(0, num_runs);
D = parallel.pool.DataQueue;
afterEach(D, @parforProgress);

parfor i = 1:num_runs
    stats = analyze_sim(simtime, squeeze(output_array(i, :, :)), [10 30]);
    result_array(i) = stats;
    send(D,[])
end

%% plotting
ind = input_array(:,1) == tau_total(11); %[result_array.r_avg] <= 20 & [result_array.r_avg] >= 18;
figure(1)
scatter3(input_array(ind,2), input_array(ind,3), [result_array(ind).V_avg])
% hold on
% scatter3(input_array(:,2), input_array(:,3), [result_array.V_std], 'r.')