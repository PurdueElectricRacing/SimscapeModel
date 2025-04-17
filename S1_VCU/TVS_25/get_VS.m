%% Function Description
% This function computes the reference angular velocity of the motor shaft
% speed given the current pedal position. The reference slip ratio is
% propotional to the throttle, but then a minimum speed is enforced to
% ensure proper startup at low speed. Otherwise, the target slip ratio is
% transformed into the corresponding target speed by using the slip ratio
% formula.
%
% Input      :  p - struct of all constant controller parameters
%               y - struct of VS processed controller data at time t-1
% 
% Return     :  y - struct of VS processed controller data at time t

function y = get_VS(p,y)
    % get the reference slip ratio [Unitless]
    y.SR_VS = y.TH_CF*y.VS_MAX_SR_CF;

    % get the reference motor shaft speed [rad/s]
    y.WM_VS = max(p.WM_VS_LS, p.gr*((y.GS_CF/p.r)*(y.SR_VS + 1))) .* [1 1];
end