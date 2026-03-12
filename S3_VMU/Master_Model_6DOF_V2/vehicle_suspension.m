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
    
    a = [cos(roll), 0, sin(roll)];
    b = [0, cos(pitch), sin(pitch)];
    
    n_ground = cross(a,b);
    p_ground = n_ground(3) * -s(6);

    n = n_ground / norm(n_ground);
    rotation_og = [a; b; n];


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

    %% Solving for tyre location using example_solving fzero solution system

    % Initialising known values from stored values in vehicle_parameters
    FL_fixed = model.FL_fixed;
    FL_lengths = model.FL_lengths;
    FL_planes = model.FL_planes;
    FR_fixed = model.FR_fixed;
    FR_lengths = model.FR_lengths;
    FR_planes = model.FR_planes;
    RL_fixed = model.RL_fixed;
    RL_lengths = model.RL_lengths;
    RL_planes = model.RL_planes;
    RR_fixed = model.RR_fixed;
    RR_lengths = model.RR_lengths;
    RR_planes = model.RR_planes;

    % Solving
    % Upper and lower bounds for the A - arm angle for the fzero function
    F_lb = -25*pi/180;
    F_ub = 25*pi/180;
    R_lb = -25*pi/180;
    R_ub = 25*pi/180;

    % solve FL
    res = @(alpha)(distance(FL_fixed, FL_lengths, alpha, n_ground, p_ground));
    FL_alpha_sol = fzero(res, [F_lb F_ub]);
    
    % solve RL
    res = @(alpha)(distance(FR_fixed, FR_lengths, alpha, n_ground, p_ground));
    FR_alpha_sol = fzero(res, [F_lb F_ub]);
    
    % solve RL
    res = @(alpha)(distance(RL_fixed, RL_lengths, alpha, n_ground, p_ground));
    RL_alpha_sol = fzero(res, [R_lb R_ub]);
    
    % solve RR
    res = @(alpha)(distance(RR_fixed, RR_lengths, alpha, n_ground, p_ground));
    RR_alpha_sol = fzero(res, [R_lb R_ub]);
    
    %% Calculate from solutions
    % FL
    FL_lower_solved = calculate_lower(FL_fixed, FL_lengths, FL_alpha_sol);
    FL_upper_solved = calculate_upper(FL_fixed, FL_lengths, FL_planes, FL_lower_solved(4,:));
    FL_solved = [FL_lower_solved; FL_upper_solved];
    % RL
    RL_lower_solved = calculate_lower(RL_fixed, RL_lengths, RL_alpha_sol);
    RL_upper_solved = calculate_upper(RL_fixed, RL_lengths, RL_planes, RL_lower_solved(4,:));
    RL_solved = [RL_lower_solved; RL_upper_solved];
    % FR
    FR_lower_solved = calculate_lower(FR_fixed, FR_lengths, FR_alpha_sol);
    FR_upper_solved = calculate_upper(FR_fixed, FR_lengths, FR_planes, FR_lower_solved(4,:));
    FR_solved = [FR_lower_solved; FR_upper_solved];
    % RR
    RR_lower_solved = calculate_lower(RR_fixed, RR_lengths, RR_alpha_sol);
    RR_upper_solved = calculate_upper(RR_fixed, RR_lengths, RR_planes, RR_lower_solved(4,:));
    RR_solved = [RR_lower_solved; RR_upper_solved];

    % Combine solved positions for all wheels
    wheelCoords = [FL_solved, FR_solved, RL_solved, RR_solved];

    %% Converting the coordinate system back to original from ground

    rotation_go = rotation_og';
    x0 = (p_ground ./ dot(n, n)) .* n;
    FL_solved_car = x0 + rotation_go .* FL_solved;  
    FR_solved_car = x0 + rotation_go .* FR_solved;
    RL_solved_car = x0 + rotation_go .* RL_solved;  
    RR_solved_car = x0 + rotation_go .* RR_solved;


    % Combining only pt2 (tyre contact point) position data for all wheels
    tyrecontact_coords = [FL_solved_car(2,:); FR_solved_car(2,:); RL_solved_car(2,:); RR_solved_car(2,:)];


    %% Defining values again

    % position of each tire fixed point [m]
    xT = tyrecontact_coords(:,1);
    yT = tyrecontact_coords(:,2);
    zT = tyrecontact_coords(:,3); %[0;0;0;0];
    
    % change in position of each shock fixed point [m/s]
    dxS = dz_pitch.*[-1;-1;1;1];
    dyS = dz_roll.*[1;-1;1;-1];
    dzS = dz0 + wb_s_actual.*dpitch.*[1;1;-1;-1] + ht_s_actual.*droll.*[-1;1;-1;1];
    dzS = min(max(dzS,model.dz_min), model.dz_max);
end