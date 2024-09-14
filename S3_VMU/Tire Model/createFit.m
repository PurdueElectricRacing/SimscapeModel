function [fitresult, gof] = createFit(FZa, SAa, FYa)
[xData, yData, zData] = prepareSurfaceData( FZa, SAa, FYa );

% Set up fittype and options.
ft = fittype( '(x*D)*sin(C*atan((B+F*x)*y-E*(B*y-atan(B*y))));', 'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 0 0 -5];
opts.MaxFunEvals = 6000;
opts.MaxIter = 4000;
opts.StartPoint = [0.0714454646006424 0.521649842464284 0.096730025780867 0.818148553859625 0.817547092079286];
opts.Upper = [5 5 5 5 5];

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );

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


