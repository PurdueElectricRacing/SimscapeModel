%% Define all desired variables
vars = ['FX', 'FY', 'FZ', 'SA', 'SL', 'IA'];

%% Get no SL function
% get data
load B2356run11.mat

% get discriminator
flag_12psi = (P > 75) & (P < 90);
flag_0deg = (IA < 0.1);
flag_ba = flag_12psi & flag_0deg;

% extract data
ad.ET = ET(flag_ba);
ad.FX = FX(flag_ba);
ad.FY = FY(flag_ba);
ad.FZ = FZ(flag_ba);
ad.SL = SL(flag_ba);
ad.SA = SA(flag_ba);

FZa = abs(ad.FZ);
FYa = -ad.FY;
FXa = ad.FX;
SLa = ad.SL;
SAa = ad.SA;

fit_FY = createFit(FZa, SAa, FYa);

%% Get no SA function
% get data
load B2356run69.mat

% get discriminator
flag_12psi = (P > 75) & (P < 90);
flag_0deg = (IA < 0.1);
flag_0SA = (SA > -1);
flag_bb = flag_12psi & flag_0deg & flag_0SA;

% extract data
bd.ET = ET(flag_bb);
bd.FX = FX(flag_bb);
bd.FY = FY(flag_bb);
bd.FZ = FZ(flag_bb);
bd.SL = SL(flag_bb);
bd.SA = SA(flag_bb);

FZb = abs(bd.FZ);
FXb = abs(bd.FX);
FYb = bd.FY;
SLb = abs(bd.SL);
SAb = bd.SA;

fit_FX = createFit1(FZb, SLb, FXb);

%% Get combined function
% concatenate pure longitudinal and lateral
FXab = [FXa; FXb];
FYab = [FYa; FYb];
FZab = [FZa; FZb];
SAab = [SAa; SAb];
SLab = [SLa; SLb];

figure(1)
scatter3(FXab, FYab, FZab)