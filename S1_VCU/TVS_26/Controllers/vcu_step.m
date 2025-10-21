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
    y = get_CF(p, f, x, y)

    % determine event
    y = get_event();

    % run controller for event
    if y.event == 0
        y = get_accel(p, f, y);
    elseif y.event == 1
        y = get_skidp(p, f, y);
    elseif y.event == 2
        y = get_autox(p, f, y)
    elseif y.event == 3
        y  =get_endur(p, f, y)
    end
end
