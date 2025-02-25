%% Initialize model and such
global S
S = [0;0];
opts = optimoptions("fsolve",'Algorithm', 'trust-region','FiniteDifferenceType','central','FiniteDifferenceStepSize',1e-8);
varCAR = varModel_master_3DOF;
s = [0; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; 0; 0; 0];

% if tauRaw = [0;0] and dx = 0, this works
tauRaw = [0;0];
vals = fsolve(@compute_ds_master_3DOF,s,opts,tauRaw,varCAR);
res  = compute_ds_master_3DOF(vals, tauRaw, varCAR);

% if velocity is 0, torque = [0;15] this works
tauRaw = [0;15];
ref_val = [0;0;0;0;0;0;0;0;0;0;0;0];
vals = fsolve(@compute_res_master,s,opts,tauRaw,varCAR,ref_val);
res  = compute_res_master(vals, tauRaw, varCAR, ref_val);