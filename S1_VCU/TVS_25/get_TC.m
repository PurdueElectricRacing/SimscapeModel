function [y] = get_TC(p, x, y)
    w_avg = mean(y.w_sf); % compute average tire velocity
    y.sl = (w_avg * p.r) / (y.v_gs_sf + p.TC_eps) - 1; % compute modified slip ratio

    % if slipping increment counter, reset if not slipping
    if y.sl >= p.sl_threshold
        y.TC_trigger_counter = y.TC_trigger_counter + 1;
    else
        y.tigger_counter = 0;
    end

    % if enough consectutive triggers, engage TC
    if y.TC_trigger_counter >= p.TC_triggers_to_switch
        y.t_tc = y.t_raw * p.TC_throttle_mult;
    else
        y.t_tc = y.t_raw;
    end
end