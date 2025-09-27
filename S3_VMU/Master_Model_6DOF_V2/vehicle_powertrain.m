%% This function computes the electrical powertrain derivatives.

% Inputs:
% s: The state vector
% tauRaw: The torque setpoint for each motor [Nm]
%         Positive is positive Fx s positive acceleration
% model:  Vehicle parameter structure

% Outputs:
% dVb: Derivative of the voltage across the terminals of the HV battery [V/s]
% dAs: Derivative of the charge drained from the HV battery, 0 corresponds to full charge [A]
% dIm: Derivative of the current pulled by each motor [FL FR RL RR] [A/s]

function [dVb, dAs, dIm] = vehicle_powertrain(s, tauRaw, model)
    % states
    w = s(19:22);
    Vb  = s(13);
    As  = s(14);
    Im = s(15:18);

    % open circuit voltage [V]
    Voc = model.ns*model.vt(As);

    % calculate reference powertrain currents
    tau_ref = max(min(min(tauRaw, model.T_ABS_MAX), model.mt(w.*model.gr, Vb.*[1;1;1;1])), 0);
    Pm = model.pt(w.*model.gr, tau_ref);
    Im_ref = Pm ./ Vb;

    % calculate actual currents
    sum_Im = sum(Im);
    Ib = (Voc-Vb) / model.Rb;

    % derivatives
    dVb = (1/model.cr) * (Ib - sum_Im);
    dAs = Ib/model.np;
    dIm = ((Im_ref - Im).*model.Rb) ./ model.Lm;
end