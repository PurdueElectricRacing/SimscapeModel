%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PER 2023 Powertrain Definition
% This program defines the PER23 powertrain. This includes the
% gearbox, motor, battery, and associated cooling systems.
%
% Input Arguments
% None
%
% Output Arguments
% None
%
% Definitions
% gr - gearbox speed reduction ratio [fl fr rl rr] (input speed/output speed)
% ge - gearbox efficiency [fl fr rl rr] (output torque / input torque)
%
% Lookup tables
% max_torque_table - max_torque_table = f(speed_bp)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Startup
clearvars -except sim

%% Gearbox
ns = 27; % number of teeth on PER23 sun gear
nr = 111; % number of teeth on PER23 ring gear
np1 = 49; % number of teeth on PER23 stage 1 planet gear
np2 = 26; % number of teeth on PER23 stage 2 planet gear
PER23_gr = ((np1 / ns) * (nr / np2)) + 1;

powertrain.gearbox.gr = [PER23_gr PER23_gr PER23_gr PER23_gr];
powertrain.gearbox.ge = [0.9 0.9 0.9 0.9];

%% Motor
Motor_tau = 0.0035; % response time costant for Plettenberg Nova 15 motor (s)
mcp_Motor = 573; % Specific Heat of Plettenberg Nova 15 motor (J/K)
I_mot = 0.777559; % Polar mass moment of inertia for Plettenberg Nova 15 motor (kg/m^2)

powertrain.motor.speed_bp = [0 733 1150]; % rad/s
powertrain.motor.max_torque_table = [5.75 15.75 0]; % Nm
powertrain.motor.max_current_table = [0 55 0]; % A

%% Battery
powertrain.battery.Np = 5; % count
powertrain.battery.Ns = 76; % count
powertrain.battery.Ah = 4; % Ah
powertrain.battery.Em = [2.8 3.375 3.65 3.9 4.15]; % V
powertrain.battery.SOC = [0 0.25 0.5 0.75 1]; % none
powertrain.battery.R = 0.003; % Ohms

%% Cooling
powertrain.cooling.area_air = 0.15; % m^2
powertrain.cooling.rad_air_vol = 0.01; % m^3
powertrain.cooling.rad_liq_vol = 0.000157; % m^3
powertrain.cooling.tube_diameter = 0.009525; % m
powertrain.cooling.motor_thermal_mass = 3.1; % kg
powertrain.cooling.motor_specific_heat = 185; % J/(kg*K)
powertrain.cooling.area_cooling_jacket = 0.022925; % m^2

%% Brakes
powertrain.brake.num_pads = 2; % count
powertrain.brake.Rm = 0.079375; % m
powertrain.brake.disk_abore = 0.0254; % m
powertrain.brake.mu_kinetic = 0.4; % none
powertrain.brake.mu_static = 0.5; % none

%% Cleaning up & Saving
save("Powertrain_Tables.mat","powertrain");
clearvars -except sim