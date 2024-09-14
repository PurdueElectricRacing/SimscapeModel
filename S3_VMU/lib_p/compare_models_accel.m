%% Add paths
addpath(genpath(pwd))

%% Setup
data_table = table();
data_table.models = ["Master"; "No Slip"];


%% Master Model
main_master

data_table.accel_time(1) = t(find(s(:,2)>75, 1));
data_table.charge_used(1) = s(1,11) - s(end,11);

%% No Slip Model
main_no_slip

data_table.accel_time(2) = t(find(s(:,2)>75, 1));
data_table.charge_used(2) = s(1,11) - s(end,11);


%% Display Values
uitable(Data=data_table);