%% Function Description
% Test controller
% Inputs
%   p   vehicle paramater struct. constant
%   y   Function input and output struct. contains all clipped and
%           filtered variables, variable buffers, and output from
%           this function.
% Outputs
%   y   modified version of input y

function y = get_AUTOX(p, y)

    % snip steering angle to positive and in LUT range, snip groundspeed to LUT range
    % ST_clipped = snip(abs(y.ST), p.AX_TV_yaw_ST_brkpt(1), p.AX_TV_yaw_ST_brkpt(end));
    % GS_clipped = snip(y.GS, p.AX_TV_yaw_GS_brkpt(1), p.AX_TV_yaw_GS_brkpt(end));
    % control_force = interp1([p.AX_ST_ZERO_TV, p.AX_ST_FULL_TV], [0,1], ST_clipped);
    control_force = y.AX_LR_control_force;

    % calculate yaw rate error; positive = slower yaw than desired
    yaw = y.AV(3);
    ST_lookup_yaw = snip(abs(y.ST), p.AX_TV_yaw_ST_brkpt(1), p.AX_TV_yaw_ST_brkpt(end));
    GS_lookup_yaw = snip(y.GS, p.AX_TV_yaw_GS_brkpt(1), p.AX_TV_yaw_GS_brkpt(end));
    AX_YAW_des = sign(y.ST) .* interp2(p.AX_TV_yaw_ST_brkpt, p.AX_TV_yaw_GS_brkpt, p.AX_TV_yaw_table, ST_lookup_yaw, GS_lookup_yaw);
    err = AX_YAW_des - yaw;

    % calculate desired LR split based on calculated desired yaw
    ST_lookup_split = snip(abs(y.ST), p.AX_TV_split_ST_brkpt(1), p.AX_TV_split_ST_brkpt(end));
    GS_lookup_split = snip(y.GS, p.AX_TV_split_GS_brkpt(1), p.AX_TV_split_GS_brkpt(end));
    AX_LR_split_des_raw = sign(y.ST) .* interp2(p.AX_TV_split_ST_brkpt, p.AX_TV_split_GS_brkpt, p.AX_TV_split_table, ST_lookup_split, GS_lookup_split);
    AX_LR_split_des = (AX_LR_split_des_raw / 2 * p.AX_LR_split_max) + 0.5;

    % proportional control on LR split based on error
    % multiply yaw rate error by gain and control force
    LR_split_raw = AX_LR_split_des + err * p.AX_LR_gain;
    LR_split_snipped = snip(LR_split_raw, .35, .65); % limit split to reasonable level (max, min of table)
    LR_split = (1 - control_force) * 0.5 + (control_force) * LR_split_snipped;
 

    % convert FR, LR split to torques
    AX_TO_DES = split2torque(y.AX_FR_split, LR_split) .* y.TH_PO .* p.MAX_TO_ABS_PO;

    % make sure torques do not violate rules or safety derating
    y.AX_TO = rescale_torque(AX_TO_DES, y.TO_BL_PO);
    % y.AX_TO = min(AX_TO_DES, y.TO_BL_PO);
end