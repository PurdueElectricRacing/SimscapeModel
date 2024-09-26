function fitresult = Theta_fit(SL_theta, SA_theta, theta_theta)
[xData, yData, zData] = prepareSurfaceData( SL_theta, SA_theta, theta_theta );

% Set up fittype and options.
ft = fittype( '(0.7853981634*exp(a*y)+atan(10*y))*(exp((b*exp(c*y)+d)*x)+0.3183098862*atan(f*x*y))', 'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf -Inf 0];
opts.MaxFunEvals = 6000;
opts.MaxIter = 4000;
opts.StartPoint = [0.0523052207703927 0.556830534131996 0.712025249134944 0.213777574762031 0.380642291284627];
opts.Upper = [0 0 0 0 Inf];

% Fit model to data.
[fitresult, ~] = fit( [xData, yData], zData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'untitled fit 1', 'theta_theta vs. SL_theta, SA_theta', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'SL_theta', 'Interpreter', 'none' );
ylabel( 'SA_theta', 'Interpreter', 'none' );
zlabel( 'theta_theta', 'Interpreter', 'none' );
grid on
view( 34.0, 10.0 );