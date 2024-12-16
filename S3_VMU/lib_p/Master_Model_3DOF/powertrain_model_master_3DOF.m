%% Function Description
% This function computes the electrical powertrain stuff. 
%
% Input: 
% s: state vector [13 1]
% wt: tire angular velocity [2 1]
% tauRaw: torque setpoint [2 1]
% model: vehicle model constants
%
% Output:
% dVoc: time derivative of battery open circuit voltage [V/s]
% dVb: time derivative of the battery terminal voltage [V/s]
% dAs: time derivative of the battery capacity [A]
% dIm: per motor derivative of current [A/s]
%
% Authors:
% Trevor Koessler
% Demetrius Gulewicz
%
% Last Modified: 11/17/24
% Last Author: Demetrius Gulewicz

%% To do:
% figure out how to decouple powertrain and vehicle dynamics

%% The Function
function [dVoc, dVb, dAs, dIm] = powertrain_model_master_3DOF(s, wt, tauRaw, model)
    % states
    Voc = s(9);
    Vb = s(10);
    As = s(11);

    % calculate reference powertrain currents
    tau = max(min(tauRaw, model.mt(wt.*model.gr, Vb.*[1;1])), 0);
    Pm = model.pt(wt.*model.gr, tau);
    Im_ref = Pm / Vb;

    % calculate actual currents
    Im = 2*sum(s(12:13));
    Ib = (Voc-Vb) / model.Rb;

    % derivatives
    dVb = (1/model.cr) * (Ib - Im);
    dVoc = ((differentiate(model.vt, As) * model.ns) / model.np) * Ib;
    dAs = Ib/model.np;
    dIm = ((Im_ref - s(12:13)).*model.Rb) ./ model.Lm;
end