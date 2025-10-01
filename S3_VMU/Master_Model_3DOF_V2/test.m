motTcurve_6DOF_scatter = scatteredInterpolant(speedI_tbl_ALL, inverterI_tbl_ALL, torqueI_tbl_ALL,'natural');

%% new
speed_brk = linspace(min(speedI_tbl_ALL), max(speedI_tbl_ALL), 1000);

low_power = 3000;
mid_power = 20000;
high_power = max(inverterI_tbl_ALL);

power_brk_low = linspace(-low_power, low_power, 9000);
power_brk_low_mid_power = linspace(low_power, mid_power, 2000);
power_brk_mid_high_pos = linspace(mid_power, high_power, 500);
power_brk = [-flip(power_brk_mid_high_pos), -flip(power_brk_low_mid_power(1:end-1)), power_brk_low(2:end-1), power_brk_low_mid_power(1:end-1), power_brk_mid_high_pos];

[speed_grid, power_grid] = ndgrid(speed_brk, power_brk);
motTcurve_6DOF_grid_v2 = griddedInterpolant(speed_grid, power_grid, motTcurve_6DOF_scatter(speed_grid, power_grid));

%% old
speedI_tbl_grid_breakpoints = linspace(min(speedI_tbl_ALL), max(speedI_tbl_ALL), 1000);
inverterI_tbl_grid_breakpoints = linspace(min(inverterI_tbl_ALL), max(inverterI_tbl_ALL), 14000);
[speedI_tbl_grid, inverterI_tbl_grid] = ndgrid(speedI_tbl_grid_breakpoints, inverterI_tbl_grid_breakpoints);
motTcurve_6DOF_grid = griddedInterpolant(speedI_tbl_grid, inverterI_tbl_grid, motTcurve_6DOF_scatter(speedI_tbl_grid, inverterI_tbl_grid));

%% plot
figure(1)
scatter3(speedI_tbl_ALL, inverterI_tbl_ALL, torqueI_tbl_ALL,".");
xlabel("speed"); ylabel("power"); zlabel("torque"); title("raw")

figure(2)
scatter3(speedI_tbl_ALL, inverterI_tbl_ALL, motTcurve_6DOF_scatter(speedI_tbl_ALL, inverterI_tbl_ALL),".")
xlabel("speed"); ylabel("power"); zlabel("torque"); title("scatterdInterp")

figure(3)
scatter3(speedI_tbl_ALL, inverterI_tbl_ALL, motTcurve_6DOF_grid(speedI_tbl_ALL, inverterI_tbl_ALL),"."); hold on
% scatter(speedI_tbl_grid, inverterI_tbl_grid, "r."); 
hold off
xlabel("speed"); ylabel("power"); zlabel("torque"); title("grid v1")

figure(4)
scatter3(speedI_tbl_ALL, inverterI_tbl_ALL, motTcurve_6DOF_grid_v2(speedI_tbl_ALL, inverterI_tbl_ALL),"."); hold on
% scatter(speed_grid, power_grid, "r.");
hold off
xlabel("speed"); ylabel("power"); zlabel("torque"); title("grid v2")

figure(5)
scatter3(speedI_tbl_ALL, inverterI_tbl_ALL, (motTcurve_6DOF_grid(speedI_tbl_ALL, inverterI_tbl_ALL)-motTcurve_6DOF_scatter(speedI_tbl_ALL, inverterI_tbl_ALL)),".")
xlabel("speed"); ylabel("power"); zlabel("torque"); title("grid v1 dif")

figure(6)
scatter3(speedI_tbl_ALL, inverterI_tbl_ALL, (motTcurve_6DOF_grid_v2(speedI_tbl_ALL, inverterI_tbl_ALL)-motTcurve_6DOF_scatter(speedI_tbl_ALL, inverterI_tbl_ALL)),".")
xlabel("speed"); ylabel("power"); zlabel("torque"); title("grid v2 dif")