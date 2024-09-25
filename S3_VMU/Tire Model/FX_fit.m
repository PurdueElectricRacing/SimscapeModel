function fitresult = FX_fit(FZf, SLf, FXf)
[xData, yData, zData] = prepareSurfaceData( FZf, SLf, FXf );

% Set up fittype and options.
ft = fittype( '(x*D)*sin(C*atan(B*y-E*(B*y-atan(B*y))));', 'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 1 0 0];
opts.MaxFunEvals = 6000;
opts.MaxIter = 4000;
opts.StartPoint = [0.262482234698333 0.801014622769739 0.0292202775621463 0.928854139478045];
opts.Upper = [inf 2 inf 1];

% Fit model to data.
[fitresult, ~] = fit( [xData, yData], zData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'untitled fit 1', 'FXf vs. FZf, SLf', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'FZf', 'Interpreter', 'none' );
ylabel( 'SLf', 'Interpreter', 'none' );
zlabel( 'FXf', 'Interpreter', 'none' );
grid on
view( 20.7, -0.9 );


