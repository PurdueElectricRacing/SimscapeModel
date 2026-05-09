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
    if x.VCU_MODE_REQ == 0 % accel
        y.VCU_MODE = 1;
    elseif x.VCU_MODE_REQ == 1 % skidpad
        y.VCU_MODE = 2;
    elseif x.VCU_MODE_REQ == 2 % autocross
        y.VCU_MODE = 3;
    elseif x.VCU_MODE_REQ == 3 % endurance
        y.VCU_MODE = 4;
    elseif x.VCU_MODE_REQ == 4 % testing
        y.VCU_MODE = 5;
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