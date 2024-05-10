%% Parameters
nF = 4;

%% load raw data
opts = spreadsheetImportOptions("NumVariables", 24);
opts.Sheet = "Sheet1";
opts.DataRange = "A5:X86402";
opts.VariableNames = ["Bus", "Main", "Main_1", "Main_2", "Main_3", "Main_4", "Main_5", "Main_6", "Main_7", "Main_8", "Main_9", "Main_10", "Main_11", "Main_12", "Main_13", "Main_14", "Main_15", "Main_16", "Main_17", "Main_18", "Main_19", "Main_20", "Main_21", "Main_22"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
tv_in = readtable("torque_vectoring_input.xlsx", opts, "UseExcel", false);
tv_in = table2array(tv_in);
clear opts

%% load tv data
load mm_in_04_20_2024_endurance.mat

%% Parse Data
time = tv_in(:,1);
V = tv_in(:,4);
ws = tv_in(:,5:6)*5.75;

n = length(time);
D = [V ws];
F = boolean(ones(n, nF));

%% Create Input Signals
D_raw = timeseries(D,time,[],"Name","D_raw");
F_raw = timeseries(F,time,[],"Name","F_raw");

% create dataset
ds_tm = Simulink.SimulationData.Dataset;

ds_tm = addElement(ds_tm,D_raw,"D_raw");
ds_tm = addElement(ds_tm,F_raw,"F_raw");
ds_tm = addElement(ds_tm,rEQUAL,"rEQUAL");
ds_tm = addElement(ds_tm,rTVS,"rTVS");

% save dataset
save("throttle_map_input_dataset.mat","ds_tm")