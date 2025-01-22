function [y] = get_TC(p, x, y)
    w_avg = mean(y.w_sf); % compute average tire velocity
    y.sl = (w_avg * p.r) / (y.v_gs_sf + p.TC_eps) - 1; % compute modified slip ratio

    % if slipping increment counter, reset if not slipping
    if y.sl >= p.sl_threshold
        y.TC_highs = y.TC_highs + 1;
        y.TC_lows = 0;
        
    elseif y.sl < p.sl_threshold
        y.TC_lows = y.TC_lows + 1;
        y.TC_highs = 0;
    else
    end

    % if enough consectutive triggers, engage or disengage TC
    if y.TC_highs >= p.TC_highs_to_engage
        y.t_tc = y.t_raw * p.TC_throttle_mult;
    
    elseif y.TC_lows >= p.TC_lows_to_disengage
        y.t_tc = y.t_raw;
    end
end