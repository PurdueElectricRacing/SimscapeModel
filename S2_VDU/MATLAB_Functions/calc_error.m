function error = calc_error(currentpos, track_setting)
% Calculate error (Perpendicular minimum distance) of a point to 
% Update: should use fmincon
if track_setting == "acceleration"
    y0 = currentpos(2);
    error = sqrt(y0^2);
else
    % x0 = currentpos(1);
    % y0 = currentpos(2);
    % x1 = point1(1);
    % y1 = point1(2);
    % x2 = point2(1);
    % y2 = point2(2);
    % 
    % numerator = abs((x2-x1)*(y1-y0)-(y2-y1)*(x1-x0));
    % denominator = sqrt((x2-x1)^2 + (y2-y1)^2);
    % 
    % error = numerator/denominator;

end