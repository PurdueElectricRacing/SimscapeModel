function create_tvs_struct
% constants
tvs.const.s = [0.649 0.621]; % vehicle half track width for PER23 [front rear] (m)
tvs.const.MOTOR_ENABLE = [0 0 1 1];
tvs.const.I_FUSE = 150;
tvs.const.ts = 0.02;
tvs.const.XYZs = [0.12;8.49;5.01];

% Signal Ranges
tvs.range.T = [0 1];
tvs.range.phi = [-170 170];
tvs.range.V = [150 430];
tvs.range.I = [-5 160];
tvs.range.w = [-20 1100];
tvs.range.xd = [-30 30];
tvs.range.xdd = [-30 30];
tvs.range.psid = [-2.5 2.5];
tvs.range.tmc = [-40 120];
tvs.range.tm = [-40 120];
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


% initial conditions
tvs.ic.R = c_compute_R(tvs.const.XYZs);

% Tunable Parameters
tvs.tune.P = 0.5;
tvs.tune.r_power_sat = 0.5;
tvs.tune.nI = 20;
tvs.tune.nF = 6;

% Tables
tvs.bp.Tmo = linspace(round(tvs.range.tm(1)-10),round(tvs.range.tm(2)+10),19);
tvs.bp.Tmc = linspace(round(tvs.range.tmc(1)-10),round(tvs.range.tmc(2)+10),19);
tvs.bp.dIb = linspace(0,tvs.range.I(2),17);
tvs.tbl.k_PL = [2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 0 0];
tvs.tbl.k_TLmc = [2 2 2 2 2 2 2 2 2 2 2 2 0 0 0 0 0 0 0];
tvs.tbl.k_TLmo = [2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 0 0 0 0];

[v_sweep,w_sweep,minK_table] = create_minK_table();
tvs.bp.V = v_sweep;
tvs.bp.w = w_sweep;
tvs.tbl.k_min = minK_table;

[~,~,maxK_table] = create_maxK_table(v_sweep,w_sweep);
tvs.tbl.k_max = maxK_table;
tvs.tbl.dk = maxK_table - minK_table;

[yaw_table, max_s_bp, max_v_bp] = create_yaw_table();
tvs.bp.s = max_s_bp;
tvs.bp.v = max_v_bp;
tvs.tbl.yaw_table = yaw_table;

% Save Parameters
save("data/tvs_parameters.mat","tvs")

end