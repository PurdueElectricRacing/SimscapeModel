function tvs = load_tvs_MAX_SIMPLE()
% skipped numbers: tvs.bounds.ub,tvs.bounds.lb,gain in outer Block Diagram

% Estimation (need two layers!)
tvs.estimation.nT = 149;
tvs.estimation.nW = 10;
tvs.estimation.nI = 20;
tvs.estimation.nF = 6;
tvs.estimation.valid_s = 3;

% Initial Conditions
tvs.IC.R = eye(3);
tvs.IC.LAST_TVS_PERMIT = 0;
tvs.IC.FINISHED_SMOOTHENING = 1;
tvs.IC.k = [0 0];
tvs.IC.ID = zeros(25,1);

% Range
tvs.range.I = [-1 75]; % skipped
tvs.range.K = [0 1]; % skipped
tvs.range.Tm = [0 100]; % skipped
tvs.range.Tmc = [0 75]; % skipped

tvs.bounds.ub = []; % skipped
tvs.bounds.lb = []; % skipped

% throttle map
[v_sweep,w_sweep,minK_table] = create_minK_table();
tvs.bp.V = v_sweep;
tvs.bp.w = w_sweep;
tvs.power_control.k_grid_min = minK_table;

[~,~,maxK_table] = create_maxK_table(minK_table);
tvs.power_control.maxK_table = maxK_table;
tvs.power_control.dK_table = maxK_table - minK_table;

% miscelaneous
tvs.misc.epsilon = 0.0001;

% TVS Controller Parameters
tvs.yaw_control.power_sat_const = 0.5;
tvs.power_control.ABS_MAX_POWER_RATIO = [1 1 1 1];
tvs.power_control.ABS_MAX_POWER_LEVEL = []; % skipped
tvs.yaw_control.P = 1;
tvs.yaw_control.geometry.s = []; % skipped
tvs.power_control.MOTOR_ENABLE = [0 0 1 1];

% Yaw Tables
tvs.yaw_control.yaw_table = [-flipud(tvs.yaw_control.max_yaw_table_ref(2:end,1:34)); tvs.yaw_control.max_yaw_table_ref(:,1:34)]';
tvs.yaw_control.max_v_bp = tvs.yaw_control.max_v_bp(1:34);
tvs.yaw_control.max_s_bp = [-fliplr(tvs.yaw_control.max_s_bp(2:end)) tvs.yaw_control.max_s_bp];

% Power Tables
tvs.bp.Tm = [75 100]; % skipped
tvs.bp.Tmc = [50 75]; % skipped
tvs.bp.Ib = [0 5]; % skipped
tvs.power_control.K = [0 1]; % skipped

end