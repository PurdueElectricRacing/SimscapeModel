% load
load("simulink_data.mat")
data = out.x_out.Data;
tx = out.x_out.Time;
x = data(2,:);
vx = data(1,:);
y = data(4,:);
vy = data(3,:);

yaw_raw = data(12,:);
yaw = yaw_raw * -180/pi + 90;
yawrate_raw = data(11,:);
yawrate = yawrate_raw * -180/pi;

vx_vehicle = vx.*cos(yaw_raw) + vy.*sin(yaw_raw);
vy_vehicle = -vx.*sin(yaw_raw) + vy.*cos(yaw_raw);

t_ccsa = out.ccsa_in.Time;
ccsa_raw = out.ccsa_in.Data;

% interp
t_int = (0:0.01:max(tx))';
x_int = interp1(tx, x, t_int);
y_int = interp1(tx, y, t_int);
vx_int = interp1(tx, vx_vehicle, t_int);
vy_int = interp1(tx, vy_vehicle, t_int);
yaw_int = interp1(tx, yaw, t_int);
yawrate_int = interp1(tx, yawrate, t_int);
ccsa_int = interp1(t_ccsa, ccsa_raw, t_int, 'linear', 'extrap');

datatable = array2table([t_int, x_int, y_int, vx_int, vy_int, yaw_int, yawrate_int, ccsa_int]);
datatable.Properties.VariableNames = {'time', 'x', 'y', 'y_vel', 'x_vel', 'yaw', 'yawrate', 'steering_angle'};

writetable(datatable, "irving_data.csv")


% plot

figure(1)
plot(x,y)

figure(2);
plot(tx, x); hold on
plot(tx, y); hold off

figure(3)
plot(tx, yaw)

figure(4)
plot(tx, yawrate)

figure(5);
plot(tx, vx); hold on
plot(tx, vy); hold off

figure(6);
plot(tx, vx_vehicle); hold on
plot(tx, vy_vehicle); hold off

figure(7);
plot(t_ccsa, ccsa_raw)