%% Setup
addpath(genpath(pwd))

data_table = table();
data_table.models = ["Master"; "No Slip"];

%% Master Model
% run model
main_master

% plot data
plot_master(v_master, data_table.models(1));

data_table.accel_time(1) = t(find(s(:,2)>75, 1));
data_table.charge_used(1) = s(1,11) - s(end,11);

%% No Slip Model
% run model
main_no_slip

% plot data
plot_master(v_no_slip, data_table.models(2));

data_table.accel_time(2) = t(find(s(:,2)>75, 1));
data_table.charge_used(2) = s(1,11) - s(end,11);


%% Display Table
figure(Name="Model Table")
uitable(Data=data_table);