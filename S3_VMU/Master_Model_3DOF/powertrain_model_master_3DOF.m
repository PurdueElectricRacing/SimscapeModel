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
% Last Modified: 09/06/25
% Last Author: Prakhar Drolia

%% The Function
function [dVb, dAs, dIm, tau_ref] = powertrain_model_master_3DOF(s, wt, tauRaw, model)
    % states
    Vb = s(9);
    As = s(10);
    
    Voc = model.ns*model.vt(As); % open circuit voltage based on battery cell data

    % derating
    over_clip = max(min(over_cal, model.Oa),0);
    if over_cal >= model.Od
        derated_torque = (model.dS*(over_cal-model.Od)) + model.ta;
    else
        derated_torque = model.ta;
    end


    % calculate reference powertrain currents
    tau_ref = max(min(tauRaw, model.mt(wt.*model.gr, Vb.*[1;1])), 0);
    Pm = model.pt(wt.*model.gr, tau_ref);
    Im_ref = Pm / Vb;

    % calculate actual currents 
    Im = 2*sum(s(11:12));
    Ib = (Voc-Vb) / model.Rb;

    % derivatives
    dVb = (1/model.cr) * (Ib - Im);
    dAs = Ib/model.np;
    dIm = ((Im_ref - s(11:12)).*model.Rb) ./ model.Lm;
end