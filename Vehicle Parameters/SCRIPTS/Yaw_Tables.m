%% Definitions
% PCoGV - planar (x&y) center of gravity velocity
% CCSA  - center column steering angle
% TOY   - time optimal yaw

%% Startup
% clearvars -except sim
load("PROCESSED_DATA\Sweep_Tables.mat");
% load("PROCESSED_DATA\Yaw_Sweep_Data.mat");

Digital_Signals = out_18in.Digital_Signals;
Driver_Signals = out_18in.Driver_Signals;
counter = out_18in.Sweep_Generator.counter.Data;

%% Parameters
max_steering_vel = 22; % m/s
dv = 0.5; % m/s    velocity breakpoint for yaw map
ds = 5; % deg      steering angle breakpoint for yaw map
dy = 0.05; % rad/s yaw rate breakpoint for max yaw map
n = 3;

%% Simulation Conditions & Data
steering_ref = ALL_SWEEP_DATA.ccw_steering(:,2);

num2 = sum(steering_ref == 0) / 2;
num3 = length(steering_ref) / num2;

velocity_grid = reshape(ALL_SWEEP_DATA.ccw_steering(:,1), [num3 num2]);
yaw_rate_grid = reshape(ALL_SWEEP_DATA.ccw_steering(:,2), [num3 num2]);

%% Extract Raw Data
theta = Digital_Signals.Corner_Dynamics_Sensors.theta.Data;
omega_m = Driver_Signals.Omega.Data;
yaw_rates = Driver_Signals.r.Data;
xdot = Driver_Signals.Vel.xdot.Data;
ydot = Driver_Signals.Vel.ydot.Data;

battery_I = Digital_Signals.Power_Sensors.batt_I.Data;
battery_V = Digital_Signals.Power_Sensors.batt_V.Data;

%% Process Raw Data into Clean Data
end_positions = [find(counter == 0); length(counter)];  % indicies for the end of each PCoGV & CCSA setpoint
omega_mean = mean([omega_m(:,3) omega_m(:,4)], 2); % mean rear tires angular velocity (rad/s)
velocities = sqrt(xdot.^2 + ydot.^2);      % vehicle PCoGV (m/s)

num_data_not_collected = num3*num2 - length(end_positions);
yaw_rate_vector = [yaw_rates(end_positions); zeros(num_data_not_collected,1)];

yaw_rate = reshape(yaw_rate_vector, [num3 num2]);
% velocity = reshape(velocities(end_positions), [num3 num2]);
velocity = reshape(sim.top_parameters.selected_sweep(:,1),[num3 num2]);
% steering = reshape(theta(end_positions), [num3 num2]);
steering = reshape(sim.top_parameters.selected_sweep(:,2),[num3 num2]);
% power_IN = reshape(battery_I(end_positions) .* battery_V(end_positions), [num3 num2]);

%% Calculate All RAW Lookup Tables
[max_yaw_v, ~] = max(yaw_rate);
[max_yaw_s, ~] = max(yaw_rate,[],2);
limit_velocity = velocity(1,:);
limit_steering = steering(:,1);

max_v_bp = min(limit_velocity):dv:max(limit_velocity);
max_v_bp2 = max_v_bp(n:end);
max_s_bp = min(limit_steering):ds:max(limit_steering);
max_y_bp = min(yaw_rate(:)):dy:max(yaw_rate(:));
[limit_velocity_grid, limit_steering_grid] = meshgrid(max_v_bp,max_s_bp);
[limit_velocity_grid2, limit_yaw_rate_grid] = meshgrid(max_v_bp,max_y_bp);

% calculate max allow yaw rate given velocity
[xData, yData] = prepareCurveData( limit_velocity, max_yaw_v );
ft = 'pchipinterp';
[fitresult1, gof] = fit( xData, yData, ft, 'Normalize', 'on' );

% calculate max allowed steering angle given max allowed yaw rate
[xData, yData] = prepareCurveData( max_yaw_s, limit_steering );
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.99999;
[fitresult2, gof] = fit( xData, yData, ft, opts );

