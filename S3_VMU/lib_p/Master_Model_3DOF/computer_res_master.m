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

function [res] = computer_res_master(s, tauRaw, varCAR, ref_val)
    [Fx, Fz, wt, tau] = traction_model_master_3DOF(s, varCAR);
    [ddx, ddz, ddo, dw] = vehicle_dynamics_model_master_3DOF(s, Fx, Fz, wt, tau, varCAR);
    [dVoc, dVb, dAs, dIm] = powertrain_model_master_3DOF(s, wt, tauRaw, varCAR);

    ds = [ddx;s(1);ddz;s(3);ddo;s(5);dw(1);dw(2);0;dVb;s(11);dIm(1);dIm(2)];
    [res] = ds - ref_val;
end


