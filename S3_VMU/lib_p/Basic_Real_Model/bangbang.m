function [tau, data] = bangbang(tauRaw, s, model, data)
    %HIGHLOWSWITCH basic bang-bang traction controller
    %   If slipping is above a threshold, reduce torque
    
    % constants [Adjust These]
    THRESHOLD = 0.15;
    LOW_TORQUE_MULT = 0.5;

    % variables
    dxCOG = s(1);

    % compute slip ratio (sl)
    [~, ~, ~, ~, ~, ~, sl, ~] = traction_model_master_3DOF(s', model);

    % if slipping, half torque
    if sl > THRESHOLD
        tau = tauRaw * LOW_TORQUE_MULT;
    else
        tau = tauRaw;
    end
end

