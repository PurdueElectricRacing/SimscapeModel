%% Simulation Inputs
% battery layout
parallel = 4; % number of cells in parallel
series = 76; % number of cells in series

% cell constants
RCell = 0.0144; % Cell internal resistance [Ω]

% read cell voltage curve
mat = readmatrix("CellVoltageCurve.csv");
CellAhDischarged = mat(:,1); % cell capacity discharged [Ah]
CellVoc = mat(:,2); % cell open-circuit voltage [V]

% Calculte cell capacity by integration [Wh]
CellCapacity = sum(diff(CellAhDischarged) .* .5 .* (CellVoc(1:end-1) + CellVoc(2:end)));

% Create whole-battery values by extrapolating cells
BattAhDischarged = CellAhDischarged .* parallel;
BattVoc = CellVoc .* series;
BattCapacity = CellCapacity .* parallel .* series;

% calculate total battery capacity and resistance
RBatt = RCell * series; % total battery internal resistance [Ω]

CReg = .006; % voltage regulation capacitor [F]

MotorCurrentTimes = [0 1 2:.01:3]; % List of times corresponding to current values [s]
MotorCurrentVals = [0 50 30:.2:50]; % List of current at given times, assumed to be constant [A]

%% Simulation Setup
tStop = 5; % simulation time [s]
tStep = 0.001; % simulation step [s]
t = 0:tStep:tStop; % array of simulation time

% resample motor (load) current
IM_t = interp1(MotorCurrentTimes, MotorCurrentVals, t, "previous", "extrap");

% preallocate arrays
Vb_t = zeros(size(t));
Voc_t = zeros(size(t));
BattAhDischarged_t = zeros(size(t));

%% Run Simulation
% inital conditions
Vb_t(1) = BattVoc(1) - RBatt * IM_t(1);
Voc_t(1) = BattVoc(1);

tOffset = 0;
IM_old = IM_t(1);
Vb_old = Vb_t(1);
scatter(t,IM_t)

% main loop
for i = 2:length(t) % start at 2 since first timestep is initial values
    if IM_t(i) ~= IM_old % motor curren value changed
        tOffset = t(i);
        IM_old = IM_t(i);
        Vb_old = Vb_t(i-1);
    end
    % update overall battery voltage using derived formula
    Vb_t(i) = (Voc_t(1) - IM_t(i)) * (1 - exp(-(t(i)-tOffset)/CReg)) + Vb_old*exp(-(t(i)-tOffset)/CReg);

    % update Ah of battery dischargd
    BattAhDischarged_t(i) = BattAhDischarged_t(i-1) + (Voc_t(1) - Vb_t(i)) / RBatt * tStep / 3600;

    % update Voc of battery according to discharge curve
end


%% Plot Results
figure(1)
subplot(3,1,1)
plot(t,IM_t)
subplot(3,1,2)
plot(t,Vb_t)
subplot(3,1,3)
plot(t,BattAhDischarged_t)