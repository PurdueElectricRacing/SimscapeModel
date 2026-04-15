%% Function Description
% 
% 
% 
% 
% 
% Inputs
%   p   vehicle paramater struct. constant
%   y   Function input and output struct. contains all clipped and
%           filtered variables, variable buffers, and output from
%           this function.
% Outputs
%   y   modified version of input y

function y = get_SKID(p, y)
    p.SK_YAW_des;
    p.SK_LR_split_des;
    p.SK_FR_split
    p.SK_LR_gain

    % calculate control force multiplier from steering angle
    % at low steering angles, we don't want any TV
    control_force = 1;

    % calculate yaw rate error; positive = slower yaw than desired
    yaw = y.AV(3);
    err = p.SK_YAW_des - yaw;

    % proportional control on LR split based on error
    LR_split = p.SK_LR_split_des + err * p.SK_LR_gain;
    LR_split = snip(LR_split, .5, 1);

    % convert FR, LR split to torques
    SK_TO_DES = split2torque(p.SK_FR_split, LR_split) .* y.TH_PO .* p.MAX_TO_ABS_PO;

    % make sure torques do not violate rules or safety derating
    y.SK_TO = max(SK_TO_DES, y.TO_BL_PO);
    
    
end