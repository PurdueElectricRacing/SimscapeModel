%% Add paths
addpath(genpath(pwd))

%% Run master
main_master

%% Recover algebraic variables
v = compute_v_master(x0, tau, varCAR);