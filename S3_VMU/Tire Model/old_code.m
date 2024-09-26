%% OLD
% cd = fix_data_FX(cd, 4, 0.7);
% dd = fix_data_FX(dd, 4, 0.7);

flag_3SA = (abs(SA) < 3.1) & (abs(SA) > 2.9);
flag_6SA = (abs(SA) < 6.1) & (abs(SA) > 5.9);
flag_ea3 = flag_12psi & flag_0deg & flag_3SA;
flag_ea6 = flag_12psi & flag_0deg & flag_6SA;

ed3 = extract_data_FY(ET, FX, -abs(FY), FZ, SL, SA, flag_ea3);
ed6 = extract_data_FY(ET, FX, -abs(FY), FZ, SL, SA, flag_ea6);

flag_3SA = (SA < -1) & (SA > -4.5);
flag_6SA = (SA < -4.5);
flag_SL = (SL < -0.05);
flag_FZ200 = (FZ < -350);

flag_cd = flag_12psi & flag_0deg & flag_3SA & flag_SL0;
flag_dd = flag_12psi & flag_0deg & flag_6SA & flag_SL0;
flag_fd = flag_12psi & flag_0deg & flag_3SA & flag_SL;
flag_gd = flag_12psi & flag_0deg & flag_6SA & flag_SL;

cd = extract_data_FX(ET, FX, FY, FZ, SL, SA, flag_cd);
dd = extract_data_FX(ET, FX, FY, FZ, SL, SA, flag_dd);
fd = extract_data_FX(ET, FX, FY, FZ, SL, SA, flag_fd);
gd = extract_data_FX(ET, FX, FY, FZ, SL, SA, flag_gd);

fd = concat_data(fd, ed3);
gd = concat_data(gd, ed6);


%% OLD
flag = (data_struct.SL > 0.04) & (data_struct.SA > 1);

FY0 = abs(feval(fit_FY_pure, data_struct.FZ, -(data_struct.SA)));
FX0 = abs(feval(fit_FX_pure, data_struct.FZ, data_struct.SL));
FX_bar = data_struct.FX ./ FX0;
FY_bar = data_struct.FY ./ FY0;

% scatter3(data_struct.SL(flag), data_struct.SA(flag), FX_bar(flag))
% scatter3(data_struct.SL(flag), data_struct.SA(flag), r(flag))

theta_thresh = atan(abs(FY0./FX0));
x = abs(FY0 ./ tan(data_struct.theta));
y = abs(FX0 .* tan(data_struct.theta));

flag_thresh = (data_struct.theta <= theta_thresh);
flag_FY = (y < FY0) & (flag_thresh == 1);

FY0(flag_FY) = y(flag_FY);
FX0(data_struct.theta > theta_thresh) = x(data_struct.theta > theta_thresh);

FY0(data_struct.theta <= theta_thresh) = y(data_struct.theta <= theta_thresh);
FX0(data_struct.theta > theta_thresh) = x(data_struct.theta > theta_thresh);

% scatter3(data_struct.FZ, data_struct.SA, FY0)
% scatter3(data_struct.FZ, data_struct.SL, FX0)

% scatter3(data_struct.FZ, data_struct.SA, y)
% scatter3(data_struct.FZ, data_struct.SL, x)

% scatter3(data_struct.SL, data_struct.SA, FY0)
scatter3(data_struct.SL, data_struct.SA, FX0)
hold on
scatter3(data_struct.SL, data_struct.SA, data_struct.FX)

r_max = sqrt(FX0.^2 + FY0.^2);
r_dat = (1./data_struct.FZ).*sqrt(data_struct.FX.^2 + data_struct.FY.^2);


figure(28)
scatter3(data_struct.SL, data_struct.SA, r_max);
hold on
scatter3(data_struct.SL, data_struct.SA, r_dat);
legend("r_max", "r_dat")

figure(29)
scatter3(abs(data_struct.SL(flag)), data_struct.SA(flag), r(flag))
xlabel("SL")
ylabel("SA")

%% OLD
FX_bar_1 = run_all.FX ./ run_all.FZ;
FY_bar_1 = run_all.FY ./ run_all.FZ;
FX_bar_2 = run_all.FX ./ feval(fit_FX_pure, run_all.FZ, run_all.SL);
FY_bar_2 = run_all.FY ./ feval(fit_FY_pure, run_all.FZ, run_all.SA);

x1 = sqrt(FX_bar_1.^2 + FY_bar_1.^2);
x2 = sqrt(FX_bar_2.^2 + FY_bar_2.^2);
r = abs(run_all.FX ./ sqrt(run_all.FX.^2 + run_all.FY.^2));

flag_12psi = (run_all.PA > 75) & (run_all.PA < 90);
flag_0deg = (run_all.IA < 0.1);
% flag_0SASL = run_all.SA > 1 & abs(run_all.SL) > 0.01;
flag = flag_12psi & flag_0deg;


scatter3(x1(flag), x2(flag), r(flag))

run_all.F = sqrt(run_all.FX.^2 + run_all.FY.^2);
run_all.F0 = sqrt(feval(fit_FX_pure, run_all.FZ, run_all.SL).^2 + feval(fit_FY_pure, run_all.FZ, run_all.SA).^2);

%% Functions
function struct_cat = concat_data(struct1, struct2)
    struct_cat.ET = [struct1.ET; struct2.ET];
    struct_cat.FX = [struct1.FX; struct2.FX];
    struct_cat.FY = [struct1.FY; struct2.FY];
    struct_cat.FZ = [struct1.FZ; struct2.FZ];
    struct_cat.SA = [struct1.SA; struct2.SA];
    struct_cat.SL = [struct1.SL; struct2.SL];
end

function J = compute_cost(x, bd, cd, dd)
    FZ_all = [bd.FZ; cd.FZ; dd.FZ];
    SL_all = [bd.SL; cd.SL; dd.SL];
    SA_all = [bd.SA; cd.SA; dd.SA];

    FX_all = [bd.FX; cd.FX; dd.FX];
    FX_pre = compute_FX(x, FZ_all, SL_all, SA_all);

    J = sum(abs(FX_pre - FX_all));
    end

function FX = compute_FX(x, FZ_all, SL_all, SA_all)
    B = x(1);
    C = x(2);
    D = x(3);
    E = x(4);
    F = x(5);
    G = x(6);
    H = x(7);
    I = x(8);

    FX = ((D + G.*SA_all).*FZ_all + (F + H.*SA_all).*FZ_all.^2).*sin(C.*atan(B.*SL_all-(E + I.*FZ_all).*(B.*SL_all-atan(B.*SL_all))));
end