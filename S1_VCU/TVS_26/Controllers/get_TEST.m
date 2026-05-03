%% Function Description
% Testing controller, driver sets LR and FR split directly
% Inputs
%   p   vehicle paramater struct. constant
%   y   Function input and output struct. contains all clipped and
%           filtered variables, variable buffers, and output from
%           this function.
% Outputs
%   y   modified version of input y

function y = get_TEST(p, y)
    ST_clipped = snip(y.ST, -p.TS_LR_max_ST, p.TS_LR_max_ST);
    TS_LR_split_clipped = snip(y.TS_LR_split, 0, .25);
    LR_split_raw = interp1([-p.TS_LR_max_ST, p.TS_LR_max_ST], [.5 - TS_LR_split_clipped, .5 + TS_LR_split_clipped], ST_clipped);
    LR_split = snip(LR_split_raw, 0, 1);
    % LR_split_raw = 0.5 + y.ST * p.TS_LR_gain;
    % split_diff = snip(y.TS_LR_split, 0, .25);
    % LR_split_clipped = snip(LR_split_raw, 0.5 - split_diff, 0.5 + split_diff);

    TS_TO_des = split2torque(y.TS_FR_split, LR_split) .* y.TH_PO .* p.MAX_TO_ABS_PO;
    y.TS_TO = rescale_torque(TS_TO_des, y.TO_BL_PO);