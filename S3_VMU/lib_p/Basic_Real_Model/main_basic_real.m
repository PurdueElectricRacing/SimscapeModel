%% Get Model
model = varModel_master;

%% Initial Conditions
s0 = [0.0001; 0; 0; model.zs; 0; model.O0; 0; 0; model.v0; model.v0; 0];

%% Boundary Conditions
tauRaw = [0; 25];

%% Configure Solver
optionsODE = odeset('MaxStep',0.001);

%% Simuation Setup
tStep = 0.015; % outer loop timestep [s]
tStop = 10; % stop time [s]

tAll = 0:tStep:tStop; % all times
sAll = zeros(length(tAll), length(s0));
tauAll = zeros(length(tAll), length(tauRaw));
slAll = zeros(length(tAll), 1);

sAll(1,:) = s0';
tauAll(1, :) = tauRaw';
slAll(1) = 0;

state = 1; % 1 = high torque 
dwellTime = 10; % number of times to be on current state before changin

%% Run Simulation

% run main control loop
for i = 1:length(tAll)-1
    % states
    tStepStart = tAll(i);
    s = sAll(i,:); % s at the current time
    dxCOG = s(1);
    dzCOG = s(3);
    zCOG = s(4);
    do = s(5);
    o = s(6);
    wCOG = s(7:8);
    Vb = s(10);
    
   % run custom controller

   data.currentTau = tauAll(i,:);
   
   %[tau, data] = bangbang(tauRaw, s, model, data);

    % run timestep
    [t,sStep] = ode23tb(@compute_ds_master, [tStepStart tStepStart+tStep], s, optionsODE, tau, model);

    sAll(i+1,:) = sStep(end,:);
    tAll(i+1) = t(end);
    tauAll(i+1,:) = tau';
end

%% Pack output
v_basic_real = compute_v_master(tAll, sAll, tauAll, model);

plot_master(v_basic_real, "basic real")
%figure(7)
%plot(tAll, sAll(:,2))