data = readmatrix("motor_speed_example.csv");
t = data(:,1);
t = t - t(1);
l = data(:,2);
r = data(:,3);
dif = l-r;

figure(1)
plot(t,l); hold on
plot(t, r)

figure(2)
plot(t, dif)

Y = fft(dif);
Fs = 1/0.015;
L = t(end) * Fs;
figure(3)
plot(Fs/L * (0:L), abs(Y))