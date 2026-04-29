%% Function Description
% Takes a set of torques and torque limits, rescales given torques
% (maintaining relative torque split) so that no torque exceeds torque limit
% Inputs
%   TO_in      Set of torques to be rescaled to be below limits Units: [Nm] Order: FL FR RL RR]
%   TO_lim     Set of torque limits Units: [Nm] Order: FL FR RL RR]
%
% Outputs
%   TO_maxed   TO_split rescaled by a constant such that no torque in TO_split
%       exceeds its corresponding torque in TO_lim, and at least one
%       torque in TO_split is equal to its corresponding TO_lim


function [TO_maxed] = rescale_torque(TO_in, TO_max)
    % if any torque limit is 0, return 0 torque
    if any(TO_max == 0)
        TO_maxed = [0 0 0 0];
        return
    end
    
    % for each wheel, scale up TO_in so that wheel matches corresponding
    % TO_max, then check if any other wheels exceed limit
    best_scale = 0;

    % FL
    if TO_in(1) ~= 0
        scale = TO_max(1) / TO_in(1);
        TO_scaled = TO_in * scale;
        if all(TO_scaled <= TO_max)
            best_scale = max(best_scale, scale);
        end
    end
    % FR
    if TO_in(2) ~= 0
        scale = TO_max(2) / TO_in(2);
        TO_scaled = TO_in * scale;
        if all(TO_scaled <= TO_max)
            best_scale = max(best_scale, scale);
        end
    end
    % RL
    if TO_in(3) ~= 0
        scale = TO_max(3) / TO_in(3);
        TO_scaled = TO_in * scale;
        if all(TO_scaled <= TO_max)
            best_scale = max(best_scale, scale);
        end
    end
    % RR
    if TO_in(4) ~= 0
        scale = TO_max(4) / TO_in(4);
        TO_scaled = TO_in * scale;
        if all(TO_scaled <= TO_max)
            best_scale = max(best_scale, scale);
        end
    end
    % make sure we don't increase torque
    best_scale_snipped = snip(best_scale, 0, 1);
    % output
    TO_maxed = TO_in * best_scale_snipped;
end