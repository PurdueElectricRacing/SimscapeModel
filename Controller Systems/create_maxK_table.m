function [v_sweep,w_sweep,maxK_table] = create_maxK_table(minK_table)
%% Import Data
opts = delimitedTextImportOptions("NumVariables", 209);
opts.DataLines = [5, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["VarName1", "Main", "Main_1", "Main_2", "Main_3", "Main_4", "Main_5", "Main_6", "Main_7", "Main_8", "Main_9", "Main_10", "Main_11", "Main_12", "Main_13", "Main_14", "Main_15", "Main_16", "Main_17", "Main_18", "Main_19", "Main_20", "Main_21", "Main_22", "Main_23", "Main_24", "Main_25", "Main_26", "Main_27", "Main_28", "Main_29", "Main_30", "Main_31", "Main_32", "Main_33", "Main_34", "Main_35", "Main_36", "Main_37", "Main_38", "Main_39", "Main_40", "Main_41", "Main_42", "Main_43", "Main_44", "Main_45", "Main_46", "Main_47", "Main_48", "Main_49", "Main_50", "Main_51", "Main_52", "Main_53", "Main_54", "Main_55", "Main_56", "Main_57", "Main_58", "Main_59", "Main_60", "Main_61", "Main_62", "Main_63", "Main_64", "Main_65", "Main_66", "Main_67", "Main_68", "Main_69", "Main_70", "Main_71", "Main_72", "Main_73", "Main_74", "Main_75", "Main_76", "Main_77", "Main_78", "Main_79", "Main_80", "Main_81", "Main_82", "Main_83", "Main_84", "Main_85", "Main_86", "Main_87", "Main_88", "Main_89", "Main_90", "Main_91", "Main_92", "Main_93", "Main_94", "Main_95", "Main_96", "Main_97", "Main_98", "Main_99", "Main_100", "Main_101", "Main_102", "Main_103", "Main_104", "Main_105", "Main_106", "Main_107", "Main_108", "Main_109", "Main_110", "Main_111", "Main_112", "Main_113", "Main_114", "Main_115", "Main_116", "Main_117", "Main_118", "Main_119", "Main_120", "Main_121", "Main_122", "Main_123", "Main_124", "Main_125", "Main_126", "Main_127", "Main_128", "Main_129", "Main_130", "Main_131", "Main_132", "Main_133", "Main_134", "Main_135", "Main_136", "Main_137", "Main_138", "Main_139", "Main_140", "Main_141", "Main_142", "Main_143", "Main_144", "Main_145", "Main_146", "Main_147", "Main_148", "Main_149", "Main_150", "Main_151", "Main_152", "Main_153", "Main_154", "Main_155", "Main_156", "Main_157", "Main_158", "Main_159", "Main_160", "Main_161", "Main_162", "Main_163", "Main_164", "Main_165", "Main_166", "Main_167", "Main_168", "Main_169", "Main_170", "Main_171", "Main_172", "Main_173", "Main_174", "Main_175", "Main_176", "Main_177", "Main_178", "Main_179", "Main_180", "Main_181", "Main_182", "Main_183", "Main_184", "Main_185", "Main_186", "Main_187", "Main_188", "Main_189", "Main_190", "Main_191", "Main_192", "Main_193", "Main_194", "Main_195", "Main_196", "Main_197", "Main_198", "Main_199", "Main_200", "Main_201", "Main_202", "Main_203", "Main_204", "Main_205", "Main_206", "VarName209"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, "VarName209", "TrimNonNumeric", true);
opts = setvaropts(opts, "VarName209", "ThousandsSeparator", ",");
accel_data = readtable("Vehicle Testing Source Data\thtl_limit_accel_4-21-23.csv", opts);
accel_data = table2array(accel_data);

Wheel_Speed_Index_a = 32;      % corresponds to AF: left_speed_mc
Battery_IV_a = 77;             % corresponds to BY: pack_current
Velocity_Index_a = 102;        % Corresponds to CX: gps_vel_n
Throttle_Index_a = 147;        % corresponds to EQ: throttle

% Vehicle Parameters
PER23_gr = 8.75;             % rear driveline gear ratio  [none]
RE = 0.2286;                  % effective tire radius      [m]

%% Parameters to aid in data processing
Max_Voltage = 340; % [V]
Min_Voltage = 90; % [V]

START = [4305 9891 13074 15517 17925 21331 25824 36229 39309 42648]; % [index]
STOP = [5371 11060 13781 16033 18392 21821 26300 36700 39782 43122]; % [index]

Rel_Start_T = 1.5; % [s]
Rel_Stop_T = [10 10 7.75 6.8 10 10 10 10 10 10]; % [s]

Max_Tire_s = (18.5*PER23_gr)/(RE); % [rad/s] (motor shaft)
Min_Tire_s = (1.5*PER23_gr)/(RE); % [rad/s] (motor shaft)
max_ds = (0.5*PER23_gr)/(RE); % [m/s] (motor shaft)

%% Initialize Processed Data
% All accel data
all_ta = [];         % all timestamps recorded during accel       [s]
all_wa = [];         % all tire velocity during accel             [rad/s]
all_sa = [];         % all chassis NED velocity during accel      [rad/s]
all_ka = [];         % all throttles during accel                 [unitless]
all_ba = [];         % all battery current & voltage during accel [A V]

% All accel event data
event_ta = [];       % all time during accel                      [s]
event_wa = [];       % all tire velocity during accel             [m/s]
event_sa = [];       % all chassis speed during accel             [m/s]
event_ka = [];       % all throttles during accel                 [%]
event_ia = [];       % all battery current during accel           [A]
event_va = [];       % all battery voltages during accel          [V]

FW_Zone_W = [];      % all chassis speed for field weakening [rad/s]
FW_Zone_K = [];      % all throttle command setpoint for field weakening    [%]
FW_Zone_I = [];      % all motor current for field weakening                [A]
FW_Zone_V = [];      % all motor controller voltage for field weakening     [V]

%% Extract All Acceleration Data
all_ta = accel_data(:,1); % time
all_wa = accel_data(:,Wheel_Speed_Index_a:Wheel_Speed_Index_a+1).*((2*pi) ./ (60)); % wheel speeds
all_sa = accel_data(:,Velocity_Index_a:Velocity_Index_a+2).*(PER23_gr./RE); % GPS velocity
all_ka = accel_data(:,Throttle_Index_a) ./ 100; % throttle
all_ba = accel_data(:,Battery_IV_a:Battery_IV_a+1); % pack voltage and current

% filtering out bad voltage measurements
all_filtering = (all_ba(:,2) > Min_Voltage) & (all_ba(:,2) < Max_Voltage);

all_ta = all_ta(all_filtering);
all_wa = [all_wa(all_filtering,1) all_wa(all_filtering,2)];
all_sa = [all_sa(all_filtering,1) all_sa(all_filtering,2) all_sa(all_filtering,3)];
all_ka = all_ka(all_filtering);
all_ba = [all_ba(all_filtering,1) all_ba(all_filtering,2)];

%% Straight Acceleration Data Processing
for i = 1:length(START)
    % Select all data for 1 run
    t_selection = all_ta(START(i):STOP(i)) - all_ta(START(i));
    w_selection = all_wa(START(i):STOP(i),:);
    s_selection = sqrt(all_sa(START(i):STOP(i),1).^2 + all_sa(START(i):STOP(i),2).^2);
    k_selection = all_ka(START(i):STOP(i));
    i_selection = all_ba(START(i):STOP(i),1);
    v_selection = all_ba(START(i):STOP(i),2);

    % filtering
    dw = abs(w_selection(:,1) - w_selection(:,2));
    valid_data = (w_selection(:,1) < Max_Tire_s) & (w_selection(:,2) < Max_Tire_s) & (w_selection(:,1) > Min_Tire_s) & (w_selection(:,2) > Min_Tire_s) & (t_selection > Rel_Start_T) & (dw < max_ds) & (t_selection < Rel_Stop_T(i));
    t_selection = t_selection(valid_data);
    w_selection = mean([w_selection(valid_data,1) w_selection(valid_data,2)],2);
    s_selection = s_selection(valid_data);
    k_selection = k_selection(valid_data);
    i_selection = i_selection(valid_data);
    v_selection = v_selection(valid_data);

    % log event data
    event_ta = cat(1, event_ta, t_selection);
    event_wa = cat(1, event_wa, w_selection);
    event_sa = cat(1, event_sa, s_selection);
    event_ka = cat(1, event_ka, k_selection);
    event_ia = cat(1, event_ia, i_selection);
    event_va = cat(1, event_va, v_selection);

    % compute max current draw for each event
    [max_I, index_I] = max(i_selection);

    FW_Zone_W = cat(1, FW_Zone_W, w_selection(index_I));
    FW_Zone_K = cat(1, FW_Zone_K, max(k_selection));
    FW_Zone_I = cat(1, FW_Zone_I, max_I/2);
    FW_Zone_V = cat(1, FW_Zone_V, v_selection(index_I));
end

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