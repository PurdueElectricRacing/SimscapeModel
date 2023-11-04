%% Startup
% clear all
% clc

%% Parameters
voltages = [340 330 320 310 300 290 280 270 260 250 240 230 220 210 190 180 170 160 150 140 130 120 110 100 90 80 70 60]; % the 28 voltages that plettenberg tested at
Tx_resolution = 26; % Number of torque breakpoints in lookup tables
RPM_resolution = 107; % Number of angular velocity breakpoints in lookup tables
V_resolution = 26; % Number of voltage breakpoints in lookup tables
num_datasets = 28; % number of sweeps for motor data from plettenberg

ABS_MAX_TORQUE = 25; % maximum torque in dataset [Nm]
MOTOR_CURRENT_MAX = 70; % maximum torque set by motor controller [A]
MOTOR_VOLTAGE_MAX = max(voltages); % max voltage in dataset [V]

rpm2radps = 0.104719755;

%% Initialize Variables
% raw data
all_voltage = []; % all raw voltage measurements (V)
all_current = []; % all raw current measurements (A)
all_rpm = [];     % all raw motor shaft angular velocity meansurements (RPM)
all_torque = [];  % all raw motor shaft torque measuremnts (Ncm)
counter = zeros(1, num_datasets);

% table breakpoints
rpm_sweep = linspace(0, 1100, RPM_resolution);  % motor shaft speed (rad/s)
torque_sweep = linspace(0, ABS_MAX_TORQUE(1), Tx_resolution);  % motor shaft torque (Nm)  
voltage_sweep = linspace(0, MOTOR_VOLTAGE_MAX, V_resolution); % motor voltage (V)

% grid version of table breakpoints
[rpm_grid, torque_grid] = meshgrid(rpm_sweep, torque_sweep);
[~, voltage_grid] = meshgrid(rpm_sweep, voltage_sweep);

% Polynomial Models of curvy motor data
P = zeros(1, 5);
RPM_Field_Weakening = zeros(1, num_datasets);

%% Import Sweep Data
cd ..

