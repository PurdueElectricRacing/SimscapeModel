%% Get Model
varCAR = vehicle_parameters;

%% Initial Conditions
s0 = [0; 0; 0; 0; 0; varCAR.z0(1) + varCAR.L0(1) - varCAR.LN - 0.01; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0];

%% Configure Solver
M = eye(22,22);
M(13,13) = 0;
M(14,14) = 0;
M(15,15) = 0;
M(16,16) = 0;

optsODE = odeset('Mass',M, 'RelTol',1e-6, 'AbsTol', 1e-6, 'Events',@accel_complete);

%% Construct Straightline Acceleration Sweep with Equal Torque
% Vectors to sweep through
tau_min = 9;
tau_max = 60;
dtau = 3;

CCSA_vec = -120:5:120;
tau_vec = tau_min:dtau:tau_max;

[CCSA_grid, tau_grid] = meshgrid(CCSA_vec, tau_vec);

CCSA_ALL = CCSA_grid(:);
tau_ALL = tau_grid(:);
V_ALL = zeros(length(CCSA_ALL),1);
yaw_ALL = zeros(length(CCSA_ALL),1);

t0 = tic;
for i = 1:length(CCSA_ALL)
    tau_i = 0.25.*tau_ALL(i).*ones(4,1);
    CCSA_i = CCSA_ALL(i);
    [t,s] = ode15s(@vehicle_ds, [0 30], s0, optsODE, tau_i, CCSA_i, varCAR);
    V_ALL(i) = sqrt(s(end,1)^2 + s(end,3)^2);
    yaw_ALL(i) = s(end,11);
end
t1 = toc(t0);

% save results
save('Vehicle_Sweeps/skidpad.mat', 'tau_ALL', 'CCSA_ALL', 'V_ALL', 'yaw_ALL');

% Plot Results
figure;
scatter3(tau_ALL, CCSA_ALL, V_ALL)

xlabel("Total Torque (Nm)")
ylabel("Center Column Steering Angle (deg)")
zlabel("Velocity Magnitude (m/s)")

figure;
scatter3(tau_ALL, CCSA_ALL, yaw_ALL)

xlabel("Total Torque (Nm)")
ylabel("Center Column Steering Angle (deg)")
zlabel("Yaw Rate (rad/s)")

figure;
scatter3(V_ALL, CCSA_ALL, yaw_ALL)

xlabel("Velocity Magnitude (m/s)")
ylabel("Center Column Steering Angle (deg)")
zlabel("Yaw Rate (rad/s)")