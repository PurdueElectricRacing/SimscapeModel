function [value,isterminal,direction] = accel_complete(t, s, tauRaw, CCSA, model)
    value = s(2) - model.sN; % The value that we want to be zero
    isterminal = 1;  % Halt integration 
    direction = 0;   % The zero can be approached from either direction
end