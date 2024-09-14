%% Setup
addpath(genpath(pwd))

data_table = table();
data_table.models = ["Master"; "No Slip"];

%% Master Model
% run model
main_master

% plot data (runs model again)
plot_master(v_master);

%% No Slip Model
% run model
main_no_slip

% plot data (runs model again)
plot_master(v_no_slip);