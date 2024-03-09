function create_tvs_vars

% unused numbers
valid_s = 3;

% constants
epsilon = 0.0001;
half_track = [0.649 0.621]; % vehicle half track width for PER23 [front rear] (m)
MOTOR_ENABLE = [0 0 1 1];
I_FUSE = 125;
ts = 0.015;
XYZs = [0.12;8.49;5.01];

% initial conditions
R_IC = compute_axis_transformation(XYZs);
FINISHED_SMOOTHENING_IC = 1;
LAST_TVS_PERMIT_IC = 0;
k_IC = [0 0];

% Tunable Parameters
P = 0.5;
r_power_sat = 0.5;
nI = 20;
nF = 6;
alpha = 0.1; % easing function coeffficient
dk_thresh = .05; % how close signals should be to stop smoothing

% Tables
Tmo = [90 100];
Tmc = [55 75];
dIb = [-5 0];
k_PL = [0 1];
k_TL = [1 0];

[v_sweep,w_sweep,minK_table] = create_minK_table();
V = v_sweep;
w = w_sweep;
minK = minK_table;

[~,~,maxK_table] = create_maxK_table_v2(minK_table,v_sweep,w_sweep);
maxK = maxK_table;
dK = maxK_table - minK_table;

[yaw_table, max_s_bp, max_v_bp] = create_yaw_table();
s = max_s_bp;
v = max_v_bp;

% Signal Ranges
Tb = [0 1];
phib = [-130 130];
Vb = [150 430];
Ib = [0 125];
wb = [0 1100];
xdb = [-30 30];
xddb = [-30 30];
psidb = [-2.5 2.5];
tmcb = [0 100];
tmb = [0 125];
rb = [0 1];
PLb = sum(MOTOR_ENABLE*rb(2));

lb = [Tb(1) phib(1) Vb(1) ... 
    wb(1)*[1 1] xdb(1)*[1 1 1] ...
    psidb(1)*[1 1 1] Ib(1) tmcb(1)*[1 1] ...
    tmb(1)*[1 1] xddb(1)*[1 1 1]];

ub = [Tb(2) phib(2) Vb(2) ... 
    wb(2)*[1 1] xdb(2)*[1 1 1] ...
    psidb(2)*[1 1 1] Ib(2) tmcb(2)*[1 1] ...
    tmb(2)*[1 1] xddb(2)*[1 1 1]];

% Save Parameters
clear v_sweep w_sweep minK_table maxK_table max_s_bp max_v_bp
save("tvs_vars.mat")

end