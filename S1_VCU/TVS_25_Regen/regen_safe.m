function [safe] = regen_safe(p, y)
% regen is safe to enable iff:
    % throttle negative
    % battery voltage below threshold
    % speed above 5 kph
    % all values used are not stale
    safe = all([ ...
        y.TH_CF < 0.1, ... % throttle negative
        abs(y.ST_CF) < 30, ... % steering straight
        y.VB_CF < 550, ... % battery voltage below threshold
        y.GS_CF > 1]); ... % car is moving
end