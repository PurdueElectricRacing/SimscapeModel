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
    y = get_VCU_mode(p,x,y);
    
    % switch between power and regen depending on throttle
    if y.TH > 0
        % baseline power torque
        % torque limit after current, power, thermal derating
        y = get_BL_PO(p, y);
        
        if y.VCU_MODE == 0 % fallback for no sensor data
            % emulate torque control using high speed setpoint
            y.TORQUE_LIM_NEG = [0 0 0 0];
            y.TORQUE_LIM_POS = y.TO_BL_PO;
            y.SPEED_OUT = p.MAX_ABS_WM .* [1 1 1 1];
            y.TORQUE_OUT = y.TO_BL_PO; % because of no speed control

        elseif y.VCU_MODE == 1 % accel event controller
            % Use torque limit from baseline controller
            % speed limit from accel controller
            y = get_ACCEL(p, y);
            y.TORQUE_LIM_NEG = [0 0 0 0];
            y.TORQUE_LIM_POS = y.TO_BL_PO;
            y.SPEED_OUT = y.AC_MW;
            y.TORQUE_OUT = y.TO_BL_PO; % because of no speed control

        elseif y.VCU_MODE == 2 % skidpad event controller
            y = get_SKID(p, y);
            y.TORQUE_LIM_NEG = [0 0 0 0];
            y.TORQUE_LIM_POS = y.SK_TO;
            y.SPEED_OUT = p.MAX_ABS_WM * [1 1 1 1];
            y.TORQUE_OUT = y.SK_TO; % because of no speed control
        elseif y.VCU_MODE == 3 % auto-x event controller
            y = get_AUTOX(p, y);
            y.TORQUE_LIM_NEG = [0 0 0 0];
            y.TORQUE_LIM_POS = y.AX_TO;
            y.SPEED_OUT = p.MAX_ABS_WM * [1 1 1 1];
            y.TORQUE_OUT = y.AX_TO; % because of no speed control
        elseif y.VCU_MODE == 4 % testing/tuning controller
            y = get_TEST(p, y);
        end

    elseif y.TH < 0
        % baseline regen torque
        % torque limit after speed, current, voltage, thermal derating
        y = get_BL_RG(p, y);
        y.TORQUE_LIM_NEG = y.TO_BL_RG;
        y.TORQUE_LIM_POS = [0 0 0 0];
        y.TORQUE_OUT = y.TO_BL_RG; % because of no speed control

    else
        % throttle == 0, and fallback
        y.TORQUE_LIM_NEG = [0 0 0 0];
        y.TORQUE_LIM_POS = [0 0 0 0];
        y.SPEED_OUT = [0 0 0 0];
        y.TORQUE_OUT = [0 0 0 0]; % because of no speed control
    end
end
