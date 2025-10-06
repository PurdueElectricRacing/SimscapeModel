%% This function computes the electrical powertrain derivatives.

% Inputs:
% s: The state vector
% tauRaw: The torque setpoint for each motor [Nm]
%         Positive is positive Fx s positive acceleration
% model:  Vehicle parameter structure

% Outputs:
% dVb: Derivative of the voltage across the terminals of the HV battery [V/s]
% dAs: Derivative of the charge drained from the HV battery, 0 corresponds to full charge [A]
% dT: Derivative of the current pulled by each motor [FL FR RL RR] [A/s]

function [dVb, dAs, dT, Im_ref, Im] = vehicle_powertrain(s, tauRaw, w, model)

    % states
    w = min(max(w, model.w_min), model.w_max);
    Vb  = s(13);
    As  = s(14);
    tau = min(max(s(15:18), model.T_min), model.T_max);

    % open circuit voltage [V]
    Voc = model.ns*(interp1(model.vt_in, model.vt_out, max(As,0)));

    % calculate reference powertrain currents
 
    tau_ref = max(min(min(tauRaw, model.T_ABS_MAX), (interp2(model.mt_in1, model.mt_in2, model.mt_out', w.*model.gr, Vb.*[1;1;1;1])) ), 0);
    Im_ref = (interp2(model.pt_in1, model.pt_in2, model.pt_out', w.*model.gr, tau_ref)) ./ Vb;
    Im = (interp2(model.pt_in1, model.pt_in2, model.pt_out', w.*model.gr, tau)) ./ Vb;

    % calculate actual currents
    sum_Im = sum(Im);
    Ib = (Voc-Vb) / model.Rb;

    % derivatives
    dVb = (1/model.cr) * (Ib - sum_Im);
    dAs = Ib/model.np;
    dT = (tau_ref - tau).*model.torque_const;

    if sum(isnan(dT)) || sum(isinf(dT)) || sum(isnan(dVb)) || sum(isinf(dVb)) || sum(isnan(dAs)) || sum(isinf(dAs))
        s = 0;
    end
end