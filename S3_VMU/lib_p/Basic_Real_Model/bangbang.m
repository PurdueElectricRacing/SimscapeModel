function [tau, data] = bangbang(tauRaw, s, model, data)
    %HIGHLOWSWITCH basic bang-bang traction controller
    %   If slipping is above a threshold, reduce torque
    
    % constants [Adjust These]
    THRESHOLD = 0.15;
    LOW_TORQUE_MULT = 0.5;

    % compute slip ratio (sl)
    [~, ~, ~, ~, ~, ~, sl, ~] = traction_model_master_3DOF(s', model);

    % if slipping, half torque
    tau = [0;0];
    if sl(1) > THRESHOLD
        tau(1) = tauRaw(1) * LOW_TORQUE_MULT;
    else
        tau(1) = tauRaw(1);
    end

    if sl(2) > THRESHOLD
        tau(2) = tauRaw(2) * LOW_TORQUE_MULT;
    else
        tau(2) = tauRaw(2);
    end
end

