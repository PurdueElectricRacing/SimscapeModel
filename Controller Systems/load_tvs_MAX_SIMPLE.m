function tvs = load_tvs_MAX_SIMPLE()

% Set 2WD or 4WD
tvs.top_parameters.MOTOR_ENABLE = [0 0 1 1];

% set signal ranges
tvs.range.I = [-1 75];
tvs.range.K = [0 1];
tvs.range.Tm = [0 100];
tvs.range.Tmc = [0 75];

% Define Power Control Lookup Tabls
tvs.bp.Tm = [75 100];
tvs.bp.Tmc = [50 75];
tvs.bp.
tvs.power_control.K = [0 1];

% Create min K table
[v_sweep,w_sweep,minK_table] = create_minK_table();
tvs.bp.V = v_sweep;
tvs.bp.w = w_sweep;
tvs.power_control.k_grid_min = minK_table;

% Create max K table
[~,~,maxK_table] = create_maxK_table(minK_table);
tvs.power_control.maxK_table = maxK_table;

% Create Power Control Lookup Tables
dT_motor = 25; % degC
dT_motor_controller = 50; % degC


tvs.power_control.[tvs.power_control.ABS_MAX_POWER_LEVEL 0];
[0 tvs.power_control.ABS_MAX_POWER_LEVEL];


% TVS Controller Parameters
tvs.yaw_control.power_sat_const = 0.5;
tvs.power_control.ABS_MAX_POWER = 1;




tvs.yaw_control.geometry.s = [];
tvs.yaw_control.P = 1;


tvs.yaw_control.yaw_table = [-flipud(tvs.yaw_control.max_yaw_table_ref(2:end,1:34)); tvs.yaw_control.max_yaw_table_ref(:,1:34)]';
tvs.yaw_control.max_v_bp = tvs.yaw_control.max_v_bp(1:34);
tvs.yaw_control.max_s_bp = [-fliplr(tvs.yaw_control.max_s_bp(2:end)) tvs.yaw_control.max_s_bp];



ABS_MAX_MOTOR_I = dot(tvs.top_parameters.MOTOR_ENABLE,tvs.range.MOTOR_CURRENT_MAX.*ones(1,4));
ABS_MAX_MOTOR_CONTROLLER_I = dot(sim.top_parameters.MOTOR_ENABLE,sim.range.MOTOR_CONTROLLER_CURRENT_MAX.*ones(1,4));

tvs.power_control.motor_controller_t_bp = [sim.range.MOTOR_CONTROLLER_TEMPERATURE_MAX-dT_motor_controller sim.range.MOTOR_CONTROLLER_TEMPERATURE_MAX];
tvs.power_control.motor_controller_I_table = [ABS_MAX_MOTOR_CONTROLLER_I 0];

tvs.power_control.motor_t_bp = [sim.range.MOTOR_TEMPERATURE_MAX-dT_motor sim.range.MOTOR_TEMPERATURE_MAX];
tvs.power_control.motor_I_table = [ABS_MAX_MOTOR_I 0];

[0 5];


tvs.bounds.ub = [];
tvs.bounds.lb = [];

tvs.IC.Ri = eye(3);
tvs.IC.ID = zeros(25,1);


tvs.misc.epsilon = 0.0001;

tvs.enable_windown_length = 6;



tvs.power_control.ABS_MAX_POWER_RATIO = [1 1 1 1];
tvs.power_control.ABS_MAX_POWER_LEVEL = dot(tvs.power_control.ABS_MAX_POWER_RATIO, tvs.top_parameters.MOTOR_ENABLE);
tvs.power_control.ABS_MIN_POWER_LEVEL = dot(tvs.power_control.ABS_MIN_POWER_RATIO, tvs.top_parameters.MOTOR_ENABLE);




end