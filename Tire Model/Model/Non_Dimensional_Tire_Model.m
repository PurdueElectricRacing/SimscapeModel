% Plot Model
k = [abs(b_bar') abs(s_bar_m')];
R = [abs(FN_bar') abs(Fx_bar_m')];

scatter(k, R)

% Predict Fx & Fy
n0 = (C .* mu_x) ./ (kx .* mu_y);