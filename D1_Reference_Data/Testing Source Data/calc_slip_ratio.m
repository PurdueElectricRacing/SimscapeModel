r = 0.2;

raw = readmatrix("04_20_2024_Endurance.csv");
t = raw(:,1);
w_l_r = raw(:,45:46);
w_avg = mean(w_l_r, 2);

vel_n_e = raw(:,143:144);
vel = sqrt(vel_n_e(:,1).^2 + vel_n_e(:,2).^2);

sl = w_avg .* r ./ vel - 1;

scatter(t, sl, ".")
hold on;
%plot(t, w_avg)
%plot(t, vel)
legend("sl", "w", "vel")