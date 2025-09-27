% This function computes the vehicle dynamics derivatives.

% Inputs:
% sum_Fxa: The sum force forces in X of the fixed coordinate system [N]
% sum_Fya: The sum force forces in Y of the fixed coordinate system [N]
% sum_Fza: The sum force forces in Z of the fixed coordinate system [N]
% sum_Mx:  The sum of the moment about the x-axis vehicle COG [Nm]
% sum_My:  The sum of the moment about the y-axis vehicle COG [Nm]
% sum_Mz:  The sum of the moment about the z-axis vehicle COG [Nm]
% res_torque: The torque residual between tractive torque and motor torque [Nm]
% model:  Vehicle parameter structure

% Outputs:
% derivatives: All 6DOF vehicle dynamics derivatives and residuals

function derivatives = vehicle_dynamics(s, sum_Fxa, sum_Fya, sum_Fza, sum_Mx, sum_My, sum_Mz, res_torque, model)
    % states
    dxa = s(1);
    dya = s(3);
    dza = s(5);

    dMx = s(7);
    dMy = s(9);
    dMz = s(11);

    % 6DOF derivatives - 12 total derivatives
    ddX = (1/model.m)*sum_Fxa; % forward acceleration - positive is forward [m/s^2]
    dX = dxa;

    ddY = (1/model.m)*sum_Fya; % rightward acceleration - positive is right [m/s^2]
    dY = dya;

    ddZ = (1/model.m_s)*sum_Fza; % upward acceleration - positive is up [m/s^2]
    dZ = dza;

    ddroll = (1/model.Ixx)*sum_Mx; % positive is right up [rad/s^2]
    droll = dMx;

    ddpitch = (1/model.Iyy)*sum_My; % positive is front up [rad/s^2]
    dpitch = dMy;

    ddyaw = (1/model.Izz)*sum_Mz; % positive is clockwise [rad/s^2]
    dyaw = dMz;

    % angular acceleration residual between tire torque and powertrain torque [rad/s^2]
    dw = (1/model.Jw)*res_torque;

    % vehicle dynamics derivative vector
    derivatives = [ddX; dX; ddY; dY; ddZ; dZ; ddroll; droll; ddpitch; dpitch; ddyaw; dyaw; dw];
end