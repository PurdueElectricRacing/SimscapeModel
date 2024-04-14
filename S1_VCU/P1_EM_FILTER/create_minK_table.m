%% Function Description
%
% Definitions
% v_sweep    - voltage breakpoints for minK_table
% w_sweep    - motor shaft angular velocity breakpoints for minK_table
% minK_table - lookup table to compute maximum K that yields 0 torque
% 
% Last Updated: 02/29/2024

function [v_sweep,w_sweep,minK_table] = create_minK_table()
%% Parameters
voltages = 340:-10:60; % the 28 voltages that plettenberg tested at
voltages(ismember(voltages,[200])) = []; % remove missing datasets
num_datasets = 28; % number of sweeps for motor data from plettenberg
RPM_resolution = 107; % Number of angular velocity breakpoints in lookup tables
V_resolution = 26; % Number of voltage breakpoints in lookup tables
rpm2radps = 0.104719755;

%% Import Motor Constants
opts = spreadsheetImportOptions("NumVariables", 1);
motor_constants = zeros(5, num_datasets);
opts.DataRange = "K4:K8";
opts.VariableNames = ["Constants"];
opts.VariableTypes = ["double"];

for i = 1:1:num_datasets
    opts.Sheet = num2str(voltages(i)) + "V";
    motor_constants(:,i) = table2array(readtable("data/all_motor_data.xlsx", opts, "UseExcel", false));
end

motor_constants(1,:) = motor_constants(1,:)*rpm2radps;
max_rpm = motor_constants(1,:);

%% Generate Table of min k
% create input data (rotation speed, voltage)
w_sweep = linspace(0, max(motor_constants(1,:)), RPM_resolution);  % motor shaft speed (rad/s)
v_sweep = linspace(min(voltages), max(voltages), V_resolution); % motor voltage (V)
[v_grid,w_grid] = meshgrid(v_sweep,w_sweep);

VM = (ones(num_datasets,1)*voltages);
WM = (ones(num_datasets,1)*motor_constants(1,:));

w_table = (WM./motor_constants(1,:)'<=1).*WM;
v_table = VM'.*(WM./motor_constants(1,:)'<=1);
k_table = (VM./voltages'<=1).*VM./voltages';

w_table = w_table(:);
v_table = v_table(:);
k_table = k_table(:);

w_table(w_table==0) = [];
v_table(v_table==0) = [];
k_table(k_table==0) = [];

w_table_min = [w_table; zeros(num_datasets,1)];
v_table_min = [v_table; voltages'];
k_table_min = [k_table; zeros(num_datasets,1)];

% create interpolated dataset
[xData, yData, zData] = prepareSurfaceData( v_table_min, w_table_min, k_table_min );
ft = 'cubicinterp';
[fitresult, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

% create final lookup table
minK_table = feval(fitresult,v_grid,w_grid);
minK_table(isnan(minK_table)) = 1;

%% Table Viewing
% figure;
% scatter3(v_table_min, w_table_min, k_table_min);
% hold on;
% scatter3(v_grid,w_grid,minK_table)

% figure;
% plot(voltages,motor_constants(1,:))
% xlabel("DC Voltage Input")
% ylabel("No Load Motor Shaft Speed (rad/s)")
% 
% figure;
% scatter3(v_table,w_table,k_table)
% xlabel("DC Voltage Input")
% ylabel("No Load Motor Shaft Speed (rad/s)")
% zlabel("Motor Command (ratio)")

end