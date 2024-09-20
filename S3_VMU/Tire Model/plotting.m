%% Define all desired variables
vars = ['FX', 'FY', 'FZ', 'SA', 'SL', 'IA', 'P'];

%% Get no SL function
% get data
load B2356run11.mat

% get discriminator
flag_12psi = (P > 75) & (P < 90);
flag_0deg = (IA < 0.1);
flag_3SA = (abs(SA) < 3.1) & (abs(SA) > 2.9);
flag_6SA = (abs(SA) < 6.1) & (abs(SA) > 5.9);
flag_ba = flag_12psi & flag_0deg;
flag_ea3 = flag_12psi & flag_0deg & flag_3SA;
flag_ea6 = flag_12psi & flag_0deg & flag_6SA;

% extract data
ad = extract_data_FY(ET, FX, FY, FZ, SL, SA, flag_ba);
ed3 = extract_data_FY(ET, FX, -abs(FY), FZ, SL, SA, flag_ea3);
ed6 = extract_data_FY(ET, FX, -abs(FY), FZ, SL, SA, flag_ea6);

%% Get no SA function
% get data
load B2356run69.mat

% get discriminator
flag_12psi = (P > 75) & (P < 90);
flag_0deg = (IA < 0.1);
flag_0SA = (SA > -1);
flag_3SA = (SA < -1) & (SA > -4.5);
flag_6SA = (SA < -4.5);
flag_SL = (SL < -0.05);
flag_FZ200 = (FZ < -350);
flag_bb = flag_12psi & flag_0deg & flag_0SA;
flag_cd = flag_12psi & flag_0deg & flag_3SA;
flag_dd = flag_12psi & flag_0deg & flag_6SA;
flag_fd = flag_12psi & flag_0deg & flag_3SA & flag_SL;
flag_gd = flag_12psi & flag_0deg & flag_6SA & flag_SL;

% extract data
bd = extract_data_FX(ET, FX, FY, FZ, SL, SA, flag_bb);
cd = extract_data_FX(ET, FX, FY, FZ, SL, SA, flag_cd);
dd = extract_data_FX(ET, FX, FY, FZ, SL, SA, flag_dd);
fd = extract_data_FX(ET, FX, FY, FZ, SL, SA, flag_fd);
gd = extract_data_FX(ET, FX, FY, FZ, SL, SA, flag_gd);

fd = concat_data(fd, ed3);
gd = concat_data(gd, ed6);

FYaa = fd.FY;
FZaa = fd.FZ;
SLaa = fd.SL;

% figure(1)
% scatter3(bd.SL, bd.FZ, bd.FX)
% 
% figure(2)
% scatter3(cd.SL, cd.FZ, cd.FX)
% 
% figure(3)
% scatter3(dd.SL, dd.FZ, dd.FX)
% 
% figure(4)
% scatter3(cd.SA, cd.FZ, cd.FY)
% 
% figure(5)
% scatter3(fd.SL, fd.FZ, fd.FY)

%% Fit Data
% pure lat & long
fit_FX_pure = FX_fit(bd.FZ, bd.SL, bd.FX);
fit_FY_pure = FY_fit(ad.FZ, ad.SA, ad.FY);

% combined lat & long, FX
fit_FX_3SA = FX_fit(cd.FZ, cd.SL, cd.FX);
fit_FX_6SA = FX_fit(dd.FZ, dd.SL, dd.FX);

% combined lat & long, FY
fit_FY_3SA = createFit(fd.FZ, fd.SL, fd.FY);
fit_FY_6SA = createFit(gd.FZ, gd.SL, gd.FY);

%% Generate SL SA table
FZ_fixed = 600; % [N]
SL_sweep_CSL = (0:0.01:1)'; % [ratio]
SL_sweep_3SA = (0:0.01:1)'; % [ratio]
SL_sweep_6SA = (0:0.01:1)'; % [ratio]
SA_sweep_0SL = (0:0.1:25)'; % [ratio]

% FX
FX_CSL = feval(fit_FX_pure, FZ_fixed, SL_sweep_CSL);
FX_3SA = feval(fit_FX_3SA, FZ_fixed, SL_sweep_3SA);
FX_6SA = feval(fit_FX_6SA, FZ_fixed, SL_sweep_6SA);
FX_0 = SA_sweep_0SL.*0;

SL_0 = SA_sweep_0SL.*0;
SA_0 = SL_sweep_CSL.*0;
SL_3SA = 3.*(SL_sweep_3SA ./ SL_sweep_3SA);
SL_6SA = 6.*(SL_sweep_6SA ./ SL_sweep_6SA);

FX_all_FX = [FX_CSL; FX_3SA; FX_6SA; FX_0];
SL_all_FX = [SL_sweep_CSL; SL_sweep_3SA; SL_sweep_6SA; SL_0];
SA_all_FX = [SA_0; SL_3SA; SL_6SA; SA_sweep_0SL];

figure(1)
scatter3(SL_all_FX, SA_all_FX, FX_all_FX)

%% Combine Data
run11 = get_run_data('B2356run11.mat');
run69 = get_run_data('B2356run69.mat');

run_all.ET = [run11.ET; run69.ET];
run_all.FX = [run11.FX; run69.FX];
run_all.FY = [run11.FY; run69.FY];
run_all.FZ = [run11.FZ; run69.FZ];
run_all.SA = [run11.SA; run69.SA];
run_all.SL = [run11.SL; run69.SL];
run_all.PA = [run11.PA; run69.PA];
run_all.IA = [run11.IA; run69.IA];

% get all descriminators
flag_12psi = (run_all.P > 75) & (run_all.P < 90);
flag_0deg = (run_all.IA < 0.1);
flag_0SA = (run_all.SA > -1);
flag_3SA = (run_all.SA < -1) & (run_all.SA > -4.5);
flag_6SA = (SA < -4.5);

flag_ba = flag_12psi & flag_0deg & flag_0SA;
flag_bb = flag_12psi & flag_0deg & flag_0SA;
flag_cd = flag_12psi & flag_0deg & flag_3SA;
flag_dd = flag_12psi & flag_0deg & flag_6SA;

function data_struct = extract_data_FX(ET, FX, FY, FZ, SL, SA, flag)
    data_struct.ET = ET(flag);
    data_struct.FX = abs(FX(flag));
    data_struct.FY = FY(flag);
    data_struct.FZ = abs(FZ(flag));
    data_struct.SL = abs(SL(flag));
    data_struct.SA = SA(flag);
end

function data_struct = extract_data_FY(ET, FX, FY, FZ, SL, SA, flag)
    data_struct.ET = ET(flag);
    data_struct.FX = FX(flag);
    data_struct.FY = -FY(flag);
    data_struct.FZ = abs(FZ(flag));
    data_struct.SL = SL(flag);
    data_struct.SA = SA(flag);
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

function struct_cat = concat_data(struct1, struct2)
    struct_cat.ET = [struct1.ET; struct2.ET];
    struct_cat.FX = [struct1.FX; struct2.FX];
    struct_cat.FY = [struct1.FY; struct2.FY];
    struct_cat.FZ = [struct1.FZ; struct2.FZ];
    struct_cat.SA = [struct1.SA; struct2.SA];
    struct_cat.SL = [struct1.SL; struct2.SL];
end