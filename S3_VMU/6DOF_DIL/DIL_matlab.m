% This program takes control inputs from DIL_2025a saved in
% simulink_data.mat and runs those inputs in the 6DOF_V2 model

%% Setup
addpath("../Master_Model_6DOF_V2")
addpath("../Master_Model_6DOF_V2/Vehicle_Data/")
s0 = load("s0.mat").s1(1:22);

%% Get Model
varCAR = class2struct(vehicle_parameters);

%% load inputs
load("simulink_data.mat");
inputs.tau = out.tau_in.Data;
inputs.ccsa = out.ccsa_in.Data;
inputs.P = zeros(size(inputs.ccsa));
inputs.t = out.ccsa_in.Time;

%% Configure Solver
M = eye(22,22);
M(19,19) = 0;
M(20,20) = 0;
M(21,21) = 0;
M(22,22) = 0;
optsODE = odeset('Mass',M, 'AbsTol', 1e-3, 'RelTol', 1e-3);

%% Setup Simulation
tstep = 0.02;
tspan = (0:tstep:inputs.t(end))';
S_out_all = zeros(length(tspan), length(s0));
S_out_all(1,:) = s0;
timings = zeros(size(inputs.t));

%% Run simulation
for i = 1:length(tspan)-1
    t0 = tic;

    % inputs
    tspan_in_step = [tspan(i), tspan(i+1)];
    S0_in_step = S_out_all(i,:);
    tau_in_step = inputs.tau(i,:);
    ccsa_in_step = inputs.ccsa(i,:);
    P_in_step = inputs.P(i,:);

    % single step
    [t_in_step, S_in_step] = ode15s(@vehicle_ds, tspan_in_step, S0_in_step', optsODE, tau_in_step', ccsa_in_step, P_in_step', varCAR);
    
    % outputs
    S_out_all(i+1,:) = S_in_step(end,:);

    timings(i) = toc(t0);
end


%% plot_data
v_master = vehicle_output(tspan, S_out_all, inputs.tau, inputs.ccsa, inputs.P, varCAR);
vehicle_plot(v_master, "Master", varCAR);

%% plot timings
fprintf("total time: %2.2f s\n", sum(timings))
fprintf("average time: %2.4f s\n", mean(timings))
fprintf("%d timesteps above %0.4f; %2.1f%% of timesteps\n", sum(timings>tstep), tstep, sum(timings>tstep)/length(timings)*100)
fprintf("%2.1f s (%2.2f%%) of total time spent above target\n\n", sum(timings(timings>tstep)-tstep), sum(timings(timings>tstep)-tstep)/sum(timings)*100)
figure(5)
plot(inputs.t, timings);
xlabel("time")
ylabel("time per frame (s)")
ylim([0, .02])
figure(6)
plot(inputs.t, cumsum(timings))