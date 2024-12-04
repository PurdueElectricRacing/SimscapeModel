function [tau, data] = PI(tauRaw, s, model, data, options)
    %PI Summary of this function goes here
    %   Detailed explanation goes here
    
    % constants
    K_P = options.Kp;
    K_I = options.Ki;
    sl_target = options.SLtarget;
    time_step = options.tStep;

    % variables
    dxCOG = s(1);
    integral = data.errorInt;

    % compute slip ratio (sl)
    [~, ~, ~, w, ~, ~, ~, ~] = traction_model_master(s', data.currentTau', model);
    sl = (w(2) * model.r0 / dxCOG) - 1;

    % error
    error = sl_target - sl;
    integral = integral + error * time_step;

    tau = [0; K_P*error + K_I*integral];
    tau = min(max(0,tau),tauRaw);
    data.errorInt = integral;
end