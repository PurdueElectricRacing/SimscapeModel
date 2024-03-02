function create_tvs_parameters

% unused numbers
tvs.const.valid_s = 3;

% constants
tvs.const.epsilon = 0.0001;
tvs.const.s = [0.649 0.621]; % vehicle half track width for PER23 [front rear] (m)
tvs.const.MOTOR_ENABLE = [0 0 1 1];
tvs.const.I_FUSE = 125;
tvs.const.ts = 0.015;
tvs.const.XYZs = [0.12;8.49;5.01];

% initial conditions
tvs.ic.R = compute_axis_transformation(tvs.const.XYZs);
tvs.ic.FINISHED_SMOOTHENING = 1;
tvs.ic.LAST_TVS_PERMIT = 0;
tvs.ic.k = [0 0];

% Tunable Parameters
tvs.tune.P = 0.5;
tvs.tune.r_power_sat = 0.5;
tvs.tune.nI = 20;
tvs.tune.nF = 6;

% Tables
tvs.bp.Tmo = [90 100];
tvs.bp.Tmc = [55 75];
tvs.bp.dIb = [-5 0];
tvs.tbl.k_PL = [0 1];
tvs.tbl.k_TL = [1 0];

[v_sweep,w_sweep,minK_table] = create_minK_table();
tvs.bp.V = v_sweep;
tvs.bp.w = w_sweep;
tvs.tbl.k_min = minK_table;

[~,~,maxK_table] = create_maxK_table_BACKUP(minK_table);
tvs.tbl.k_max = maxK_table;
tvs.tbl.dk = maxK_table - minK_table;

[yaw_table, max_s_bp, max_v_bp] = create_yaw_table();
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
    tvs.range.w(1)*[1 1] tvs.range.xd(1)*[1 1 1] ...
    tvs.range.psid(1)*[1 1 1] tvs.range.I(1) tvs.range.tmc(1)*[1 1] ...
    tvs.range.tm(1)*[1 1] tvs.range.xdd(1)*[1 1 1]];

tvs.range.ub = [tvs.range.T(2) tvs.range.phi(2) tvs.range.V(2) ... 
    tvs.range.w(2)*[1 1] tvs.range.xd(2)*[1 1 1] ...
    tvs.range.psid(2)*[1 1 1] tvs.range.I(2) tvs.range.tmc(2)*[1 1] ...
    tvs.range.tm(2)*[1 1] tvs.range.xdd(2)*[1 1 1]];

% Save Parameters
save("tvs_parameters.mat","tvs")

end