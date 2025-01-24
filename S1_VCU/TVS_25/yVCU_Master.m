classdef yVCU_Master < handle
    %% y properties
    properties
    % Traction Control (TC) variables
        TC_highs; % counter to track number of consecutive high sl values
        TC_lows; % counter to track number of consecutive low sl values
    end

    %% y Methods
    methods
        function y = yVCU_Master()
            y.TC_highs = 0;
            y.TC_lows = 0;
        end
    end
end