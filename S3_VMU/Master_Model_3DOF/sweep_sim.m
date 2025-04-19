%% Setup
addpath(genpath(pwd))

%% Get Model
varCAR = varModel_master_3DOF;

%% Initial Conditions
vvec = linspace(0,16000,20);
rvec = linspace(1,25,10);

[V_grid, r_grid] = meshgrid(vvec,rvec);

s0 = [0.001; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; varCAR.v0; 0; 0];

v_all2 = V_grid(:);
r_all2 = r_grid(:);

n = length(v_all2);

vals_all2 = zeros(n,numel(s0));
%% Boundary Conditions
% for idx = 1:25
% 
%     tau(idx,:) = [idx;25-idx]
% 
% end

Assa = linspace(2000,2500,10);
tau = linspace(25,0,10);
count = 1;


%% Configure Solver
optionsODE = odeset('MaxStep', 5, 'AbsTol', 1e-4, 'RelTol', 1e-4);
%% Simulate
t0 = tic;
for i = 1:n
    s0 = [0.001; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; v_all2(i); 0; 0];
    % Solve the ODE
    taut = [0;r_all2(i)];
    [t, ss] = ode23tb(@compute_ds_mastersim_3DOF, [0 10], s0, optionsODE, taut, varCAR);
    ddx_call = compute_ds_mastersim_3DOF(t, s0, taut, varCAR); 
    ddx_plot(i) = ddx_call(1);
    endsize = size(ss);
    % Store the final values of the solution vector s and the final value of t
    vals_all2 = ss(endsize(1),:); % Storing the last column of ss
    %disp(ddx_plot);
    power_plot2(i) = vals_all2 (9) * vals_all2(12);
    %count = count + 1;
    %inpR(i,:) = [taut(1),taut(2),v_all(i)];
    %end_stateR(i,:) = vals_all2;
end
t1 = toc(t0);
disp(t1)

%tau = (tau.*ones(2,length(t)))';
%t1 = toc(t0);

%% Pack output
%%v_master = compute_v_master_3DOF(t, s, tau, varCAR);

%% plot data
%IMf_Imr = vals_all(:,10)
%pow_pow = vals_all(:,9).*(IMf_Imr(1)+IMf_Imr(2));
% scatter3(r_all,v_all,ddx_plot);
% xlabel("Torque (Nm)")
% ylabel("State of Discharge (SOD)")
% zlabel("Inverter Input Power (W)")
% max_open = abs(max(ddx_plot));
% disp(max_open);
% filename2 = "Dynamic_F&R_PowerR.m"
% save("Dynamic_R_PowerR.mat","inpR","end_stateR");
save("3DOF_v","v_all2");
save("3DOF_r","r_all2");
save("3DOF_p","power_plot2");
%plot(tau,power_plot)

