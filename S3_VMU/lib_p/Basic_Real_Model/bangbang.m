function [tau, data] = bangbang(tauRaw, s, model, data, options)
    % basic bang-bang traction controller
    % If slipping is above a threshold, reduce torque
    
    %onstants [Adjust These]
    threshold = options.SLthresh;
    low_torque_mult = options.lowTorqueMult;

    % compute slip ratio (sl)
    [~, ~, ~, ~, ~, ~, sl, ~] = traction_model_master_3DOF(s', model);

    % if slipping, half torque
    tau = [0;0];
    if sl(1) > threshold
        tau(1) = tauRaw(1) * low_torque_mult;
    else
        tau(1) = tauRaw(1);
    end

    if sl(2) > threshold
        tau(2) = tauRaw(2) * low_torque_mult;
    else
        tau(2) = tauRaw(2);
    end
end

