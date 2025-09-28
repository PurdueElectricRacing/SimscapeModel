%% This function computes the slip angle and slip ratio of a 4 tire vehicle

% Inputs:
% s:      The state vector
% CCSA:   The center column steering angle [deg]
%         Positive is clockwise
% xT:     Signed longitudinal distance from supsension COG (SCOG) to tire contact patch [FL FR RL RR] [m]
%         Positive distance corresponds to in front of SCOG
% yT:     Signed lateral distance from supsension COG (SCOG) to tire contact patch [FL FR RL RR] [m]
%         Positive distance corresponds to right of SCOG
% model:  Vehicle parameter structure

% Outputs:
% SA: Slip angle of each tire [rad] [FL FR RL RR]
%     positive slip angle corresponds to positive Fy
%     positive Fy corresponds to acceleration to the right
% SR: Slip ratio of each tire [unitless] [FL FR RL RR]
%     Positive slip angle corresponds to positive Fx
%     Positive Fx corresponds to forward acceleration

function [SA, SR] = vehicle_slip(s, CCSA, xT, yT, model)
    % get states
    dyaw = s(11);
    yaw = s(12);
    w = s(19:22);

    % transform abolute velocity into vehicle frame velocity
    dxv = s(3)*sin(yaw) + s(1)*cos(yaw);
    dyv = s(3)*cos(yaw) - s(1)*sin(yaw);

    % distance from CoG to each corner [m] [FL FR RL RR]
    r = sqrt(xT.^2 + yT.^2);

    % absolute value of the angle that forms Vx as opposite and Vy as adjacent [rad] [FL FR RL RR]
    t = atan(abs(yT./xT));

    % longitudinal and lateral corner velocity at each corner [m/s] [FL FR RL RR]
    dxC = dxv + [1; -1; -1; 1].*dyaw.*r.*sin(t); % positive dxC is forward
    dyC = dyv + [1; 1; -1; -1].*dyaw.*r.*cos(t); % positive dyC is right

    % slip angle [rad] [FL FR RL RR] positive slip angle is positive Fy is acceleration to the right
    toe = sign(CCSA).*abs(polyval(model.p, [-CCSA;CCSA;0;0])) + model.st;
    vel = sqrt(s(1)^2 + s(3)^2);
    SA = (toe - atan(dyC ./ max(abs(dxC),model.epsSA))) * ((2 / (1+exp(-2*vel^2))) - 1);

    % longitudinal tire velocity at each corner [m/s] [FL FR RL RR]
    dxT = sqrt(dxC.^2 + dyC.^2).*cos(SA);

    % slip ratio [unitless] [FL FR RL RR] positive slip ratio is positive Fx is forward acceleration
    sign_dxT = (dxT >= 0) - (dxT < 0);
    SR = (w.*model.r0 - dxT) ./ (sign_dxT.*max(abs(dxT), model.epsSR));
end