%% Parameters
nF = 13;

%% load data
opts = spreadsheetImportOptions("NumVariables", 24);
opts.Sheet = "Sheet1";
opts.DataRange = "A5:X86402";
opts.VariableNames = ["Bus", "Main", "Main_1", "Main_2", "Main_3", "Main_4", "Main_5", "Main_6", "Main_7", "Main_8", "Main_9", "Main_10", "Main_11", "Main_12", "Main_13", "Main_14", "Main_15", "Main_16", "Main_17", "Main_18", "Main_19", "Main_20", "Main_21", "Main_22"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
tv_in = readtable("torque_vectoring_input.xlsx", opts, "UseExcel", false);
tv_in = table2array(tv_in);
clear opts

%% Parse Data
time = tv_in(:,1);
t = tv_in(:,2)/100;
s = tv_in(:,3);
V = tv_in(:,4);
ws = tv_in(:,5:6)*5.75;
ve = sqrt(tv_in(:,7).^2 + tv_in(:,8).^2 + tv_in(:,9).^2);
gy = tv_in(:,10:12);
bI = tv_in(:,13);
mcT = max(tv_in(:,14:15),[],2);
mT = max(tv_in(:,16:17),[],2);
bT = tv_in(:,18);
ac = tv_in(:,19:21);

n = length(time);
D = [t s V ws ve gy bI mcT mT bT ac];
F = boolean(ones(n, nF));

ds = tv_in(:,22);
I = tv_in(:,23);
P = tv_in(:,24);

%% Find R
R = ac_compute_R(ac(1:150,1), ac(1:150,2), ac(1:150,3));
R_mat = repmat(R(:)',n,1);

%% Create Input Signals
D_raw = timeseries(D,time,[],"Name","D_raw");
F_raw = timeseries(F,time,[],"Name","F_raw");
R = timeseries(R,0,[],"Name","R");

TVS_P = timeseries(P,time,[],"Name","TVS_P");
TVS_I = timeseries(I,time,[],"Name","TVS_I");
dphi = timeseries(ds,time,[],"Name","dphi");

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