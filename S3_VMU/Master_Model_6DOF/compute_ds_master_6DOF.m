%% Function Description
%  s - state vector [22 1]
%  
%  s(1)  = dxCOG  [m/s] - the chassis center of gravity longitudinal velocity
%  s(2)  = xCOG   [m] - the longitudinal distance traveled by the chassis center of gravity
%  s(3)  = dyCOG  [m/s] - the chassis center of gravity lateral velocity
%  s(4)  = yCOG   [m] - the lateral distance traveled by the chassis center of gravity
%  s(5)  = dzCOG  [m/s] - the chassis center of gravity vertical velocity
%  s(6)  = zCOG   [m] - the vertical distance between the ground plane and the chassis center of gravity

%  s(7)  = doCOG  [rad/s] - the derivative of the orientation of the vehicle wrt the lateral axis
%  s(8)  = oCOG   [rad] - the  orientation of the vehicle wrt the lateral axis
%  s(9)  = dnCOG  [rad/s] - the derivative of the orientation of the vehicle wrt the longitudinal axis
%  s(10) = nCOG   [rad] - the  orientation of the vehicle wrt the longitudinal axis
%  s(11) = dpCOG  [rad/s] - the derivative of the orientation of the vehicle wrt the vertical axis
%  s(12) = pCOG   [rad] - the  orientation of the vehicle wrt the vertical axis

%  s(13) = dwfl  [rad/s] - the differential angular velocity of the front left tire
%  s(14) = dwfr  [rad/s] - the differential angular velocity of the front right tire
%  s(15) = dwrl  [rad/s] - the differential angular velocity of the rear left tire
%  s(16) = dwrr  [rad/s] - the differential angular velocity of the rear right tire

%  s(17) = Vb  [V] - the voltage across the terminals of the HV battery
%  s(18) = As  [A*s] - the charge drained from the HV battery, 0 corresponds to full charge

%  s(19) = Imfl [A] - the current pulled by the front left powertrain
%  s(20) = Imfr [A] - the current pulled by the front right powertrain
%  s(21) = Imrl [A] - the current pulled by the rear left powertrain
%  s(22) = Imrr [A] - the current pulled by the rear right powertrain

%% The function
function ds = compute_ds_master_6DOF(t, s, tauRaw, CCSA, varCAR)
    [Fx_t, Fxv, Fyv, Fz, wt, tau] = traction_model_master_6DOF(s, CCSA, varCAR);
    [ddx, dX, ddy, dY, ddz, ddo, ddn, ddp, dw] = vehicle_dynamics_model_master_6DOF(s, Fx_t, Fxv, Fyv, Fz, tau, varCAR);
    [dVb, dAs, dIm] = powertrain_model_master_6DOF(s, wt, tauRaw, varCAR);
    
    ds = [ddx; dX; ddy; dY; ddz; s(5); ddo; s(7); ddn; s(9); ddp; s(11); dw; dVb; dAs; dIm];
end