speed_calibration = 1000*(1/(2*78.54))*8.7479; % (ms*rad)/(count*s)

motor_I = s.UserData.Data(:,1)./100;
motor_V = s.UserData.Data(:,2)./100;
motor_W = s.UserData.Data(:,3).*2*pi./600;
motor_T = s.UserData.Data(:,4)./100;
motor_K = s.UserData.Data(:,5)./100;
ticks = s.UserData.Data(:,6);
magnets_W = s.UserData.Data(:,7).*8.7479./100.0;
counter = s.UserData.Data(:,8);

delta_counter = counter(2:end) - counter(1:end-1); % count
delta_ticks = ticks(2:end) - ticks(1:end-1); % ms

raw_speed = delta_counter ./ delta_ticks;

mean_W_mot = mean(motor_W(151:408));
mean_W_mag = mean(magnets_W(151:408));

ratio_error = mean_W_mot / mean_W_mag;

time_array = (1:1:s.UserData.Count).*0.015;


valid_speed_data = (magnets_W < 12000) & (motor_W < 500);
magnets_W = magnets_W(valid_speed_data);
time_w = time_array(valid_speed_data);
motor_W = motor_W(valid_speed_data);

% time_array = (1:1:length(motor_V)) * 0.015-0;
% clear s

% figure(1)
% plot(time_array, motor_I)           `
% xlabel("Time (s)")
% ylabel("Current (A)")
% 
% figure(2)
% plot(time_array, motor_V)
% xlabel("Time (s)")
% ylabel("Voltage (V)")

figure(3)
plot(time_w, motor_W)
hold on
plot(time_w, magnets_W)
    
xlabel("Time (s)")
ylabel("Speed (rad/s)")
legend('MC Speed', 'Magnetic Speed')

% figure(4)
% plot(time_array, motor_T)
% xlabel("Time (s)")
% ylabel("Temperature (C)")
% 
% figure(5)
% plot(time_array, motor_K)
% xlabel("Time (s)")
% ylabel("Motor Command (%)")

% figure(7)
% plot(time_array, ccr)
% xlabel("Time (s)")
% ylabel("ccr")
