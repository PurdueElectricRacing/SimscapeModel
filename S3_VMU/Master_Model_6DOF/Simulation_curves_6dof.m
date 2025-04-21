%% Setup
addpath(genpath(pwd))

%% Get Model
varCAR = varModel_master_6DOF;

%% Initialisations
%Initialising tau values
tauval = linspace(1,25,2000);
tauval = tauval(:);

s0 = [0; 0; 0; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0];
timespace = linspace(1,100,200);
vals_all = [];
%% Calcuation

%configuring
optionsODE = odeset('MaxStep', 5, 'AbsTol', 1e-2, 'RelTol', 1e-2);

%runnnig the loop for values
t0 = tic;

for i = 1:200:2000

    s0 = [0; 0; 0; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0];
    %defining tau for the instance
    taut = [0;0;tauval(i);tauval(i)];

    [t, ss] = ode23tb(@compute_ds_mastersim_6DOF, timespace, s0, optionsODE, taut, 0, varCAR);

    vals_all = [vals_all; ss];

    dxplot = vals_all(:,1);
end

t1 = toc(t0)

%% Plot

[V_grid, r_grid] = meshgrid(t,tauval);

v_all = V_grid(:);
r_all = r_grid(:);

scatter3(v_all,r_all,dxplot)

save("6DOF_nm","dxplot");




%% POWER SECTION

vvec = linspace(0,16000,20);
rvec = linspace(1,25,10);

[V_grid, r_grid] = meshgrid(vvec,rvec);

s0 = [0; 0; 0; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; 0; 0; 0; 0; 0; 0; varCAR.v0; 0; 0; 0; 0; 0];

v_all = V_grid(:);
r_all = r_grid(:);

n = length(v_all);

vals_all = zeros(n,numel(s0));
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
    s0 = [0; 0; 0; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; 0; 0; 0; 0; 0; 0; varCAR.v0; v_all(i); 0; 0; 0; 0];
    % Solve the ODE
    taut = [0;0;r_all(i);r_all(i)];
    [t, ss] = ode23tb(@compute_ds_mastersim_6DOF, [0 10], s0, optionsODE, taut, 0, varCAR);
    ddx_call = compute_ds_mastersim_6DOF(t, s0, taut, 0, varCAR); 
    ddx_plot(i) = ddx_call(1)
    endsize = size(ss);
    % Store the final values of the solution vector s and the final value of t
    vals_all = ss(endsize(1),:); % Storing the last column of ss
    %disp(ddx_plot);
    power_plot(i) = (vals_all(21)+vals_all(22)) * vals_all(17);
    %count = count + 1;
    inpR2(i,:) = [taut(1),taut(2),v_all(i)];
    end_stateR2(i,:) = vals_all;
end 
t1 = toc(t0);
disp(t1)

%tau = (tau.*ones(2,length(t)))';
%t1 = toc(t0);

%% Pack output
% %%v_master = compute_v_master_3DOF(t, s, tau, varCAR);
% 
% %% plot data
% % %IMf_Imr = vals_all(:,10)
% % %pow_pow = vals_all(:,9).*(IMf_Imr(1)+IMf_Imr(2));
% scatter3(r_all,v_all,power_plot);
% % xlabel("Torque (Nm)")
% % ylabel("State of Discharge (SOD)")
% % zlabel("Inverter Input Power (W)")
% % max_open = abs(max(ddx_plot));
% % disp(max_open);
% % filename2 = "Dynamic_F&R_PowerR.m"
% % save("Dynamic_R2_PowerR.mat","inpR2","end_stateR2");
% save("6DOF_v","v_all");
% save("6DOF_r","r_all");
% save("6DOF_p","power_plot");
% % %plot(tau,power_plot)

