%% Setup
addpath(genpath(pwd))

%% Get Model
varCAR = varModel_master_3DOF;

% varCAR.m = varCAR.m * 2

%% Initialisations
%Initialising tau values
tauval = linspace(1,25,2000);
tauval = tauval(:);

s0 = [0.001; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; varCAR.v0; 0; 0];

vals_all = [];
time = [];
r_all = [];

%% Calcuation

%configuring
optionsODE = odeset('MaxStep', 5, 'AbsTol', 1e-2, 'RelTol', 1e-2);

%runnnig the loop for values
t0 = tic;
timespace = linspace(1,100,200);
for i = 1:200:2000

    s0 = [0.001; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; varCAR.v0; 0; 0];
    %defining tau for the instance
    taut = [0;tauval(i)];

    [t, ss] = ode23tb(@compute_ds_mastersim_3DOF, timespace, s0, optionsODE, taut, varCAR);
    
    vals_all = [vals_all; ss];
    time = [time;t];
    dxplot1 = vals_all(:,1);
end

t1 = toc(t0)

%% Plot

% [V_grid, r_grid] = meshgrid(t,tauval);
% 
% v_all = V_grid(:);
% r_all = r_grid(:);

% v_all = linspace(1,11,121)
% v_all = v_all(:)
% r_all = linspace(1,25,121)
% r_all = r_all(:)

scatter3(time,tauval,dxplot1)
hold on
scatter3(time, tauval, dxplot)