% calculate overall lookup table
[xData, yData, zData] = prepareSurfaceData( velocity, steering, yaw_rate );
ft = 'linearinterp';
[fitresult3, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

%% Minimum Turning Radius
max_yaw_table = feval(fitresult1, max_v_bp);
max_theta_table = feval(fitresult2, max_yaw_table);
max_yaw_table_ref = feval(fitresult3, limit_velocity_grid,limit_steering_grid);

[max_theta, max_theta_idx] = max(max_theta_table);
critical_velocity = max_v_bp(max_theta_idx);
critical_radius = max_v_bp(n:end) ./ max_yaw_table(n:end)';

max_steering = (ones(1,length(max_v_bp)).*sim.range.CENTER_STEER_ANGLE_MAX).*(max_v_bp < critical_velocity);
normal_steering = max_theta_table' .* (max_v_bp >= critical_velocity);

max_theta_table = min(sim.range.CENTER_STEER_ANGLE_MAX,max_steering + normal_steering);

yaw_rate_table = max_yaw_table_ref.*((gradient(max_yaw_table_ref) >= 0) & (limit_velocity_grid < max_steering_vel));
yaw_rate_table(yaw_rate_table==0) = nan;

[xData, yData, zData] = prepareSurfaceData( limit_velocity_grid, yaw_rate_table, limit_steering_grid );
ft = 'linearinterp';
[fitresult4, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

[xData, yData] = prepareCurveData( critical_radius, max_v_bp2 );
ft = 'pchipinterp';
[fitresult5, gof] = fit( xData, yData, ft, 'Normalize', 'on' );

steering_angle_table = feval(fitresult4, limit_velocity_grid2, limit_yaw_rate_grid);
steering_angle_table(1,:) = 0;

%% Populate TVS & Driver Structs with Yaw Data
tvs.yaw_control.max_v_bp = max_v_bp;
tvs.yaw_control.max_s_bp = max_s_bp;
tvs.yaw_control.max_yaw_table_ref = max_yaw_table_ref;

driver.control.max_v_bp = max_v_bp;
driver.control.max_s_bp = max_s_bp;
driver.control.max_y_bp = max_y_bp;
driver.control.steering_angle_table = steering_angle_table;
driver.control.max_yaw_table = max_yaw_table;
driver.control.max_theta_table = max_theta_table;

%% Power Control Law
tvs.power_control.dTx = 0.01; % Nm
tvs.power_control.min_velocity_regen = 1.4; % m/s

tvs.power_control.ABS_MIN_TORQUE = [0 0 0 0]; % Nm
tvs.power_control.ABS_MAX_TORQUE = [25 25 25 25]; % Nm
tvs.power_control.ABS_MAX_TRQ_CMD = dot(tvs.power_control.ABS_MAX_TORQUE, sim.top_parameters.MOTOR_ENABLE);
tvs.power_control.ABS_MIN_TRQ_CMD = dot(tvs.power_control.ABS_MIN_TORQUE, sim.top_parameters.MOTOR_ENABLE);

MOTOR_CURRENT_LIMIT = [55 55 55 55]; % A
tvs.power_control.ABS_MAX_I_FLOW = dot(MOTOR_CURRENT_LIMIT, sim.top_parameters.MOTOR_ENABLE);

dT_motor = 25; % degC
dT_motor_controller = 50; % degC

ABS_MAX_MOTOR_I = dot(sim.top_parameters.MOTOR_ENABLE,sim.range.MOTOR_CURRENT_MAX.*ones(1,4));
ABS_MAX_MOTOR_CONTROLLER_I = dot(sim.top_parameters.MOTOR_ENABLE,sim.range.MOTOR_CONTROLLER_CURRENT_MAX.*ones(1,4));

tvs.power_control.motor_controller_t_bp = [sim.range.MOTOR_CONTROLLER_TEMPERATURE_MAX-dT_motor_controller sim.range.MOTOR_CONTROLLER_TEMPERATURE_MAX];
tvs.power_control.motor_controller_I_table = [ABS_MAX_MOTOR_CONTROLLER_I 0];

tvs.power_control.motor_t_bp = [sim.range.MOTOR_TEMPERATURE_MAX-dT_motor sim.range.MOTOR_TEMPERATURE_MAX];
tvs.power_control.motor_I_table = [ABS_MAX_MOTOR_I 0];

%% Yaw Control Law
tvs.yaw_control.dy = 0.2; % rad/s^2
tvs.yaw_control.torque_sat_const = 0.5;
tvs.yaw_control.dB = 0.001; % rad/s^2

tvs.yaw_control.ang_acc_hystersesis = 0.1; % rad/s^2
tvs.yaw_control.yaw_filter = 0.1;

tvs.yaw_control.deadband_angle = 12;
tvs.yaw_control.TVS_Intensity = 1;
tvs.yaw_control.P = 20;
tvs.yaw_control.I = 0;

%% Traction Control Law
tvs.traction_control.Vth = 2; % m/s
tvs.traction_control.low_V_SA = 0.001; % rad

%% Torque Control Law
wc = 0; % rad/s
wm = 675; % rad/s
wf = 1150; % rad/s
dK = 0.025;

tvs.torque_control.omega_bp = [wc wm wf]; % rad/s
k_linear_bp = 0.05:0.05:0.95;

k_actual_1 = zeros(1,length(k_linear_bp));
k_actual_2 = ((wm/wf).*(1-k_linear_bp)) + k_linear_bp;
k_actual_3 = ones(1,length(k_linear_bp));

k_actual = [k_actual_1; k_actual_2; k_actual_3];
tvs.torque_control.k_actual = [[0; 0; 0;],[0; 0; 0;],k_actual,[1; 1; 1],[1; 1; 1]];
tvs.torque_control.k_linear_bp = [0 dK k_linear_bp 1-dK 1];

%% Driver Model
driver.control.pressure_filter = 0.05;
driver.control.brake_gain = 5;
driver.control.P_Driver = 1;
driver.control.P_Steering_Adjust = 5;
driver.control.P_High_Speed = 0.5;
driver.control.P_Straight_Adjust = 15;
driver.control.axb = -5;     % m/s^2 Braking decceleration
driver.control.dt_ON = 7.5;  % time (s) that each data point is active
driver.control.dt_OFF = 4.5; % time (s) between different velocities for vehicle recovery

% indicies denoting each quadrant, and .5 denoting axis CCW starting from +Y axis
driver.vision.indicies = [3 3.5 4 0.5 1 1.5 2 2.5 3 3.5 4 0.5 1 1.5 2 2.5 3 3.5 4 0.5 1 1.5 2 2.5 3 3.5 4];
driver.vision.dIndex = 50;                % number of future track points
driver.vision.q_thresh = 0.01;            % threshhold between quadrants in cartesian plane
driver.vision.dx = 0.1;                   % distance between 2 track points

%% Cleaning up & Saving
% save("Vehicle Parameters/PROCESSED_DATA\TVS_Tables.mat", "tvs");
% save("Vehicle Parameters/PROCESSED_DATA\Driver_Tables.mat", "driver");
% save("Vehicle Parameters/PROCESSED_DATA\Yaw_Tables.mat", "fitresult5");
% 
% clearvars -except sim

%% Data Viewing
% scatter3(limit_velocity_grid,limit_steering_grid,max_yaw_table_ref)
% scatter3(max_yaw_bp,max_theta_table,max_yaw_table);hold on;scatter3(velocity(:), steering(:), yaw_rate(:))
% scatter3(velocity(:), steering(:), yaw_rate_TOY(:))
% scatter3(velocity(:), steering(:), TOY_error(:))
% scatter3(velocity(:), steering(:), TOY_correction_table(:))

% xlabel("Velocity (m/s)")
% ylabel("Steeting Angle (deg)")
% zlabel("Yaw Rate (rad/s)")

% xlabel("Planar CoG Velocity (m/s)")
% ylabel("Center Column Steering Angle (deg)")
% zlabel("Planar Vehicle Yaw Rate (rad/s)")

% scatter3(velocity(:), steering(:), power_IN(:))
% scatter3(velocity(:), steering(:), power_OUT(:))
% xlabel("Planar CoG Velocity (m/s)")
% ylabel("Center Column Steering Angle (deg)")
% zlabel("Battery Output Power (W)")

% scatter3(velocity(:), steering(:), vehicle_e(:))
% scatter3(velocity(:), steering(:), radius(:))
% hold on
% scatter3(velocity(:), steering(:), skidpad_radius(:)
