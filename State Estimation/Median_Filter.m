function [Tn_filt, T0_filt]  = Median_Filter(T0_filt,Tn)
    % update Temperature vector
    T0_filt = [T0_filt(2:end,:); Tn];
    
    % apply filter
    Tn_filt = median(T0_filt);
end