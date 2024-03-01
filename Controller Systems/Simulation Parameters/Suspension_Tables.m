%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PER 2023
% Program Description 
% This program calculates various lookup tables that are related to the
% suspension of a formula style electric vehicle. In particular, the PER23
% suspension. In addition, sets various suspension parameters
%
% Input Arguments
% None
%
% Output Arguments
% None
%
% Definitions
% CCSA  - center column steering angle
%
% Lookup tables
% Damper Lookup: Damper Force = f(shock velocity, duty cycle)
% Front tire angles [FL FR] = f(CCSA)
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Startup
clearvars -except sim
load("Chassis_Tables.mat");

%% Conversions
lbin2kgm = 4.44822162/0.0254; % (N*in)/(lb*m)

%% Scalar Prameters
suspension.shock.Kz = 250*lbin2kgm; % [N/m] spring constant per wheel
suspension.shock.F0z = [0 0]; % [N] preload per wheel
suspension.shock.Hmax = 0.05715 + 0.0225; % [m] max suspension height
suspension.arb.AntiSwayR = 0.0635; % [m] antisway bar radius
suspension.arb.AntiSwayNtrlAng = pi/4; % [rad] antisway neutral angle
suspension.arb.AntiSwayTrsK = 1218; % [Nm/rad] antisway stiffness

steer_slope = 0.282; % CCSA to rack displacement slope (mm/deg)
S1 = 7E-5; % rack displacement to tire angle x^3 coefficient (deg/mm^3)
S2 = -0.0038; % rack displacement to tire angle x^2 coefficient (deg/mm^2)
S3 = 0.6535; % rack displacement to tire angle x coefficient (deg/mm)
S4 = 0.1061; % rack displacement to tire angle constant coefficient (deg)

%% Tire
suspension.tire.WIDTH = 0.1524; % [m] tire width
suspension.tire.RIM_RADIUS = 0.1524; % [m] tire rim radius

suspension.tire.RE = 0.223; % [m] tire effective radius
suspension.tire.UNLOADED_RADIUS = 0.2286; % m

% suspension.tire.RE = 0.1970; % [m] tire effective radius
% suspension.tire.UNLOADED_RADIUS = 0.2024; % m

suspension.tire.br = 1e-2; % [Nm*s/rad] tire rotational damping coefficient
suspension.tire.IYY = 0.3; % [kg*m^2] tire inertia about rotational axis
suspension.tire.VERTICAL_DAMPING = 500; % [Ns/m] tire vertical damping

Fz = [0 204.13 427.04 668.1 895.72 1124.40 1324.40]; % tire normal force sample points (N)
cy = [0 13757.41 21278.97 26666.02 30253.47 30313.18 30313.18]; % lateral tire stiffness (N/rad)
A1 = 39.8344; % longitudinal tire stiffness x coefficient (1/rad)
A2 = 813.0780; % longitudinal tire stiffness constant coefficient (N/rad)
B1 = 0.000001287; % longitudinal tire coefficient of friction x^2 coefficient (1/N^2)
B2 = -0.002325; % longitudinal tire coefficient of friction x coefficient (1/N)
B3 = 3.797; % longitudinal tire coefficient of friction constant coefficient (none)
C1 = -0.000000002541; % lateral tire coefficient of friction x^3 coefficient (1/N^3)
C2 = 0.000005279; % lateral tire coefficient of friction x^2 coefficient (1/N^2)
C3 = -0.003943; % lateral tire coefficient of friction x coefficient (1/N)
C4 = 3.6340; % lateral tire coefficient of friction constant coefficient (none)

% create coefficient matricies for each model
p_kx = [A1 A2];
p_mx = [B1 B2 B3];
p_my = [C1 C2 C3 C4];

suspension.tire.Fz_sweep = sim.range.FZ_MIN:10:sim.range.FZ_MAX; % tire normal force breakpoints (N)

% calculate tables values
suspension.tire.kx_sweep = polyval(p_kx, suspension.tire.Fz_sweep); % longitudinal tire stiffness (N/rad)
suspension.tire.cy_sweep = pchip(Fz, cy, suspension.tire.Fz_sweep); % lateral tire stiffness (N/rad)
suspension.tire.mx_sweep = polyval(p_mx, suspension.tire.Fz_sweep); % longitudinal coefficient of friction
suspension.tire.my_sweep = polyval(p_my, suspension.tire.Fz_sweep); % lateral coefficient of friction

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
sus_damper_con = ((sus_damper_for ./ abs(sus_damper_vel)) * [1 1])';

% replace NaN damping coefficient with interpolated value
suspension.shock.f_act_susp_cz = fillmissing(sus_damper_con,'pchip',2);

% set velocity breakpoints for damping coefficient
suspension.shock.f_act_susp_zdot_bpt = sus_damper_vel';

% set duty cycle breakpoints (this is only applicable to active damper, for now this parameter is set to dummy value
suspension.shock.f_act_susp_duty_bpt = [0 1];

%% Generate Front Tire Angles Table
% CCSA breakpoints 
suspension.steering.theta_sweep = -sim.range.CENTER_STEER_ANGLE_MAX:1:sim.range.CENTER_STEER_ANGLE_MAX;

% rack displacement (mm)
x = suspension.steering.theta_sweep.*steer_slope;

% left tire angle (rad)
suspension.steering.theta_left = deg2rad((S1*x.^3) - (S2*x.^2) + (S3.*x) - S4);

% right tire angle (rad)
suspension.steering.theta_right = deg2rad((S1*x.^3) + (S2*x.^2) + (S3.*x) + S4);

% precomputation of Aeq
theta_tires = [suspension.steering.theta_left; suspension.steering.theta_right];
left_tires = cos(theta_tires);
right_tires = sin(theta_tires);

% left Aeq
suspension.steering.Aeq_left = sum([chassis.geometry.s(1); chassis.geometry.l(1)] .* [left_tires(1,:); right_tires(1,:)]);

% right Aeq
suspension.steering.Aeq_right = sum([-chassis.geometry.s(1); chassis.geometry.l(1)] .* [left_tires(2,:); right_tires(2,:)]);

%% Cleanup & Saving
save("Suspension_Tables.mat","suspension");
clearvars -except sim