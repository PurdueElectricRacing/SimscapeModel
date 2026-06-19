% load data
path = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\may10-accel-skids\out_001.csv";
% path = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\may3_part1\out_000.csv";
% T = data2table(path, "removeNaN", "filldata");

%% Plotting Data
%% motors
INV_setpoints = [T.MAIN_MODULE.INVB_SET.AMK_TorqueSetpoint, ...
               T.MAIN_MODULE.INVA_SET.AMK_TorqueSetpoint, ...
               T.MAIN_MODULE.INVC_SET.AMK_TorqueSetpoint, ...
               T.MAIN_MODULE.INVD_SET.AMK_TorqueSetpoint];
figure(1)
tiledlayout(2,2, TileSpacing="compact")
p1 = nexttile;
plot(T.time, INV_setpoints, "-")
legend("FL","FR","RL","RR")
title("Torque")

p2 = nexttile;
plot(T.time, T.DASHBOARD.steering_angle.angle, "-")
title("Steering")


p3 = nexttile;
plot(T.time, -T.TORQUE_VECTOR.IMU_angular_rate.Z_axis);
title("Yaw")

linkaxes([p1 p2, p3], "x")
zoom(gcf, "xon")

%% Power
figure(2)
tiledlayout(2,2, TileSpacing="compact")
p4 = nexttile;
plot(T.time, T.A_BOX.pack_stats.pack_voltage);
title("voltage")

p5 = nexttile;
plot(T.time,T.A_BOX.pack_stats.pack_current)
title("current")

p6 = nexttile;
PB = T.A_BOX.pack_stats.pack_current .* T.A_BOX.pack_stats.pack_voltage;
plot(T.time, PB);
title("Power")

linkaxes([p1 p2, p3, p4, p5, p6], "x")
zoom(gcf, "xon")