% load data
load("torque_vectoring_input.mat")

% create dataset
ds_tv = Simulink.SimulationData.Dataset;

ds_tv = addElement(ds_tv,D_raw,"D_raw");
ds_tv = addElement(ds_tv,F_raw,"F_raw");
ds_tv = addElement(ds_tv,R,"R");
ds_tv = addElement(ds_tv,TVS_P,"TVS_P");
ds_tv = addElement(ds_tv,TVS_I,"TVS_I");
ds_tv = addElement(ds_tv,dphi,"dphi");

% save dataset
save("torque_vectoring_input_dataset.mat","ds_tv")