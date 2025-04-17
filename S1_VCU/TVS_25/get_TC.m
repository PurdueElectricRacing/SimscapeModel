%% Function Description
% This function computes the traction control torque control setpoint,
% which is sent to main. First, the slip ratio is approximated. Next, a
% counter is used to determine how much time has been spent above or below
% a reference slip ratio threshold. Finally, the value of the counter is
% used to determine the value of the torque setpoint.
%
% Input      :  p - struct of all constant controller parameters
%               y - struct of TC processed controller data at time t-1
% 
% Return     :  y - struct of TC processed controller data at time t

function y = get_TC(p, y)
    % compute modified slip ratio
    w_avg = 0.5*(y.W_CF(1) + y.W_CF(2));
    y.SR = (w_avg * p.r) / snip(y.GS_CF, p.TC_eps, y.GS_CF) - 1; 

    % increment high or low sr counter
    y.TC_highs = (y.TC_highs + 1)*(y.SR >= p.TC_SR_threshold);
    y.TC_lows = (y.TC_lows + 1)*(y.SR < p.TC_SR_threshold);

    % if enough consectutive triggers, engage or disengage TC
    if y.TC_highs >= p.TC_highs_to_engage
        y.TO_VT = y.TO_PT * y.TC_TR_CF;
    
    elseif y.TC_lows >= p.TC_lows_to_disengage
        y.TO_VT = y.TO_PT;
    end
end