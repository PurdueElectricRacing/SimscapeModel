global S
S = [0;0];

varCAR = varModel_master_3DOF;
s = [0.001; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; 0; 0; 0];
ref_val = [0;0;0;0;0;0;0;0;0;0;0;0];
tauRaw = [0;0];

tauf = linspace(0,11,11);

% vals = fsolve(@computer_res_master,s,optimoptions("fsolve"),tauRaw, varCAR,ref_val);
% [resv]  = computer_res_master(vals, tauRaw, varCAR, ref_val);

vals = fsolve(@compute_ds_master_3DOF,s,optimoptions("fsolve"),tauRaw,varCAR);
[resv]  = compute_ds_master_3DOF(vals, tauRaw, varCAR);