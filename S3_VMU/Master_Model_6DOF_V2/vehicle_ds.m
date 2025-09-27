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

%  s(13) = wfl  [rad/s] - the angular velocity of the front left tire
%  s(14) = wfr  [rad/s] - the angular velocity of the front right tire
%  s(15) = wrl  [rad/s] - the angular velocity of the rear left tire
%  s(16) = wrr  [rad/s] - the angular velocity of the rear right tire

%  s(17) = Vb  [V] - the voltage across the terminals of the HV battery
%  s(18) = As  [A*s] - the charge drained from the HV battery, 0 corresponds to full charge

%  s(19) = Imfl [A] - the current pulled by the front left powertrain
%  s(20) = Imfr [A] - the current pulled by the front right powertrain
%  s(21) = Imrl [A] - the current pulled by the rear left powertrain
%  s(22) = Imrr [A] - the current pulled by the rear right powertrain

%  s(23)
%  s(24)
%  s(25)
%  s(26)


%% The function
function ds = vehicle_ds(t, s, tauRaw, CCSA, model)
    [dVb, dAs, dIm] = vehicle_powertrain(s, tauRaw, model);
    [xS, yS, zS, dxS, dyS, dzS, xT, yT, zT] = vehicle_suspension(s, model);
    [SA, SR] = vehicle_slip(s, CCSA, xT, yT, model);
    [sum_Fxa, sum_Fya, sum_Fza, sum_Mx, sum_My, sum_Mz, res_torque, res_power] = vehicle_forces(s, CCSA, SR, SA, xT, yT, zS, dzS, tauRaw, model);
    derivatives = vehicle_dynamics(s, sum_Fxa, sum_Fya, sum_Fza, sum_Mx, sum_My, sum_Mz, res_torque, model);
    
    ds = [derivatives; dVb; dAs; dIm; res_power];
end