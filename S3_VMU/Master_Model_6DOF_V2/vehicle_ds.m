%% Function Description
%  s - state vector [22 1]
%  
%  s(1)  = dxCOG  [m/s] - the X velocity in fixed coordinate system [m/s]
%  s(2)  = xCOG   [m] - the X position in fixed coordinate system [m]
%  s(3)  = dyCOG  [m/s] - the Y velocity in fixed coordinate system [m/s]
%  s(4)  = yCOG   [m] - the Y position in fixed coordinate system [m]
%  s(5)  = dzCOG  [m/s] - the Z velocity in fixed coordinate system [m/s]
%  s(6)  = zCOG   [m] - the Z position in fixed coordinate system [m]

%  s(7)  = dnCOG  [rad/s] - the derivative of the orientation of the vehicle wrt the longitudinal axis
%  s(8) = nCOG   [rad] - the  orientation of the vehicle wrt the longitudinal axis
%  s(9)  = doCOG  [rad/s] - the derivative of the orientation of the vehicle wrt the lateral axis
%  s(10)  = oCOG   [rad] - the  orientation of the vehicle wrt the lateral axis
%  s(11) = dpCOG  [rad/s] - the derivative of the orientation of the vehicle wrt the vertical axis
%  s(12) = pCOG   [rad] - the  orientation of the vehicle wrt the vertical axis

%  s(13) = Vb  [V] - the voltage across the terminals of the HV battery
%  s(14) = As  [A*s] - the charge drained from the HV battery, 0 corresponds to full charge

%  s(15) = taufl [Nm] - the actual torque applied to the front left motor
%  s(16) = taufr [Nm] - the actual torque applied to the front right motor
%  s(17) = taurl [Nm] - the actual torque applied to the rear left motor
%  s(18) = taurr [Nm] - the actual torque applied to the rear right motor

%  s(19) = wfl  [rad/s] - the angular velocity of the front left tire
%  s(20) = wfr  [rad/s] - the angular velocity of the front right tire
%  s(21) = wrl  [rad/s] - the angular velocity of the rear left tire
%  s(22) = wrr  [rad/s] - the angular velocity of the rear right tire

%% The function
function ds = vehicle_ds(t, s, tauRaw, CCSA, P, model)
    if sum(isnan(s)) || sum(isinf(s))
        stop = 1;
    end

    % if t > 10
    %     tauRaw = tauRaw.*0.5;
    % end
    % 
    % if t > 20
    %     tauRaw = tauRaw.*0;
    % end

    % if t > 20
    %     P = 400000;
    % end

    [dVb, dAs, dT] = vehicle_powertrain(s, tauRaw, model);
    [xS, yS, zS, dxS, dyS, dzS, xT, yT, zT] = vehicle_suspension(s, model);
    [SA, SR] = vehicle_slip(s, CCSA, xT, yT, model);
    [sum_Fxa, sum_Fya, sum_Fza, sum_Mx, sum_My, sum_Mz, res_torque] = vehicle_forces(s, CCSA, P, SR, SA, xT, yT, zS, dzS, tauRaw, model);
    derivatives = vehicle_dynamics(s, sum_Fxa, sum_Fya, sum_Fza, sum_Mx, sum_My, sum_Mz, res_torque, model);
    
    ds = [derivatives; dVb; dAs; dT; res_torque];

    if sum(isnan(ds)) || sum(isinf(ds))
        stop = 1;
    end
end