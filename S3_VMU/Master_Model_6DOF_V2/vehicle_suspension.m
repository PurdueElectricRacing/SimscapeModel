%% This function computes the position and derivative of position of the
% shock fixed points and tire contact patch.

% Inputs:
% s: The state vector
% model:  Vehicle parameter structure

% Outputs:
% xS:  Signed longitudinal distance from supsension COG (SCOG) to shock fixed point [FL FR RL RR] [m]
%      positive distance corresponds to in front of SCOG
% yS:  Signed lateral distance from supsension COG (SCOG) to shock fixed point [FL FR RL RR] [m]
%      positive distance corresponds to right of SCOG
% zS:  Signed vertical distance from ground to shock fixed point [FL FR RL RR] [m]
%      positive distance corresponds to above ground
% dxS: Signed derivative of longitudinal distance from supsension COG (SCOG) to shock fixed point [FL FR RL RR] [m]
%      positive distance corresponds to in front of SCOG
% dyS: Signed derivative of lateral distance from supsension COG (SCOG) to shock fixed point [FL FR RL RR] [m]
%      positive distance corresponds to right of SCOG
% dzS: Signed derivative of vertical distance from ground to shock fixed point [FL FR RL RR] [m]
%      positive distance corresponds to above ground
% xT:  Signed longitudinal distance from supsension COG (SCOG) to tire contact patch [FL FR RL RR] [m]
%      positive distance corresponds to in front of SCOG
% yT:  Signed lateral distance from supsension COG (SCOG) to tire contact patch [FL FR RL RR] [m]
%      positive distance corresponds to right of SCOG
% zT:  Signed vertical distance from ground to tire contact patch [FL FR RL RR] [m]
%      positive distance corresponds to above ground

function [xS, yS, zS, dxS, dyS, dzS, xT, yT, zT] = vehicle_suspension(s, model)
    % get states
    dza = s(5);
    za = s(6);

    droll = s(7);
    roll = s(8);
    dpitch = s(9);
    pitch = s(10);

    % height & derivative of height of supsension plane at point that is normal to zCOG [m]
    % the COG longitudinal & lateral positions are always at the origin [m]
    a = cos(pitch)^2 + cos(roll)^2*sin(pitch)^2;
    z0 = za + (model.LN*cos(pitch)*cos(roll)) / (sqrt(a));
    dz0 = dza - ((model.LN*(sin(pitch)*cos(roll)^3*dpitch + sin(roll)*cos(pitch)^3*droll)) / (sqrt(a^3)));

    % actual wheel base and half track defining shock fixed points [m]
    wb_s_actual = model.wb_s0.*cos(pitch);
    ht_s_actual = model.hs_s0.*cos(roll);

    % change in height due to pitch and roll [m]
    dz_pitch = model.wb_s0.*sin(pitch);
    dz_roll = model.hs_s0.*sin(roll);

    % position of each shock fixed point [m]
    xS = wb_s_actual.*[1;1;-1;-1]; % longitudinal position, positive is forward of COG [m]
    yS = ht_s_actual.*[-1;1;-1;1]; % lateral position, positive is right of COG [m]
    zS = z0 + dz_pitch.*[1;1;-1;-1] + dz_roll.*[-1;1;-1;1];

    % position of each tire fixed point [m]
    xT = xS;
    yT = yS;
    zT = [0;0;0;0];
    
    % change in position of each shock fixed point [m/s]
    dxS = dz_pitch.*[-1;-1;1;1];
    dyS = dz_roll.*[1;-1;1;-1];
    dzS = dz0 + wb_s_actual.*dpitch.*[1;1;-1;-1] + ht_s_actual.*droll.*[-1;1;-1;1];
    dzS = min(max(dzS,model.dz_min), model.dz_max);
end