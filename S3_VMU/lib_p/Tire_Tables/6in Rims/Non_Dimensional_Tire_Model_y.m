FZ = abs(FZ);
% 7in
% mu_y model
% C1 = -0.000000002582;
% C2 = 0.000005639;
% C3 = -0.00423;
% C4 = 3.658;

% C model
% D1 = -0.01593;
% D2 = 46.1;
% D3 = 4193;

% G model
% E1 = 0.003204;
% E2 = 1.278;
% E3 = -33.92;



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
mu_y = (C1 .* (FZ.^3)) + (C2 .* (FZ.^2)) + (C3 .* (FZ)) + C4;
% C = (D1 .* (FZ.^2)) + (D2 .* (FZ)) + D3;
% G = (E1 .* (FZ.^2)) + (E2 .* (FZ)) + E3;

% 2 Steps Back
a_bar = (C .* tand(-SA)) ./ (mu_y .* FZ);
% g_bar = (G .* sind(IA)) ./ (mu_y .* FZ);

F_bar = FY ./ (mu_y .* FZ);

% 1 Step Back
% b_bar = (a_bar) ./ (1 - (g_bar .* sign(-SA)));

% FN_bar = (F_bar - g_bar) ./ (1 - (g_bar .* sign(-SA)));

% Lateral Only
scatter(a_bar, F_bar)
%scatter(abs(b_bar), abs(FN_bar))
hold on

% Model Fitting
% xdata = abs(b_bar);
% ydata = abs(FN_bar);
% 
% p = [8.143 0.1316 0.9488 0.9864];
% yout = p(1)*sin(p(2)*atan(p(3)*xdata-p(4)*((p(3)*xdata)-atan(p(3)*xdata))));
% 
% scatter(xdata, yout)
% 
% %Note that we don't have to explicitly calculate residuals
% fun = @(p,xdata) p(1)*sin(p(2)*atan(p(3)*xdata-p(4)*((p(3)*xdata)-atan(p(3)*xdata))));
% 
% %starting guess
% pguess = [1 1 1 1];
% 
% [p,fminres] = lsqcurvefit(fun,pguess,xdata,ydata);
