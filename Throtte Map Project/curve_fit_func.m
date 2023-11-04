function [VfuncK, WfuncKV] = curve_fit_func(K,V,W)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Fit KV curve
[xData, yData] = prepareCurveData( K, V );
% Set up fittype and options.
ft = fittype( 'poly1' );
% Fit model to data.
[KV_fit, ~] = fit( xData, yData, ft );

%% Fit KV surface
[xData, yData, zData] = prepareSurfaceData( K, V, W );

% Set up fittype and options.
ft = fittype( 'a1*K^2+a2*K+a3+b1*V^2+b2*V+b3', 'independent', {'K', 'V'}, 'dependent', 'W' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.753729094278495 0.380445846975357 0.567821640725221 0.0758542895630636 0.0539501186666071 0.530797553008973];

% Fit model to data.
[KV_surf, ~] = fit( [xData, yData], zData, ft, opts );

VfuncK = KV_fit;
WfuncKV = KV_surf;
end