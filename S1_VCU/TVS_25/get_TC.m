function y = get_TC(p, y)
    w_avg = mean(y.WT_CF); % compute average tire velocity
    y.sl = (w_avg * p.r) / (y.GS_CF + p.TC_eps) - 1; % compute modified slip ratio

    % increment high or low sl counter
    % y.TC_highs = (y.TC_highs + 1)*(y.sl >= p.TC_sl_threshold);
    % y.TC_lows = (y.TC_lows + 1)*(y.sl < p.TC_sl_threshold);

    if y.sl >= p.TC_sl_threshold
        y.TC_highs = y.TC_highs + 1;
        y.TC_lows = 0;

    elseif y.sl < p.TC_sl_threshold
        y.TC_lows = y.TC_lows + 1;
        y.TC_highs = 0;

    else % only happens in case of NAN
        y.TC_lows = 0;
        y.TC_highs = 0;
    end

    % if enough consectutive triggers, engage or disengage TC
    if y.TC_highs >= p.TC_highs_to_engage
        y.TO_VT = y.TO_PT * p.TC_throttle_mult;
    
    elseif y.TC_lows >= p.TC_lows_to_disengage
        y.TO_VT = y.TO_PT;
    end
end