function y = get_PT(p,y)
    %% Load interpolant data
    load(p);  % VMU/lib_p/Motor_tables/TorqueTable.mat
    %% Get Maximum Torque
    speed_query = y.w_sf;
    voltage_query = y.VB_sf;
    maxT = torqInterpolant(speed_query, voltage_query);
end