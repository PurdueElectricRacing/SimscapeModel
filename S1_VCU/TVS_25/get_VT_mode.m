%
% Youngshin Choi
%
% function description
% deterimes what mode the vehicle is in based on its steering angle
%
% Parameters description
% currentmode: the current mode the vehicle is at
% steering: the steering angle of the vehicle
% meansteer: the mean steering angle of the vehicle
%

function y = get_VT_mode(y)
    if abs(steering) < meansteer + deltasteer
        updatedmode = 2;  % car is turning
    elseif abs(steering) > meansteer + deltasteer
        updatedmode = 1;   % car is going in a straight line
    else
        updatedmode = currentmode; % neither, the car is still in the previous mode
    end
end
