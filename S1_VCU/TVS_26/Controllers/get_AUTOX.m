%% Function Description
% Transietn Auto-X controller
% Inputs
%   p   vehicle paramater struct. constant
%   y   Function input and output struct. contains all clipped and
%           filtered variables, variable buffers, and output from
%           this function.
% Outputs
%   y   modified version of input y

function y = get_AUTOX(p, y)

    % calculate control force multiplier from steering angle
    % at low steering angles, we don't want any TV
    ST_clipped = snip(abs(y.ST), p.AX_ST_ZERO_TV, p.AX_ST_FULL_TV);
    control_force = interp1([p.AX_ST_ZERO_TV, p.AX_ST_FULL_TV], [0,1], ST_clipped);

    % calculate yaw rate error; positive = slower yaw than desired
    yaw = y.AV(3);
    err = sign(y.ST) * p.AX_YAW_des - yaw;

    % proportional control on LR split based on error
    % multiply yaw rate error by gain and control force
    LR_split_raw = p.AX_LR_split_des + err * y.AX_LR_gain;
    LR_split_snipped = snip(LR_split_raw, .25, .75); % limit split to reasonable level
    LR_split = (1 - control_force) * 0.5 + (control_force) * LR_split_snipped;
 

    % convert FR, LR split to torques
    AX_TO_DES = split2torque(y.AX_FR_split, LR_split) .* y.TH_PO .* p.MAX_TO_ABS_PO;

    % make sure torques do not violate rules or safety derating
    y.AX_TO = min(AX_TO_DES, y.TO_BL_PO);
end