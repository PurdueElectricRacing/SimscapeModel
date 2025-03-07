function [fitresult, gof] = createFit(FZaa, SLaa, FYaa)
%CREATEFIT1(FZAA,SLAA,FYAA)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input: FZaa
%      Y Input: SLaa
%      Z Output: FYaa
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 19-Sep-2024 19:58:24


%% Fit: 'untitled fit 1'.
[xData, yData, zData] = prepareSurfaceData( FZaa, SLaa, FYaa );

% Set up fittype and options.
ft = fittype( '(a+b*x)*y+(c+d*y)*x+(e+f*x)*y^2+(g+h*y)*x^2', 'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.757740130578333 0.743132468124916 0.392227019534168 0.706046088019609 0.0318328463774207 0.27692298496089 0.0461713906311539 0.0971317812358475];

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'untitled fit 1', 'FYaa vs. FZaa, SLaa', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'FZaa', 'Interpreter', 'none' );
ylabel( 'SLaa', 'Interpreter', 'none' );
zlabel( 'FYaa', 'Interpreter', 'none' );
grid on
view( -78.3, -12.9 );


