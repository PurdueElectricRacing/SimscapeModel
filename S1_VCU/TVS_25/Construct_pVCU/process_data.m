addpath 'Process Functions'\
%% Compute IMU calibration
% call function that does this, located in Process Functions

% save data in Processed Data

%% Compute AMK max torque lookup table
% call function that does this, located in Process Functions
[speed_bp,voltage_bp,torque_bp,minT_tbl,maxT_tbl, speedT_tbl, voltageT_tbl] = compute_AMK_func("Source Data\A2370DD_T120C.mat");
% save data in Processed Data
save("Processed Data\AMK_lookup",'speed_bp','voltage_bp','torque_bp','minT_tbl','maxT_tbl', 'speedT_tbl', 'voltageT_tbl');
%% Compute Yaw Table
% empty until steady state 6DOF model is ready

% call function that does this, located in Process Functions

% save data in Processed Data