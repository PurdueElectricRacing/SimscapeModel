% simulates one run, returns cost, which depends on both speed and how
% closely the output matches the desired radius of curvature
% Inputs

function [J] = cost_2WD(x, s0, optsODE, varCAR)
    % extract inputs
    tau = x(1:4)';
    CCSA = x(5);
    
    % run sim
    P = [0; 0; 0; 0]; % no brake pressure
    [t,s] = ode15s(@vehicle_ds, [0 30], s0, optsODE, tau, CCSA, P, varCAR);
    
    % analyze results
    stats = analyze_sim(t, s, [10 30]);
    
    % cost
    J = -stats.V_avg + 1*(18.25 - stats.r_avg)^2 + 25*stats.r_std;
end