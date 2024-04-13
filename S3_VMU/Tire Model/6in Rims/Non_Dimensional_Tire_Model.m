% Plot Model
k = [abs(a_bar') abs(s_bar_m')];
R = [abs(F_bar') abs(Fx_bar_m')];

scatter(k, R)
hold on

p = [5.9728 0.1919 0.848 1.1];
yout = p(1)*sin(p(2)*atan(p(3)*k-p(4)*((p(3)*k)-atan(p(3)*k))));

scatter(k, yout)

ylabel('abs(R(k))')
xlabel('k')
title('All Wheel Loads, Pure FX Slip or Pure FY Slip')


% Predict Fx & Fy
% n0 = (C .* mu_x) ./ (kx .* mu_y);