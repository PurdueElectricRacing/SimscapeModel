% vcu_step runs every loop on the TV board
% Inputs
%   p   vehicle paramater struct. constant
%   f   CAN flag variable struct. filled with data read from CAN
%           in main.c
%   x   Raw sensor data struct. filled with data read from CAN
%           in main.c
%   y   Function input and output struct. contains all clipped and
%           filtered variables, variable buffers, and output from
%           this function.

function y = vcu_step(p,f,x,y)
    y = get_CF(p, f, x, y);

    % determine VCU mode
    y = get_VCU_mode(p,f,x,y);
    
    % calculate baseline control
    y = get_BL(p,y);

    % calculate proportional control
    y = get_PT(p,y);

    % calculate variable speed (TC)
    y = get_VS(p, y);

    % calculate variable torque (TV)
    y = get_VT(p, y);

    % calculate regen
end
