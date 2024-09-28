%% Get Model
model = varModel_master;

%% Initial Conditions
s0 = [0.0001; 0; 0; model.zs; 0; model.O0; 0; 0; model.v0; model.v0; 0];

%% Boundary Conditions
tauRaw = [0; 25];

%% Configure Solver
optionsODE = odeset('MaxStep',0.0001);

%% Simuation Setup
tStep = 0.015; % outer loop timestep [s]
tStop = 7; % stop time [s]

tAll = 0;
sAll = s0';

%% Run Simulation

% run main control loop
for tStepStart = 0:tStep:tStop
    % states
    s = sAll(end,:); % s at the current time
    dxCOG = s(1);
    dzCOG = s(3);
    zCOG = s(4);
    do = s(5);
    o = s(6);
    wCOG = s(7:8);
    Vb = s(10);

    % possible tractive force, constrained by the motor [N]
    wm = model.gr*((dxCOG/model.r0) + wCOG(2)); % this is not quite right
    tauMax = model.mt(wm, Vb);
    tau = min(tauRaw, tauMax).*model.ge;
    FxFR = tau.*model.gr./model.r0;

    % update controller

    % restrict torque if slipping detected
    slip_ratio = model.r0 * wCOG(2) / dxCOG - 1;

    %if slip_ratio > 0.25
    %    disp("slipping at t = " + t(end))
    %    tau = [0; 0];    
    %end
    %tauAll = [tauAll, tau];

    % run timestep
    [t,sStep] = ode23tb(@compute_ds_basic_real, [tStepStart tStepStart+tStep], s, optionsODE, tau, model);
    sAll(end+1,:) = sStep(end,:);
    tAll(end+1) = t(end);
end
%% Pack output
v_basic_real = compute_v_basic_real(tAll, sAll, tau, model);

%plot_master(v_basic_real, "basic real")
%figure(7)
%plot(tAll, tauAll)