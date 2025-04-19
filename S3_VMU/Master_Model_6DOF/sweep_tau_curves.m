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