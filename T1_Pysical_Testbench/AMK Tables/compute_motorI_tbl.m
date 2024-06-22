function motorI_tbl = compute_motorI_tbl(speed_matrix,torque_matrix,current_matrix,speed_tbl,torque_tbl)
    %% Step 1: make torque-speed-current a bijective function
    not_bijective_matrix = abs(torque_matrix(:,1:end-1) - torque_matrix(:,2:end)) < 0.5;
    not_bijective_matrix = [not_bijective_matrix(:,1) not_bijective_matrix];
    
    speed_matrix_bijectiveT = speed_matrix(~not_bijective_matrix);
    torque_matrix_bijectiveT = torque_matrix(~not_bijective_matrix);
    current_matrix_bijectiveT = current_matrix(~not_bijective_matrix);
    
    %% Step 2: make positive torque-speed-current table
    [xData, yData, zData] = prepareSurfaceData( torque_matrix_bijectiveT, speed_matrix_bijectiveT, current_matrix_bijectiveT );
    ft = 'linearinterp';
    opts = fitoptions( 'Method', 'LinearInterpolant' );
    opts.ExtrapolationMethod = 'linear';
    opts.Normalize = 'on';
    [current_all_fit, gof] = fit( [xData, yData], zData, ft, opts );
    
    current_all_fit_matrix = feval(current_all_fit, torque_matrix, speed_matrix);
    
    %% Step 3: make full torque-speed-current table
    speed_all = [speed_matrix speed_matrix];
    torque_all = [torque_matrix -torque_matrix + 2*torque_matrix(:,1)];
    current_all = [current_all_fit_matrix -current_all_fit_matrix];
    
    [xData, yData, zData] = prepareSurfaceData( speed_all, torque_all, current_all );
    ft = 'cubicinterp';
    opts = fitoptions( 'Method', 'CubicSplineInterpolant' );
    opts.ExtrapolationMethod = 'linear';
    opts.Normalize = 'on';
    [current_all_fit, gof] = fit( [xData, yData], zData, ft, opts );
    
    motorI_tbl = feval(current_all_fit, speed_tbl, torque_tbl);
end