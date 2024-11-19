%% Get no SL data
% get data
load B2356run11.mat

% get discriminator
flag_12psi = (P > 75) & (P < 90);
flag_0deg = (IA < 0.1);
flag_ba = flag_12psi & flag_0deg;

% extract data
ad = extract_data(ET, FX, FY, FZ, SL, SA, flag_ba);
clearvars -except ad

% figure(1)
% scatter3(ad.SA, ad.FZ, ad.FY)

%% Get no SA data
% get data
load B2356run69.mat

% get discriminator
flag_12psi = (P > 75) & (P < 90);
flag_0deg = (IA < 0.1);
flag_0SA = (SA > -1);
flag_SL0 = (SL <= 0);
flag_bb = flag_12psi & flag_0deg & flag_0SA & flag_SL0;

% extract data
bd = extract_data(ET, FX, FY, FZ, SL, SA, flag_bb);
clearvars -except ad bd

% add BC to longitudinal data
bd = fix_data_FX(bd, 40, 0.8);

% figure(2)
% scatter3(bd.SL, bd.FZ, bd.FX)

%% Get theta data
% combine data
run11 = get_run_data('B2356run11.mat');
run69 = get_run_data('B2356run69.mat');

run_all.PA = [run11.PA; run69.PA];
run_all.ET = [run11.ET; run69.ET];
run_all.FX = [run11.FX; run69.FX];
run_all.FY = [run11.FY; run69.FY];
run_all.FZ = [run11.FZ; run69.FZ];
run_all.SA = [run11.SA; run69.SA];
run_all.SL = [run11.SL; run69.SL];
run_all.PA = [run11.PA; run69.PA];
run_all.IA = [run11.IA; run69.IA];
run_all.theta = atan(abs(run_all.FY ./ run_all.FX));

% get all descriminators
flag_12psi = (run_all.PA > 75) & (run_all.PA < 90);
flag_0deg = (run_all.IA < 0.1);
flag_bc = flag_12psi & flag_0deg;

cd = extract_gen_data(run_all, flag_bc);
clearvars -except ad bd cd

% figure(3)
% scatter3(abs(cd.SL), cd.SA, cd.theta)

%% Fit All Data
% pure lat & long
fit_FY_pure = FY_fit(ad.FZ, ad.SA, ad.FY);
fit_FX_pure = FX_fit(bd.FZ, bd.SL, bd.FX);
fit_theta = Theta_fit(cd.SL, cd.SA, cd.theta);

% slip ratio at maximum traction
Sm = fmincon(@force_func, 0, [], [], [], [], 0, 1, [], [], fit_FX_pure);

%% Polynomial fit of bijective portion of longitudinal model
S_sweep = linspace(0, Sm, 100);
r_sweep = -force_func(S_sweep, fit_FX_pure);
p = fmincon(@poly_func, [0; 0; 0], [], [], [], [], [], [], [], [], S_sweep, r_sweep);
p3 = [p;0];

save("tire_fits", "fit_FX_pure", "fit_FY_pure", "fit_theta", "Sm", "p3")

figure(7)
scatter(S_sweep, r_sweep)
hold on
plot(S_sweep, polyval([p;0], S_sweep))

xlabel("slip ratio")
ylabel("r")
legend("Data", "Fit")

%% Evaluate Fits
FZ_sweep = 0:100:5000;
SA_sweep = 0:1:50;
SL_sweep = 0:1:1000;

% FY0 fit
[FZ_FYgrid, SA_FYgrid] = meshgrid(FZ_sweep, SA_sweep);
FZ_FYvec = FZ_FYgrid(:);
SA_FYvec = SA_FYgrid(:);
FY0_vec = feval(fit_FY_pure, FZ_FYvec, SA_FYvec);

figure;
scatter3(FZ_FYvec, SA_FYvec, FY0_vec)

% FX0 fit
[FZ_FXgrid, SL_FXgrid] = meshgrid(FZ_sweep, SL_sweep);
FZ_FXvec = FZ_FXgrid(:);
SL_FXvec = SL_FXgrid(:);
FX0_vec = feval(fit_FX_pure, FZ_FXvec, SL_FXvec);

figure;
scatter3(FZ_FXvec, SL_FXvec, FX0_vec)

% theta fit
[SA_Tgrid, SL_Tgrid] = meshgrid(SA_sweep, SL_sweep);
SA_Tvec = SA_Tgrid(:);
SL_Tvec = SL_Tgrid(:);
theta_vec = feval(fit_theta, SL_Tvec, SA_Tvec);

figure;
scatter3(SL_Tvec, SA_Tvec, theta_vec)

%% Function Bank
function J = poly_func(p, S_sweep, r_sweep)
    r_test = polyval([p;0], S_sweep);
    J = sum(abs(r_test - r_sweep));
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

function data_struct = extract_gen_data(data_struct, flag)
    data_struct.ET = data_struct.ET(flag);
    data_struct.FX = abs(data_struct.FX(flag));
    data_struct.FY = abs(data_struct.FY(flag));
    data_struct.FZ = abs(data_struct.FZ(flag));
    data_struct.SL = abs(data_struct.SL(flag));
    data_struct.SA = abs(data_struct.SA(flag));
    data_struct.theta = data_struct.theta(flag);
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