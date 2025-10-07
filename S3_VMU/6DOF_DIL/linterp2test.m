% x_index = x(1)*xq + x(2)
% y_index = y(1)*yq + y(2)
function z = linterp2test(x, y, v, xq, yq)
    mx = (length(x)-1)/(x(end)-x(1));
    bx = 1-x(1)*mx;
    my = (length(y)-1)/(y(end)-y(1));
    by = 1-y(1)*my;
    x_min = min(size(v,1)-1, max(1, floor(xq*x(1)+x(2))));
    x_max = x_min + 1;
    y_min = min(size(v,2)-1, max(1, floor(yq*y(1)+y(2))));
    y_max = y_min + 1;
    a = xq*mx+bx - x_min;
    b = yq*my+by - y_min;
    z = dot([v(x_min,y_min), v(x_min,y_max), v(x_max,y_min), v(x_max,y_max)], [(1-a)*(1-b), (1-a)*b, a*(1-b), a*b]);
    % z = [1-a, a]*[v(x_min,y_min), v(x_min,y_max); v(x_max,y_min), v(x_max,y_max)] * [1-b; b];
end