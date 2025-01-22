function y = init_Y()

    % Traction Control (TC) variables
    y.TC_highs = 0; % counter to track number of consecutive high sl values
    y.TC_lows = 0; % counter to track number of consecutive low sl values
end