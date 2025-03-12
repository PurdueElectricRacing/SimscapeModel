%% Setup
addpath(genpath(pwd))

%% Get Model
varCAR = varModel_master_3DOF;

%% Initial Conditions
vvec = linspace(1,1000,5);
rvec = linspace(1,25,5);

[V_grid, r_grid] = meshgrid(vvec,rvec);

s0 = [0.001; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; varCAR.v0; 0; 0];

v_all = V_grid(:);
r_all = r_grid(:);

n = length(v_all);

vals_all = zeros(n,numel(s0));
%% Boundary Conditions


%% Configure Solver
optionsODE = odeset('MaxStep', 5, 'AbsTol', 1e-4, 'RelTol', 1e-4);

%% Simulate
for i = 1:n
    s0 = [0.001; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; v_all(i); 0; 0];
    % Solve the ODE
    [t, ss] = ode23tb(@compute_ds_mastersim_3DOF, [0 10], s0, optionsODE, tau, varCAR);
    endsize = size(ss);
    % Store the final values of the solution vector s and the final value of t
    vals_all(i,:) = ss(endsize(1),:); % Storing the last column of s
    
end
t0 = tic;

tau = (tau.*ones(2,length(t)))';
t1 = toc(t0);

%% Pack output
%%v_master = compute_v_master_3DOF(t, s, tau, varCAR);

%% plot data
IMf_Imr = vals_all(:,10)
pow_pow = vals_all(:,9).*(IMf_Imr(1)+IMf_Imr(2));
scatter3(v_all,t11,pow_pow);