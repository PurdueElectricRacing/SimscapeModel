%% Function Description
% vcu_step runs every loop on the TV board
%
% Inputs
%   p   vehicle paramater struct. constant
%   x   Raw sensor data struct. filled with data read from CAN
%           in main.c
%   y   Function input and output struct. contains all clipped and
%           filtered variables, variable buffers, and output from
%           this function.
% Outputs
%   y   modified version of input y

function y = vcu_step(p, x, y)
    % clip and filter results
    y = get_CF(p, x, y);

    % determine VCU mode
    y = get_VCU_mode(p,f,x,y);
    
    % switch between power and regen depending on throttle
    if y.TH >= 0
        % baseline power torque
        % torque limit after current, power, thermal derating
        y = get_BL_PO(p, x, y);
    elseif y.TH < 0
        % baseline regen torque
        % torque limit after speed, current, voltage, SOC, thermal derating
        % y = get_BL_RG(p, x, y);
        y.TORQUE_OUT = [0 0 0 0];
    end
end
