function [Tn_filt, T0_filt]  = Median_Filter(T0_filt,Tn)
    % update Temperature vector
    T0_filt = [T0_filt(2:end,:); Tn];
    
    % apply filter
    Tn_filt0 = median(T0_filt);

    % initialize search
    i = 1;

    % search for nearest valid data point
    while abs(Tn_filt0 - Tn) > 1
        Tn = T0_filt(end-i);
        i = i + 1;
    end

    % select nearest valid data point as official temperature
    Tn_filt = Tn;
end