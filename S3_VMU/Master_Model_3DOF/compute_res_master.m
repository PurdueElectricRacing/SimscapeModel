%Function to compute the resultant from the derivate states and the ref
%values
%Author: Prakhar Drolia

%res = ddx - 0;
%res2 = dx - 0;
%res3 = ddz - 0;
%res4 = dz - 0;
%res5 = ddo - 0;
%res6 = do - 0;
%res7 = dwf - 0;
%res8 = dwr - 0;
%res9 = dVb - 0;
%res11 = dImf - 0;
%res12 = dImr - 0;

%  s(1)  = dx  [m/s] - the chassis center of gravity forward velocity
%  s(2)  = x   [m] - the longitudinal distance traveled by the chassis center of gravity
%  s(3)  = dz  [m/s] - the chassis center of gravity vertical velocity
%  s(4)  = z   [m] - the vertical distance between the ground plane and the chassis center of gravity
%  s(5)  = do  [rad/s] - the derivative of the orientation of the vehicle wrt the horizontal axis
%  s(6)  = o   [rad] - the  orientation of the vehicle wrt the horizontal axis
%  s(7)  = wf  [rad/s] - the differential angular velocity of the front tires
%  s(8)  = wr  [rad/s] - the differential angular velocity of the rear tires
%  s(9) = Vb  [V] - the voltage across the terminals of the HV battery
%  s(10) = As  [A*s] - the charge drained from the HV battery, 0 corresponds to full charge
%  s(11) = Imf [A] - the current pulled by the front powertrain
%  s(12) = Imr [A] - the current pulled by the rear powertrain

function res = compute_res_master(s, tauRaw, varCAR, ref_val)
    [Fx, Fz, wt, tau] = traction_model_master_3DOF(s, varCAR);
    [ddx, ddz, ddo, dw] = vehicle_dynamics_model_master_3DOF(s, Fx, Fz, wt, tau, varCAR);
    [dVb, dAs, dIm] = powertrain_model_master_3DOF(s, wt, tauRaw, varCAR);

    ds = [ddx;s(2);ddz;s(3);ddo;s(5);dw(1);dw(2);dVb;dIm(1);dIm(2);s(10)];
    res = ds - ref_val;
end


