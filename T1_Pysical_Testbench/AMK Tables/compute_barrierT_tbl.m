function [minT_tbl, maxT_tbl] = compute_barrierT_tbl(speed_matrix,torque_matrix,voltageDC_matrix,current_matrix,voltageT_tbl,speed_bp,nv,ns)
    %% Step 1: make speed-currrent-max_voltage_dc a bijective function
    VoltageDC_matrix_rounded = round(voltageDC_matrix,2);
    abs_max_VDC = max(VoltageDC_matrix_rounded,[],"all");
    not_bijective_matrix = VoltageDC_matrix_rounded == abs_max_VDC;
    
    VoltageDC_matrix_bijectiveVDC = voltageDC_matrix(~not_bijective_matrix);
    current_matrix_bijectiveVDC = current_matrix(~not_bijective_matrix);
    speed_matrix_bijectiveVDC = speed_matrix(~not_bijective_matrix);

    %% Step 2: make max I as a function of speed and VDC
    [xData, yData, zData] = prepareSurfaceData(speed_matrix_bijectiveVDC,VoltageDC_matrix_bijectiveVDC,current_matrix_bijectiveVDC);
    ft = 'linearinterp';
    opts = fitoptions('Method','LinearInterpolant');
    opts.ExtrapolationMethod = 'nearest';
    opts.Normalize = 'on';
    maxI_fit = fit([xData,yData],zData,ft,opts);
    
    %% Step 3: make torque as a function of battery current and motor speed
    [xData, yData, zData] = prepareSurfaceData(speed_matrix,current_matrix,torque_matrix);
    ft = 'cubicinterp';
    opts = fitoptions('Method','CubicSplineInterpolant');
    opts.ExtrapolationMethod = 'linear';
    opts.Normalize = 'on';
    torque_fit = fit([xData,yData],zData,ft,opts);
    
    %% Step 4: generate max torque table given battery voltage and motor speed
    maxT_tbl = zeros(nv,ns);
    
    for i = 1:nv
        barrier_current = feval(maxI_fit,speed_bp,voltageT_tbl(i,:));
        maxT_tbl(i,:) = feval(torque_fit,speed_bp,barrier_current);
    end

    %% Step 5: flip and translate limit table to get regen as well
    minT_tbl = -maxT_tbl + 2*min(maxT_tbl,[],"all");
end