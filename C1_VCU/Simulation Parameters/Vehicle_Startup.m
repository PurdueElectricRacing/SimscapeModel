%% Startup
clear all;
clc;

%% File Management
addpath(genpath("Vehicle Parameters"));
addpath(genpath("Controller Systems"));
addpath(genpath("Code_Generation_Project"));

%% Simulation Top Parameters
sim.top_parameters.YAW_ENABLE = 1;  % Enable yaw rate sweeping when set to 0
sim.top_parameters.TVS_ENABLE = 0;  % Enable TVS when set to 1
sim.top_parameters.TRACTION_ENABLE = 0; % Enable variable objective function coefficients when set to 1
sim.top_parameters.MOTOR_ENABLE = [0 0 1 1]; % Enable motors when set to 1 

%% Simulation Sample Rates
sim.timing.control_timing = 0.01; % s
sim.timing.duplicate = sim.timing.control_timing; % duplicate simulation
sim.timing.gps_hz = sim.timing.control_timing; % gps sample period (s)
sim.timing.imu_hz = sim.timing.control_timing; % imu sample period (s)

sim.timing.gps_ratio = sim.timing.gps_hz  / sim.timing.imu_hz; % ratio of gps sample period to imu sample period

%% Simulation Strange Parameters
% Tire unknown parameters
sim.strange_parameters.LONGVL = 16.7; % m/s
sim.strange_parameters.FNOMIN = 850; % N
sim.strange_parameters.NOMPRES = 82737; % Pa
sim.strange_parameters.VXLOW = 0.1; % m/s
sim.strange_parameters.xdot_tol = 0.1; % m/s

% Aerodynamics unknown parameters
sim.strange_parameters.beta_w = [0 0.01:0.01:0.3]; % rad
sim.strange_parameters.Cs = [0 0.01:0.01:0.3]; % none
sim.strange_parameters.Cym = [0 1e-6:0.01:0.3]; % none
sim.strange_parameters.cpm = .1; % none

%% Simulation Constants
sim.constant.deg2rad = 0.01745329; % multiply to convert from deg to rad (rad/deg)
sim.constant.rpm2radps = 0.104719755; % multipe to convert RPM to rad/s (rad/RPM*s)

sim.constant.g = 9.81; % m/s^2
sim.constant.rho = 1.225; % air density [kg/m^3]
sim.constant.Tair = 300; % Ambient air temperature [K]
sim.constant.Pair = 101325; % Ambient absolute pressure [Pa]

%% Signal Ranges
% navigation sensors
sim.range.VELOCITY_MAX = 30; % m/s
sim.range.YAW_MAX = 2.5; % rad/s
sim.range.ACCELERATION_MAX = 30; % m/s^2
sim.range.ORIENTATION_MAX = 360; % deg
sim.range.MAG_MAX = 200; % uT

% battery
sim.range.BATTERY_VOLTAGE_MAX = 340; % V
sim.range.BATTERY_VOLTAGE_MIN = 60; % V
sim.range.BATTERY_CURRENT_MAX = 140; % A
sim.range.BATTERY_CURRENT_MIN = 0; % A
sim.range.BATTERY_TEMPERATURE_MAX = 60; % degC
sim.range.BATTERY_TEMPERATURE_MIN = 0; % degC

sim.range.DCL_MAX = 130; % A
sim.range.DCL_MIN = 0; % A

% motor
sim.range.MOTOR_VOLTAGE_MAX = 340; % V
sim.range.MOTOR_VOLTAGE_MIN = 90; % V
sim.range.MOTOR_CURRENT_MAX = 70; % A
sim.range.MOTOR_CURRENT_MIN = 0; % A
sim.range.MOTOR_TEMPERATURE_MAX = 100; % degC
sim.range.MOTOR_TEMPERATURE_MIN = 0; % degC

% motor controller
sim.range.MOTOR_CONTROLLER_TEMPERATURE_MAX = 75; % degC
sim.range.MOTOR_CONTROLLER_CURRENT_MAX = 140; % A

