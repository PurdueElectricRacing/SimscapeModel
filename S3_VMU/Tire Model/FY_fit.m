function fitresult = FY_fit(FZa, SAa, FYa)
[xData, yData, zData] = prepareSurfaceData( FZa, SAa, FYa );

% Set up fittype and options.
ft = fittype( '(x*D)*sin(C*atan(B*y-E*(B*y-atan(B*y))));', 'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 1 0 0];
opts.MaxFunEvals = 6000;
opts.MaxIter = 4000;
opts.StartPoint = [0.0714454646006424 0.521649842464284 0.096730025780867 0.818148553859625];
opts.Upper = [inf 2 inf 1];

% Fit model to data.
[fitresult, ~] = fit( [xData, yData], zData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'untitled fit 1', 'FYa vs. FZa, SAa', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'FZa', 'Interpreter', 'none' );
ylabel( 'SAa', 'Interpreter', 'none' );
zlabel( 'FYa', 'Interpreter', 'none' );
grid on
view( 62.3, 15.0 );