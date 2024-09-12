%% Add paths
addpath(genpath(pwd))

%% Run master
main_master

%% View Data
plot_master(v_master);

%% Run no slip
main_no_slip

%% View Data
plot_master(v_no_slip);