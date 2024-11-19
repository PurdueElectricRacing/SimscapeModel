%% Function Description
% This function computes the electrical powertrain derivatives. 
%
% Input: 
% s: state vector [23 1]
% wt: tire angular velocity [4 1]
% tauRaw: torque setpoint [4 1]
% model: vehicle model constants
%
% Output:
% dVoc: time derivative of battery open circuit voltage
% dVb: time derivative of the battery terminal voltage
% dAh: time derivative of the battery capacity
% dIm: per motor time derivative of current
%
% Authors:
% Trevor Koessler
% Demetrius Gulewicz
%
% Last Modified: 11/16/24
% Last Author: Demetrius Gulewicz

%% To do:
% figure out how to decouple powertrain and vehicle dynamics

%% The Function
function [dVoc, dVb, dAh, dIm] = powertrain_model_master_6DOF(s, wt, tauRaw, model)
    % states
    Voc = s(17);
    Vb  = s(18);
    Ah  = s(19);

    % calculate reference powertrain currents
    tau = max(min(tauRaw, model.mt(wt.*model.gr, Vb.*[1;1;1;1])), 0);
    Pm = model.pt(wt.*model.gr, tau);
    Im_ref = Pm ./ Vb;

    % calculate actual currents
    Im = sum(s(20:23));
    Ib = (Voc-Vb) / model.Rb;

    % derivatives
    dVb = (1/model.cr) * (Ib - Im);
    dVoc = ((differentiate(model.vt, Ah) * model.ns) / model.np) * (Ib / 3600);
    dAh = Ib / 3600;
    dIm = ((Im_ref - s(20:23)).*model.Rb) ./ model.Lm;
end