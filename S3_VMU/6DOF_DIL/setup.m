clear
addpath("../Master_Model_6DOF_V2")
addpath("../Master_Model_6DOF_V2/Vehicle_Data/")
varCAR = vehicle_parameters;
varCAR = class2struct(varCAR);
s0 = load("s0.mat").s1(1:18)';
dt = 0.01;

M = eye(22,22);
M(19,19) = 0;
M(20,20) = 0;
M(21,21) = 0;
M(22,22) = 0;

optsODE = odeset('Mass',M,'RelTol',1e-2, 'AbsTol', 1e-2);