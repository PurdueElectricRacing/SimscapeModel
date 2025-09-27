clear
addpath("../Master_Model_6DOF_V2")
addpath("../Master_Model_6DOF_V2/Vehicle_Data/")
varCAR = vehicle_parameters;
varCAR = class2struct(varCAR);
s0 = [0; 0; 0; 0; 0; varCAR.z0(1) + varCAR.L0(1) - varCAR.LN - 0.01; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0];