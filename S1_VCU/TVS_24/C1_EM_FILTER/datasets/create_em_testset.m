%% Get Data
opts = spreadsheetImportOptions("NumVariables", 8);
opts.Sheet = "raw_data";
opts.DataRange = "A5:H21651";
opts.VariableNames = ["Bus", "Main", "Main_1", "Main_2", "Main_3", "Main_4", "Main_5", "Main_6"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double"];
emdata = readtable("datasets\em_data.xlsx", opts, "UseExcel", false);
emdata = table2array(emdata);
clear opts

%% Parse Data
time = emdata(:,1);
w_data = emdata(:,2:3);
V_data = emdata(:,4);
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
ds_em_test_v0 = Simulink.SimulationData.Dataset;

ds_em_test_v0 = addElement(ds_em_test_v0,w_signal,"w");
ds_em_test_v0 = addElement(ds_em_test_v0,V_signal,"V");
ds_em_test_v0 = addElement(ds_em_test_v0,rEQUAL_signal,"rEQUAL");
ds_em_test_v0 = addElement(ds_em_test_v0,rTVS_signal,"rTVS");
ds_em_test_v0 = addElement(ds_em_test_v0,TVS_STATE_signal,"TVS_STATE");

%% save dataset
save("ds_em_test_v0.mat","ds_em_test_v0")