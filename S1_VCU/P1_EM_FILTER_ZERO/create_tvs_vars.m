function create_tvs_vars

% unused numbers
valid_s = 3;

% constants
epsilon = 0.0001;
half_track = [0.649 0.621]; % vehicle half track width for PER23 [front rear] (m)
MOTOR_ENABLE = [0 0 1 1];
I_FUSE = 150;
ts = 0.015;
XYZs = [0.12;8.49;5.01];

% Signal Ranges
Tb = [0 1];
phib = [-170 170];
Vb = [150 430];
Ib = [0 160];
wb = [0 1100];
xdb = [-30 30];
xddb = [-30 30];
psidb = [-2.5 2.5];
tmcb = [-50 130];
tmb = [-50 130];
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

% initial conditions
R_IC = c_compute_R(XYZs);
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
Tmo = linspace(-50,130,19);
Tmc = linspace(-50,130,19);
dIb = linspace(0,Ib(2),17);
k_PL = [2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 0 0];
k_TLmc = [2 2 2 2 2 2 2 2 2 2 2 2 0 0 0 0 0 0 0];
k_TLmo = [2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 0 0 0 0];

[v_sweep,w_sweep,minK_table] = create_minK_table();
V = v_sweep;
w = w_sweep;
minK = minK_table;

[~,~,maxK_table] = create_maxK_table(v_sweep,w_sweep);
maxK = maxK_table;
dK = maxK_table - minK_table;

[yaw_table, max_s_bp, max_v_bp] = create_yaw_table();
s = max_s_bp;
v = max_v_bp;

% Save Parameters
clear v_sweep w_sweep minK_table maxK_table max_s_bp max_v_bp voltages ... 
      RPM_Field_Weakening v_grid w_grid max_rpm
save("data/tvs_vars.mat")

end