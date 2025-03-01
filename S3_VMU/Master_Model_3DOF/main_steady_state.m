%% Initialize model and such
global S
S = [0;0];
opts = optimoptions("fsolve",'Algorithm', 'trust-region-dogleg','FiniteDifferenceType','central','FiniteDifferenceStepSize',1e-4);
varCAR = varModel_master_3DOF;

% if velocity is 0, torque = [0;0] this works
s = [10; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; 0; 0; 0];
tauRaw = [0;0];
vals = fsolve(@compute_ds_master_3DOF,s,opts,tauRaw,varCAR);
res  = compute_ds_master_3DOF(vals, tauRaw, varCAR);

% if velocity is 0, torque = [0;15] this works
s = [0; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; 0; 0; 0; 12.5;12.5];
ref_val = [0;10;0;0;0;0;0;0;0;0;0;0];
vals = fsolve(@compute_res_master,s,opts,varCAR,ref_val);
res  = compute_res_master(vals, varCAR, ref_val);
