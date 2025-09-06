%% Function Description
%  s - state vector [12 1]
%  
%  s(1)  = dxCOG  [m/s] - the chassis center of gravity longitudinal velocity
%  s(2)  = xCOG   [m] - the longitudinal distance traveled by the chassis center of gravity
%  s(3)  = dzCOG  [m/s] - the chassis center of gravity vertical velocity
%  s(4)  = zCOG   [m] - the vertical distance between the ground plane and the chassis center of gravity
%  s(5)  = do  [rad/s] - the derivative of the orientation of the vehicle wrt the longitudinal axis
%  s(6)  = o   [rad] - the  orientation of the vehicle wrt the longitudinal axis; positive means front higher than rear
%  s(7)  = wf  [rad/s] - the differential angular velocity of the front tires
%  s(8)  = wr  [rad/s] - the differential angular velocity of the rear tires
%  s(9)  = Vb  [V] - the voltage across the terminals of the HV battery
%  s(10) = As  [A*s] - the charge drained from the HV battery, 0 corresponds to full charge
%  s(11) = Imf [A] - per motor current pulled by the front powertrain
%  s(12) = Imr [A] - per motor current pulled by the rear powertrain
%  s(13) = Ovf [ratio] - per motor overload of the front powertrain
%  s(14) = Ovr [ratio] - per motor overload of the rear powertrain

%% The function
function ds = compute_ds_master_3DOF(t, s, tauRaw, varCAR)
    [Fx, Fz, wt, tau] = traction_model_master_3DOF(s, varCAR);
    [ddx, ddz, ddo, dw] = vehicle_dynamics_model_master_3DOF(s, Fx, Fz, wt, tau, varCAR);
    [dVb, dAs, dIm] = powertrain_model_master_3DOF(s, wt, tauRaw, varCAR);

    ds = [ddx; s(1); ddz; s(3); ddo; s(5); dw; dVb; dAs; dIm];
end