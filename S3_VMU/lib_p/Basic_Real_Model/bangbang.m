function [tau, data] = bangbang(tauRaw, s, model, data)
    %HIGHLOWSWITCH basic bang-bang traction controller
    %   If slipping is above a threshold, reduce torque
    
    % constants [Adjust These]
    threshold = 0.15;
    lowTorqueMultiplier = 0.5;

    % state variables
    dxCOG = s(1);

    % compute slip ratio (sl)
    [~, ~, ~, w, ~, ~, ~, ~] = traction_model_master(s', data.currentTau', model);
    sl = (w(2) * model.r0 / dxCOG) - 1;

    % if slipping, half torque
    if sl > threshold
        tau = tauRaw * lowTorqueMultiplier;
    else
        tau = tauRaw;
    end
end

