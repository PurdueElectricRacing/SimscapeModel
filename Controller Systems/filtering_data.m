%% Import Data
opts = spreadsheetImportOptions("NumVariables", 13);
opts.Sheet = "2023_5_11_controller_testing_RA";
opts.DataRange = "A2:M212987";
opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "left_wheel_omega", "right_wheel_omega", "Var8", "Var9", "Var10", "gps_vel_n", "gps_vel_e", "gps_vel_d"];
opts.SelectedVariableNames = ["left_wheel_omega", "right_wheel_omega", "gps_vel_n", "gps_vel_e", "gps_vel_d"];
opts.VariableTypes = ["char", "char", "char", "char", "char", "double", "double", "char", "char", "char", "double", "double", "double"];
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var8", "Var9", "Var10"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var8", "Var9", "Var10"], "EmptyFieldRule", "auto");
unfiltered_data = readtable("Vehicle Testing Source Data\2023_5_11_controller_testing_RAW.xlsx", opts, "UseExcel", false);
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

wL_filtered = filloutliers(wL,"linear","movmedian",40);
wL_filtered = smoothdata(wL_filtered,"movmean","SmoothingFactor",0.0003);

wR_filtered = filloutliers(wR,"linear","movmedian",40);
wR_filtered = smoothdata(wR_filtered,"movmean","SmoothingFactor",0.0003);

plot(wL_filtered)