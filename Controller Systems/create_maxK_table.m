function [v_sweep,w_sweep,maxK_table] = create_maxK_table(minK_table)

<<<<<<< HEAD
%% Import Data
[FW_Zones, event_data] = maxK_table_import_data("C:\Users\TAK\Documents\GitHub\SimscapeModel\Controller Systems\Vehicle Testing Source Data\2023-12-2-corrected-100-throttle_REFORMATTED.csv", ...
    8.75, 0.2286, 340, 90, ...
    [7500,16000], ...
    [9000, 23000], ...
    1.5, [10,10]);
=======
for i = 1:numData
    disp('=======================================')
    disp(i)
    % import data

    % Split apart Zones
    [FW_Zones, event_data] = maxK_table_import_data("Vehicle Testing Source Data\thtl_limit_accel_4-21-23_REFORMATTED.csv", ...
        8.75, 0.2286, 340, 90, ...
        [4305 9891 13074 15517 17925 21331 25824 36229 39309 42648], ... % Start
        [5371 11060 13781 16033 18392 21821 26300 36700 39782 43122], ... % Stop
        1.5, [10 10 7.75 6.8 10 10 10 10 10 10]); % Rel Start T, Rel Stop T
    FW_Zone_W = FW_Zones(:,1);
    FW_Zone_K = FW_Zones(:,2);
    FW_Zone_I = FW_Zones(:,3);
    FW_Zone_V = FW_Zones(:,4);

    % Split apart eventa data
    event_ta = event_data(:,1);
    event_wa = event_data(:,2);
    event_sa = event_data(:,3);
    event_ka = event_data(:,4);
    event_ia = event_data(:,5);
    event_va = event_data(:,6);


    % Visualize Raw Data & Extracted Data
    figure(2*i-1)
    scatter3(event_wa, event_ka, event_ia)
    hold on
    scatter3(FW_Zone_W, FW_Zone_K, 2.*FW_Zone_I)
    
    xlabel("FW Tire Omega (rad/s)")
    ylabel("FW Throttle (%)")
    zlabel("FW Current (A)")
    legend("Acceleration","Max Current")
    
    %% Fit FW Data
    % Fit KV curve
    [xData, yData] = prepareCurveData( FW_Zone_K, FW_Zone_V );
    ft = fittype( 'poly1' );
    [VfuncK, ~] = fit( xData, yData, ft );
    
    % Fit KV surface
    [xData, yData, zData] = prepareSurfaceData( FW_Zone_K, FW_Zone_V, FW_Zone_W );
    ft = fittype( 'a1*K^2+a2*K+a3+b1*V^2+b2*V+b3', 'independent', {'K', 'V'}, 'dependent', 'W' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.StartPoint = [0.0971317812358475 0.823457828327293 0.694828622975817 0.317099480060861 0.950222048838355 0.0344460805029088];
    [WfuncKV, ~] = fit( [xData, yData], zData, ft, opts );
    
    % Plot example curve
    FW_K_smooth = linspace(min(FW_Zone_K),max(FW_Zone_K),100);
    FW_V_smooth = feval(VfuncK, FW_K_smooth);
    FW_K_smooth = FW_K_smooth';
    FW_W_smooth = feval(WfuncKV, FW_K_smooth, FW_V_smooth);
    
    % Visualize FW data
    figure(2*i)
    scatter3(FW_Zone_K, FW_Zone_V, FW_Zone_W)
    hold on
    plot3(FW_K_smooth, FW_V_smooth, FW_W_smooth, Marker='none')
    grid on
    % fit curve data
end
disp(1)
%% Import Data
[FW_Zones, event_data] = maxK_table_import_data("Vehicle Testing Source Data\thtl_limit_accel_4-21-23_REFORMATTED.csv", 8.75, 0.2286, 340, 90, [4305 9891 13074 15517 17925 21331 25824 36229 39309 42648], [5371 11060 13781 16033 18392 21821 26300 36700 39782 43122], 1.5, [10 10 7.75 6.8 10 10 10 10 10 10]);
>>>>>>> 784d48afe6a199e4d4b36115da7fa3061a3a517f

% Split apart Zones
FW_Zone_W = FW_Zones(:,1);
FW_Zone_K = FW_Zones(:,2);
FW_Zone_I = FW_Zones(:,3);
FW_Zone_V = FW_Zones(:,4);

% Split apart eventa data
event_ta = event_data(:,1);
event_wa = event_data(:,2);
event_sa = event_data(:,3);
event_ka = event_data(:,4);
event_ia = event_data(:,5);
event_va = event_data(:,6);

% Visualize Raw Data & Extracted Data
figure(1)
scatter3(event_wa, event_ka, event_ia)
hold on
scatter3(FW_Zone_W, FW_Zone_K, 2.*FW_Zone_I)

xlabel("FW Tire Omega (rad/s)")
ylabel("FW Throttle (%)")
zlabel("FW Current (A)")
legend("Acceleration","Max Current")

%% Fit FW Data
% Fit KV curve
[xData, yData] = prepareCurveData( FW_Zone_K, FW_Zone_V );
ft = fittype( 'poly1' );
[VfuncK, ~] = fit( xData, yData, ft );

% Fit KV surface
[xData, yData, zData] = prepareSurfaceData( FW_Zone_K, FW_Zone_V, FW_Zone_W );
ft = fittype( 'a1*K^2+a2*K+a3+b1*V^2+b2*V+b3', 'independent', {'K', 'V'}, 'dependent', 'W' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.0971317812358475 0.823457828327293 0.694828622975817 0.317099480060861 0.950222048838355 0.0344460805029088];
[WfuncKV, ~] = fit( [xData, yData], zData, ft, opts );

% Plot example curve
FW_K_smooth = linspace(min(FW_Zone_K),max(FW_Zone_K),100);
FW_V_smooth = feval(VfuncK, FW_K_smooth);
FW_K_smooth = FW_K_smooth';
FW_W_smooth = feval(WfuncKV, FW_K_smooth, FW_V_smooth);

% Visualize FW data
figure(2)
scatter3(FW_Zone_K, FW_Zone_V, FW_Zone_W)
hold on
plot3(FW_K_smooth, FW_V_smooth, FW_W_smooth, Marker='none')
grid on

xlabel("Motor Command K (unitless)")
ylabel("Applied DC Voltage V (V)")
zlabel("Motor Shaft Angular Velcoity W $\frac{rad}{s}$","Interpreter","latex")
legend("Raw","Smoothened")

%% Parameters
voltages = 340:-10:60; % the 28 voltages that plettenberg tested at
voltages(ismember(voltages,[200])) = []; % remove missing datasets
num_datasets = 28; % number of sweeps for motor data from plettenberg
RPM_resolution = 107; % Number of angular velocity breakpoints in lookup tables
V_resolution = 26; % Number of voltage breakpoints in lookup tables
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
    motor_data(:, :, i) = table2array(readtable("Plettenberg Source Data\all_motor_data.xlsx", opts, "UseExcel", false));

    all_current = [all_current; motor_data(:, 2, i)];
    all_rpm = [all_rpm; motor_data(:, 3, i)];

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
    motor_constants(:,i) = table2array(readtable("Plettenberg Source Data\all_motor_data.xlsx", opts, "UseExcel", false));
end

motor_constants(1,:) = motor_constants(1,:)*rpm2radps;

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
RPM_FW_Model = polyfit(voltages, RPM_Field_Weakening, 1);

%% Generate Table of dK data
w_sweep = linspace(0, max(motor_constants(1,:)), RPM_resolution);  % motor shaft speed (rad/s)
v_sweep = linspace(min(voltages), max(voltages), V_resolution); % motor voltage (V)

[v_grid,w_grid] = meshgrid(v_sweep,w_sweep);

dK_ref = FW_K_smooth - interp2(v_grid,w_grid,minK_table,FW_V_smooth,FW_W_smooth);

w_table_max = [zeros(1,num_datasets); RPM_Field_Weakening];
v_table_max = repmat(voltages,2,1);
dk_table_max = [zeros(1,num_datasets); ones(1,num_datasets)*max(dK_ref)];

% do a jank scaling instead
K_scale = repmat(dK_ref,1,10);
V_scale = repmat(FW_V_smooth,1,10) .* [1.2 1.1 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2];
W_scale = repmat(FW_W_smooth,1,10);
W_scale = W_scale .*polyval(RPM_FW_Model,V_scale(end,:)) ./ W_scale(end,:);

w_table_max = [w_table_max(:); FW_W_smooth; W_scale(:)];
v_table_max = [v_table_max(:); FW_V_smooth; V_scale(:)];
dk_table_max = [dk_table_max(:); dK_ref; K_scale(:)];

[xData, yData, zData] = prepareSurfaceData( v_table_max, w_table_max, dk_table_max );
ft = fittype( 'loess' );
[dk_fit, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

maxK_table = max(min(feval(dk_fit,v_grid,w_grid) + minK_table,1),0);

% view lookup table
figure(3)
scatter3(v_grid,w_grid,maxK_table)

xlabel("Voltage (V)")
ylabel("Motor Shaft Angular Velocity $\frac{rad}{s}$","Interpreter","latex")
zlabel("Motor Command (unitless)")

end