% corner dynamics sensors
sim.range.CENTER_STEER_ANGLE_MAX = 130; % deg
sim.range.OMEGA_MAX = 150; % rad/s
sim.range.OMEGA_MIN = 0; % rad/s
sim.range.SHOCK_LENGTH_MAX = 0.25; % m
sim.range.SHOCK_LENGTH_MIN = 0; % m
sim.range.FZ_MAX = 1200; % N
sim.range.FZ_MIN = 200; % N

% driver saturation
sim.range.Max_Driver_Input = 1; % unitless
sim.range.Min_Driver_Input = 0; % unitless

sim.range.Max_Brake_Pressure = 6*10^6; % Pa
sim.range.Min_Brake_Pressure = 1; % Pa
sim.range.MAX_STEERING_ADJUST = 15; % deg
sim.range.MAX_DTHETA_DRIVER = 360; % deg/s

%% Update Tables
% Yaw_Tables;
Chassis_Tables;
Suspension_Tables;
Powertrain_Tables;
Sensor_Tables;

%% Load Table Data
% Driver Systems 
load("Track_Tables.mat");
load("Sweep_Tables.mat");
load("Driver_Tables.mat");

% Vehicle Systems
load("Suspension_Tables.mat");
load("Chassis_Tables.mat");
load("Powertrain_Tables.mat");

% Control Systems
load("TVS_Tables.mat");
load("Sensor_Tables.mat");

%% Select Track
track.selected_track = ALL_TRACK_DATA.(event_names(7)); % xy track data
track.selected_maxvm = MIN_TRACK_DATA.(event_names(7)); % section track data
track.selected_sweep = ALL_SWEEP_DATA.(sweep_names(1)); % driver control data 

%% Simulation Initial Conditions
% battery
sim.IC.SOC_IC = 1;

% thermal system
sim.IC.motor_T_IC = 300; % K
sim.IC.motor_FT_IC = 300; % K
sim.IC.battery_T_IC = 300; % K
sim.IC.battery_FT_IC = 300; % K
sim.IC.motor_heat_loss_IC = 0; % W

% navigation sensors
sim.IC.vel_IC = [0 0 0]; % m/s
sim.IC.pos_IC = 0; % m
sim.IC.acc_IC = 0; % m/s^2
sim.IC.ang_IC = 0; % rad
sim.IC.ang_vel_IC = 0; % rad/s

% power sensors
sim.IC.battery_voltage_IC = 332; % V
sim.IC.battery_current_IC = 0; % A
sim.IC.motor_voltage_IC = 332; % V
sim.IC.motor_current_IC = 0; % A
sim.IC.dcl_IC = 140; % A
sim.IC.ccl_IC = 0; % A

% corner dynamics sensors
sim.IC.omega_IC = 0 ; % rad/s
sim.IC.theta_IC = 0; % deg
sim.IC.shock_length_IC = 0.1; % m
sim.IC.Fz_IC = chassis.mass.m_all*sim.constant.g/4; % vehicle corner weight [N]

% vehicle initial conditions
sim.IC.zdot_tires_IC = 0; % m/s
sim.IC.z_tire_IC = 0; % m

% sensor fusion initial conditions
sim.IC.location_lla_IC = [40.437675, -86.943750, 680]; % [deg deg m]
sim.IC.mag_field_IC = [19.78899, -1.607, 48.9449]; % NED magnetic field uT
sim.IC.gps_counter_IC = 0;
sim.IC.covarience_matrix_IC = eye(28)./1000;
sim.IC.state_IC = zeros(28,1);
sim.IC.state_IC(1:4) = [1 0 0 0];       % orientation
sim.IC.state_IC(23:25) = sim.IC.mag_field_IC; % magnetic field

% driver initial conditions
sim.IC.Brake_Pressure_IC = 1; % Pa
sim.IC.driver_input_IC = 0;

%% Throttle Map
Data_Parse_Events;
Motor_Tables;

%% Cleanup & Saving
% clearvars -except chassis driver powertrain sensor sim suspension tvs track rpm_sweep_min voltage_sweep_min dk_grid k_grid_min