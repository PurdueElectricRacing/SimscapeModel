function [maxT] = get_max_T(p,y)
    %% Load interpolant data
    load(p);
    %% Get Maximum Torque
    speed_query = y.w_sf;
    voltage_query = y.VB_sf;
    maxT = torqInterpolant(speed_query, voltage_query);
end