function [minT_tbl, maxT_tbl] = compute_barrierT_tbl(speed_matrix,torque_matrix,voltageDC_matrix,current_matrix,voltageT_tbl,speed_bp,nv)
    %% Step 1: Make speed-currrent-max_voltage_ac a bijective function
    VoltageAC_matrix_rounded = round(voltageDC_matrix,2);
    abs_max_VAC = max(VoltageAC_matrix_rounded,[],"all");
    not_bijective_matrix = VoltageAC_matrix_rounded == abs_max_VAC;
    
    VoltageDC_matrix_bijectiveVAC = voltageDC_matrix(~not_bijective_matrix);
    current_matrix_bijectiveVAC = current_matrix(~not_bijective_matrix);
    speed_matrix_bijectiveVAC = speed_matrix(~not_bijective_matrix);

    %% Step 2: Make Max I as a function of speed and VDC
    [xData, yData, zData] = prepareSurfaceData( speed_matrix_bijectiveVAC, VoltageDC_matrix_bijectiveVAC, current_matrix_bijectiveVAC );
    ft = 'linearinterp';
    opts = fitoptions( 'Method', 'LinearInterpolant' );
    opts.ExtrapolationMethod = 'nearest';
    opts.Normalize = 'on';
    [maxI_fit, gof] = fit( [xData, yData], zData, ft, opts );
    
    %% Step 3: Make torque as a function of battery current and motor speed
    [xData, yData, zData] = prepareSurfaceData( speed_matrix, current_matrix, torque_matrix );
    ft = 'cubicinterp';
    opts = fitoptions( 'Method', 'CubicSplineInterpolant' );
    opts.ExtrapolationMethod = 'linear';
    opts.Normalize = 'on';
    [torque_fit, gof] = fit( [xData, yData], zData, ft, opts );
    
    %% Step 4: Generate max torque table given battery voltage and motor speed
    maxT_tbl = [];
    
    for i = 1:nv
        barrier_current = feval(maxI_fit,speed_bp,voltageT_tbl(i,:));
        barrier_torque = feval(torque_fit,speed_bp,barrier_current);
    
        maxT_tbl = [maxT_tbl; barrier_torque'];
    end

    %% Step 5: Flip and translate limit table to get regen as well
    minT_tbl = -maxT_tbl + 2*min(maxT_tbl,[],"all");
end