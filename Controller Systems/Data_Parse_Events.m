% To Do:
% 1. Shockpot stuff, when data exists for this
% 2. graphing: (4 categories: all, fw, no fw, steady), (sensor comparison), (3D graphs)
% 3. Better parameters for Battery_OCV
% 4. Update steps to use & modify this script
% 5. structs for all the different sets of data

%% Assumptions this script makes
% 1. The vehicle has 2 rear motors driven by equal torque mode

%% How to use this script on a new device
% Step 1: Modify line 24 & 44 to import the correct path

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
accel_data = readtable(".\thtl_limit_accel_4-21-23.csv", opts);
accel_data = table2array(accel_data);

% Data Locations for accel_data
% Wheel_Speed_Index_a = 52;      % corresponds to AZ: left_speed_mc
% Battery_IV_a = 113;            % corresponds to DI: pack_current
% Velocity_Index_a = 147;        % Corresponds to EQ: gps_vel_n
% LL_Index_a = 155;              % corresponds to EY: latitude
% Accelerometer_Index_a = 160;   % corresponds to FD: imu_accel_x
% Throttle_Index_a = 192;        % corresponds to GJ: throttle

Wheel_Speed_Index_a = 32;      % corresponds to AF: left_speed_mc
Battery_IV_a = 77;             % corresponds to BY: pack_current
Velocity_Index_a = 102;        % Corresponds to CX: gps_vel_n
LL_Index_a = 110;              % corresponds to DF: latitude
Accelerometer_Index_a = 115;   % corresponds to DK: imu_accel_x
Throttle_Index_a = 147;        % corresponds to EQ: throttle

