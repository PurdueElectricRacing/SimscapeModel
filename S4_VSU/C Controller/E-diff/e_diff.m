function [Tx, omega_m, error_wheelspeed_diff] = e_diff(BA, AP, Vx, Vy, yaw, theta)
%% INPUTS
% BA    - Maximum Regenerative Braking Power [W][1x1]
% AP    - Accelerator Pedal Position [Unitless][1x1]
% Vx    - Longitudinal Velocity CoG [m/s][1x1]
% Vy    - Lateral Velocity CoG [m/s][1x1]
% yaw   - Vehicle Body Yaw Rate z-axis [rad/s][1x1]
% theta - Angle of Steering Wheel [deg][1x1]

%% OUTPUTS
% Tx    - Torque Request for Rear Motors [Nm][1x2]

%% Constants
% Equation constants to get tire angles
S1 = 7 * (10^(-5));
S2 = -0.0038;
S3 = 0.6535;
S4 = 0.1061;

% Vehicle Physical Constants
% W and s constants are inconsistent. Confirm what actual value is. (also L)
W = 1.269; % [m]
L = 1.574; %[m]
s = [0.647895, 0.62102]; % Half track width [front rear][m]
r = 0.22; % Tire radius [m]
GR_r = (40/21) * (84/23) + 1; % Rear gear ratio [Unitless]
gr = [GR_r, GR_r]; % Gear ratios [Unitless]
max_torque = [25 25];
motor_efficiency = 0.85;
steer_slope = 0.00962; % [in/deg] 

% Conversion Values
inch2mm = 25.4; % [mm/in]
deg2rad = 0.01745329; % [rad/deg]

%% Parameters
k = 1;   % e-diff parameter
P = 10;  % control parameter, proportional

%% Compute
vehicle_speed = sqrt(Vx^2 + Vy^2);

rack_disp = steer_slope * inch2mm * theta;
left_steer_angle = -((S1*(-rack_disp)^3)+(S2*(-rack_disp)^2)+(S3*-rack_disp)+S4);
right_steer_angle = ((S1*(rack_disp)^3)+(S2*(rack_disp)^2)+(S3*rack_disp)+S4);

avg_steer_angle = ((left_steer_angle + right_steer_angle) / 2) * deg2rad;


%% Compute Tire Dynamics
V_rl = Vx + (yaw * s(2));
V_rr = Vx + (yaw * -s(2));

Vx_tires = [V_rl V_rr];
omega_m = Vx_tires .* (gr ./ r);

%% E-diff Equations
% E-diff
ground_speed_rl = vehicle_speed + vehicle_speed * W * tan(avg_steer_angle) / (2*L);
ground_speed_rr = vehicle_speed - vehicle_speed * W * tan(avg_steer_angle) / (2*L);

desired_wheelspeed_diff = (ground_speed_rl - ground_speed_rr) * k;
actual_wheelspeed_diff = Vx_tires(1) - Vx_tires(2);
error_wheelspeed_diff = desired_wheelspeed_diff - actual_wheelspeed_diff;

% This is pure proportional control
delta_torque = P * error_wheelspeed_diff;

if delta_torque > 50
    delta_torque = 50;
elseif delta_torque < -50
    delta_torque = -50;
end

%% Torque Limit Lookup Table Compute
% use omega_m_lookup & limits to make a lookup table
omega_m_lookup = 0:10:1000;

% Motor Shaft Speed, rpm
ang_vel_RPM = omega_m_lookup .* 9.5492965964254;

% quadratic constants that connect current and max RPM of motors
a_v = 0.2667;
b_v = -66.353;
c_v = 10452 - ang_vel_RPM;

% quadratic constants that connnect current and max torque of motors
a_t = -0.0987;
b_t = 45.799;
c_t = -129.65;

% maximum possible current at the current RPM
max_current = zeros(1, 101);

% calculate the maximum current possible at the current RPM
for i = 1:101
   if ang_vel_RPM(i) < 7000
       max_current(i) = 70;
   else
       max_current(i) = (-b_v - sqrt(b_v^2 - (4*a_v.*c_v(i)))) .* (1/(2*a_v));
   end
end

% calculate the maximum torque at the max current
rpm_limit = ((a_t .* (max_current.^2)) + (b_t .* max_current) + c_t) ./ 100;
for i = [1:101]
   if rpm_limit(i) < 0
      rpm_limit(i) = 0;
   end
end

motor_limit_power = 15000;
% If torque_limit_motor ever exceed 30, then the exact value is no longer
% needed. As in, the ceiling is 30
power_limit = (motor_limit_power .* motor_efficiency) ./ omega_m_lookup;

% Erase power limit solution above torque limit, for better data
% visualization
for i = 1:101
    if power_limit(i) > 25 
        power_limit(i) = 25;
    elseif power_limit(i) < -25 && omega_m_lookup(i) > 0
        power_limit(i) = -0.01; 
    elseif power_limit(i) < -25 && omega_m_lookup(i) < 0
        power_limit(i) = 25; 
    end
end

limits = min([rpm_limit; power_limit]);

%% Final Torque Computation
Tx_straight = max_torque .* AP;
Tx_limit = interp1(omega_m_lookup, limits, omega_m);

if AP >= 0
    TRL = min(Tx_straight(1), Tx_limit(1));
    TRR = min(Tx_straight(2), Tx_limit(2));
    torque_output = [TRL, TRR];
else
    TRL = max(Tx_straight(1), -Tx_limit(1));
    TRR = max(Tx_straight(2), -Tx_limit(2));
    torque_output = [TRL, TRR];
end

current_delta_torque = TRL - TRR;

error2 = abs(delta_torque) - abs(current_delta_torque);

if AP >= 0
    if error_wheelspeed_diff > 0
        torque_output(2) = torque_output(2) - error2;
    elseif error_wheelspeed_diff < 0
        torque_output(1) = torque_output(1) - error2;
    end
else
    if error_wheelspeed_diff > 0
        torque_output(2) = torque_output(2) + error2;
    elseif error_wheelspeed_diff < 0
        torque_output(1) = torque_output(1) + error2;
    end
end

%% Power Limiter
power_out = sum(torque_output .* omega_m) * motor_efficiency;
avg_omega_m = mean(omega_m);

if avg_omega_m < 85
    BA = 0;
end

if BA > power_out
   power_limiter = [0.5 0.5] .* (BA - power_out) ./ motor_efficiency;
else
    power_limiter = [0 0];
end

%% Compute Torque Request
Tx = torque_output + (power_limiter ./ avg_omega_m);