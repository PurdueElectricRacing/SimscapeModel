%% Function Description
% Stead-state skid-pad controller
% Inputs
%   p   vehicle paramater struct. constant
%   y   Function input and output struct. contains all clipped and
%           filtered variables, variable buffers, and output from
%           this function.
%   
% Outputs
%   y   modified version of input y
function y = get_VCU_mode(p, x, y)
    % vcu_mode
    if x.VCU_MODE_REQ == 0
        y.VCU_MODE = 1;
    elseif x.VCU_MODE_REQ == 1
        y.VCU_MODE = 2;
    elseif x.VCU_MODE_REQ == 2
        y.VCU_MODE = 3;
    elseif x.VCU_MODE_REQ == 3
        y.VCU_MODE = 4;
    else
        y.VCU_MODE = 0; % Default case for unrecognized VCU_MODE_REQ
    end

    % regen
    if x.REGEN_EN == 1
        y.REGEN_EN = 1;
    else
        y.REGEN_EN = 0;
    end
end