opts = spreadsheetImportOptions("NumVariables", 7);
motor_data = zeros(69, 7, num_datasets);
opts.DataRange = "A2:G70";
opts.VariableNames = ["VoltageV", "CurrentA", "SpeedRPM", "InputPowerW", "OutputPowerW", "TorqueNcm", "Efficiency"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double"];

for i = 1:1:num_datasets
    opts.Sheet = num2str(voltages(i)) + "V";
    motor_data(:, :, i) = table2array(readtable("Real_Data\all_motor_data.xlsx", opts, "UseExcel", false));

    all_voltage = [all_voltage; motor_data(:, 1, i)];
    all_current = [all_current; motor_data(:, 2, i)];
    all_rpm = [all_rpm; motor_data(:, 3, i)];
    all_torque = [all_torque; motor_data(:, 6, i)];

    counter(i) = length(all_rpm);
end

%% Import Motor Constants
opts = spreadsheetImportOptions("NumVariables", 1);
motor_constants = zeros(5, num_datasets);
opts.DataRange = "K4:K8";
opts.VariableNames = ["Constants"];
opts.VariableTypes = ["double"];

for i = 1:1:num_datasets
    opts.Sheet = num2str(voltages(i)) + "V";
    motor_constants(:,i) = table2array(readtable("Real_Data\all_motor_data.xlsx", opts, "UseExcel", false));
end

%% Generate Table of k Data
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

scatter3(w_table,v_table,k_table)

%% Prepare Data for Fitting
all_rpm = all_rpm .* rpm2radps; % motor shaft angular velocity (rad/s)
all_torque = all_torque ./ 100; % motor shaft torque (Nm)
all_power_in = all_voltage .* all_current; % battery input power (W)
all_power_out = all_torque .* all_rpm; % motor output power (W)
all_efficiency = all_power_out ./ all_power_in; % motor/controller efficiency

all_no_load_RPM = motor_constants(1,:); % RPM when torque output reaches 0
all_specific_RPM = motor_constants(3,:); % no load RPM drop per volt
all_torque_constant = motor_constants(5,:); % torque generated per amp

%% Compute Start of Field Weakening Zone for each sweep
for i = 1:1:num_datasets
    if i == 1
        start_idx = 1;
    else
        start_idx = counter(i-1)+1;
    end

    P = polyfit(all_rpm(start_idx:counter(i)), all_current(start_idx:counter(i)),4);

    syms RPM_FW

    sol = solve(MOTOR_CURRENT_MAX == P(1)*RPM_FW^4 + P(2)*RPM_FW^3 + P(3)*RPM_FW^2 + P(4)*RPM_FW + P(5));

    if double(sol(1)) > 50
        RPM_Field_Weakening(i) = double(sol(1));
    else
        RPM_Field_Weakening(i) = double(sol(2));
    end
end

RPM_FW_Model = polyfit(voltages, RPM_Field_Weakening, 1);
RPM_FW_MAX_bkpt = polyval(RPM_FW_Model, voltage_sweep)';

%% Generate Table of Voltage Data
v_table_max = repmat(voltages,3,1);
k_table_max = [zeros(1,num_datasets); ones(2,num_datasets)];
w_table_max = [zeros(1,num_datasets); RPM_Field_Weakening./rpm2radps; motor_constants(1,:)];

scatter3(w_table_max,v_table_max,k_table_max)

%% Prepare Max Torque Lookup Table
max_torque_grid = griddata(all_rpm,all_voltage,all_torque,rpm_grid,voltage_grid);
[xData, yData, zData] = prepareSurfaceData(rpm_grid, voltage_grid, max_torque_grid);
ft = fittype('lowess');
opts = fitoptions('Method', 'LowessFit');
opts.Normalize = 'on';
opts.Span = 0.1;
[fitresult, gof] = fit([xData, yData], zData, ft, opts);

max_torque_grid = reshape(feval(fitresult,[rpm_grid(:),voltage_grid(:)]), [V_resolution, RPM_resolution]);
max_torque_grid = max(0, min(25, max_torque_grid));

%% Prepare Efficiency Lookup Table
efficiency_grid = griddata(all_rpm,all_torque,all_efficiency,rpm_grid,torque_grid);
[xData, yData, zData] = prepareSurfaceData(rpm_grid, torque_grid, efficiency_grid);
ft = fittype('loess');
opts = fitoptions('Method', 'LowessFit');
opts.Normalize = 'on';
opts.Span = 0.2;
[fitresult, gof] = fit([xData, yData], zData, ft, opts);

efficiency_grid = reshape(feval(fitresult,[rpm_grid(:),torque_grid(:)]), [Tx_resolution, RPM_resolution]);

%% Prepare Motor Command Lookup Table
CMD_grid = griddata(all_rpm,all_torque,all_voltage,rpm_grid,torque_grid);
[xData, yData, zData] = prepareSurfaceData( rpm_grid, torque_grid, CMD_grid );
ft = fittype('lowess');
[fitresult, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

CMD_grid = reshape(feval(fitresult,[rpm_grid(:),torque_grid(:)]), [V_resolution, RPM_resolution]);

%% Prepare Current Draw Lookup Table
I_grid = griddata(all_rpm,all_voltage,all_current,rpm_grid,voltage_grid);
[xData, yData, zData] = prepareSurfaceData( rpm_grid, voltage_grid, I_grid);
ft = fittype('lowess');
opts = fitoptions('Method', 'LowessFit');
opts.Normalize = 'on';
opts.Span = 0.15;
[fitresult, gof] = fit([xData, yData], zData, ft, opts);

I_grid = reshape(feval(fitresult,[rpm_grid(:),voltage_grid(:)]), [V_resolution RPM_resolution]);
k = voltage_grid ./ max(max(voltage_grid));
r = rpm_grid ./ RPM_FW_MAX_bkpt;
NO_FW_ZONE = (I_grid > MOTOR_CURRENT_MAX);
%I_grid_no_FW = (((-k.*0.*rpm_grid ./ RPM_FW_MAX_bkpt) + (MAX_MOTOR_CURRENT .* rpm_grid ./ RPM_FW_MAX_bkpt)) + (k.*0)) .* (I_grid > MAX_MOTOR_CURRENT);
%I_grid_no_FW = (MOTOR_CURRENT_MAX .* rpm_grid ./ RPM_FW_MAX_bkpt) .* (I_grid > MAX_MOTOR_CURRENT);
I_grid_no_FW = MOTOR_CURRENT_MAX .* NO_FW_ZONE;
I_grid_FW = max(0, ~NO_FW_ZONE .* I_grid);
I_grid_NO_RPM = (I_grid_no_FW + I_grid_FW);

I_grid_RPM = I_grid_NO_RPM .* NO_FW_ZONE .* r;
I_grid = I_grid_RPM + (I_grid_NO_RPM .* ~NO_FW_ZONE);

% I_grid_340V = I_grid .* voltage_grid./max(max(voltage_grid));
max_torque_grid_340V = max_torque_grid .* voltage_grid./max(max(voltage_grid));

%% Cleaning up & Saving
clearvars -except CMD_grid efficiency_grid max_torque_grid rpm_sweep torque_sweep voltage_sweep I_grid
save("PROCESSED_DATA\Motor_Tables.mat");

%% Data Viewing
% scatter3(all_rpm, all_torque, all_efficiency)
% scatter3(rpm_grid(:), torque_grid(:), efficiency_grid(:))
% scatter3(rpm_grid(:), voltage_grid(:), max_torque_grid_340V(:))
% scatter3(rpm_grid(:), torque_grid(:), CMD_grid(:))
% scatter3(rpm_grid(:), voltage_grid(:), I_grid(:))

% xlabel("Motor Shaft Angular Velocity (rad/s)")
% ylabel("Vmc * CMD (V)")
% zlabel("MC Current Draw (A)")

% xlabel("Motor Shaft Angular Velocity (rad/s)")
% ylabel("Vmc * CMD (V)")
% zlabel("Motor Shaft Torque (Nm)")