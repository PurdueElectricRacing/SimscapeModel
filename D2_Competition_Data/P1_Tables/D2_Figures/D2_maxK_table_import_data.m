function [FW_Zones, event_data] = maxK_table_import_data( ...
    csv_path, ...
    gear_ratio, ...
    tire_radius, ...
    Max_Voltage, ...
    Min_Voltage, ...
    START, ...
    STOP, ...
    Rel_Start_T, ...
    Rel_Stop_T)
%maxK_table_import_data Imports .csv for processing
%   Detailed explanation goes here

%% Constants
Max_Tire_s = (18.5*gear_ratio)/(tire_radius); % [rad/s] (motor shaft)
Min_Tire_s = (1.5*gear_ratio)/(tire_radius); % [rad/s] (motor shaft)
max_ds = (0.5*gear_ratio)/(tire_radius); % [m/s] (motor shaft)

raw_data = readmatrix(csv_path);

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
all_ta = raw_data(:,1); % time
all_wa = raw_data(:,2:3).*((2*pi) ./ (60)); % wheel speeds [left, right]
all_sa = raw_data(:,4:6).*(gear_ratio./tire_radius); % GPS velocity -> motor shaft w, [n, e, d]
all_ka = raw_data(:,7) ./ 100; % throttle
all_ba = raw_data(:,8:9); % pack [current, voltage]

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

%% Export Data
% combine event data into table
event_data = [event_ta event_wa event_sa event_ka event_ia event_va];

% combine FW_Zones into table
FW_Zones = [FW_Zone_W, FW_Zone_K, FW_Zone_I, FW_Zone_V];

%figure(1)
%scatter3(event_wa, event_ka, event_ia)
%hold on
%scatter3(FW_Zone_W, FW_Zone_K, 2.*FW_Zone_I)

%xlabel("FW Tire Omega (rad/s)")
%ylabel("FW Throttle (%)")
%zlabel("FW Current (A)")
%legend("Acceleration","Max Current")