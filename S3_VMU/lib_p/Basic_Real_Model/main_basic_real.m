%% Cursed Global Variable
global S
S = [0; 0];

%% Get Model
model = varModel_master_3DOF;

%% Initial Conditions
s0 = [0.001; 0; 0; model.zs; 0; model.O0; 0; 0; model.v0; model.v0; 0; 0; 0];

%% Boundary Conditions
tauRaw = [0; 25];

%% Configure Solver
optionsODE = odeset('MaxStep', 0.0005, 'AbsTol', 100, 'RelTol', 100);

%% Simuation Setup
% time controls
tStep = 0.01; % outer loop timestep [s]
tStop = 7; % stop time [s]

% preallocate variables
tAll = 0:tStep:tStop; % all times
sAll = zeros(length(tAll), length(s0)); % all states
tauAll = zeros(length(tAll), length(tauRaw)); % all torque requests
slAll = zeros(length(tAll), 2); % all slip ratios

% initial conditions
sAll(1,:) = s0';
tauAll(1, :) = tauRaw';
slAll(1,:) = [0 0];

%% == Controller Initial Data Setup ==
% bang-bang
    % data.state = "low";
    % data.lastSwitchTime = -10;
% PI
    % data.errorInt = 0;
% ESC
    data.SL_kminus1 = 0;
    data.W1 = 0;
    data.W2 = 1;

%% == Contoller options ==
% bang-bang
    % options.dwellTime = 0.1;
    % options.lowTorqueMult = 0.5;
    % options.SLthresh = 0.15;
% PI
    % options.Kp = 100;
    % options.Ki = 0;
    % options.SLtarget = 0.15;
    % options.tStep = tStep;
% ESC
    % ESC simulation parameters
    options.a = 50;
    options.b = 0.1;
    options.k = 6;
    options.w = 50;
    options.ph = 60;
    options.pl = 8;
    
    options.SLstar = 0.15; % target slip ratio
    options.tStep = tStep; % simulation timestep


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
    
    % == Run Custom Controller ==
    % bang-bang controller
        % data.currentTau = tauAll(i,:)';
        % data.currentTime = tStepStart;
        % [tau, data] = bangbang(tauRaw, s, model, data, options);

    % PI controller
        % data.currentTau = tauAll(i,:)';
        % data.currentTime = tStepStart;
        % [tau, data] = PI(tauRaw, s, model, data, options);

    % Extremum seeking controller
        data.currentTime = tStepStart;
        [tau, data] = esc(tauRaw, s, model, data, options);
        

    % run timestep
    [t,sStep] = ode23tb(@compute_ds_master_3DOF, [tStepStart tStepStart+tStep], s, optionsODE, tau, model);

    % debug
    [~, ~, ~, ~, ~, ~, sl, ~] = traction_model_master_3DOF(s', model);
    slAll(i,:) = sl';

    % update main arrays
    sAll(i+1,:) = sStep(end,:);
    tAll(i+1) = t(end);
    tauAll(i+1,:) = tau';
end

% debug
[~, ~, ~, ~, ~, ~, sl, ~] = traction_model_master_3DOF(sAll(end,:)', model);
slAll(end,:) = sl';

%% Pack output
v_basic_real = compute_v_master_3DOF(tAll, sAll, tauAll, model);

plot_master_3DOF(v_basic_real, "basic real")
figure(4)
% plot(v_basic_real.t, v_basic_real.Sl);
hold on
plot(tAll,tauAll)
legend("vb","vb","all","all")
