clear
addpath("../Master_Model_6DOF_V2")
addpath("../Master_Model_6DOF_V2/Vehicle_Data/")
varCAR = vehicle_parameters;
varCAR = class2struct(varCAR);
s0 = [0; 0; 0; 0; 0; varCAR.z0(1) + varCAR.L0(1) - varCAR.LN - 0.01; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
s0 = [0; 0; 0; 0; 0; varCAR.z0(1) + varCAR.L0(1) - varCAR.LN - 0.01; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0];
dt = 0.01;

M = eye(26,26);
M(19,19) = 0;
M(20,20) = 0;
M(21,21) = 0;
M(22,22) = 0;
M(23,23) = 0; % FL
M(24,24) = 0; % FR
M(25,25) = 0; % RL
M(26,26) = 0; % RR

optsODE = odeset('Mass',M,'RelTol',1e-2, 'AbsTol', 1e-2);