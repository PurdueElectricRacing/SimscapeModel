% load data
load("throttle_map_input.mat")

% create signals
w_signal = timeseries(w_data,time,[],"Name","w");
V_signal = timeseries(V_data,time,[],"Name","V");
rEQUAL_signal = timeseries(rEQUAL_data,time,[],"Name","rEQUAL");
rTVS_signal = timeseries(rTVS_data,time,[],"Name","rTVS");
TVS_STATE_signal = timeseries(TVS_STATE_data,time,[],"Name","TVS_STATE");

% create dataset
ds_tm = Simulink.SimulationData.Dataset;

ds_tm = addElement(ds_tm,w_signal,"w");
ds_tm = addElement(ds_tm,V_signal,"V");
ds_tm = addElement(ds_tm,rEQUAL_signal,"rEQUAL");
ds_tm = addElement(ds_tm,rTVS_signal,"rTVS");
ds_tm = addElement(ds_tm,TVS_STATE_signal,"TVS_STATE");

% save dataset
save("throttle_map_input_dataset.mat","ds_tm")