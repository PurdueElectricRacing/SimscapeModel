%% Import Data
opts = spreadsheetImportOptions("NumVariables", 13);
opts.Sheet = "2023_5_11_controller_testing_RA";
opts.DataRange = "A2:M212987";
opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "left_wheel_omega", "right_wheel_omega", "Var8", "Var9", "Var10", "gps_vel_n", "gps_vel_e", "gps_vel_d"];
opts.SelectedVariableNames = ["left_wheel_omega", "right_wheel_omega", "gps_vel_n", "gps_vel_e", "gps_vel_d"];
opts.VariableTypes = ["char", "char", "char", "char", "char", "double", "double", "char", "char", "char", "double", "double", "double"];
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var8", "Var9", "Var10"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var8", "Var9", "Var10"], "EmptyFieldRule", "auto");
unfiltered_data = readtable("2023_5_11_controller_testing_RAW.xlsx", opts, "UseExcel", false);
unfiltered_data = table2array(unfiltered_data);
clear opts

%% Filter Velocity
vN = unfiltered_data(:,3);
vE = unfiltered_data(:,4);
vD = unfiltered_data(:,5);

vN_filtered = filloutliers(vN,"linear","percentiles",[0.01 99.98999999999999]);
vE_filtered = filloutliers(vE,"linear","percentiles",[0.013 99.995]);
vD_filtered = filloutliers(vD,"linear","percentiles",[0.007 99.98999999999999]);

%% Filter Wheel Speed
wL = unfiltered_data(:,1);
wR = unfiltered_data(:,2);

% wL_filtered = filloutliers(wL,"linear","movmedian",40);
%wL_filtered = smoothdata(wL_filtered,"movmean","SmoothingFactor",0.0003);

wR_filtered = filloutliers(wR,"linear","movmedian",40);
%wR_filtered = smoothdata(wR_filtered,"movmean","SmoothingFactor",0.0003);

%% Better Wheel Speed Filter
N = 70;
x = linspace(0,1,N)';
d = 4;

N1 = 76896;
N2 = N1 + 100;
num = length(wL) - N + 1;

% form data matrix
D = zeros(N,d);

for i = 1:d
    D(:,i) = legendreP(i-1,x);
end

% form inequality matrix
A = [D -eye(N); -D -eye(N)];

% form cost function
f = [zeros(d,1); ones(N,1)];

% apply filter
%wL_filtered = zeros(length(wL),1);
options = optimoptions('linprog','Algorithm','dual-simplex','display','none');

t0 = tic;
for i = N1:N2
    % get data
    data = wL(i:i+N-1);

    % form inequality vector
    b = [data; -data];

    % solve optimization
    x = linprog(f,A,b,[],[],[],[],options);

    % compute last point
    wL_x = x(1)*legendreP(0,1) + x(2)*legendreP(1,1) + x(3)*legendreP(2,1) + x(4)*legendreP(3,1);
    wL_filtered(i+N-1) = wL_x;
end
t1 = toc(t0);