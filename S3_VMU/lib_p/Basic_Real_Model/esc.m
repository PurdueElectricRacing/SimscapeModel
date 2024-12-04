function [tau, data] = esc(tauRaw, s, model, data, options)
    % extremum seeking controller
    
    % constants from options
    SLstar = options.SLstar;

    % function to map from slip ratio to maximumm tractive force
    J = @(SL, SLstar) ((SLstar*SL) / (SLstar^2 + SL^2));

    % load data
    SL_kminus1 = data.SL_kminus1;

    % compute current slip ratio
    [~, ~, ~, ~, ~, ~, SL_k, ~] = traction_model_master_3DOF(s', model);

end