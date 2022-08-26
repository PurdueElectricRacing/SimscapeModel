rpm_sweep = linspace(0, 10600, 107);
torque_sweep = linspace(0, 2500, 251);

rpm_extend = ones(251, 1);
torque_extend = ones(1, 107);

rpm_grid = rpm_extend * rpm_sweep;
torque_grid = torque_sweep' * torque_extend;

%rpm_grid = rpm_grid(:);
%torque_grid = torque_grid(:);

efficiency_grid = (griddata(all_rpm,all_torque,all_efficiency,rpm_grid,torque_grid)' + 0.01) .* 100;

max_torque = flip([all_torque(2159:end-4); 2500]');
max_rpm = flip([all_rpm(2159:end-4); 0]');

%% Unit Conversions
rpm_sweep = rpm_sweep .* 0.104719755;
torque_sweep = torque_sweep ./ 100;

max_torque = max_torque ./ 100;
max_rpm = max_rpm .* 0.104719755;

A = unique(all_rpm);

%scatter3(rpm_grid, torque_grid, efficiency_grid);