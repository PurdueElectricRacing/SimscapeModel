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
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Startup
clearvars -except sim

%% Chassis Constants
chassis.mass.m_unsprung = [6 6 6 6] + ([8 8 8 8] .* sim.top_parameters.MOTOR_ENABLE); % kg
chassis.mass.m_driver = 60; % kg
chassis.mass.m_body = 180; % kg
chassis.mass.m_all = chassis.mass.m_body + sum(chassis.mass.m_unsprung) + chassis.mass.m_driver;
chassis.mass.Iveh = [41.78 1.22 -41.28; 1.22 207.92 -0.32; -41.28 -0.32 209.31]; % kg*m^2

chassis.geometry.l = [0.772 0.772]; % vehicle wheelbase for PER23 [front rear] (m)
chassis.geometry.s = [0.649 0.621]; % vehicle half track width for PER23 [front rear] (m)
chassis.geometry.dZ = 0.295; % m
chassis.geometry.phi = 45; % deg angle of firewall with resepct to horizontal

chassis.aero.Af = 1.0221; % Frontal area of vehicle with respect to aerodynamics (m^2)
chassis.aero.Cd = 1.149; % Coefficient of drag (dimensionless)
chassis.aero.Cl = 2.11014; % Coefficient of lift (dimensionless)

%% Cleaning up & Saving
save("Chassis_Tables.mat","chassis");
clearvars -except sim