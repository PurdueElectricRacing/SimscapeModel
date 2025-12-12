% takes t and s data from a vehicle simulation, and returns statistics
% INPUTS
%   t       timesteps of sim [N 1]
%   s       states of sim [N 26]
%   tSpan   time range to analyze [tMin, tMax]
function [stats] = analyze_sim(t, s, tSpan)
    % if no inputs, return empty struct
    if nargin == 0
        stats.V_avg = 0;
        stats.r_avg = 0;
        stats.V_std = 0;
        stats.r_std = 0;
        return
    end
    
    % only take statsitics from specified time of run
    t_ind = t >= tSpan(1) & t <= tSpan(2);

    % get raw values from sim data
    Vx = s(t_ind, 1);
    Vy = s(t_ind, 3);
    drho = s(t_ind, 11);
    
    % intermediate values
    V = sqrt(Vx.^2 + Vy.^2);


    % calculate statistics
    stats.V_avg = mean(V);
    stats.r_avg = mean(V ./ drho);
    stats.V_std = std(V);
    stats.r_std = std(V ./ drho);
end