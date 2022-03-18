%% Control
P=10; % Proportional gain for PI controller 
I=0; % Integral gain for PI controller
T=0; % Control signal feedback gain

%% Constants
g = Simulink.Parameter(9.81); % Acceleration due to gravity [1x1][m/s^2]
t = Simulink.Parameter(0.015); % Controller timing [1x1][s]
m = Simulink.Parameter(308); % Vehicle + driver mass [kg]
RE = Simulink.Parameter(0.2228169203); % Effective Tire Radius [1x1][m]
s = Simulink.Parameter([0.647895, 0.62102]); % Half track width [front rear][m]
l = Simulink.Parameter([0.7922471, 0.7828529]); % Wheelbase [front rear][m]
gr = Simulink.Parameter([6.63043, 6.63043, 7.95652, 7.95652]); % Gearbox gear ratio [1x4][unitless]
motor_limit_torque = Simulink.Parameter([-25, 25]); % max & min motor torque [1x2][Nm]
motor_limit_power = Simulink.Parameter([15000, 15000, 15000, 15000]); % Max per motor power [1x4][W]
motor_efficiency = Simulink.Parameter([0.85, 0.85, 0.85, 0.85]); % Power efficiency of motor [1x4][unitless]
gearbox_efficiency = Simulink.Parameter([0.97 0.97 0.97 0.97]); % Power efficiency of gearbox [1x4][unitless]
J_z = Simulink.Parameter(75); % Polar mass moment of inertia about z-axis [1x1][kg m^2]
min_speed_regen = Simulink.Parameter(85); % Minimum speed required for regen braking [1x1][rad/s]

%% Tunable Parameters
tire_mu = Simulink.Parameter(1.65); % Friction coefficient for max allowed yaw [1x1][unitless]
tau = Simulink.Parameter(0.1); % Motor response time constant [1x1][1/s]
c_factor = Simulink.Parameter(0.8); % Yaw contribution to lateral acceleration [1x1][unitless]
k_limit = Simulink.Parameter(3.4); % Combined slip at peak combined tire forces [1x1][unitless]
mu_factor = Simulink.Parameter(2/3); % Ratio of forces seen at calspan vs. actual condition [1x1][unitless]
yaw_factor = Simulink.Parameter(1); % Factor to control yaw magnitude [1x1][unitless]
K_u = Simulink.Parameter(0.075); % Understeer gradient [1x1]

%% Braking
disk_diameter = Simulink.Parameter([0.1,0.1,0.1,0.1]); % Diameter of brake disk [1x1][m]
brakeforce_max = Simulink.Parameter([250,250,250,250]); % Max force from the brake pads [1x4][N]
brakepad_mu = Simulink.Parameter([0.5,0.5,0.5,0.5]); % Friction for brakes [1x4][unitless]
mech_brake = Simulink.Parameter(-0.5); % The value of driver_input where mechanical braking begins [unitless]

%% Tire Models
% kx model
A1 = Simulink.Parameter(0);
A2 = Simulink.Parameter(50.76);
A3 = Simulink.Parameter(1526);

% mu_x model
B1 = Simulink.Parameter(-0.0000004726);
B2 = Simulink.Parameter(0.001047);
B3 = Simulink.Parameter(1.855);

% mu_y model
C1 = Simulink.Parameter(-0.000000002582);
C2 = Simulink.Parameter(0.000005639);
C3 = Simulink.Parameter(-0.00423);
C4 = Simulink.Parameter(3.658);

% Non Dimensional Model
a = Simulink.Parameter(1.136);
b = Simulink.Parameter(-0.03333);
c = Simulink.Parameter(-1.136);
d = Simulink.Parameter(-1.032);
