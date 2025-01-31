addpath 'Process Functions'\
%% Compute IMU calibration
% call function that does this, located in Process Functions
R = ac_compute_R();
% save data in Processed Data
save("Processed Data\R", "R");

%% Compute AMK max torque lookup table
% call function that does this, located in Process Functions
[torqInterpolant] = compute_AMK_func("Source Data\A2370DD_T120C.mat");
% save data in Processed Data
save('Processed Data\TorqueTable.mat', 'torqInterpolant')
%% Compute Yaw Table
% empty until steady state 6DOF model is ready

% call function that does this, located in Process Functions

% save data in Processed Data

%% Compute Batttery SOC lookup table
[Voc, AsDischarged] = compute_SOC_tbl();
save('Processed Data\battery_SOC_Tbl.mat', 'Voc', 'AsDischarged')