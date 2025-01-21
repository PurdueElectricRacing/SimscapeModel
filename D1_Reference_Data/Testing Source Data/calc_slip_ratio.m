% constants
% add code to eliminate data when in mode 2 (turning) (~12 deg)
% add consevutive concurrence to check

r = 0.2;

% import data
raw = readmatrix("out_11.csv");
t = raw(:,1);
w_l_r = raw(:,55:56);
w_avg = mean(w_l_r, 2);

vel_n_e = raw(:,154:155);
vel = sqrt(vel_n_e(:,1).^2 + vel_n_e(:,2).^2);

theta = raw(:,223);
turn = abs(theta) >= 12;

% calculate slip ratios and modes from them
sl_normal = w_avg .* r ./ vel - 1;
sl_normal(turn) = 0;
sl_no_ratio = w_avg * r - vel;
sl_no_ratio(turn) = 0;

sl_div_plus1 = w_avg .* r ./ (vel + 1) - 1;
% sl_div_plus1(turn) = 0;

figure(1)
scatter(t(~turn), sl_normal(~turn), ".");

figure(2)
scatter(t(~turn), sl_no_ratio(~turn), ".");

figure(3)
scatter(t(~turn),sl_div_plus1(~turn), ".");
