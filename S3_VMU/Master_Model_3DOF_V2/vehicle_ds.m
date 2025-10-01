%% Function Description
%  s - state vector [12 1]
%  
%  s(1)  = dxCOG  [m/s] - the X velocity in fixed coordinate system [m/s]
%  s(2)  = xCOG   [m] - the X position in fixed coordinate system [m]
%  s(3)  = dzCOG  [m/s] - the Z velocity in fixed coordinate system [m/s]
%  s(4)  = zCOG   [m] - the Z position in fixed coordinate system [m]
%  s(5)  = doCOG  [rad/s] - the derivative of the orientation of the vehicle wrt the lateral axis
%  s(6)  = oCOG   [rad] - the  orientation of the vehicle wrt the lateral axis

%  s(7) = Vb  [V] - the voltage across the terminals of the HV battery
%  s(8) = As  [A*s] - the charge drained from the HV battery, 0 corresponds to full charge

%  s(9) = tauf [Nm] - the actual torque applied to the front motors
%  s(10) = taur [Nm] - the actual torque applied to the rear motors

%  s(11) = Ovf [%] - Overload of the front motors
%  s(12) = Ovf [%] - Overload of the rear motors

%  s(13) = SRfl  [rad/s] - the slip ratio of the front tires
%  s(14) = SRrl  [rad/s] - the slip ratio of the rear tires

%% The function
function ds = vehicle_ds(t, s, tauRaw, P, model)
    [xS, yS, zS, dxS, dzS, xT, yT, zT] = vehicle_suspension(s, model);
    w = vehicle_slip(s, model);
    [sum_Fxa, sum_Fza, sum_My, res_torque] = vehicle_forces(s, P, w, xT, zS, dzS, model);
    derivatives = vehicle_dynamics(s, sum_Fxa, sum_Fza, sum_My, model);
    [dVb, dAs, dT, dOv] = vehicle_powertrain(s, tauRaw, w, model);
    
    ds = [derivatives; dVb; dAs; dT(1); dT(3); dOv; res_torque(1); res_torque(3)];
end