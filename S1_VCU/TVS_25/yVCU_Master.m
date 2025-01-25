classdef yVCU_Master < handle
    %% y properties
    properties
    % Clip and filter (CF) variables
        IB_CF_vec; % vector of the past N battery current measurements

    % Traction Control (TC) variables
        TC_highs; % counter to track number of consecutive high sl values
        TC_lows; % counter to track number of consecutive low sl values
    end

    %% y Methods
    methods
        function y = yVCU_Master(p)
            % Clip and filter (CF) variables
            y.IB_CF_vec = ones(1,p.SF_IB_filter);

            % Traction Control (TC) variables
            y.TC_highs = 0;
            y.TC_lows = 0;
        end
    end
end