% x(1) is slope of 
function z = linterp2(x, y, v, xq, yq)
    x_min = floor(xq*x(1)+x(2));
    x_max = x_min + 1;
    y_min = floor(yq*y(1)+y(2));
    y_max = y_min + 1;
    a = xq*x(1)+x(2) - x_min;
    b = xq*x(1)+x(2) - y_min;
    z = [1-a, a]*[v(x_min,y_min), v(x_min,y_max); v(x_max,y_min), v(x_max,y_max)] * [1-b; b];
end