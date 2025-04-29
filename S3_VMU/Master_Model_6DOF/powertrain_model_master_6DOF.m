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
function [dVb, dAs, dIm, tau_ref] = powertrain_model_master_6DOF(s, wt, tauRaw, model)
    % states
    Vb  = s(17);
    As  = s(18);
    Voc = model.ns*model.vt(As);

    % calculate reference powertrain currents
    tau_ref = max(min(tauRaw, model.mt(wt.*model.gr, Vb.*[1;1;1;1])), 0);
    Pm = model.pt(wt.*model.gr, tau_ref);
    % Im_ref = sign(tau_ref).*abs(Pm ./ Vb);
    Im_ref = Pm ./ Vb;

    % calculate actual currents
    Im = sum(s(19:22));
    Ib = (Voc-Vb) / model.Rb;

    % derivatives
    dVb = (1/model.cr) * (Ib - Im);
    dAs = Ib/model.np;
    dIm = ((Im_ref - s(19:22)).*model.Rb) ./ model.Lm;
end