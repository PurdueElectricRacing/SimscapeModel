%% Function Description
%  s - state vector [11 1]
%  
%  s(1)  = dx  [m/s] - the chassis center of gravity forward velocity
%  s(2)  = x   [m] - the longitudinal distance traveled by the chassis center of gravity
%  s(3)  = dz  [m/s] - the chassis center of gravity vertical velocity
%  s(4)  = z   [m] - the vertical distance between the ground plane and the chassis center of gravity
%  s(5)  = do  [rad/s] - the derivative of the orientation of the vehicle wrt the horizontal axis
%  s(6)  = o   [rad] - the  orientation of the vehicle wrt the horizontal axis
%  s(7)  = wf  [rad/s] - the differential angular velocity of the front tires
%  s(8)  = wr  [rad/s] - the differential angular velocity of the rear tires
%  s(9)  = Voc [V] - the open circuit voltage of the HV battery
%  s(10) = Vb  [V] - the voltage across the terminals of the HV battery
%  s(11) = Ah  [A*hr] - the charge drained from the HV battery, 0 corresponds to full charge
%  s(12) = Imf [A] - the current pulled by the front powertrain
%  s(13) = Imr [A] - the current pulled by the rear powertrain

%% The function
function ds = compute_ds_master(t, s, tauRaw, varCAR)
    [FxFR, zFR, dzFR, wt, tau, FzFR] = traction_model_3DOF_master(s, varCAR);
    [ddx, ddz, ddo, dw] = vehicle_dynamics_model_master(s, tau, FxFR, zFR, dzFR, FzFR, wt, varCAR);
    [dVoc, dVb, dAh, dIm] = powertrain_model_master(s, tauRaw, wt, varCAR);

    ds = [ddx; s(1); ddz; s(3); ddo; s(5); dw; dVoc; dVb; dAh; dIm];
end