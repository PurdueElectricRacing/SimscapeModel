function [y] = get_TC(p, y)
    w_avg = mean(y.w_sf); % compute average tire velocity
    y.sl = (w_avg * p.r) / (y.v_gs_sf + p.TC_eps) - 1; % compute modified slip ratio

    % increment high or low sl counter
    if y.sl >= p.sl_threshold
        y.TC_highs = y.TC_highs + 1;
        y.TC_lows = 0;
        
    elseif y.sl < p.sl_threshold
        y.TC_lows = y.TC_lows + 1;
        y.TC_highs = 0;

    else % only happens in case of NAN
        y.TC_lows = 0;
        y.TC_highs = 0;
    end

    % if enough consectutive triggers, engage or disengage TC
    if y.TC_highs >= p.TC_highs_to_engage
        y.TH_VT = y.t_raw * p.TC_throttle_mult;
    
    elseif y.TC_lows >= p.TC_lows_to_disengage
        y.TH_VT = y.t_raw;
    end
end