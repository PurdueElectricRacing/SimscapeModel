function load_tvs_MAX_SIMPLE

% constants
tvs.const.epsilon = 0.0001;
tvs.const.s = [0.649 0.621]; % vehicle half track width for PER23 [front rear] (m)
tvs.const.MOTOR_ENABLE = [0 0 1 1];
tvs.const.valid_s = 3;

% initial conditions
tvs.ic.R = eye(3);
tvs.ic.FINISHED_SMOOTHENING = 1;
tvs.ic.LAST_TVS_PERMIT = 0;
tvs.ic.k = [0 0];

% Tunable Parameters
tvs.tune.P = 1;
tvs.tune.r_power_sat = 0.5;
tvs.tune.nI = 20;
tvs.tune.nF = 6;

% Tables
tvs.bp.Tm = [75 100]; % skipped
tvs.bp.Tmc = [50 75]; % skipped
tvs.bp.dIb = [0 5]; % skipped
tvs.tbl.k_PL = [0 1]; % skipped

[v_sweep,w_sweep,minK_table] = create_minK_table();
tvs.bp.V = v_sweep;
tvs.bp.w = w_sweep;
tvs.tbl.k_grid_min = minK_table;

% [~,~,maxK_table] = create_maxK_table(minK_table);
% tvs.tbl.maxK_table = maxK_table;
% tvs.tbl.dK_table = maxK_table - minK_table;

load yaw_table_2_21_24.mat
tvs.bp.s = max_s_bp;
tvs.bp.v = max_v_bp;
tvs.tbl.yaw_table = yaw_table;

% Signal Ranges
tvs.range.T = [0 1];
tvs.range.phi = [-130 130];
tvs.range.V = [150 430];
tvs.range.I = [0 125];
tvs.range.w = [0 1100];
tvs.range.xd = [-30 30];
tvs.range.xdd = [-30 30];
tvs.range.psid = [-2.5 2.5];
tvs.range.tmc = [0 100];
tvs.range.tm = [0 125];
tvs.range.r = [0 1];
tvs.range.PL = sum(tvs.const.MOTOR_ENABLE*tvs.range.r(2));

tvs.range.lb = [tvs.range.T(1) tvs.range.phi(1) tvs.range.V(1) ... 
    tvs.range.I(1) tvs.range.w(1) tvs.range.xd(1) tvs.range.xdd(1) ...
    tvs.range.psid(1) tvs.range.tmc(1) tvs.range.tm(1)];

tvs.range.ub = [tvs.range.T(2) tvs.range.phi(2) tvs.range.V(2) ... 
    tvs.range.I(2) tvs.range.w(2) tvs.range.xd(2) tvs.range.xdd(2) ...
    tvs.range.psid(2) tvs.range.tmc(2) tvs.range.tm(2)];

% Save Parameters
save("tvs_parameters.mat","tvs")

end