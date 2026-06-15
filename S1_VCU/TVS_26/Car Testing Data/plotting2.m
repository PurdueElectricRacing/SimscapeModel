clearvars

path = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\june-14-morning\out_005_2026_06_14__09_51_49.csv";
path1 = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\june-14-crash\data\data\out_000_2026_06_14__21_45_42.csv";
path2 = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\june-14-crash\data\data\out_001_2026_06_14__21_47_27.csv";
path3 = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\june-14-crash\data\data\out_002_2026_06_14__21_48_44.csv";
T = data2table(path3, "removeNaN", "filldata");

%% Data
time = T.time;
TV_torque = [T.TORQUE_VECTOR.vcu_torque_request.front_right, ...
             T.TORQUE_VECTOR.vcu_torque_request.front_left, ...
             T.TORQUE_VECTOR.vcu_torque_request.rear_left, ...
             T.TORQUE_VECTOR.vcu_torque_request.rear_right,];

INV_torque = [T.INVERTER_A.INVA_CRIT.AMK_ActualTorque, ...
              T.INVERTER_B.INVB_CRIT.AMK_ActualTorque, ...
              T.INVERTER_C.INVC_CRIT.AMK_ActualTorque, ...
              T.INVERTER_D.INVD_CRIT.AMK_ActualTorque];

IGBT_temps = [T.INVERTER_A.INVA_TEMPS.AMK_IGBTTemp, ...
              T.INVERTER_B.INVB_TEMPS.AMK_IGBTTemp, ...
              T.INVERTER_C.INVC_TEMPS.AMK_IGBTTemp, ...
              T.INVERTER_D.INVD_TEMPS.AMK_IGBTTemp];

MOT_temps = [T.INVERTER_A.INVA_TEMPS.AMK_MotorTemp, ...
             T.INVERTER_B.INVB_TEMPS.AMK_MotorTemp, ...
             T.INVERTER_C.INVC_TEMPS.AMK_MotorTemp, ...
             T.INVERTER_D.INVD_TEMPS.AMK_MotorTemp];
INV_temp =  [T.INVERTER_A.INVA_TEMPS.AMK_InverterTemp, ...
             T.INVERTER_B.INVB_TEMPS.AMK_InverterTemp, ...
             T.INVERTER_C.INVC_TEMPS.AMK_InverterTemp, ...
             T.INVERTER_D.INVD_TEMPS.AMK_InverterTemp];


%% Plotting
tiledlayout(4,1, TileSpacing="compact")
nexttile;
plot(time,INV_torque, LineWidth=1);
title("INV torque")
legend("A","B","C","D")

nexttile;
plot(time,TV_torque, LineWidth=1);
title("TV req")


nexttile;
plot(time, IGBT_temps, LineWidth=1);
title("IGBT temp")

nexttile;
plot(time, MOT_temps, LineWidth=1);
title("motor temp")

% linkaxes([p1 p2 p3 p4], "x")
zoom(gcf, "xon")

% shockpots
figure(3)
tiledlayout(2,2);
nexttile;
plot(time, T.DRIVELINE.rear_shockpots.left)
title("shockpot")

nexttile();
plot(time, T.INVERTER_C.INVC_CRIT.AMK_ActualSpeed);
title("speed")

nexttile();
plot(time, T.INVERTER_C.INVC_CRIT.AMK_ActualTorque)
title("torque")

nexttile();
plot(time, T.DASHBOARD.pedals.brake)
title("brake")

scatter(T.TORQUE_VECTOR.gps_coordinates.longitude, T.TORQUE_VECTOR.gps_coordinates.latitude, ".")

% linkaxes([p1 p2 p3], "x")

figure(4)
plot(time, T.DASHBOARD.pedals.throttle)
hold on
plot(time, T.DASHBOARD.pedals.brake);
plot(time, T.DASHBOARD.pedals.regen);
legend("throttle", "brake", "regen")


%% speeds
figure(5)
tiledlayout(2, 2, TileSpacing="compact")
nexttile;
plot(time, T.INVERTER_A.INVA_CRIT.AMK_ActualSpeed)
title("INV A")

nexttile
plot(time, T.INVERTER_B.INVB_CRIT.AMK_ActualSpeed)
title("INV B")


nexttile
plot(time, T.INVERTER_C.INVC_CRIT.AMK_ActualSpeed)
title("INV C")

nexttile
plot(time, T.INVERTER_D.INVD_CRIT.AMK_ActualSpeed)
title("INV D")

%% Torques
figure(6)
tiledlayout(2, 2, TileSpacing="compact")
nexttile;
plot(time, T.INVERTER_A.INVA_CRIT.AMK_ActualTorque)
title("INV A")

nexttile
plot(time, T.INVERTER_B.INVB_CRIT.AMK_ActualTorque)
title("INV B")


nexttile
plot(time, T.INVERTER_C.INVC_CRIT.AMK_ActualTorque)
title("INV C")

nexttile
plot(time, T.INVERTER_D.INVD_CRIT.AMK_ActualTorque)
title("INV D")

%% Pedals
figure(7)
tiledlayout(2, 2, TileSpacing="compact")
nexttile;
plot(time, T.DASHBOARD.pedals.throttle)
title("throttle")

nexttile
plot(time, T.DASHBOARD.pedals.brake)
title("brake")


nexttile
plot(time, T.DASHBOARD.pedals.regen)
title("regen")
