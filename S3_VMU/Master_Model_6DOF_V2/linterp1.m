%% faster version of interp2, but only works on data with linearly spaced breakpoints

%
%   x is a two element vector that represents the slope and intercept of a linear
%   equation that maps an input query point to the corresponding x index in v
%       x_index = x(1)*xq + x(2)
%   
%   y is a two element vector that represents the slope and intercept of a linear
%   equation that maps an input query point to the corresponding y index in v
%       y_index = y(1)*yq + y(2)
%   
%   v is a meshgrid of data
%   
%   xq is the x query point
%   
%   yq is the y query point
function z = linterp1(x, v, xq)
    % lower and upper indices
    x_min = min(length(v)-1, max(1, floor(xq*x(1)+x(2))));
    x_max = x_min + 1;
    % a is the fractional x linear interpolatin values
    a = xq.*x(1)+x(2) - x_min;
    % lerp formula
    z = v(x_min).*(1-a) + v(x_max).*a;