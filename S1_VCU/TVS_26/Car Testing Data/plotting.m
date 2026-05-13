%% load data
path = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\may10-accel-skids\out_001.csv";
% path = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\may3_part1\out_000.csv";
% T = data2table(path, "removeNaN", "filldata");

%% Plotting Data
% motors
INV_torques = [T.MAIN_MODULE.INVB_SET.AMK_TorqueSetpoint, ...
               T.MAIN_MODULE.INVA_SET.AMK_TorqueSetpoint, ...
               T.MAIN_MODULE.INVC_SET.AMK_TorqueSetpoint, ...
               T.MAIN_MODULE.INVD_SET.AMK_TorqueSetpoint];
figure(1)
p1 = subplot(2,2,1);
plot(T.time, INV_torques, "-")
legend("FL","FR","RL","RR")

p2 = subplot(2,2,2);
plot(T.time, T.DASHBOARD.steering_angle.angle, "-")


p3 = subplot(2,2,3);
plot(T.time, T.TORQUE_VECTOR.IMU_angular_rate.Z_axis);

linkaxes([p1 p2, p3], "x")
zoom(gcf, "xon")