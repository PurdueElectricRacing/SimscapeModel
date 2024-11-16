FZ = abs(FZ);
% 7in rims

% kx model
% A1 = 0;
% A2 = 50.76;
% A3 = 1526;

% mu_x model
% B1 = -0.0000004726;
% B2 = 0.001047;
% B3 = 1.855;

% 6in rims

% kx model
A1 = 0;
A2 = 42.55;
A3 = 2355;

% mu_x model
B1 = 0.000001287;
B2 = -0.002325;
B3 = 3.797;

% mu_y model
C1 = -0.000000002541;
C2 = 0.000005279;
C3 = -0.003943;
C4 = 3.634;

% G model
E1 = 0.002031;
E2 = 2.369;
E3 = -165.9;

% Basic Coefficients
kx = (A1 .* (FZ.^2)) + (A2 .* (FZ)) + A3;
mu_x = (B1 .* (FZ.^2)) + (B2 .* (FZ)) + B3;
mu_y = (C1 .* (FZ.^3)) + (C2 .* (FZ.^2)) + (C3 .* (FZ)) + C4;
% C = (D1 .* (FZ.^2)) + (D2 .* (FZ)) + D3;
G = (E1 .* (FZ.^2)) + (E2 .* (FZ)) + E3;

% 2 Steps Back
% a_bar = (C .* tand(-SA)) ./ (mu_y .* FZ);
% g_bar = (G .* sind(IA)) ./ (mu_y .* FZ);
% F_bar = FY ./ (mu_y .* FZ);

% 1 Step Back
s_bar = (kx .* SL) ./ (mu_x .* FZ);
% b_bar = (a_bar) ./ (1 - (g_bar .* sign(-SA)));

Fx_bar = (FX) ./ (mu_x .* FZ);
% FN_bar = (F_bar - g_bar) ./ (1 - (g_bar .* sign(-SA)));

f = length(s_bar);
counter = 1;
s_bar_m = zeros(f, 1);
Fx_bar_m = zeros(f, 1);
for i = 1:f
    if abs(SA(i)) < 0.5 && abs(IA(i)) < 0.5
       s_bar_m(counter) = s_bar(i);
       Fx_bar_m(counter) = Fx_bar(i);
       
       counter = counter + 1;
    end
end

% Longitudinal Only
scatter(s_bar_m, Fx_bar_m)
hold on

% Model Fitting
xdata = abs(s_bar_m);
ydata = abs(Fx_bar_m);

%p = [11.1689 0.1097 1.8276 1.0864];
yout = p(1)*sin(p(2)*atan(p(3)*xdata-p(4)*((p(3)*xdata)-atan(p(3)*xdata))));

scatter(xdata, yout)

%Note that we don't have to explicitly calculate residuals
fun = @(p,xdata) p(1)*sin(p(2)*atan(p(3)*xdata-p(4)*((p(3)*xdata)-atan(p(3)*xdata))));

%starting guess
pguess = [1 1 1 1];

[p,fminres] = lsqcurvefit(fun,pguess,xdata,ydata);