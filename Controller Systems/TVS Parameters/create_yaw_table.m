function [yaw_table, max_s_bp, max_v_bp] = create_yaw_table()

%% Definitions
% PCoGV - planar (x&y) center of gravity velocity
% CCSA  - center column steering angle

%% Import Data
load("raw_yaw_data.mat");

%% Parameters
dv = 0.5; % m/s    velocity breakpoint for yaw map
ds = 5; % deg      steering angle breakpoint for yaw map

%% Simulation Conditions & Data
steering_ref = ALL_SWEEP_DATA.ccw_steering(:,2);

num2 = sum(steering_ref == 0) / 2;
num3 = length(steering_ref) / num2;

%% Extract Raw Data
theta = Digital_Signals.Corner_Dynamics_Sensors.theta.Data;
yaw_rates = Driver_signals.r.Data;
xdot = Driver_signals.Vel.xdot.Data;
ydot = Driver_signals.Vel.ydot.Data;

%% Process Raw Data into Clean Data
end_positions = [find(counter == 0); length(counter)];  % indicies for the end of each PCoGV & CCSA setpoint
velocities = sqrt(xdot.^2 + ydot.^2);      % vehicle PCoGV (m/s)

num_data_not_collected = num3*num2 - length(end_positions);
yaw_rate_vector = [yaw_rates(end_positions); zeros(num_data_not_collected,1)];

yaw_rate = reshape(yaw_rate_vector, [num3 num2]);
yaw_rate = [yaw_rate zeros(28,1) zeros(28,1)];

velocity = reshape(velocities(end_positions), [num3 num2]);
velocity = [velocity zeros(28,1) 25*ones(28,1)];

steering = reshape(theta(end_positions), [num3 num2]);
steering = [steering steering(:,1) steering(:,1)];

%% Calculate All RAW Lookup Tables
limit_velocity = velocity(1,:);
limit_steering = steering(:,1);

max_v_bp = min(limit_velocity):dv:max(limit_velocity);
max_s_bp = min(limit_steering):ds:max(limit_steering);
[limit_velocity_grid, limit_steering_grid] = meshgrid(max_v_bp,max_s_bp);

% calculate overall lookup table
[xData, yData, zData] = prepareSurfaceData( velocity, steering, yaw_rate );
ft = 'linearinterp';
[fitresult3, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

yaw_table = feval(fitresult3, limit_velocity_grid,limit_steering_grid);

% the final table
yaw_table = [-flipud(yaw_table(2:end,:)); yaw_table]';
max_s_bp = [-fliplr(max_s_bp(2:end)) max_s_bp];

save("yaw_table_2_21_24.mat","max_s_bp","yaw_table","max_v_bp")

end