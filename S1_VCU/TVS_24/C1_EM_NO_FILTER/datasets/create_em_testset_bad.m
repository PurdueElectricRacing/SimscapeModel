%% Get Data
opts = spreadsheetImportOptions("NumVariables", 9);
opts.Sheet = "raw_data";
opts.DataRange = "A5:I18995";
% opts.VariableNames = ["Bus", "Main", "Main_1", "Main_2", "Main_3", "Main_4", "Main_5", "Main_6"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double"];
emdata = readtable("datasets\em_data_bad.xlsx", opts, "UseExcel", false);
emdata = table2array(emdata);
clear opts

%% Parse Data
time = emdata(:,1);
w_data = emdata(:,2:3);
V_data = emdata(:,9);
rEQUAL_data = [emdata(:,5) emdata(:,5)] / 100;
rTVS_data = [emdata(:,5) emdata(:,5)] / 100;
TVS_STATE_data = emdata(:,6);

%% create signals
w_signal = timeseries(w_data,time,[],"Name","w");
V_signal = timeseries(V_data,time,[],"Name","V");
rEQUAL_signal = timeseries(rEQUAL_data,time,[],"Name","rEQUAL");
rTVS_signal = timeseries(rTVS_data,time,[],"Name","rTVS");
TVS_STATE_signal = timeseries(TVS_STATE_data,time,[],"Name","TVS_STATE");

%% create dataset
ds_em_test_bad = Simulink.SimulationData.Dataset;

ds_em_test_bad = addElement(ds_em_test_bad,w_signal,"w");
ds_em_test_bad = addElement(ds_em_test_bad,V_signal,"V");
ds_em_test_bad = addElement(ds_em_test_bad,rEQUAL_signal,"rEQUAL");
ds_em_test_bad = addElement(ds_em_test_bad,rTVS_signal,"rTVS");
ds_em_test_bad = addElement(ds_em_test_bad,TVS_STATE_signal,"TVS_STATE");

%% save dataset
save("ds_em_test_bad.mat","ds_em_test_bad")