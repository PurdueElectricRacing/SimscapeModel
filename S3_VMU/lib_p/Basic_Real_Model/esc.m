function [tau, data] = esc(tauRaw, s, model, data, options)
    % extremum seeking controller
    
    % constants from options
    SLstar = options.SLstar;
    tStep = options.tStep;
    a = options.x(1);
    b = options.x(2);
    k = options.x(3);
    w = options.x(4);
    pl = options.x(5);
    ph = options.x(6);

    % function to map from slip ratio to maximumm tractive force
    J = @(SL, SLstar) ((SLstar*SL) / (SLstar^2 + SL^2));

    % load data
    SL_kminus1 = data.SL_kminus1;

    % compute current slip ratio
    [~, ~, ~, ~, ~, ~, SL_k, ~] = traction_model_master_3DOF(s', model);
    
    % compute u_dot
    u_dot = (J(SL_k) - J(SL_kminus1)) / tStep;

    % save current slip ratio to use in next step
    data.SL_kminus1 = SL_k;

end