function [tau, data] = bb_dwell(tauRaw, s, model, data)
    %BB_DWELL bang-bang traction control with dwell time
    %   If slipping is above a threshold, reduce torque
    
    % constants
    DWELL_TIME = 0.1; % [s]
    THRESHOLD = 0.15;
    LOW_TORQUE_MULT = 0.5;

    % variables
    dxCOG = s(1);
    t = data.currentTime;
    lastSwitchTime = data.lastSwitchTime;
    state = data.state;

    % compute slip ratio (sl)
    [~, ~, ~, w, ~, ~, ~, ~] = traction_model_master(s', data.currentTau', model);
    sl = (w(2) * model.r0 / dxCOG) - 1;

    % check if able to switch
    if t - lastSwitchTime >= DWELL_TIME

        if sl > THRESHOLD && state == "high" % high torque slipping
           tau = tauRaw * LOW_TORQUE_MULT;
           data.state = "low";
           data.lastSwitchTime = t;
        elseif sl < THRESHOLD && state == "low" % low torque no slip
            tau = tauRaw;
            data.state = "high";
            data.lastSwitchTime = t;
        elseif sl > THRESHOLD && state == "low" % low torque slipping
            tau = data.currentTau;
        elseif sl < THRESHOLD && state == "high" % high torque no slip
            tau = data.currentTau;
        end
    else
        tau = data.currentTau;
    end
end