function [speed_bp,voltage_bp,torque_bp,minT_tbl,maxT_tbl, speedT_tbl, voltageT_tbl] = compute_AMK_func(data_path)
%% Load 
load (data_path, "Speed", "Shaft_Torque", "Voltage_Phase_RMS", "Total_Loss");
%% Define Matrices
% get raw data
[m,n] = size(Speed);
speed_matrix = Speed.*(pi/30); % speed breakpoints (rad/s)
current_matrix = repmat(0:5.25:105,[m,1]); % current matrix (A)
torque_matrix = Shaft_Torque; % Output motor torque (Nm)
voltageDC_matrix = Voltage_Phase_RMS.*sqrt(2); % DC voltage (V)
loss_matrix = Total_Loss; % power wasted (W)

minT_matrix = -torque_matrix(:,2:end) + 2*torque_matrix(:,1);
torque_matrix_all = [torque_matrix  minT_matrix];
speed_matrix_all = [speed_matrix speed_matrix(:,2:end)];
power_matrix_all = [loss_matrix loss_matrix(:,2:end)];

% speed breakpoint definition
min_speed = 0;
max_speed = speed_matrix(end,1);
ns = 150;
speed_bp = linspace(min_speed,max_speed,ns)';

% voltage breakpoint definition
min_voltage = 298;
max_voltage = 598;
nv = 50;
voltage_bp = linspace(min_voltage,max_voltage,nv)';

% torque breakpoint definition
min_torque = -23;
max_torque = 23;
nt = 101;
torque_bp = linspace(min_torque,max_torque,nt)';

% Table 1: speed-voltage-torque
[speedT_tbl, voltageT_tbl] = meshgrid(speed_bp, voltage_bp);

% Table 2: speed-torque-current
[speedI_tbl, torqueI_tbl] = meshgrid(speed_bp, torque_bp);

%% Step 0: remove 0 speed torque because it is obviously wrong
speed_matrix = speed_matrix(2:end,:);
current_matrix = current_matrix(2:end,:);
torque_matrix = torque_matrix(2:end,:);
voltageDC_matrix = voltageDC_matrix(2:end,:);
loss_matrix = loss_matrix(2:end,:);

%% Step 1: make speed-currrent-max_voltage_dc a bijective function
VoltageDC_matrix_rounded = round(voltageDC_matrix,2);
abs_max_VDC = max(VoltageDC_matrix_rounded,[],"all");
not_bijective_matrix = VoltageDC_matrix_rounded == abs_max_VDC;

VoltageDC_matrix_bijectiveVDC = voltageDC_matrix(~not_bijective_matrix);
current_matrix_bijectiveVDC = current_matrix(~not_bijective_matrix);
speed_matrix_bijectiveVDC = speed_matrix(~not_bijective_matrix);

%% Step 2: make max I as a function of speed and VDC
[xData, yData, zData] = prepareSurfaceData(speed_matrix_bijectiveVDC,VoltageDC_matrix_bijectiveVDC,current_matrix_bijectiveVDC);
ft = 'linearinterp';
opts = fitoptions('Method','LinearInterpolant');
opts.ExtrapolationMethod = 'nearest';
opts.Normalize = 'on';
maxI_fit = fit([xData,yData],zData,ft,opts);

%% Step 3: make torque as a function of battery current and motor speed
[xData, yData, zData] = prepareSurfaceData(speed_matrix,current_matrix,torque_matrix);
ft = 'cubicinterp';
opts = fitoptions('Method','CubicSplineInterpolant');
opts.ExtrapolationMethod = 'linear';
opts.Normalize = 'on';
torque_fit = fit([xData,yData],zData,ft,opts);

%% Step 4: generate max torque table given battery voltage and motor speed
maxT_tbl = zeros(nv,ns);

for i = 1:nv
    barrier_current = feval(maxI_fit,speed_bp,voltageT_tbl(i,:));
    maxT_tbl(i,:) = max(0, feval(torque_fit,speed_bp,barrier_current));
end

%% Step 5: flip and translate limit table to get regen as well
minT_tbl = -maxT_tbl + 2*min(maxT_tbl,[],"all");

%% 

end