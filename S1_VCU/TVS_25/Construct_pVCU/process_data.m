%% Path
addpath 'Process_Functions'

%% Compute IMU calibration
% call function that does this, located in Process Functions
R = ac_compute_R();

% save data in Processed Data
save("Processed_Data/R", "R");

%% Compute AMK max torque lookup table
% call function that does this, located in Process Functions
[speedT_brk, voltageT_brk, maxT_tbl] = compute_AMK_func("Source_Data\A2370DD_T120C.mat");

% save data in Processed Data
save('Processed_Data/torque_table.mat', 'speedT_brk', 'voltageT_brk', 'maxT_tbl')

%% Compute Yaw Table
% empty until steady state 6DOF model is ready

% call function that does this, located in Process Functions

% save data in Processed Data

%% Compute Batttery SOC lookup table
% call function that does this, located in Process Functions
[Voc, AsDischarged] = compute_SOC_tbl();

% save data in Processed Data
save('Processed_Data/battery_SOC_Tbl.mat', 'Voc', 'AsDischarged')