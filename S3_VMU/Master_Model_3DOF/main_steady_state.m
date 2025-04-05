%% Initialize model and such
opts = optimoptions("fsolve",'Algorithm', 'trust-region','FiniteDifferenceType','central','FiniteDifferenceStepSize',1e-8);
varCAR = varModel_master_3DOF;

% if velocity is 0, torque = [0;0] this works
% s = [10; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; 0; 0; 0];
% tauRaw = [0;0];
% vals = fsolve(@compute_ds_master_3DOF,s,opts,tauRaw,varCAR);
% res  = compute_ds_master_3DOF(vals, tauRaw, varCAR);

s = [10; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0; 0];

vvec = linspace(1,15,15);
rvec = linspace(0,1,10);

[V_grid, r_grid] = meshgrid(vvec,rvec);

v_all = V_grid(:);
r_all = r_grid(:);

n = length(v_all);

vals_all = zeros(n,numel(s));

% if velocity is 0, torque = [0;15] this works
for idx = 1:n
        s = [v_all(idx); 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; 0; 0; 0; 12.5;12.5;r_all(idx)];
        ref_val = [0;v_all(idx);0;0;0;0;0;0;0;0;0;0;r_all(idx)];
        vals = fsolve(@compute_res_master,s,opts,varCAR,ref_val);
        res  = compute_res_master(vals, varCAR, ref_val);
        vals_all(idx,:) = vals;
end

pow_pow = vals_all(:,9).*(vals_all(:,11)+vals_all(:,12));
scatter3(v_all,r_all,pow_pow);


%% Tester
s = [15; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; 1000; 0; 0; 10; 10; 0];
ref_val = [0;15;0;0;0;0;0;0;0;1000;0;0;0];
vals = fsolve(@compute_res_master,s,opts,varCAR,ref_val);