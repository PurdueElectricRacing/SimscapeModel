%% Make Open Circuit Voltage vs. Capacity Model
% Description:
%   Loads constant-current discharge curves for 21700 cell
%   Offsets battery voltage to obtain open-circuit voltage
%   Curve fit and export data
%   Data source:https://www.e-cigarette-forum.com/threads/bench-test-results-molicel-p45b-50a-4500mah-21700%E2%80%A6an-incredible-cell.974244/

% Import Data: Imports data into arrays formatted:
%   [capacity drained {Ah}, batteryvoltage {V}]
A5 = table2array(readtable("Raw_Data/Battery_Cell_P45B_21700_6DOF.xlsx", Sheet="5A", ReadVariableNames=false)); % 5A Discharge
A10 = table2array(readtable("Raw_Data/Battery_Cell_P45B_21700_6DOF.xlsx", Sheet="10A", ReadVariableNames=false)); % 10A Discharge
A20 = table2array(readtable("Raw_Data/Battery_Cell_P45B_21700_6DOF.xlsx", Sheet="20A", ReadVariableNames=false)); % 20A Discharge
A30 = table2array(readtable("Raw_Data/Battery_Cell_P45B_21700_6DOF.xlsx", Sheet="30A", ReadVariableNames=false)); % 30 Discharge
A40 = table2array(readtable("Raw_Data/Battery_Cell_P45B_21700_6DOF.xlsx", Sheet="40A", ReadVariableNames=false)); % 40A Discharge
CellIR = 0.0093; % Cell Internal Resistance [Ω]

% Find Cell Open Circuit Voltage: Add resistive loss to voltage
A5Voc = [A5(:,1) A5(:,2) + 5 * CellIR];
A10Voc = [A10(:,1) A10(:,2) + 10 * CellIR];
A20Voc = [A20(:,1) A20(:,2) + 20 * CellIR];
A30Voc = [A30(:,1) A30(:,2) + 30 * CellIR];
A40Voc = [A40(:,1) A40(:,2) + 40 * CellIR];

% Combine all Offset Data
AllCurrentCapacity = [A5Voc(:,1); A10Voc(:,1);  A20Voc(:,1);  A30Voc(:,1);  A40Voc(:,1)].*3600;
AllCurrentVoc = [A5Voc(:,2); A10Voc(:,2); A20Voc(:,2); A30Voc(:,2); A40Voc(:,2)];

% Fit: 'Discharge Curve'.
[xData, yData] = prepareCurveData( AllCurrentCapacity, AllCurrentVoc );
ft = fittype( 'poly5' );
[VAscurve_6DOF, gof] = fit( xData, yData, ft );

% discretize into an equally spaced lookup table
V_min = 2.0;
V_max = 4.1;
N = 100;

opts = optimoptions("fsolve");
As_min = fsolve(@res_VA, 0, opts, VAscurve_6DOF, V_min);
As_max = fsolve(@res_VA, 0, opts, VAscurve_6DOF, V_max);

As_brk = linspace(0,As_min-As_max,N);
V_tbl = VAscurve_6DOF(As_brk);
VAs_tbl_6DOF = griddedInterpolant(As_brk, V_tbl);

% export data as .mat file
save("Vehicle_Data/P45BCellDischarge_6DOF.mat", "VAscurve_6DOF", "As_brk", "V_tbl", "VAs_tbl_6DOF")
clear;

%% Make Damping Coefficient vs. Damper Velocity Model
% Description: 
%     This program calculates damper lookup table
%     Damper Lookup: Damper Force = f(shock velocity)

% Import Damper Data
DamperDataSample = table2array(readtable("Raw_Data/Shock_TTX_25_MKll_6DOF.xlsx"));

% Generate Damping Table
% calculate damping coefficient (Ns/m)
sus_damper_con = DamperDataSample(:,2) ./ DamperDataSample(:,1);

% replace NaN damping coefficient with interpolated value
c_bkpt = fillmissing(sus_damper_con,'pchip');

% create lookup table function
VCcurve_6DOF = griddedInterpolant(DamperDataSample(:,1), c_bkpt);

% export data as .mat file
save("Vehicle_Data/Mk25ll_6DOF.mat","VCcurve_6DOF");
clear;

