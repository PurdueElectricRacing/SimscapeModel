r = 0.2;

raw = readmatrix("out_11.csv");
t = raw(:,1);
w_l_r = raw(:,55:56);
w_avg = mean(w_l_r, 2);

vel_n_e = raw(:,154:155);
vel = sqrt(vel_n_e(:,1).^2 + vel_n_e(:,2).^2);

sl = w_avg .* r ./ vel - 1;

figure(1)
scatter(t, sl, ".")
figure(2)
hold on;
plot(t, w_avg * r)
plot(t, vel)
legend("w*r", "vel")