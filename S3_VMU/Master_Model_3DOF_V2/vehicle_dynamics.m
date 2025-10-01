% This function computes the vehicle dynamics derivatives.

% Inputs:
% sum_Fxa: The sum force forces in X of the fixed coordinate system [N]
% sum_Fza: The sum force forces in Z of the fixed coordinate system [N]
% sum_My:  The sum of the moment about the y-axis vehicle COG [Nm]
% res_torque: The torque residual between tractive torque and motor torque [Nm]
% model:  Vehicle parameter structure

% Outputs:
% derivatives: All 3DOF vehicle dynamics derivatives

function derivatives = vehicle_dynamics(s, sum_Fxa, sum_Fza, sum_My, model) 
    % states
    dxa = s(1);
    dza = s(3);
    dMy = s(5);

    % 3DOF derivatives - 6 total derivatives
    ddX = (1/model.m)*sum_Fxa; % forward acceleration - positive is forward [m/s^2]
    dX = dxa;

    ddZ = (1/model.m_s)*sum_Fza; % upward acceleration - positive is up [m/s^2]
    dZ = dza;

    ddpitch = (1/model.Iyy)*sum_My; % positive is front up [rad/s^2]
    dpitch = dMy;

    % vehicle dynamics derivative vector
    derivatives = [ddX; dX; ddZ; dZ; ddpitch; dpitch];
end