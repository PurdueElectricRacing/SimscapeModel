% Youngshin Choi
%
% function description
% deterimes what mode the vehicle is in based on its steering angle
%
% Parameters description
% currentmode: the current mode the vehicle is at
% steering: the steering angle of the vehicle
% meansteer: the mean steering angle of the vehicle

function y = get_VT_mode(y)
    if abs(y.ST_CF) < y.DB_CF + p.dST_DB
        y.VT_mode = 2;  % car is turning
    elseif abs(y.ST_CF) > y.DB_CF + p.dST_DB
        y.VT_mode = 1;  % car is going in a straight line
    end
end