%% Control
P=1; % Proportional gain for PI controller 
I=15; % Integral gain for PI controller
T=0; % Control signal feedback gain
mu_factor = Simulink.Parameter(0.7); % Ratio of forces seen at calspan vs. actual condition [1x1][unitless]

%% Constants
g = Simulink.Parameter(9.81); % Acceleration due to gravity [1x1][m/s^2]
t = Simulink.Parameter(0.015); % Controller timing [1x1][s]
RE = Simulink.Parameter(0.2228169203); % Effective Tire Radius [1x1][m]
s = Simulink.Parameter([0.647895, 0.62102]); % Half track width [front rear][m]
l = Simulink.Parameter([0.7922471, 0.7828529]); % Wheelbase [front rear][m]
motor_limit_torque = Simulink.Parameter([-25, 25]); % max & min motor torque [1x2][Nm]
motor_efficiency = Simulink.Parameter([0.9, 0.9, 0.9, 0.9]); % Power efficiency of motor [1x4][unitless]
gearbox_efficiency = Simulink.Parameter([0.97 0.97 0.97 0.97]); % Power efficiency of gearbox [1x4][unitless]
J_z = Simulink.Parameter(75); % Polar mass moment of inertia about z-axis [1x1][kg m^2]
max_motor_temp = 75; % Temperature at which only continuous power is allowed [C]
max_regen_limit = -60000;
yaw_error_limit = 0.2;
rpm_index_calibration = 10.4719755;
min_velocity_regen = Simulink.Parameter(1.4); % Minimum speed required for regen braking [1x1][m/s]
absolute_batter_power_limit = Simulink.Parameter(75000);
deadband_velocity = Simulink.Parameter(0.5);
T2F = Simulink.Parameter(single([4.385 4.385 4.385 4.385]));
Vth = Simulink.Parameter(2); % Velocity Threshhold for Slip Ratio [m/s]
inch2mm = Simulink.Parameter(25.4); % [mm/in]
deg2rad = Simulink.Parameter(0.01745329); % [rad/deg]


%% Tunable Parameters
tau = Simulink.Parameter(0); % Motor response time constant [1x1][1/s]
k_limit = Simulink.Parameter(3.461); % Combined slip at peak combined tire forces [1x1][unitless]
time_delay = 0.022; % Time delay between sensor input and Motor SS [1x1][s]
dTx = 0.01; % differential torque to accomodate microcontroller stuff [Nm]
ramp_rate = 1; % Scaling coefficient for steering_angle [1x1][unitless]
steering_freq = pi; % Frequency of steering input for sinusoid [1x1][rad/s]
Ku = Simulink.Parameter(0.24 / g.Value); % Understeer Gradient of the Vehicle [1x1][]
V_target = Simulink.Parameter([0 3 6 9 12 15 18 21 25 31]);
max_yaw_field = Simulink.Parameter([1.34 1.34 1.34 1.66 1.14 1.24 0.754 0.849 0.85 0.85]);
SL_limit = Simulink.Parameter(0.3);
Fx_limit = [500 500];

power_loss_limit = Simulink.Parameter([0, 0, 5800, 5800]); % Max per motor power loss [1x4][W]
distance_traveled = 75; % distance vehicle must travel in x direaction [m]
initial_velocity = 15; % initial longitudinal velocity [m/s]
final_velocity = 15; % velocity that should be reached at the ending distance [m/s]
gr = Simulink.Parameter([6.63043, 6.63043, 8, 8]); % Gearbox gear ratio [1x4][unitless]

%% Braking
brakecoeff = Simulink.Parameter([((1.23*25.4/2)^2 * pi * 2) * (0.4) * (0.1), ((1.23*25.4/2)^2 * pi * 2) * (0.4) * (0.1), ((1*25.4/2)^2 * pi * 2) * (0.4) * (0.1), ((1*25.4/2)^2 * pi * 2) * (0.4) * (0.1)]); % coefficient for brake torques [1x2][Nm/MPa]
mech_brake = Simulink.Parameter(-0.5); % The value of driver_input where mechanical braking begins [unitless]

%% Steering Model
steer_slope = Simulink.Parameter(0.0111); % [in/deg] 

S1 = Simulink.Parameter(7 * (10^(-5)));
S2 = Simulink.Parameter(-0.0038);
S3 = Simulink.Parameter(0.6535);
S4 = Simulink.Parameter(0.1061);

%% Tire Models
% kx model
A1 = Simulink.Parameter(39.8344);
A2 = Simulink.Parameter(813.0780);

% mu_x model
B1 = Simulink.Parameter(0.000001287);
B2 = Simulink.Parameter(-0.002325);
B3 = Simulink.Parameter(3.797);

% mu_y model
C1 = Simulink.Parameter(-0.000000002541);
C2 = Simulink.Parameter(0.000005279);
C3 = Simulink.Parameter(-0.003943);
C4 = Simulink.Parameter(3.634);

% C model
FZ_C = Simulink.Parameter([0 204.13 427.04 668.1 895.72 1124.40 1324.40]);
C_param = Simulink.Parameter([0 13757.41 21278.97 26666.02 30253.47 30313.18 30313.18]);

% Non Dimensional Model
a = Simulink.Parameter(1.14);
b = Simulink.Parameter(-0.03291);
c = Simulink.Parameter(-1.14);
d = Simulink.Parameter(-1.027);

