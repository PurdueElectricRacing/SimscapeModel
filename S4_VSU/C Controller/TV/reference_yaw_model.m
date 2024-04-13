%% The Data
V_target = [0 6 9 12 15 18 21 25 31];
yaw_factor_measured = [1.25 1.25 0.55 0.4 0.325 0.275 0.275 0.275 0.275];
tire_mu_measured = [1.9 1.9 1.875 1.85 1.8 1.725 1.65 1.5 1.5];

%% Model Data with Polynomial Degree 2
x_test = 0:0.1:31;

y_yaw = pchip(V_target, yaw_factor_measured,x_test);
% coeff_yaw = polyfit(V_target, yaw_factor_measured, 2);
y_mu = pchip(V_target, tire_mu_measured,x_test);
% coeff_mu = polyfit(V_target, tire_mu_measured, 2);

%% Plot Data & Models
% y_yaw = polyval(coeff_yaw, V_target);
% y_mu = polyval(coeff_mu, V_target);

figure(1)
scatter(V_target, yaw_factor_measured);
hold on
plot(x_test, y_yaw);

figure(2)
scatter(V_target, tire_mu_measured)
hold on
plot(x_test, y_mu);

