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

%% Sensor Modeling Parameters
% GPS performance
sensor.gps.GPS_Z_ACCURACY = 1.6; % m
sensor.gps.GPS_XY_ACCURACY = 3; % m
sensor.gps.GPS_V_ACCURACY = 0.1; % m/s
sensor.gps.GPS_NOISE_FACTOR = 0.599; % none
sensor.gps.r_GPS = randi([0 100]);

% IMU performance
sensor.imu.ACC_MAX = 1000; % m/s^2
sensor.imu.ACC_RES = 0; % m/(s^2*LSB)
sensor.imu.ACC_BIAS = [0.05 0.05 0.05]; % m/s^2 MAX: 20 mg
sensor.imu.ACC_SKEW = [ 100, 0, 0; 0, 100, 0; 0, 0, 100 ]; % %

sensor.imu.GYR_MAX = 100; % rad/s
sensor.imu.GYR_RES = 0; % rad/(s*LSB)
sensor.imu.GYR_BIAS = [0.25, 0.25, 0.25].*0.*(pi/180); % rad/s MAX: 1 deg
sensor.imu.GYR_SKEW = [ 100, 0, 0; 0, 100, 0; 0, 0, 100 ]; % %
sensor.imu.GYR_ACC_BIAS = [ 0, 0, 0 ]; % (rad/s)/(m/s^2)

sensor.imu.MAG_MAX = 10000; % uT
sensor.imu.MAG_RES = 0; % uT/LSB
sensor.imu.MAG_BIAS = [ 0, 0, 0 ]; % uT
sensor.imu.MAG_SKEW = [ 100, 0, 0; 0, 100, 0; 0, 0, 100 ]; % %

sensor.imu.ACC_VEL_WALK = [ 0, 0, 0 ]; % (m/s^2)/sqrt(Hz)
sensor.imu.ACC_BIAS_INSTABILITY = [ 0, 0, 0 ]; % (m/s^2)
sensor.imu.ACC_WALK = [ 0.01, 0.01, 0.01 ]; % (m/s^2)*sqrt(Hz)

sensor.imu.GYR_ANG_WALK = [ 0, 0, 0 ]; % (rad/s)/sqrt(Hz)
sensor.imu.GYR_BIAS_INSTABILITY = [ 0, 0, 0 ]; % (rad/s)
sensor.imu.GYR_WALK = [ 0.0001, 0.0001, 0.0001 ]; % (rad/s)*sqrt(Hz)

sensor.imu.MAG_WHITE = [ 0.1, 0.1, 0.1 ]; % uT/sqrt(Hz)
sensor.imu.MAG_BIAS_INSTABILITY = [ 0, 0, 0 ]; % uT
sensor.imu.MAG_WALK = [ 0, 0, 0 ]; % uT*sqrt(Hz)

sensor.imu.ACC_T_BIAS = [ 0, 0, 0 ]; % (m/s^2)/degC MAX: 0.2 mg/K
sensor.imu.ACC_T_SCALE = [ 0, 0, 0 ]; % %/degC

sensor.imu.GYR_T_BIAS = [ 0, 0, 0 ]; % (rad/s)/degC MAX: 0.015deg/s*K
sensor.imu.GYR_T_SCALE = [ 0, 0, 0 ]; % %/degC

sensor.imu.MAG_T_BIAS = [ 0, 0, 0 ]; % uT/degC
sensor.imu.MAG_T_SCALE = [ 0, 0, 0 ]; %/degC

sensor.imu.r_IMU = randi([0 100]);

% covariance of each sensor
sensor.imu.covA = 4.0095;
sensor.imu.covG = 0.018;
sensor.imu.covM = 0.99;
sensor.gps.covP = 1;
sensor.gps.covV = 0.1747;

%% Filter Noise Parameters
QuaternionNoise = [1e-06 1e-06 1e-06 1e-06];     % none
AngularVelocityNoise = [0.005 0.005 0.005];      % (rad/s)²
PositionNoise = [1e-06 1e-06 1e-06];             % m²
VelocityNoise = [1e-06 1e-06 1e-06];             % (m/s)²
AccelerationNoise = [50 50 50];                  % (m/s²)²
GyroscopeBiasNoise = [1e-10 1e-10 1e-10];        % (rad/s)²
AccelerometerBiasNoise = [0.0001 0.0001 0.0001]; % (m/s²)²
GeomagneticVectorNoise = [1e-06 1e-06 1e-06];    % uT²
MagnetometerBiasNoise = [0.1 0.1 0.1];           % uT²

sensor.noise.noise_state = zeros(28, 1);
sensor.noise.noise_state(1:4) = QuaternionNoise;
sensor.noise.noise_state(5:7) = AngularVelocityNoise;
sensor.noise.noise_state(8:10) = PositionNoise;
sensor.noise.noise_state(11:13) = VelocityNoise;
sensor.noise.noise_state(14:16) = AccelerationNoise;
sensor.noise.noise_state(17:19) = GyroscopeBiasNoise;
sensor.noise.noise_state(20:22) = AccelerometerBiasNoise;
sensor.noise.noise_state(23:25) = GeomagneticVectorNoise;
sensor.noise.noise_state(26:28) = MagnetometerBiasNoise;

%% Cleanup & Saving
save("Vehicle Parameters/PROCESSED_DATA\Sensor_Tables.mat","sensor");
clearvars -except sim