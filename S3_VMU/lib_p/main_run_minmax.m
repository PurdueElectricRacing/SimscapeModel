%% Setup
addpath(genpath(pwd))

data_table = table();
data_table.model = ["Master"; "No Slip"; "Basic Real"];

%% Master Model
% run model
t0 = tic;
main_master_3DOF
t1 = toc(t0);

% plot data
plot_master_3DOF(v_master, data_table.model(1), varCAR);

data_table.accel_time(1) = t(find(s(:,2)>75, 1));
data_table.charge_used(1) = s(end,11) - s(1,11);

%% No Slip Model
% run model
t0 = tic;
main_no_slip
t2 = toc(t0);

% plot data
plot_master(v_no_slip, data_table.model(2));

data_table.accel_time(2) = t(find(s(:,2)>75, 1));
data_table.charge_used(2) = s(end,11) - s(1,11);

%% Basic Real Model
% run model
t0 = tic;
main_basic_real
t3 = toc(t0);

% plot data
plot_master_3DOF(v_basic_real, data_table.model(3))

data_table.accel_time(3) = tAll(find(sAll(:,2)>75, 1));
data_table.charge_used(3) = sAll(end,11) - sAll(1,11);

%% Display Table
disp(data_table)