%% Make Center Column Steering Angle vs. Toe Angle Model
SteeringDataSample = table2array(readtable('Raw_Data/Steering_6DOF.csv'));
CCSA = SteeringDataSample(:,1);
Toe_y = deg2rad(SteeringDataSample(:,2));
p_Toe_6DOF = polyfit(CCSA,Toe_y,3);
p_Toe_6DOF(4) = 0; % zero out static toe; this is vehicle parameter

save('Vehicle_Data/Toe_6DOF.mat', 'p_Toe_6DOF');

%% Make Tire Tables
% Get no SL data
load Raw_Data/Tire_B2356run11_6DOF.mat

% get discriminator
flag_12psi = (P > 75) & (P < 90);
flag_0deg = (IA < 0.1);
flag_ba = flag_12psi & flag_0deg;

% extract data
ad = extract_data(ET, FX, FY, FZ, SL, SA, flag_ba);

% Fit FY Data: pure lateral
FZSFYcurve = FY_fit(ad.FZ, deg2rad(ad.SA), ad.FY);

clearvars -except FZSFYcurve

% Get no SA data
load Raw_Data/Tire_B2356run69_6DOF.mat

% get discriminator
flag_12psi = (P > 75) & (P < 90);
flag_0deg = (IA < 0.1);
flag_0SA = (SA > -1);
flag_SL0 = (SL <= 0);
flag_bb = flag_12psi & flag_0deg & flag_0SA & flag_SL0;

% extract data
bd = extract_data(ET, FX, FY, FZ, SL, SA, flag_bb);

% add BC to longitudinal data
bd = fix_data_FX(bd, 40, 0.8);

% Fit FX Data: pure longitudinal
FZSFXcurve = FX_fit(bd.FZ, bd.SL, bd.FX);

clearvars -except FZSFXcurve FZSFYcurve

% combine data
run11 = get_run_data('Raw_Data/Tire_B2356run11_6DOF.mat');
run69 = get_run_data('Raw_Data/Tire_B2356run69_6DOF.mat');

run_all.PA = [run11.PA; run69.PA];
run_all.ET = [run11.ET; run69.ET];
run_all.FX = [run11.FX; run69.FX];
run_all.FY = [run11.FY; run69.FY];
run_all.FZ = [run11.FZ; run69.FZ];
run_all.SA = [run11.SA; run69.SA];
run_all.SL = [run11.SL; run69.SL];
run_all.PA = [run11.PA; run69.PA];
run_all.IA = [run11.IA; run69.IA];

eps_FX = 30;
eps_FY = 30;
run_all.theta = atan(abs((run_all.FY + eps_FY) ./ (run_all.FX + eps_FX)));

% get all descriminators
flag_12psi = (run_all.PA > 75) & (run_all.PA < 90);
flag_0deg = (run_all.IA < 0.1);
flag_bc = flag_12psi & flag_0deg;

cd = extract_gen_data(run_all, flag_bc);

% Fix Theta Data: ratio between lateral and longitudinal
SLSA0Curve = Theta_fit(cd.SL, deg2rad(cd.SA), cd.theta);

clearvars -except FZSFXcurve FZSFYcurve SLSA0Curve

% slip ratio at maximum traction
Sm = fmincon(@force_func, 0, [], [], [], [], 0, 1, [], [], FZSFXcurve);
Am = fmincon(@force_func, 0, [], [], [], [], 0, 100, [], [], FZSFYcurve);

% export data as .mat file
save("Vehicle_Data/TIRE_R20_6DOF.mat","FZSFXcurve", "FZSFYcurve", "SLSA0Curve", "Sm", "Am");
clear;

%% Make Motor Tables
% Description:
%         This program calculates several lookup tables that characterize
%         motor performance. 

% Import Motor Data
load Raw_Data/Motor_AMK_FSAE_120C_6DOF.mat

% get raw data
[m,n] = size(Speed);
speed_matrix = Speed.*(pi/30); % speed breakpoints (rad/s)
current_matrix = repmat(0:5.25:105,[m,1]); % current matrix (A)
torque_matrix = Shaft_Torque; % Output motor torque (Nm)
voltageDC_matrix = Voltage_Phase_RMS.*sqrt(2); % DC voltage (V)
loss_matrix = Total_Loss; % power wasted (W)

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
min_torque = -21;
max_torque = 21;
nt = 101;
torque_bp = linspace(min_torque,max_torque,nt)';

% Table 1: speed-voltage-torque
[speedT_tbl, voltageT_tbl] = meshgrid(speed_bp, voltage_bp);

% Table 2: speed-torque-current
[speedI_tbl, torqueI_tbl] = meshgrid(speed_bp, torque_bp);

