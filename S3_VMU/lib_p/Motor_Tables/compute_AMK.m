%% Import data
load A2370DD_T80C.mat

%% Define Matrices
% get raw data
[m,n] = size(Speed);
speed_matrix = Speed.*(pi/30); % speed breakpoints (rad/s)
current_matrix = repmat(0:5.25:105,[m,1]); % current matrix (A)
torque_matrix = Shaft_Torque; % Output motor torque (Nm)
voltageDC_matrix = Voltage_Phase_RMS.*sqrt(2); % DC voltage (V)
loss_matrix = Total_Loss; % power wasted (W)

minT_matrix = -torque_matrix(:,2:end) + 2*torque_matrix(:,1);
torque_matrix_all = [torque_matrix  minT_matrix];
speed_matrix_all = [speed_matrix speed_matrix(:,2:end)];
power_matrix_all = [loss_matrix loss_matrix(:,2:end)];

% speed breakpoint definition
min_speed = 0;
max_speed = speed_matrix(end,1);
ns = 150;
speed_bp = linspace(min_speed,max_speed,ns)';

% voltage breakpoint definition
min_voltage = 298;
max_voltage = 598;
nv = 50;
voltage_bp = linspace(min_voltage,max_voltage,nv)';

% torque breakpoint definition
min_torque = -23;
max_torque = 23;
nt = 101;
torque_bp = linspace(min_torque,max_torque,nt)';

% Table 1: speed-voltage-torque
[speedT_tbl, voltageT_tbl] = meshgrid(speed_bp, voltage_bp);

% Table 2: speed-torque-current
[speedI_tbl, torqueI_tbl] = meshgrid(speed_bp, torque_bp);

%% Step 0: remove 0 speed torque because it is obviously wrong
speed_matrix = speed_matrix(2:end,:);
current_matrix = current_matrix(2:end,:);
torque_matrix = torque_matrix(2:end,:);
voltageDC_matrix = voltageDC_matrix(2:end,:);
loss_matrix = loss_matrix(2:end,:);

%% calculate max and min motor torque
[minT_tbl, maxT_tbl] = compute_barrierT_tbl(speed_matrix,torque_matrix,voltageDC_matrix,current_matrix,voltageT_tbl,speed_bp,nv,ns);

%% calculate inverter current draw
[inverterP_tbl,speed_matrix_bijectiveT,torque_matrix_bijectiveT,power_matrix_bijectiveT]  = compute_inverterP_tbl(speed_matrix,torque_matrix,loss_matrix,speedI_tbl,torqueI_tbl);

%% save lookup tables
save("AMK_lookup",'speed_bp','voltage_bp','torque_bp','inverterP_tbl','minT_tbl','maxT_tbl')

%% visualize 
% flatten tables
speedT_tbl_flat = speedT_tbl(:);
voltageT_tbl_flat = voltageT_tbl(:);
minT_tbl_flat = minT_tbl(:);
maxT_tbl_flat = maxT_tbl(:);
speedI_tbl_flat = speedI_tbl(:);
torqueI_tbl_flat = torqueI_tbl(:);
inverterI_tbl_flat = inverterP_tbl(:);

% get positive power-rpm-torque table
f = (torqueI_tbl_flat >= 0);
speedI_tbl_T = speedI_tbl_flat(f);
torqueI_tbl_T = torqueI_tbl_flat(f);
inverterI_tbl_T = inverterI_tbl_flat(f);

% max and min torque tables
figure(1);
scatter3(speedT_tbl_flat,voltageT_tbl_flat,minT_tbl_flat)
hold on;
scatter3(speedT_tbl_flat,voltageT_tbl_flat,maxT_tbl_flat)

xlabel("Motor Speed (rad/s)")
ylabel("Supply Voltage (V)")
zlabel("Torque (Nm)")
legend("Min", "Max")

% inverter DC current table
figure(2);
scatter3(speedI_tbl_flat,torqueI_tbl_flat,inverterI_tbl_flat./1000)

xlabel("Motor Speed (rad/s)")
ylabel("Torque (Nm)")
zlabel("Inverter Power (kW)")

% motor output torque
figure(3);
scatter3(inverterI_tbl_T./1000, speedI_tbl_T, torqueI_tbl_T)

xlabel("Inverter Current (kW)")
ylabel("Motor Speed (rad/s)")
zlabel("Torque (Nm)")

% create lookup table functions
motorPtable = griddedInterpolant(speedI_tbl', torqueI_tbl', inverterP_tbl');
save('motorPowerTable.mat', 'motorPtable')
motorTtable = scatteredInterpolant(speedI_tbl_T(:), inverterI_tbl_T(:), torqueI_tbl_T(:));
save('motorTorqueTable.mat', 'motorTtable')
motorMaxTtable = griddedInterpolant(speedT_tbl', voltageT_tbl', maxT_tbl');
save('motorMaxTtable.mat', 'motorMaxTtable')