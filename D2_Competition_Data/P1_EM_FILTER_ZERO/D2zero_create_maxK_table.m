function [v_sweep,w_sweep,maxK_table,voltages,RPM_Field_Weakening,v_grid,w_grid] = D2zero_create_maxK_table(v_sweep,w_sweep)
%% Parameters
voltages = 340:-10:60; % the 28 voltages that plettenberg tested at
voltages(ismember(voltages,[200])) = []; % remove missing datasets
num_datasets = 28; % number of sweeps for motor data from plettenberg
MOTOR_CURRENT_MAX = 70; % maximum current set by motor controller [A]
rpm2radps = 0.104719755;

%% Initialize Variables
% raw data
all_current = []; % all raw current measurements (A)
all_rpm = [];     % all raw motor shaft angular velocity meansurements (RPM)
counter = zeros(1, num_datasets);

% Polynomial Models of curvy motor data
RPM_Field_Weakening = zeros(1, num_datasets);

%% Import Sweep Data
opts = spreadsheetImportOptions("NumVariables", 7);
motor_data = zeros(69, 7, num_datasets);
opts.DataRange = "A2:G70";
opts.VariableNames = ["VoltageV", "CurrentA", "SpeedRPM", "InputPowerW", "OutputPowerW", "TorqueNcm", "Efficiency"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double"];

for i = 1:1:num_datasets
    opts.Sheet = num2str(voltages(i)) + "V";
    motor_data(:, :, i) = table2array(readtable("D2zero_data/D2zero_all_motor_data.xlsx", opts, "UseExcel", false));

    all_current = [all_current; motor_data(:, 2, i)];
    all_rpm = [all_rpm; motor_data(:, 3, i)];

    counter(i) = length(all_rpm);
end

%% Prepare Data for Fitting
all_rpm = all_rpm .* rpm2radps; % motor shaft angular velocity (rad/s)

%% Compute Start of Field Weakening Zone for each input voltage
for i = 1:1:num_datasets
    if i == 1
        start_idx = 1;
    else
        start_idx = counter(i-1)+1;
    end

    % fit plet data, use scaling option by having mu output
    [P,~,mu] = polyfit(all_rpm(start_idx:counter(i)), all_current(start_idx:counter(i)),4);

    syms RPM_FW

    % account for scaling
    x = (RPM_FW - mu(1))/mu(2);

    % find speed that maximum current is hit for this particular voltage
    sol = solve(MOTOR_CURRENT_MAX == P(1)*x^4 + P(2)*x^3 + P(3)*x^2 + P(4)*x + P(5));

    % choose the right solution
    if double(sol(1)) > 50
        RPM_Field_Weakening(i) = double(sol(1));
    else
        RPM_Field_Weakening(i) = double(sol(2));
    end
end

% create field weakening model
% RPM_FW_Model = polyfit(voltages, RPM_Field_Weakening, 1);
% RPM_Field_Weakening = polyval(RPM_FW_Model,voltages);

%% Generate Table of maxK
VM = (ones(num_datasets,1)*voltages);
WM = (ones(num_datasets,1)*RPM_Field_Weakening(1,:));

w_table = (WM./RPM_Field_Weakening(1,:)'<=1).*WM;
v_table = VM'.*(WM./RPM_Field_Weakening(1,:)'<=1);
k_table = (VM./voltages'<=1).*VM./voltages';

w_table = w_table(:);
v_table = v_table(:);
k_table = k_table(:);

w_table(w_table==0) = [];
v_table(v_table==0) = [];
k_table(k_table==0) = [];

w_table_max = [w_table; zeros(num_datasets,1)];
v_table_max = [v_table; voltages'];
k_table_max = [k_table; 0.1*ones(num_datasets,1)];

[v_grid,w_grid] = meshgrid(v_sweep,w_sweep);

% create interpolated dataset
[xData, yData, zData] = prepareSurfaceData( v_table_max, w_table_max, k_table_max );
ft = 'cubicinterp';
[fitresult, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

% create final lookup table
maxK_table = feval(fitresult,v_grid,w_grid);
maxK_table(isnan(maxK_table)) = 1;

% figure;
% scatter3(v_table,w_table,k_table)
% hold on
% scatter3(v_grid,w_grid,minK_table)
% 
% figure;
% scatter3(v_table,w_table,k_table)
% hold on
% scatter3(FW_Zone_V,FW_Zone_W-40,FW_Zone_K)
% 
% figure;
% scatter3(v_grid,w_grid,maxK_table)
% hold on
% scatter3(v_table,w_table,k_table)
%
% figure;
% scatter3(v_grid,w_grid,maxK_table)
% hold on
% scatter3(v_grid,w_grid,minK_table)
%
% figure;
% scatter3(v_grid,w_grid,maxK_table-minK_table)
%
% figure;
% scatter3(voltages,RPM_Field_Weakening,1)
% hold on
% scatter3(max(voltages),RPM_Field_Weakening,throttles)
% hold on
% scatter3(FW_V_smooth,FW_W_smooth,FW_K_smooth)
% hold on
% scatter3(FW_Zone_V,FW_Zone_W,FW_Zone_K)

% figure;
% plot(voltages,RPM_Field_Weakening)
% xlabel("DC Voltage Input")
% ylabel("Max Current Motor Shaft Speed (rad/s)")
% 
% figure;
% scatter3(v_table,w_table,k_table)
% xlabel("DC Voltage Input")
% ylabel("Max Current Motor Shaft Speed (rad/s)")
% zlabel("Motor Command (ratio)")

end