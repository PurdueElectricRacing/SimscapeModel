%% Get Model
varCAR = vehicle_parameters;

%% Initial Conditions - SPLIT THIS UP LATER
s0 = load("s0.mat").s0';
% s0 = [0; 0; 0; varCAR.z0(1) + varCAR.L0(1) - varCAR.LN - 0.01; 0; 0; varCAR.v0; 0; 0; 0; 0; 0;];

%% Configure Solver
M = eye(14,14);
M(13,13) = 0;
M(14,14) = 0;

optsODE = odeset('Mass',M,'RelTol',1e-9, 'AbsTol', 1e-9, 'Events',@accel_complete);

%% Construct Straightline Acceleration Sweep with Equal Torque
% Vectors to sweep through
P = 0;
tau_min = 15;
tau_max = 85;
dtau = 7;
tau_ALL = tau_min:dtau:tau_max;
r_ALL = 0:0.1:1;

% Set distance at which point the simulation ends
varCAR.sN = 75;

% Construct vectors to save
t_accel_ALL = zeros(length(tau_ALL)*length(r_ALL),1);
tau_accel_ALL = zeros(length(tau_ALL)*length(r_ALL),1);
r_accel_ALL = zeros(length(tau_ALL)*length(r_ALL),1);

% loop through all possible combinations
t0 = tic;
for i = 1:length(tau_ALL)
    for j = 1:length(r_ALL)
        tau_i = 0.5.*[tau_ALL(i)*r_ALL(j); tau_ALL(i)*(1-r_ALL(j));];
        [t,s] = ode15s(@vehicle_ds, [0 100], s0, optsODE, tau_i, P, varCAR);
        t_accel_ALL((i-1)*length(r_ALL) + j) = t(end);
        tau_accel_ALL((i-1)*length(r_ALL) + j) = 2*sum(tau_i);
        r_accel_ALL((i-1)*length(r_ALL) + j) = r_ALL(j);
    end
    disp(i)
end
t1 = toc(t0);

% save results
save('Vehicle_Sweeps/acceleration.mat', 'tau_accel_ALL', 'r_accel_ALL', 't_accel_ALL');

% Plot Results
figure;
scatter3(tau_accel_ALL, r_accel_ALL, t_accel_ALL)

xlabel("Total Torque (Nm)")
ylabel("Torque Ratio Front-Rear")
zlabel("Time taken to reach 75m (s)")