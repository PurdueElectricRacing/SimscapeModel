%% Add paths
addpath(genpath(pwd))

%% Run master
main_master

%% Recover algebraic variables
v = compute_v_master(x0, tau, varCAR);

figure(2)

tiledlayout(3, 4)

nexttile
plot(t, v.w)
title("X vel")

% nexttile
% plot(t, x0(:,2))
% title("X distance")
% 
% nexttile
% plot(t, x0(:,3))
% title("Z vel")
% 
% nexttile
% plot(t, x0(:,4))
% title("Z distance")
% 
% nexttile
% plot(t, x0(:,5))
% title("pitch rate")
% 
% nexttile
% plot(t, x0(:,6))
% title("pitch")
% 
% nexttile
% plot(t, x0(:,7))
% title("front w")
% 
% nexttile
% plot(t, x0(:,8))
% title("rear w")
% 
% nexttile
% plot(t, x0(:,9))
% title("Voc")
% 
% nexttile
% plot(t, x0(:,10))
% title("Vb")
% 
% nexttile
% plot(t, x0(:,11))
% title("Ah")
% 
% nexttile
% plot(t, x0(:,1) - x0(:,8)*varCAR.r0)
% title("m/s")