% Step 0: remove 0 speed torque because it is obviously wrong
speed_matrix = speed_matrix(2:end,:);
current_matrix = current_matrix(2:end,:);
torque_matrix = torque_matrix(2:end,:);
voltageDC_matrix = voltageDC_matrix(2:end,:);
loss_matrix = loss_matrix(2:end,:);

% Step 1: calculate max and min motor torque
[minT_tbl, maxT_tbl] = compute_barrierT_tbl(speed_matrix,torque_matrix,voltageDC_matrix,current_matrix,voltageT_tbl,speed_bp,nv,ns);

% calculate inverter current draw
[inverterP_tbl,speed_matrix_bijectiveT,torque_matrix_bijectiveT,power_matrix_bijectiveT] = compute_inverterP_tbl(speed_matrix,torque_matrix,loss_matrix,speedI_tbl,torqueI_tbl);

% get the full table
speedI_tbl_flat = speedI_tbl(:);
torqueI_tbl_flat = torqueI_tbl(:);
inverterI_tbl_flat = inverterP_tbl(:);

% get only positive torques - now table is bijective
f = (torqueI_tbl_flat >= 0);
speedI_tbl_T = speedI_tbl_flat(f);
torqueI_tbl_T = torqueI_tbl_flat(f);
inverterI_tbl_T = inverterI_tbl_flat(f);

% mirror along speed axis
g = (speedI_tbl_T > 0);
speedI_tbl_ALL = [speedI_tbl_T; -speedI_tbl_T(g)];
torqueI_tbl_ALL = [torqueI_tbl_T; torqueI_tbl_T(g)];
inverterI_tbl_ALL = [inverterI_tbl_T; inverterI_tbl_T(g)];

% mirror along power axis
g = (inverterI_tbl_ALL > 0);
speedI_tbl_ALL = [speedI_tbl_ALL; speedI_tbl_ALL(g)];
torqueI_tbl_ALL = [torqueI_tbl_ALL; -torqueI_tbl_ALL(g)];
inverterI_tbl_ALL = [inverterI_tbl_ALL; -inverterI_tbl_ALL(g)];

