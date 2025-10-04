    %% This function computes the electrical powertrain derivatives.

% Inputs:
% s: The state vector
% tauRaw: The torque setpoint for each motor [Nm]
%         Positive is positive Fx s positive acceleration
% model:  Vehicle parameter structure

% Outputs:
% dVb: Derivative of the voltage across the terminals of the HV battery [V/s]
% dAs: Derivative of the charge drained from the HV battery, 0 corresponds to full charge [A]
% dT:  Derivative of the current pulled by each motor [FL FR RL RR] [A/s]
% dOv: Derivative of the overload for each motor [FL FR RL RR]

function [dVb, dAs, dT, dOv, Im_ref, Im] = vehicle_powertrain(s, tauRaw, w, model)
    % interp functions for simulink :(
    mt = @(x1,x2) (interp2(model.mt_in1, model.mt_in2, model.mt_out', x1, x2));
    pt = @(x1,x2) (interp2(model.pt_in1, model.pt_in2, model.pt_out', x1, x2));
    vt = @(x1) (interp1(model.vt_in, model.vt_out, x1));

    % states
    Vb  = s(7);
    As  = s(8);
    w = min(max(w, model.w_min), model.w_max);
    tau = min(max(s(9:10), model.T_min), model.T_max);
    tau = [tau(1); tau(1); tau(2); tau(2)];

    tauRaw = [tauRaw(1); tauRaw(1); tauRaw(2); tauRaw(2)];

    Ov = max(min(s(11:12), model.Oa),0);
    Ov = [Ov(1); Ov(1); Ov(2); Ov(2)];

    % derating
    derated_torque = interp1(model.Ox,model.Tx,Ov,"linear");
    tau_der = min(derated_torque,max(tauRaw,0));

    % open circuit voltage [V]
    Voc = model.ns*vt(max(As,0));

    % calculate reference powertrain currents
    tau_ref = max(min(min(tauRaw, model.T_ABS_MAX), mt(w.*model.gr, Vb.*[1;1;1;1])), 0);
    tau_ref = min(tau_ref,tau_der);
    Im_ref = pt(w.*model.gr, tau_ref) ./ Vb;
    Im = pt(w.*model.gr, tau) ./ Vb;

    % calculate actual currents
    sum_Im = sum(Im);
    Ib = (Voc-Vb) / model.Rb;

    % derivatives
    dVb = (1/model.cr) * (Ib - sum_Im);
    dAs = Ib/model.np;
    dT = (tau_ref - tau).*model.torque_const;

    for idx = 11:12
        if idx == 11
            tidx = 1;
        elseif idx == 12
            tidx = 3;
        end
        if s(idx) < model.Oa && tau(tidx) > model.tn
            dOv(idx-10) = (model.Oc.*(((tau(tidx)).^2)-((model.tn).^2))); 
        elseif s(idx) > 0 && tau(tidx) < model.tn
            dOv(idx-10) = model.Oc.*(((tau(tidx)).^2)-((model.tn).^2));
        else 
            dOv(idx-10) = 0;
        end
    end
    dOv = dOv(:);
end