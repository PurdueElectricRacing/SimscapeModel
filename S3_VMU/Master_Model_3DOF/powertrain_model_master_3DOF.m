%% Function Description
% This function computes the electrical powertrain derivatives. 
%
% Input: 
% s: state vector [12 1]
% wt: tire angular velocity [2 1]
% tauRaw: torque setpoint [2 1]
% model: vehicle model constants
%
% Output:
% dVb: time derivative of the battery terminal voltage [V/s]
% dAs: time derivative of the battery capacity [A]
% dIm: per motor derivative of current [A/s]
%
% Authors:
% Trevor Koessler
% Demetrius Gulewicz
% Prakhar Drolia
%
% Last Modified: 09/23/25
% Last Author: Prakhar Drolia

%% The Function
function [dVb, dAs, dIm, dOv, tau_ref] = powertrain_model_master_3DOF(s, wt, tauRaw, model, tau)
    % states
    Vb = s(9);
    As = s(10);
    Voc = model.ns*model.vt(As); % open circuit voltage based on battery cell data

    % derating
    over_clip = [max(min(s(13:14), model.Oa),0)];
    derated_torque = interp1(model.Ox,model.Tx,over_clip,"linear");
    tau_der = min(derated_torque,max(tauRaw,0));
    
    % calculate reference powertrain currents
    tau_ref = max(min(tauRaw, model.mt(wt.*model.gr, Vb.*[1;1])), 0);
    tau_ref = min(tau_ref,tau_der);
    Pm = model.pt(wt.*model.gr, tau_ref);
    Im_ref = Pm / Vb;

    % calculate actual currents 
    Im = 2*sum(s(11:12));
    Ib = (Voc-Vb) / model.Rb;

    % derivatives
    dVb = (1/model.cr) * (Ib - Im);
    dAs = Ib/model.np;
    dIm = ((Im_ref - s(11:12)).*model.Rb) ./ model.Lm;

    for idx = 13:14
        if s(idx) < model.Oa && tau(idx-12) > model.tn
            dOv(idx-12) = model.Oc.*((tau(idx-12)-model.tn).^2); 
        elseif s(idx) > 0 && tau(idx-12) <= model.tn
            dOv(idx-12) = -(model.Oc.*((tau(idx-12)-model.tn).^2));
        else dOv(idx-12) = 0;
        end
    end
    dOv = dOv(:);    
end