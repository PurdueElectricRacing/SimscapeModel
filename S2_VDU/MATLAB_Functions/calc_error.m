function error = calc_error(currentpos, trackXY, turn_setting)
% Calculate error (Perpendicular minimum distance) of a point to 
% Update: should use fmincon
if turn_setting == "straight"
    index = find(trackXY(:,1) > currentpos(1), 1);
    if isempty(index)
        
    else
        next_trackpos = [trackXY(index,1) trackXY(index,2)];
    end
    x0 = currentpos(1);
    y0 = currentpos(2);
    xtarget = next_trackpos(1);
    ytarget = next_trackpos(2);
    error = sqrt((xtarget - x0)^2 + (ytarget - y0)^2);
    % error = abs(y0);
elseif turn_setting == "Left"
    index = find(trackXY(:,1) > currentpos(2), 1);
    if isempty(index)
        
    else
        next_trackpos = [trackXY(index,1) trackXY(index,2)];
    end
    x0 = currentpos(1);
    y0 = currentpos(2);
    xtarget = next_trackpos(1);
    ytarget = next_trackpos(2);
    error = sqrt((xtarget - x0)^2 + (ytarget - y0)^2);
    % error = abs(y0);

end