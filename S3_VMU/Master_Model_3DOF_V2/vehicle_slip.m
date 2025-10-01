%% This function computes the front/rear slip ratio of a 4 tire vehicle 
% with equal torque left to right

% Inputs:
% s:      The state vector
% model:  Vehicle parameter structure

% Outputs:
% SR: Slip ratio of each tire [unitless] [FL FR RL RR]
%     Positive slip angle corresponds to positive Fx
%     Positive Fx corresponds to forward acceleration

function w = vehicle_slip(s, model)
    % get states
    SR = s(13:14);

    % transform abolute velocity into vehicle frame velocity
    dxv = s(1);

    % longitudinal corner velocity at each corner [m/s] [FL FR RL RR]
    dxC = dxv; % positive dxC is forward

    % longitudinal tire velocity at each corner [m/s] [FL FR RL RR]
    dxT = dxC;

    % tire angular velocity [rad/s] [FL FR RL RR] positive slip ratio is positive Fx is forward acceleration
    sign_dxT = (dxT >= 0) - (dxT < 0);
    w = (SR.*(sign_dxT.*max(abs(dxT), model.epsSR)) + dxT) ./ model.r0;
    w = [w(1); w(1); w(2); w(2)];
end