% create lookup table function
minTcurve_6DOF = griddedInterpolant(speedT_tbl', voltageT_tbl', minT_tbl');
maxTcurve_6DOF = griddedInterpolant(speedT_tbl', voltageT_tbl', maxT_tbl');
motPcurve_6DOF = griddedInterpolant(speedI_tbl', torqueI_tbl', inverterP_tbl');
motTcurve_6DOF = scatteredInterpolant(speedI_tbl_ALL, inverterI_tbl_ALL, torqueI_tbl_ALL,'natural');

% export data as .mat file
save("Vehicle_Data/AMK_FSAE_6DOF.mat","minTcurve_6DOF", "maxTcurve_6DOF", "motPcurve_6DOF", "motTcurve_6DOF");
clear;

%% Function Bank
function res = res_VA(V, VAs_func, As_ref)
    res = As_ref - VAs_func(V);
end

function Fx = force_func(S, model)
    Fx = -model.D.*sin(model.C.*atan(model.B.*S - model.E.*(model.B.*S - atan(model.B.*S))));
end

function data_struct = extract_data(ET, FX, FY, FZ, SL, SA, flag)
    data_struct.ET = ET(flag);
    data_struct.FX = abs(FX(flag));
    data_struct.FY = abs(FY(flag));
    data_struct.FZ = abs(FZ(flag));
    data_struct.SL = abs(SL(flag));
    data_struct.SA = abs(SA(flag));
end

function data_struct = fix_data_FX(data_struct, n, mu_ratio)
    data_struct.FY = [data_struct.FY; zeros(n, 1)];
    data_struct.SL = [data_struct.SL; ones(n, 1)];
    data_struct.SA = [data_struct.SA; zeros(n, 1)];

    flag_FZ200 = (data_struct.FZ < 300);
    flag_FZ600 = (data_struct.FZ < 750) & (data_struct.FZ > 500);
    flag_FZ800 = (data_struct.FZ < 1000) & (data_struct.FZ > 750);
    flag_FZ1200 = (data_struct.FZ > 1000);

    FZ200_avg = mean(data_struct.FZ(flag_FZ200));
    FZ600_avg = mean(data_struct.FZ(flag_FZ600));
    FZ800_avg = mean(data_struct.FZ(flag_FZ800));
    FZ1200_avg = mean(data_struct.FZ(flag_FZ1200));

    FZ200_add = FZ200_avg.*ones(n/4,1);
    FZ600_add = FZ600_avg.*ones(n/4,1);
    FZ800_add = FZ800_avg.*ones(n/4,1);
    FZ1200_add = FZ1200_avg.*ones(n/4,1);

    FX200_max = max(data_struct.FX(flag_FZ200));
    FX600_max = max(data_struct.FX(flag_FZ600));
    FX800_max = max(data_struct.FX(flag_FZ800));
    FX1200_max = max(data_struct.FX(flag_FZ1200));

    FX200_add = mu_ratio.*FX200_max.*ones(n/4,1);
    FX600_add = mu_ratio.*FX600_max.*ones(n/4,1);
    FX800_add = mu_ratio.*FX800_max.*ones(n/4,1);
    FX1200_add = mu_ratio.*FX1200_max.*ones(n/4,1);

    data_struct.FX = [data_struct.FX; FX200_add; FX600_add; FX800_add; FX1200_add];
    data_struct.FZ = [data_struct.FZ; FZ200_add; FZ600_add; FZ800_add; FZ1200_add];
end

function fitresult = FX_fit(FZf, SLf, FXf)
    [xData, yData, zData] = prepareSurfaceData( FZf, SLf, FXf );
    
    % Set up fittype and options.
    ft = fittype( '(x*D)*sin(C*atan(B*y-E*(B*y-atan(B*y))));', 'independent', {'x', 'y'}, 'dependent', 'z' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.Lower = [0 1 0 0];
    opts.MaxFunEvals = 6000;
    opts.MaxIter = 4000;
    opts.StartPoint = [0.262482234698333 0.801014622769739 0.0292202775621463 0.928854139478045];
    opts.Upper = [inf 2 inf 1];
    
    % Fit model to data.
    [fitresult, ~] = fit( [xData, yData], zData, ft, opts );
end

function fitresult = FY_fit(FZa, SAa, FYa)
    [xData, yData, zData] = prepareSurfaceData( FZa, SAa, FYa );

    % Set up fittype and options.
    ft = fittype( '(x*D)*sin(C*atan(B*y-E*(B*y-atan(B*y))));', 'independent', {'x', 'y'}, 'dependent', 'z' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.Lower = [0 1 0 0];
    opts.MaxFunEvals = 6000;
    opts.MaxIter = 4000;
    opts.StartPoint = [0.0714454646006424 0.521649842464284 0.096730025780867 0.818148553859625];
    opts.Upper = [inf 2 inf 1];

    % Fit model to data.
    [fitresult, ~] = fit( [xData, yData], zData, ft, opts );
end

function fitresult = Theta_fit(SL_theta, SA_theta, theta_theta)
    [xData, yData, zData] = prepareSurfaceData( SL_theta, SA_theta, theta_theta );

    % Set up fittype and options.
    ft = fittype( '(0.7853981634*exp(a*y)+atan(10*y))*(exp((b*exp(c*y)+d)*x)+0.3183098862*atan(f*x*y))', 'independent', {'x', 'y'}, 'dependent', 'z' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.Lower = [-Inf -Inf -Inf -Inf 0];
    opts.MaxFunEvals = 6000;
    opts.MaxIter = 4000;
    opts.StartPoint = [0.0523052207703927 0.556830534131996 0.712025249134944 0.213777574762031 0.380642291284627];
    opts.Upper = [0 0 0 0 Inf];
    
    % Fit model to data.
    [fitresult, ~] = fit( [xData, yData], zData, ft, opts );
end

function run_data = get_run_data(file)
    load(file)
    
    run_data.ET = ET;
    run_data.IA = IA;
    run_data.PA = P;
    run_data.FX = FX;
    run_data.FY = FY;
    run_data.FZ = FZ;
    run_data.SA = SA;
    run_data.SL = SL;
end

function data_struct = extract_gen_data(data_struct, flag)
    data_struct.ET = data_struct.ET(flag);
    data_struct.FX = abs(data_struct.FX(flag));
    data_struct.FY = abs(data_struct.FY(flag));
    data_struct.FZ = abs(data_struct.FZ(flag));
    data_struct.SL = abs(data_struct.SL(flag));
    data_struct.SA = abs(data_struct.SA(flag));
    data_struct.theta = data_struct.theta(flag);
end

function [minT_tbl, maxT_tbl] = compute_barrierT_tbl(speed_matrix,torque_matrix,voltageDC_matrix,current_matrix,voltageT_tbl,speed_bp,nv,ns)
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
end

function [inverterP_tbl,speed_matrix_bijectiveT,torque_matrix_bijectiveT,power_matrix_bijectiveT] = compute_inverterP_tbl(speed_matrix,torque_matrix,loss_matrix,speedI_tbl,torqueI_tbl)
    %% Step 1: form overall raw table
    minT_matrix = -torque_matrix(:,2:end) + 2*torque_matrix(:,1);
    torque_matrix_all = [torque_matrix  minT_matrix];
    speed_matrix_all = [speed_matrix speed_matrix(:,2:end)];
    power_matrix_all = torque_matrix_all.*speed_matrix_all + [loss_matrix loss_matrix(:,2:end)];

    %% Step 2: make torque-speed-power a bijective function
    not_bijective_matrix_max = abs(torque_matrix(:,1:end-1) - torque_matrix(:,2:end)) < 0.5;
    not_bijective_matrix_min = abs(minT_matrix(:,1:end-1) - minT_matrix(:,2:end)) < 0.5;
    not_bijective_matrix = [not_bijective_matrix_max(:,1) not_bijective_matrix_max not_bijective_matrix_min(:,1) not_bijective_matrix_min];
    
    speed_matrix_bijectiveT = speed_matrix_all(~not_bijective_matrix);
    torque_matrix_bijectiveT = torque_matrix_all(~not_bijective_matrix);
    power_matrix_bijectiveT = power_matrix_all(~not_bijective_matrix);

    %% Step 3: make full torque-speed-current table   
    [xData, yData, zData] = prepareSurfaceData(speed_matrix_bijectiveT,torque_matrix_bijectiveT,power_matrix_bijectiveT);
    ft = 'linearinterp';
    opts = fitoptions('Method','LinearInterpolant');
    opts.ExtrapolationMethod = 'linear';
    opts.Normalize = 'on';
    power_all_fit = fit([xData,yData],zData,ft,opts);
    
    inverterP_tbl = (feval(power_all_fit, speedI_tbl, torqueI_tbl)' - feval(power_all_fit, speedI_tbl(51,:), torqueI_tbl(51,:))')';
end

function S = get_S(dw, dxCOG, Fz, P,  model)
    if abs(dw) >= 0.1
        S = (dw*model.r0 + model.Sm*dxCOG) / dxCOG;
    else
        [Fx_t, Fx] = get_Fx_3DOF(model.Sm, Fz, P, dxCOG, model);
        if Fx <= Fx_t
            S = model.Sm;
        else
            S = fzero_better(0, Fz, P, dxCOG, model);
        end
    end
end

function S = get_S_noW(Fz, P, dxCOG,  model)
    [Fx_t, Fx] = get_Fx_3DOF(model.Sm, Fz, P, dxCOG, model);
    if Fx <= Fx_t
        S = model.Sm;
    else
        S = fzero_better(0, Fz, P, dxCOG, model);
    end
end

function S = fzero_better(S0, Fz, P, dxCOG, model)
    for i = 1:model.imax
        fx = get_res_3DOF(S0, Fz, P, dxCOG, model);
        dfx = (get_res_3DOF(S0+model.eps, Fz, P, dxCOG, model) - fx) / model.eps;

        if isnan(fx)
            S = fx;
            return
        elseif abs(fx) < model.tolX
            S = S0;
            return;
        end
        S0 = S0 - (fx / dfx);
    end
    S = S0;
    disp("max iterations!")
end

function [Fx_t, Fx, Fx_max, tau, wt] = get_Fx_3DOF(S, Fz, P, dxCOG, model)
    % tire wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % limit slip
    S = max(min(S, 1), -1);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = model.tt(wt.*model.gr, P) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    Fx_t = (tau*model.gr/model.r0);

    % applied tractive force [N]
    Fx = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));

    % maximum tractive force [N]
    Fx_max = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*model.Sm - model.Ex.*(model.Bx.*model.Sm - atan(model.Bx.*model.Sm))));
end

function res = get_res_3DOF(S, Fz, P, dxCOG, model)
    % tire wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % limit slip
    S = max(min(S, 1), -1);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = model.tt(wt.*model.gr, P) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    Fx_t = (tau*model.gr/model.r0);

    % applied tractive force [N]
    Fx = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));

    % compute residual
    res = Fx_t - Fx;
end