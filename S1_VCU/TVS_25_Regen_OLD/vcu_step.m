function y = vcu_step(p,f,x,y)
    % determine VCU mode - ET, PT, VT, VS
    y = get_VCU_mode(p,f,x,y);

    % compute clip and filtered measurements
    y = get_CF(p,x,y);

    % get baseline mode (BL)
    y = get_BL(p,y);

    % if in regen, go to seperate set of controllers
    if y.VCU_mode == 5
        y = get_PT_R(p,y);
    else
    % if not in regen, choose correct mode
        % if permissible, get Proportional Torque (PT)
        if y.VCU_mode >= 2
            y = get_PT(p,y);
        end
    
        % if permissible, get Variable Speed (VS)
        if y.VCU_mode == 3
            y = get_VS(p,y);
        end
    
        % if permissible, get Variable Torque (VT)
        if y.VCU_mode == 4
            y = get_VT(p,y);
        end
    end
end