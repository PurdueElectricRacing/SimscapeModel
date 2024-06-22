%% Import data
load A2370DD_T80C.mat

%% Define Matrices
% get raw data
[m,n] = size(Speed);
speed_matrix = Speed.*(pi/30); % speed breakpoints (rad/s)
current_matrix = repmat(0:5.25:105,[m,1]); % current matrix (A)
torque_matrix = Shaft_Torque; % Output motor torque (Nm)
voltageDC_matrix = Voltage_Phase_RMS.*sqrt(2); % DC voltage

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
nt = 100;
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

%% calculate max and min motor torque
[minT_tbl, maxT_tbl] = compute_barrierT_tbl(speed_matrix,torque_matrix,voltageDC_matrix,current_matrix,voltageT_tbl,speed_bp,nv,ns);

%% calculate battery current draw
motorI_tbl = compute_motorI_tbl(speed_matrix,torque_matrix,current_matrix,speedI_tbl,torqueI_tbl);

%% Save and Clear
clearvars -except speedT_tbl voltageT_tbl minT_tbl maxT_tbl speedI_tbl torqueI_tbl motorI_tbl
save("AMK_lookup")

%% visualize 
% flatten tables
speedT_tbl_flat = speedT_tbl(:);
voltageT_tbl_flat = voltageT_tbl(:);
minT_tbl_flat = minT_tbl(:);
maxT_tbl_flat = maxT_tbl(:);
speedI_tbl_flat = speedI_tbl(:);
torqueI_tbl_flat = torqueI_tbl(:);
motorI_tbl_flat = motorI_tbl(:);

% max and min torque tables
figure(1);
scatter3(speedT_tbl_flat,voltageT_tbl_flat,minT_tbl_flat)
hold on;
scatter3(speedT_tbl_flat,voltageT_tbl_flat,maxT_tbl_flat)

xlabel("Motor Speed (rad/s)")
ylabel("Supply Voltage (V)")
zlabel("Torque (Nm)")
legend("Min", "Max")

% motor DC current table
figure(2);
scatter3(speedI_tbl_flat,torqueI_tbl_flat,motorI_tbl_flat)

xlabel("Motor Speed (rad/s)")
ylabel("Torque (Nm)")
zlabel("Motor Current (A)")