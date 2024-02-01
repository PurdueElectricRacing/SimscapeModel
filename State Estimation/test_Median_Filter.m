%% import temperature data
opts = spreadsheetImportOptions("NumVariables", 5);
opts.Sheet = "2023_5_11_controller_testing_RA";
opts.DataRange = "A2:E212987";
opts.VariableNames = ["Var1", "left_temp_motor", "right_temp_motor", "left_temp_controller", "right_temp_controller"];
opts.SelectedVariableNames = ["left_temp_motor", "right_temp_motor", "left_temp_controller", "right_temp_controller"];
opts.VariableTypes = ["char", "double", "double", "double", "double"];
opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");
controllertestingRAW = readtable("Vehicle Testing Source Data\2023_5_11_controller_testing_RAW.xlsx", opts, "UseExcel", false);
controllertestingRAW = table2array(controllertestingRAW);
clear opts

%% Define paremeters
[n,~] = size(controllertestingRAW);
t = linspace(0,n-1,n).*0.015;
m = 1; % select which temperature to filter
s = 149; % MUST BE ODD NUMBER

%% Vectors
T0_filt = zeros(s,1);
T_filt = zeros(n,1);

%% Apply Filter
for i = 1:n
    [Tn_filt,T0_filt] = Median_Filter(T0_filt,controllertestingRAW(i,m));
    T_filt(i) = Tn_filt;
end

%% Visualize Filter
% Set Defaults
set(0,'defaultLineLineWidth', 2)
set(0,'defaultAxesFontName' , 'Times')
set(0,'defaultTextFontName' , 'Times')
set(0,'defaultAxesFontSize' , 16)
set(0,'defaultTextFontSize' , 16)
set(0,'defaultAxesGridLineStyle','-.')

figure(1)
scatter(t,controllertestingRAW(:,m))
hold on
plot(t,T_filt(:,1))

xlabel("Time (s)")
ylabel("Temperature (" + char(176) + "C)")

legend("Raw Data","Filtered Data")

%% Save Data
% save_figure(figure(1),'T_Filter','png')
% save_figure(figure(1),'T_Filter_zoom','png')