opts = delimitedTextImportOptions("NumVariables", 212);
opts.DataLines = [5, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["VarName1", "Main", "Main_1", "Main_2", "Main_3", "Main_4", "Main_5", "Main_6", "Main_7", "Main_8", "Main_9", "Main_10", "Main_11", "Main_12", "Main_13", "Main_14", "Main_15", "Main_16", "Main_17", "Main_18", "Main_19", "Main_20", "Main_21", "Main_22", "Main_23", "Main_24", "Main_25", "Main_26", "Main_27", "Main_28", "Main_29", "Main_30", "Main_31", "Main_32", "Main_33", "Main_34", "Main_35", "Main_36", "Main_37", "Main_38", "Main_39", "Main_40", "Main_41", "Main_42", "Main_43", "Main_44", "Main_45", "Main_46", "Main_47", "Main_48", "Main_49", "Main_50", "Main_51", "Main_52", "Main_53", "Main_54", "Main_55", "Main_56", "Main_57", "Main_58", "Main_59", "Main_60", "Main_61", "Main_62", "Main_63", "Main_64", "Main_65", "Main_66", "Main_67", "Main_68", "Main_69", "Main_70", "Main_71", "Main_72", "Main_73", "Main_74", "Main_75", "Main_76", "Main_77", "Main_78", "Main_79", "Main_80", "Main_81", "Main_82", "Main_83", "Main_84", "Main_85", "Main_86", "Main_87", "Main_88", "Main_89", "Main_90", "Main_91", "Main_92", "Main_93", "Main_94", "Main_95", "Main_96", "Main_97", "Main_98", "Main_99", "Main_100", "Main_101", "Main_102", "Main_103", "Main_104", "Main_105", "Main_106", "Main_107", "Main_108", "Main_109", "Main_110", "Main_111", "Main_112", "Main_113", "Main_114", "Main_115", "Main_116", "Main_117", "Main_118", "Main_119", "Main_120", "Main_121", "Main_122", "Main_123", "Main_124", "Main_125", "Main_126", "Main_127", "Main_128", "Main_129", "Main_130", "Main_131", "Main_132", "Main_133", "Main_134", "Main_135", "Main_136", "Main_137", "Main_138", "Main_139", "Main_140", "Main_141", "Main_142", "Main_143", "Main_144", "Main_145", "Main_146", "Main_147", "Main_148", "Main_149", "Main_150", "Main_151", "Main_152", "Main_153", "Main_154", "Main_155", "Main_156", "Main_157", "Main_158", "Main_159", "Main_160", "Main_161", "Main_162", "Main_163", "Main_164", "Main_165", "Main_166", "Main_167", "Main_168", "Main_169", "Main_170", "Main_171", "Main_172", "Main_173", "Main_174", "Main_175", "Main_176", "Main_177", "Main_178", "Main_179", "Main_180", "Main_181", "Main_182", "Main_183", "Main_184", "Main_185", "Main_186", "Main_187", "Main_188", "Main_189", "Main_190", "Main_191", "Main_192", "Main_193", "Main_194", "Main_195", "Main_196", "Main_197", "Main_198", "Main_199", "Main_200", "Main_201", "Main_202", "Main_203", "Main_204", "Main_205", "Main_206", "Main_207", "Main_208", "Main_209", "VarName212"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, "VarName212", "TrimNonNumeric", true);
opts = setvaropts(opts, "VarName212", "ThousandsSeparator", ",");
endur_data = readtable(".\endurance_1_4_21_23.csv", opts);
endur_data = table2array(endur_data);

% Data Locations for endur_data
% Wheel_Speed_Index_e = 56;      % corresponds to BD: left_speed_mc
% Battery_IV_e = 117;            % corresponds to DI: pack_current
% Velocity_Index_e = 151;        % Corresponds to EU: gps_vel_n
% LL_Index_e = 159;              % corresponds to FC: latitude
% Accelerometer_Index_e = 164;   % corresponds to FH: imu_accel_x
% Throttle_Index_e = 196;        % corresponds to GN: throttle

Wheel_Speed_Index_e = 32;      % corresponds to AF: left_speed_mc
Battery_IV_e = 77;             % corresponds to BY: pack_current
Velocity_Index_e = 102;        % Corresponds to CX: gps_vel_n
LL_Index_e = 110;              % corresponds to DF: latitude
Accelerometer_Index_e = 115;   % corresponds to DK: imu_accel_x
Throttle_Index_e = 147;        % corresponds to EQ: throttle

% Vehicle Parameters
PER23_gr = 8.75;             % rear driveline gear ratio  [none]
RE = 0.222;                  % effective tire radius      [m]
m = 280;                     % system mass                [kg]
ts = 0.015;                  % sample rate                [s]
phi = 45;                    % orientation of navigation  [deg]

%% Parameters to aid in data processing
Max_Voltage = 340; % [V]
Min_Voltage = 90; % [V]

START = [4305 9891 13074 15517 17925 21331 25824 36229 39309 42648]; % [index]
STOP = [5371 11060 13781 16033 18392 21821 26300 36700 39782 43122]; % [index]

Start_T = [64.56 148.35 196.095 232.74 268.86 319.85 387.345 543.42 589.62 639.705]; % [s]
End_T = [66.78 151.035 199.665 238.935 280 330 400 560 610 650]; % [s]
Start_SS = [67.68 152.655 202.065 250 280 330 400 560 610 650]; % [s]

Rel_Start_T = 1.5; % [s]
Rel_Stop_T = [10 10 7.75 6.8 10 10 10 10 10 10]; % [s]

Max_Tire_s = 18.5; % [m/s]
Min_Tire_s = 1.5; % [m/s]
max_ds = 0.5; % [m/s]

STEADY_T = Start_SS - Start_T;
TRANSIENT_T = End_T - Start_T;

Battery_OCV = [285.1 284.9 283.8 282.9 282.7 282.3 282.3 281.9 280.5 279]; % [V]

START0 = 20000; % [index]
STOP0 = 21000; % [index]

%% Initialize Processed Data
% All accel data
all_ta = [];          % all timestamps recorded during accel       [s]
all_wa = [];          % all tire velocity during accel             [m/s]
all_sa = [];          % all chassis NED velocity during accel      [m/s]
all_ka = [];          % all throttles during accel                 [%]
all_pa = [];          % all position data during accel             [deg deg m]
all_aa = [];          % all accelerometer readings during accel    [m/s^2]
all_ba = [];          % all battery current & voltage during accel [A V]

% All endur data
all_te = [];          % all timestamps recorded during endur       [s]
all_we = [];          % all tire velocity during endur             [m/s]
all_se = [];          % all chassis NED velocity during endur      [m/s]
all_ke = [];          % all throttles during endur                 [%]
all_pe = [];          % all position data during endur             [deg deg m]
all_ae = [];          % all accelerometer readings during endur    [m/s^2]
all_be = [];          % all battery current & voltage during endur [A V]

% All accel event data
event_ta = [];        % all time during accel                      [s]
event_wa = [];        % all tire velocity during accel             [m/s]
event_sa = [];        % all chassis speed during accel             [m/s]
event_ka = [];        % all throttles during accel                 [%]
event_pa = [];        % all displacment during accel               [m]
event_aa = [];        % all chassis acceleration during accel      [m/s^2]
event_ia = [];        % all battery current during accel           [A]
event_va = [];        % all battery voltages during accel          [V]

% All endur event data
event_te = [];        % all time during endur                      [s]
event_we = [];        % all tire velocity during endur             [m/s]
event_se = [];        % all chassis speed during endur             [m/s]
event_ke = [];        % all throttles during endur                 [%]
event_pe = [];        % all displacment during endur               [m]
event_ae = [];        % all chassis acceleration during endur      [m/s^2]
event_ie = [];        % all battery current during endur           [A]
event_ve = [];        % all battery voltages during endur          [V]

% All transient accel data
transient_t = [];    % all timestamps st chassis is accelerating     [s]
transient_w = [];    % all tire velocity st chassis a > 0            [rad/s]
transient_s = [];    % all chassis speed st chassis is accelerating  [m/s]
transient_k = [];    % all throttles st chassis is accelerating      [%]
transient_p = [];    % all displacement st chassis is accelerating   [m]
transient_a = [];    % all acceleration st chassis is accelerating   [m/s^2]
transient_i = [];    % all battery current st chassis a > 0          [A]
transient_v = [];    % all battery voltage st chassis a > 0          [V]

% All steady state accel data
steady_t = [];       % all timestamps st chassis is not accelerating
steady_w = [];       % all tire velocity st chassis a ~ 0 
steady_s = [];       % all chassis speed st chassis a ~ 0
steady_k = [];       % all throttles st chassis  ~ 0
steady_p = [];       % all chassis displacement st chassis a ~ 0
steady_a = [];       % all chassis acceleration st chassis a ~ 0
steady_i = [];       % all battery current st chassis a ~ 0
steady_v = [];       % all battery voltage st chassis a ~ 0

% All fitted data
event_s_fit = [];    % all filtered chassis speed during event        [m/s]
event_a_fit = [];    % all filtered chassis acceleration during event [m/s^2]
event_e_fit = [];    % all filtered battery power output during event [W]

% Calculated Parameters
event_n = [];           % all vehicle efficiency estimates          [%]
event_r = [];           % all battery internal resistance estimates [ohm]

FW_Zone_W = [];      % all chassis speed for field weakening [rad/s]
FW_Zone_K = [];      % all throttle command setpoint for field weakening    [%]
FW_Zone_I = [];      % all motor current for field weakening                [A]
FW_Zone_V = [];      % all motor controller voltage for field weakening     [V]

%% Extract All Acceleration Data
% all recorded timestamps [s]
all_ta = accel_data(:,1);

% all recorded rear tire angular velocities [rad/s]
all_wa = ((accel_data(:,Wheel_Speed_Index_a:Wheel_Speed_Index_a+1).*2*pi*RE) ./ (PER23_gr*60));

% all recorded GPS NED velocities [m/s]
all_sa = accel_data(:,Velocity_Index_a:Velocity_Index_a+2);

% all recorded throttle commands [%]
all_ka = accel_data(:,Throttle_Index_a);

% all recorded lattitude and longitude and altitude data [deg deg m]
LL = accel_data(:,LL_Index_a:LL_Index_a+1) .* 10^(-7);
A = accel_data(:,LL_Index_a-1) .* 10;
all_pa = [LL,A];

% all recorded accelerometer readings [m/s^2]
all_aa = accel_data(:,Accelerometer_Index_a:Accelerometer_Index_a+2);

% all recorded battery current and battery voltage [A V]
all_ba = accel_data(:,Battery_IV_a:Battery_IV_a+1);

% filtering
all_filtering = (all_ba(:,2) > Min_Voltage) & (all_ba(:,2) < Max_Voltage);

all_ta = all_ta(all_filtering);
all_wa = [all_wa(all_filtering,1) all_wa(all_filtering,2)];
all_sa = [all_sa(all_filtering,1) all_sa(all_filtering,2) all_sa(all_filtering,3)];
all_ka = all_ka(all_filtering);
all_pa = [all_pa(all_filtering,1) all_pa(all_filtering,2) all_pa(all_filtering,3)];
all_aa = [all_aa(all_filtering,1) all_aa(all_filtering,2) all_aa(all_filtering,3)];
all_ba = [all_ba(all_filtering,1) all_ba(all_filtering,2)];

%% Plotting All Data
% figure(1)
% plot(all_ta(START0:STOP0), all_aa(START0:STOP0,1))
% hold on
% plot(all_ta(START0:STOP0), all_aa(START0:STOP0,2))
% hold on
% plot(all_ta(START0:STOP0), all_aa(START0:STOP0,3))
% 
% xlabel("Time (s)")
% ylabel("Acceleration (m/s^2)")
% legend("x", "y", "z")
% title("Static Vehicle Accelerometer Readings")
% 
% figure(2)
% scatter(all_ta, all_wa(:,1))
% hold on
% scatter(all_ta, all_wa(:,2))
% 
% xlabel("time (s)")
% ylabel("Tire Speed (m/s)")
% title("All Collected Data for Acceleration")
% legend("Rear Left","Rear Right")
% 
% figure(3)
% scatter(all_ta, all_sa(:,1))
% hold on
% scatter(all_ta, all_sa(:,2))
% hold on
% scatter(all_ta, all_sa(:,3))
% 
% xlabel("time (s)")
% ylabel("Chassis Velocity (m/s)")
% title("All Collected Data for Acceleration")
% legend("N","E","D")
% 
% figure(4)
% scatter(all_ta, all_ka)
% 
% xlabel("time (s)")
% ylabel("Throttle (%)")
% title("All Collected Data for Acceleration")
% 
% figure(5)
% scatter(all_pa(:,1), all_pa(:,2))
% 
% xlabel("Lattitude (deg)")
% ylabel("Longitude (deg)")
% title("All Collected Data for Acceleration")
% 
% figure(6)
% scatter(all_ta, all_aa(:,1))
% hold on
% scatter(all_ta, all_aa(:,2))
% hold on
% scatter(all_ta, all_aa(:,3))
% 
% xlabel("time (s)")
% ylabel("Chassis Acceleration (m/s^2)")
% title("All Collected Data for Acceleration")
% legend("x","y","z")
% 
% figure(7)
% scatter(all_ta, all_ba(:,1))
% 
% xlabel("time (s)")
% ylabel("Battery Current (A)")
% title("All Collected Data for Acceleration")
% 
% figure(8)
% scatter(all_ta, all_ba(:,2))
% 
% xlabel("time (s)")
% ylabel("Battery Voltage (V)")
% title("All Collected Data for Acceleration")

%% Straight Acceleration Data Processing
% Static Characteristics
avg_acc = mean(all_aa(START0:STOP0,:));

for i = 1:length(START)
    % Select all data for 1 run
    t_selection = all_ta(START(i):STOP(i)) - all_ta(START(i));
    w_selection = all_wa(START(i):STOP(i),:);
    s_selection = sqrt(all_sa(START(i):STOP(i),1).^2 + all_sa(START(i):STOP(i),2).^2);
    k_selection = all_ka(START(i):STOP(i));
    p_selection = lla2ned(all_pa(START(i):STOP(i),:),all_pa(START(i),:),'flat');
    a_selection = sqrt((avg_acc(2) - all_aa(START(i):STOP(i),2)) + (avg_acc(3) - all_aa(START(i):STOP(i),3)).^2);
    i_selection = all_ba(START(i):STOP(i),1);
    v_selection = all_ba(START(i):STOP(i),2);

    % filtering
    dw = abs(w_selection(:,1) - w_selection(:,2));
    valid_data = (w_selection(:,1) < Max_Tire_s) & (w_selection(:,2) < Max_Tire_s) & (w_selection(:,1) > Min_Tire_s) & (w_selection(:,2) > Min_Tire_s) & (t_selection > Rel_Start_T) & (dw < max_ds) & (t_selection < Rel_Stop_T(i));
    t_selection = t_selection(valid_data);
    w_selection = mean([w_selection(valid_data,1) w_selection(valid_data,2)],2);
    s_selection = s_selection(valid_data);
    k_selection = k_selection(valid_data);
    p_selection = [p_selection(valid_data,1) p_selection(valid_data,2) p_selection(valid_data,3)];
    a_selection = a_selection(valid_data);
    i_selection = i_selection(valid_data);
    v_selection = v_selection(valid_data);

    % log event data
    event_ta = cat(1, event_ta, t_selection);
    event_wa = cat(1, event_wa, w_selection);
    event_sa = cat(1, event_sa, s_selection);
    event_ka = cat(1, event_ka, k_selection);
    event_pa = cat(1, event_pa, p_selection);
    event_aa = cat(1, event_aa, a_selection);
    event_ia = cat(1, event_ia, i_selection);
    event_va = cat(1, event_va, v_selection);

    % select region of data st vehicle is not at steady state velocity
    Transient_v_Yes = (t_selection < TRANSIENT_T(i));

    transient_t = cat(1, transient_t, t_selection(Transient_v_Yes));
    transient_w = cat(1, transient_w, w_selection(Transient_v_Yes));
    transient_s = cat(1, transient_s, s_selection(Transient_v_Yes));
    transient_k = cat(1, transient_k, k_selection(Transient_v_Yes));
    transient_p = cat(1, transient_p, [p_selection(Transient_v_Yes,1) p_selection(Transient_v_Yes,2) p_selection(Transient_v_Yes,3)]);
    transient_a = cat(1, transient_a, a_selection(Transient_v_Yes));
    transient_i = cat(1, transient_i, i_selection(Transient_v_Yes));
    transient_v = cat(1, transient_v, v_selection(Transient_v_Yes));

    % selection region of data st vehicle is at steady state velocity
    Steady_v_YES = (t_selection > STEADY_T(i));

    steady_t = cat(1, steady_t, t_selection(Steady_v_YES));
    steady_w = cat(1, steady_w, w_selection(Steady_v_YES));
    steady_s = cat(1, steady_s, s_selection(Steady_v_YES));
    steady_k = cat(1, steady_k, k_selection(Steady_v_YES));
    steady_p = cat(1, steady_p, [p_selection(Steady_v_YES,1) p_selection(Steady_v_YES,2) p_selection(Steady_v_YES,3)]);
    steady_a = cat(1, steady_a, a_selection(Steady_v_YES));
    steady_i = cat(1, steady_i, i_selection(Steady_v_YES));
    steady_v = cat(1, steady_v, v_selection(Steady_v_YES));

    % fit GPS velocity data to get speed model
    [xData, yData] = prepareCurveData( t_selection, s_selection );
    ft = fittype( 'smoothingspline' );
    opts = fitoptions( 'Method', 'SmoothingSpline' );
    opts.Normalize = 'on';
    opts.SmoothingParam = 0.995;
    [fitresult, gof] = fit( xData, yData, ft, opts );
    vel_from_vel = feval(fitresult,t_selection);
    
    % fit battery power data to get power consumption model
    battery_P = i_selection .* v_selection;
    [xData, yData] = prepareCurveData( t_selection, battery_P );
    ft = fittype( 'smoothingspline' );
    opts = fitoptions( 'Method', 'SmoothingSpline' );
    opts.Normalize = 'on';
    opts.SmoothingParam = 0.995;
    [fitresult, gof] = fit( xData, yData, ft, opts );
    pow_from_pow = feval(fitresult, t_selection);

%     figure(100)
%     scatter(t_selection, s_selection)
%     hold on
%     plot(t_selection, vel_from_vel)
%     legend("Raw", "Smooth")
% 
%     figure(200)
%     scatter(t_selection, battery_P)
%     hold on
%     scatter(t_selection, pow_from_pow)
%     legend("Output", "Input")

    % save fitted data
    event_s_fit = cat(1, event_s_fit, vel_from_vel);
    event_a_fit = cat(1, event_a_fit, gradient(vel_from_vel)./gradient(t_selection));
    event_e_fit = cat(1, event_e_fit, pow_from_pow);

    % compute vehicle efficiency by using kinetic energy approach
    KE = 0.5*m.*(vel_from_vel(2:end).^2 - vel_from_vel(1:end-1).^2)./(t_selection(2:end) - t_selection(1:end-1));
    efficiency = (100.*KE) ./ pow_from_pow(1:end-1);
    
    % calculate internal resistance of the battery
    req = (Battery_OCV(i) - v_selection) ./ i_selection;

    % compute max current draw for each event
    [max_I, index_I] = max(i_selection);

    % save calculated parameters
    event_n = cat(1, event_n, efficiency);

    event_r = cat(1, event_r, req);

    FW_Zone_W = cat(1, FW_Zone_W, s_selection(index_I));
    FW_Zone_K = cat(1, FW_Zone_K, max(k_selection));
    FW_Zone_I = cat(1, FW_Zone_I, max_I/2);
    FW_Zone_V = cat(1, FW_Zone_V, v_selection(index_I));
end

%% Extract All Endurance Data
% all recorded timestamps [s]
all_te = endur_data(:,1);

% all recorded rear tire angular velocities [rad/s]
all_we = ((endur_data(:,Wheel_Speed_Index_e:Wheel_Speed_Index_e+1).*2*pi*RE) ./ (PER23_gr*60));

% all recorded GPS NED velocities [m/s]
all_se = endur_data(:,Velocity_Index_e:Velocity_Index_e+2);

% all recorded throttle commands [%]
all_ke = endur_data(:,Throttle_Index_e);

% all recorded lattitude and longitude and altitude data [deg deg m]
LL = endur_data(:,LL_Index_e:LL_Index_e+1) .* 10^(-7);
A = endur_data(:,LL_Index_e-1) .* 10;
all_pe = [LL,A];

% all recorded accelerometer readings [m/s^2]
all_ae = endur_data(:,Accelerometer_Index_e:Accelerometer_Index_e+2);

% all recorded battery current and battery voltage [A V]
all_be = endur_data(:,Battery_IV_e:Battery_IV_e+1);

% filtering
all_filtering = (all_be(:,2) > Min_Voltage) & (all_be(:,2) < Max_Voltage);

all_te = all_te(all_filtering);
all_we = [all_we(all_filtering,1) all_we(all_filtering,2)];
all_se = [all_se(all_filtering,1) all_se(all_filtering,2) all_se(all_filtering,3)];
all_ke = all_ke(all_filtering);
all_pe = [all_pe(all_filtering,1) all_pe(all_filtering,2) all_pe(all_filtering,3)];
all_ae = [all_ae(all_filtering,1) all_ae(all_filtering,2) all_ae(all_filtering,3)];
all_be = [all_be(all_filtering,1) all_be(all_filtering,2)];

%% Endurance Data Processing
dw = abs(all_we(:,1) - all_we(:,2));

% filter out bad wheelspeed measurements
endurance_filter = (all_we(:,1) < Max_Tire_s) & (all_we(:,2) < Max_Tire_s) & (all_we(:,1) > Min_Tire_s) & (all_we(:,2) > Min_Tire_s) & (dw < 5*max_ds);

event_te = all_te(endurance_filter);
event_we = all_we(endurance_filter);
event_ke = all_ke(endurance_filter);
event_ie = all_be(endurance_filter,1);

% [xData, yData] = prepareCurveData( event_te, event_ke );
% ft = fittype( 'smoothingspline' );
% [fitresult, gof] = fit( xData, yData, ft );
% 
% filtered_ke = feval(fitresult, event_te);
% 
% current_increase_filter = (gradient(event_ke) >= 0) & (event_ke > 10);
% 
% filter_we = event_we(current_increase_filter);
% filter_ke = event_ke(current_increase_filter);
% filter_ie = event_ie(current_increase_filter);

%% Plotting Straight Acceleration Data
% figure(9)
% scatter(event_ta, event_wa)
% hold on
% scatter(transient_t, transient_w)
% hold on
% scatter(steady_t, steady_w)
% 
% xlabel("time (s)")
% ylabel("Tire Speed (m/s)")
% title("Event Data")
% legend("event", "transient","steady",'Location','northwest')
% 
figure(10)
scatter(event_ta, event_sa)
hold on
scatter(transient_t, transient_s)
hold on
scatter(steady_t, steady_s)
hold on
scatter(event_ta, event_s_fit)

xlabel("time (s)")
ylabel("Chassis Speed (m/s)")
title("Event Data")
legend("event", "transient","steady","Event Fit",'Location','northwest')
% 
% figure(11)
% scatter(event_ta, event_ka)
% hold on
% scatter(transient_t, transient_k)
% hold on
% scatter(steady_t, steady_k)
% 
% xlabel("time (s)")
% ylabel("Throttle (%)")
% title("Event Data")
% legend("event", "transient","steady")
% 
% figure(12)
% scatter(event_pa(:,1), event_pa(:,2))
% hold on
% scatter(transient_p(:,1), transient_p(:,2))
% hold on
% scatter(steady_p(:,1), steady_p(:,2))
% 
% xlabel("North Displacement (m)")
% ylabel("East Displacement (m)")
% title("Event Data")
% legend("event", "transient","steady")
% 
% figure(13)
% scatter(event_ta, event_aa)
% hold on
% scatter(transient_t, transient_a)
% hold on
% scatter(steady_t, steady_a)
% 
% xlabel("time (s)")
% ylabel("Chassis Acceleration (m/s^2)")
% title("Event Data")
% legend("event", "transient","steady")
% 
% figure(14)
% scatter(event_ta, event_ia)
% hold on
% scatter(transient_t, transient_i)
% hold on
% scatter(steady_t, steady_i)
% 
% xlabel("time (s)")
% ylabel("Battery Current (A)")
% title("Event Data")
% legend("event", "transient","steady","Location","northwest")
% 
% figure(15)
% scatter(event_ta, event_va)
% hold on
% scatter(transient_t, transient_v)
% hold on
% scatter(steady_t, steady_v)
% 
% xlabel("time (s)")
% ylabel("Battery Voltage (V)")
% title("Event Data")
% legend("event", "transient","steady","Location","southwest")

figure(16)
scatter(event_ta,event_r)

xlabel("time (s)")
ylabel("Battery Resistance (ohm)")
title("Event Data")

figure(17)
scatter(event_ta(1:length(event_n)), event_n)

xlabel("time (s)")
ylabel("Estimated Vehicle Efficiency (%)")
title("Event Data")

%% Sensor Verification
% figure(18)
% scatter(event_ta, event_wa)
% hold on
% scatter(event_ta, event_sa)
% 
% xlabel("time (s)")
% ylabel("speed (m/s)")
% legend("Wheelspeed", "GPS Speed")
% 
% figure(19)
% scatter(event_ta, event_aa)
% hold on
% scatter(event_ta, event_a_fit)
% 
% xlabel("time (s)")
% ylabel("acceleration (m/s^2)")
% legend("IMU Acceleration", "Time Derivative of GPS Speed")

%% 3D graphing YEAAAH BOIII
% figure(30)
% scatter3(event_ta, event_ka, event_sa)
% xlabel("time (s)")
% ylabel("Throttle Percent")
% zlabel("Chassis Velocity (m/s)")
% title("Acceleration Event Sweep")
%
% figure(31)
% scatter3(event_ta, event_ka, event_ia)
% xlabel("time (s)")
% ylabel("Throttle Percent")
% zlabel("Battery Current (A)")
% title("Acceleration Event Sweep")
% 
% figure(32)
% scatter3(event_ta, event_ka, event_va)
% xlabel("time (s)")
% ylabel("Throttle Percent")
% zlabel("Battery Voltage (V)")
% title("Acceleration Event Sweep")

figure(33)
scatter3(event_wa, event_ka, event_ia)
hold on
scatter3(event_we, event_ke, event_ie)
hold on
scatter3(FW_Zone_W, FW_Zone_K, 2.*FW_Zone_I)

xlabel("FW Tire Speed (m/s)")
ylabel("FW Throttle (%)")
zlabel("FW Current (A)")
legend("Acceleration","Endurance","Max Current")

%% KWV Curve Fitting
% scale data appropriately
FW_Zone_W_TM = FW_Zone_W.*(8.749./0.2286);
FW_Zone_K_TM = FW_Zone_K./100;
FW_Zone_V_TM = FW_Zone_V;

[VfuncK, WfuncKV] = curve_fit_func(FW_Zone_K_TM, FW_Zone_V_TM, FW_Zone_W_TM);

% Plot example curve
FW_K_smooth = linspace(min(FW_Zone_K_TM),max(FW_Zone_K_TM),100);
FW_V_smooth = feval(VfuncK, FW_K_smooth);
FW_K_smooth = FW_K_smooth';
FW_W_smooth = feval(WfuncKV, FW_K_smooth, FW_V_smooth);
figure(314)
scatter3(FW_Zone_K_TM, FW_Zone_V_TM, FW_Zone_W_TM)
hold on
plot3(FW_K_smooth, FW_V_smooth, FW_W_smooth, Marker='none')
grid on
xlabel("K")
ylabel("V")
zlabel("W")


%% Lookup Tables (WIP)
% Table 1: Current
% scatter3(valid_W_grid.*RE./PER23_gr,valid_K_grid.*100,valid_I_grid.*2)
% hold on;
% scatter3(Speeds,Throttles,Amps);
% xlabel("Chassis Speed (m/s)");
% ylabel("Throttle Percent");
% zlabel("Battery Current (A)");
% legend("Predicted","Actual");
%
% scatter3(W,K,I)
% hold on
% scatter3(Speeds,Throttles,Amps);
% xlabel("Chassis Speed (m/s)");
% ylabel("Throttle Percent");
% zlabel("Battery Current (A)");
% legend("Endurance","Acceleration")
% 
% scatter3(Times,Throttles,Speeds)
% xlabel("Time (s)");
% ylabel("Throttle Percent");
% zlabel("Chassis Speed (m/s)");
%
% scatter(MAX_K,MAX_I)
% hold on
% scatter(throttle_sweep_PL,MAX_I_LIMIT)
% xlabel("Throttle (%)")
% ylabel("Max Current (A)")
% legend("Using Data", "Linear Fit using Global Max Amperage")
%
% scatter3(Speeds,Throttles,Volts)
% xlabel("Chassis Speed (m/s)");
% ylabel("Throttle Percent");
% zlabel("Voltage (V)");
%
% scatter3(Times_filt,Throttles_filt,Rint_filt)
% xlabel("Chassis Speed (m/s)");
% ylabel("Throttle Percent");
% zlabel("Internal Resistance (ohm)");
% 
% scatter(V_sweep,Throttle_ABS_MAX)
% hold on
% scatter(V_sweep,Throttle_MAX)
% 
% xlabel("Max Voltage Drop (V)")
% ylabel("Max Throttle Percent")
% legend("Linear Fit using Global Max Amperage", "Using Data")
% 
% RPM = [135 226 319 402 479 552];
% AMP = [2.9 6.5 8.3 11.4 15.5 19.5];
% CMD = [0.1 0.2 0.3 0.4 0.5 0.6];
% 
% plot([0 100 200 1150].*RE./PER23_gr,[0 0 0.1 1].*100)
% hold on
% plot(RPM.*RE./PER23_gr,CMD.*100)
% hold on
% plot(MAX_W,MAX_K)
% hold on
% plot([0 675.*RE./PER23_gr],[0.05 1].*100)
% 
% xlabel("Chassis Speed (m/s)");
% ylabel("Throttle Percent");
% legend("Upper Bound-Data","Lower Bound-Data","Upper Bound-Map","Lower Bound-Map")
% 
% plot(t_selection, all_w(START(i):STOP(i),1).*60.*PER23_gr./(RE.*2.*pi))
% 
% xlabel("Time (s)")
% ylabel("Motor Shaft Speed (RPM)")