function motorI_tbl = compute_motorI_tbl(speed_matrix,torque_matrix,current_matrix,speedI_tbl,torqueI_tbl)
    %% Step 1: form overall raw table
    minT_matrix = -torque_matrix(:,2:end) + 2*torque_matrix(:,1);
    torque_matrix_all = [torque_matrix  minT_matrix];
    speed_matrix_all = [speed_matrix speed_matrix(:,2:end)];
    current_matrix_all = [current_matrix -current_matrix(:,2:end)];

    %% Step 2: make torque-speed-current a bijective function
    not_bijective_matrix_max = abs(torque_matrix(:,1:end-1) - torque_matrix(:,2:end)) < 0.5;
    not_bijective_matrix_min = abs(minT_matrix(:,1:end-1) - minT_matrix(:,2:end)) < 0.5;
    not_bijective_matrix = [not_bijective_matrix_max(:,1) not_bijective_matrix_max not_bijective_matrix_min(:,1) not_bijective_matrix_min];
    
    speed_matrix_bijectiveT = speed_matrix_all(~not_bijective_matrix);
    torque_matrix_bijectiveT = torque_matrix_all(~not_bijective_matrix);
    current_matrix_bijectiveT = current_matrix_all(~not_bijective_matrix);

    %% Step 3: make full torque-speed-current table   
    [xData, yData, zData] = prepareSurfaceData(speed_matrix_bijectiveT,torque_matrix_bijectiveT,current_matrix_bijectiveT);
    ft = 'cubicinterp';
    opts = fitoptions('Method','CubicSplineInterpolant');
    opts.ExtrapolationMethod = 'linear';
    opts.Normalize = 'on';
    current_all_fit = fit([xData,yData],zData,ft,opts);
    
    motorI_tbl = feval(current_all_fit, speedI_tbl, torqueI_tbl);
end