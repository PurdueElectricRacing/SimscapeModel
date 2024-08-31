%% Get Model
varCAR = varModel;

%% Initial Conditions
x0 = [0.1; 0; 0; varCAR.zs; 0; varCAR.O0; 0; 0; varCAR.v0; varCAR.v0; 0];

%% Boundary Conditions
tau = [0; 5];

%% Configure Solver
optionsODE = odeset('MaxStep',0.5);

%% Simulate
[t,x0] = ode23tb(@compute_ds, [0 1.4], x0, optionsODE, tau, varCAR);

tiledlayout(3, 4)
plot(x0(:,1))
title("X vel")

nexttile
plot(x0(:,2))
title("X distance")

nexttile
plot(x0(:,3))
title("Z vel")

nexttile
plot(x0(:,4))
title("Z distance")

nexttile
plot(x0(:,5))
title("pitch rate")

nexttile
plot(x0(:,6))
title("pitch")

nexttile
plot(x0(:,7))
title("front w")

nexttile
plot(x0(:,8))
title("rear w")

nexttile
plot(x0(:,9))
title("Voc")

nexttile
plot(x0(:,10))
title("Vb")

nexttile
plot(x0(:,11))
title("Ah")