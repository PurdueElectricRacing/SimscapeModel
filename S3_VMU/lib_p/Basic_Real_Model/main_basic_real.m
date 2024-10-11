%% Get Model
model = varModel_master;

%% Initial Conditions
s0 = [0.0001; 0; 0; model.zs; 0; model.O0; 0; 0; model.v0; model.v0; 0];

%% Boundary Conditions
tauRaw = [0; 25];

%% Configure Solver
optionsODE = odeset('MaxStep',0.001);

%% Simuation Setup
tStep = 0.01; % outer loop timestep [s]
tStop = 10; % stop time [s]

tAll = 0;
sAll = s0';
tauAll = tauRaw';

%% Run Simulation

% run main control loop
for tStepStart = 0:tStep:tStop-tStep
    % states
    s = sAll(end,:); % s at the current time
    dxCOG = s(1);
    dzCOG = s(3);
    zCOG = s(4);
    do = s(5);
    o = s(6);
    wCOG = s(7:8);
    Vb = s(10);
    
    % check for slipping
    [~, ~, ~, w, ~, ~, ~, ~] = traction_model_master(s, tauRaw, model);
    sr = (w(2) * model.r0 / dxCOG) - 1; % slip ratio
    disp(sr)
    if sr > 0.15
        tau = tauRaw / 2;
    elseif sr < .1
        tau = tauRaw;
    end

    % run timestep
    [t,sStep] = ode23tb(@compute_ds_basic_real, [tStepStart tStepStart+tStep], s, optionsODE, tau, model);

    sAll(end+1,:) = sStep(end,:);
    tAll(end+1) = t(end);
    tauAll(end+1,:) = tau';
end

%% Pack output
v_basic_real = compute_v_basic_real(tAll, sAll, tauAll, model);

plot_master(v_basic_real, "basic real")
%figure(7)
%plot(tAll, sAll(:,2))