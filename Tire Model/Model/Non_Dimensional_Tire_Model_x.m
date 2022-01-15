FZ = abs(FZ);

% kx model
A1 = -0.02103;
A2 = 64.08;
A3 = -3472;

% mu_x model
B1 = 0.000000005037;
B2 = -0.00001037;
B3 = 0.006655;
B4 = 1.069;

% mu_y model
C1 = -0.000000002582;
C2 = 0.000005639;
C3 = -0.00423;
C4 = 3.658;

% C model
D1 = -0.01593;
D2 = 46.1;
D3 = 4193;

% G model
E1 = 0.00002509;
E2 = 0.05972;
E3 = -11.37;

% Basic Coefficients
kx = (A1 .* (FZ.^2)) + (A2 .* (FZ)) + A3;
mu_x = (B1 .* (FZ.^3)) + (B2 .* (FZ.^2)) + (B3 .* (FZ)) + B4;
mu_y = (C1 .* (FZ.^3)) + (C2 .* (FZ.^2)) + (C3 .* (FZ)) + C4;
C = (D1 .* (FZ.^2)) + (D2 .* (FZ)) + D3;
G = (E1 .* (FZ.^2)) + (E2 .* (FZ)) + E3;

% 2 Steps Back
a_bar = (C .* tand(abs(SA))) ./ (mu_y .* FZ);
g_bar = (G .* sind(IA)) ./ (mu_y .* FZ);

F_bar = abs(FY) ./ (mu_y .* FZ);

% 1 Step Back
s_bar = (kx .* SL) ./ (mu_x .* FZ);
b_bar = (a_bar) ./ (1 - (g_bar .* sign(SA)));

FN_bar = (F_bar - g_bar) ./ (1 - (g_bar .* sign(SA)));
Fx_bar = (FX) ./ (mu_x .* FZ);

% Final
k = sqrt((s_bar.^2) + (a_bar.^2));
R = sqrt((FN_bar.^2) + (Fx_bar.^2));


f = length(s_bar);
counter = 1;
s_bar_m = zeros(f, 1);
Fx_bar_m = zeros(f, 1);
for i = 1:f
    if abs(SA(i)) < 0.5 && abs(IA(i))
       s_bar_m(counter) = s_bar(i);
       Fx_bar_m(counter) = Fx_bar(i);
       
       counter = counter + 1;
    end
end

% Longitudinal Only
scatter(s_bar_m, Fx_bar_m)