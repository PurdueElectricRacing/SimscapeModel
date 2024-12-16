%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PER 2024
% Program Description 
% This program calculates damper lookup table
%
% Input Arguments
% None
%
% Output Arguments
% None
%
% Definitions
%
% Lookup tables
% Damper Lookup: Damper Force = f(shock velocity)
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Startup
clearvars

%% Import Damper Data
% import damper dyno data
opts = spreadsheetImportOptions("NumVariables", 4);
opts.Sheet = "0-4.3 0-4.3";
opts.DataRange = "A1:D26";
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4"];
opts.VariableTypes = ["double", "double", "double", "double"];
DamperDataSample = readtable("Damper_Data_Sample.xlsx", opts, "UseExcel", false);
DamperDataSample = table2array(DamperDataSample);

%% Generate Damping Table
% extract damper velocity measurements (m/s)
sus_damper_vel = [-flipud(DamperDataSample(:,1)); DamperDataSample(2:end,3)]./1000;

% extract damper force, positive for compression (N)
sus_damper_for = [-flipud(DamperDataSample(:,2)); DamperDataSample(2:end,4)];

% calculate damping coefficient (Ns/m)
sus_damper_con = ((sus_damper_for ./ abs(sus_damper_vel)))';

% replace NaN damping coefficient with interpolated value
c_bkpt = fillmissing(sus_damper_con,'pchip');

% set velocity breakpoints for damping coefficient
dz_bkpt = sus_damper_vel';

% create lookup table function
c_tbl = griddedInterpolant(dz_bkpt, c_bkpt);

%% View Result
figure(1)
scatter(dz_bkpt, c_bkpt)
hold on
plot(dz_bkpt, c_tbl(dz_bkpt))

xlabel("Velocity (m/s)")
ylabel("Damping Coefficient (kg*s/m")
legend("Data", "Fit Interp")

%% Cleanup & Saving
save("c_tbl.mat","c_tbl");
clearvars