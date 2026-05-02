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

    LR_split_raw = 0.5 + y.ST * p.TS_LR_gain;
    split_diff = snip(y.TS_LR_split, 0, .25);
    LR_split_clipped = snip(LR_split_raw, 0.5 - split_diff, 0.5 + split_diff);

    TS_TO_des = split2torque(y.TS_FR_split, LR_split_clipped);
    y.TS_TO = rescale_torque(TS_TO_des, y.BL_TO_PO);