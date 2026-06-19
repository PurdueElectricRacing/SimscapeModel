clearvars
close all
clc

path = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\june-14-morning\out_005_2026_06_14__09_51_49.csv";
path1 = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\june-14-crash\data\data\out_000_2026_06_14__21_45_42.csv";
path2 = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\june-14-crash\data\data\out_001_2026_06_14__21_47_27.csv";
path3 = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\june-14-crash\data\data\out_002_2026_06_14__21_48_44.csv";
may10_0 = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\may10-accel-skids\out_000.csv";
may10_1 = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\may10-accel-skids\out_001.csv";
may10_2 = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\may10-accel-skids\out_002.csv";
may10_3 = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\may10-accel-skids\out_003.csv";
T = data2table(may10_1, nodeRow=2, messageRow=3, signalRow=4, dataRow=5, nameColumn=2, fillMissing=true, printTable=true);
fprintf("---------\n")

%% Time
time = T.time;

%% Temps
IGBT_temps = [T.INVERTER_A.INVA_TEMPS.AMK_IGBTTemp, ...
              T.INVERTER_B.INVB_TEMPS.AMK_IGBTTemp, ...
              T.INVERTER_C.INVC_TEMPS.AMK_IGBTTemp, ...
              T.INVERTER_D.INVD_TEMPS.AMK_IGBTTemp];
MOT_temps = [T.INVERTER_A.INVA_TEMPS.AMK_MotorTemp, ...
             T.INVERTER_B.INVB_TEMPS.AMK_MotorTemp, ...
             T.INVERTER_C.INVC_TEMPS.AMK_MotorTemp, ...
             T.INVERTER_D.INVD_TEMPS.AMK_MotorTemp];
INV_temps =  [T.INVERTER_A.INVA_TEMPS.AMK_InverterTemp, ...
             T.INVERTER_B.INVB_TEMPS.AMK_InverterTemp, ...
             T.INVERTER_C.INVC_TEMPS.AMK_InverterTemp, ...
             T.INVERTER_D.INVD_TEMPS.AMK_InverterTemp];
figure(1);
set(gcf, "Name", "Temps")
t1 = tiledlayout(2,2, TileSpacing="compact");
title(t1, "Temps")
nexttile
plot(time, INV_temps)
legend("INV A", "INV B", "INV C", "INV D", Location="southeast")
title("Inverter")

nexttile
plot(time, IGBT_temps)
legend("INV A", "INV B", "INV C", "INV D", Location="southeast")
title("IGBT")

nexttile
plot(time, MOT_temps)
legend("INV A", "INV B", "INV C", "INV D", Location="southeast")
title("Motor")

%% Battery
figure(2)
set(gcf, "Name", "Battery")
t2 = tiledlayout(2, 2, TileSpacing="compact");
title(t2, "Battery")
nexttile;
plot(time, T.A_BOX.pack_stats.pack_current);
title("Current")

nexttile;
plot(time, T.A_BOX.pack_stats.pack_voltage);
title("Voltage")

nexttile;
plot(time, T.A_BOX.pack_stats.pack_voltage .* T.A_BOX.pack_stats.pack_current);
title("Power")

nexttile;
% plot(time, T.A_BOX.pack_stats.plot);
title("Temp")
%% Shockpots
figure(4)
set(gcf, "Name", "Shockpots")
t4 = tiledlayout(2, 2, TileSpacing="compact");
title(t4, "Shockpots")
nexttile;
plot(time, T.DRIVELINE.front_shockpots.left);
title("FL")

nexttile;
plot(time, T.DRIVELINE.front_shockpots.right);
title("FR")

nexttile;
plot(time, T.DRIVELINE.rear_shockpots.left);
title("RL")

nexttile;
plot(time, T.DRIVELINE.rear_shockpots.right);
title("RR")

%% speeds
figure(5)
set(gcf, "Name", "Motor Speed")
t5 = tiledlayout(2, 2, TileSpacing="compact");
title(t5, "Motor Speed")

nexttile
plot(time, T.INVERTER_B.INVB_CRIT.AMK_ActualSpeed)
title("INV B")

nexttile;
plot(time, T.INVERTER_A.INVA_CRIT.AMK_ActualSpeed)
title("INV A")

nexttile
plot(time, T.INVERTER_C.INVC_CRIT.AMK_ActualSpeed)
title("INV C")

nexttile
plot(time, T.INVERTER_D.INVD_CRIT.AMK_ActualSpeed)
title("INV D")

%% Inverter Toruqes
figure(6)
set(gcf, "Name", "INV Torque")
t6 = tiledlayout(2, 2, TileSpacing="compact");
title(t6, "Inverter Torque")

nexttile
plot(time, T.INVERTER_B.INVB_CRIT.AMK_ActualTorque)
title("INV B")

nexttile;
plot(time, T.INVERTER_A.INVA_CRIT.AMK_ActualTorque)
title("INV A")


nexttile
plot(time, T.INVERTER_C.INVC_CRIT.AMK_ActualTorque)
title("INV C")

nexttile
plot(time, T.INVERTER_D.INVD_CRIT.AMK_ActualTorque)
title("INV D")


%% Torque Vector Toruqes
figure(7)
set(gcf, "Name", "TV Torque")
t7 = tiledlayout(2, 2, TileSpacing="compact");
title(t7, "TV Torque")

nexttile
plot(time, T.TORQUE_VECTOR.vcu_torque_request.front_left)
title("FL")

nexttile;
plot(time,  T.TORQUE_VECTOR.vcu_torque_request.front_right)
title("FR")


nexttile
plot(time,  T.TORQUE_VECTOR.vcu_torque_request.rear_left)
title("RL")

nexttile
plot(time,  T.TORQUE_VECTOR.vcu_torque_request.rear_right)
title("RR")

%% Pedals
figure(8)
set(gcf, "Name", "Pedals")
t8 = tiledlayout(2, 2, TileSpacing="compact");
title(t8, "Pedals")
nexttile;
plot(time, T.DASHBOARD.pedals.throttle)
title("throttle")

nexttile
plot(time, T.DASHBOARD.pedals.brake)
title("brake")


nexttile
plot(time, T.DASHBOARD.pedals.regen)
title("regen")

%% Position
figure(9)
set(gcf, "Name", "Position")
title("Position")

speed = T.TORQUE_VECTOR.gps_speed_heading.gps_speed;

% color based on time
colmap = hsv(256);
gps_lock_ind = find(T.TORQUE_VECTOR.gps_coordinates.latitude ~= 0, 1);
ind = round(interp1([time(gps_lock_ind), time(end)], [1 256], clip(time, time(gps_lock_ind), time(end))));
colors = colmap(ind, :);
plt = geoscatter(T.TORQUE_VECTOR.gps_coordinates.latitude, T.TORQUE_VECTOR.gps_coordinates.longitude, ".", CData=colors);
geobasemap satellite
plt.DataTipTemplate.DataTipRows(end) = dataTipTextRow("Speed", speed);
plt.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow("Time", time);
geolimits([dms2degrees([40 27 40]) dms2degrees([40 27 46])], [-dms2degrees([86 57 28]) -dms2degrees([86 57 22])])

fprintf("GPS Lock at %.3f s\n", time(gps_lock_ind))
