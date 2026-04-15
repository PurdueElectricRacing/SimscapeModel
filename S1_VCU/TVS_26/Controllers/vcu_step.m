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
    % y = get_VCU_mode(p,f,x,y);
    
    % switch between power and regen depending on throttle
    if y.TH > 0
        % baseline power torque
        % torque limit after current, power, thermal derating
        y = get_BL_PO(p, y);
        
        if y.VCU_MODE == 0 % fallback for no sensor data
            % emulate torque control using high speed setpoint
            y.TORQUE_OUT = y.TO_BL_PO;
            y.SPEED_OUT = p.MAX_ABS_WM .* [1 1 1 1];

        elseif y.VCU_MODE == 1 % accel event controller
            % Use torque limit from baseline controller
            % speed limit from accel controller
            y = get_ACCEL(p, y);
            y.TORQUE_OUT = y.TO_BL_PO;
            y.SPEED_OUT = y.AC_MW;

        elseif y.VCU_MODE == 2 % skidpad event controller
            y = get_SKID(p, y);
            y.TORQUE_OUT
        end

    elseif y.TH < 0
        % baseline regen torque
        % torque limit after speed, current, voltage, thermal derating
        y = get_BL_RG(p, y);
        y.TORQUE_OUT = y.TO_BL_RG;

    else
        % throttle == 0, and fallback
        y.TORQUE_OUT = [0 0 0 0];
        y.SPEED_OUT = [0 0 0 0];
    end
end
