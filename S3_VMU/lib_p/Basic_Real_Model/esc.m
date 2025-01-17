function [tau, data] = esc(tauRaw, s, model, data, options)
    % extremum seeking controller
    
    %% Setup
    % constants from options
    SLstar = options.SLstar;
    dt = options.tStep;
    a = options.a;
    b = options.b;
    k = options.k;
    w = options.w;
    pl = options.pl;
    ph = options.ph;

    % load data
    SL_kminus1 = data.SL_kminus1;
    t0 = data.currentTime;
    W1 = data.W1;
    W2 = data.W2;


    % cost function of slip ratio (ESC to maximize this)
    J = @(SL, SLstar) ((SLstar*SL) / (SLstar^2 + SL^2) * 2);
    
    % ESC simulation function (generated symbolically in esc_simulation.m)
    func = @(a,dt,du,k,ph,pl,t0,w,w1,w2,y0_hat)[w1.*exp(-dt.*pl)+a.*k.*y0_hat.*((w.*cos(t0.*w)+ph.*sin(t0.*w)+pl.*sin(t0.*w))./(ph.*pl.*2.0+ph.^2+pl.^2+w.^2)-(exp(-dt.*ph-dt.*pl).*(w.*cos(w.*(dt+t0))+ph.*sin(w.*(dt+t0))+pl.*sin(w.*(dt+t0))))./(ph.*pl.*2.0+ph.^2+pl.^2+w.^2))+(a.*du.*k.*((w.*cos(t0.*w)+pl.*sin(t0.*w))./(pl.^2+w.^2)-(exp(-dt.*pl).*(w.*cos(w.*(dt+t0))+pl.*sin(w.*(dt+t0))))./(pl.^2+w.^2)))./ph-(a.*du.*k.*((w.*cos(t0.*w)+ph.*sin(t0.*w)+pl.*sin(t0.*w))./(ph.*pl.*2.0+ph.^2+pl.^2+w.^2)-(exp(-dt.*ph-dt.*pl).*(w.*cos(w.*(dt+t0))+ph.*sin(w.*(dt+t0))+pl.*sin(w.*(dt+t0))))./(ph.*pl.*2.0+ph.^2+pl.^2+w.^2)))./ph;w2-(w1.*(exp(-dt.*pl)-1.0))./pl+(a.*k.*y0_hat.*((w.*cos(t0.*w)+ph.*sin(t0.*w))./(ph.^2+w.^2)-(exp(-dt.*ph).*(w.*cos(w.*(dt+t0))+ph.*sin(w.*(dt+t0))))./(ph.^2+w.^2)))./pl-(a.*k.*y0_hat.*((w.*cos(t0.*w)+ph.*sin(t0.*w)+pl.*sin(t0.*w))./(ph.*pl.*2.0+ph.^2+pl.^2+w.^2)-(exp(-dt.*ph-dt.*pl).*(w.*cos(w.*(dt+t0))+ph.*sin(w.*(dt+t0))+pl.*sin(w.*(dt+t0))))./(ph.*pl.*2.0+ph.^2+pl.^2+w.^2)))./pl-(a.*du.*k.*((w.*cos(t0.*w)+ph.*sin(t0.*w))./(ph.^2+w.^2)-(exp(-dt.*ph).*(w.*cos(w.*(dt+t0))+ph.*sin(w.*(dt+t0))))./(ph.^2+w.^2)))./(ph.*pl)-(a.*du.*k.*((w.*cos(t0.*w)+pl.*sin(t0.*w))./(pl.^2+w.^2)-(exp(-dt.*pl).*(w.*cos(w.*(dt+t0))+pl.*sin(w.*(dt+t0))))./(pl.^2+w.^2)))./(ph.*pl)+(a.*du.*k.*((w.*cos(t0.*w)+ph.*sin(t0.*w)+pl.*sin(t0.*w))./(ph.*pl.*2.0+ph.^2+pl.^2+w.^2)-(exp(-dt.*ph-dt.*pl).*(w.*cos(w.*(dt+t0))+ph.*sin(w.*(dt+t0))+pl.*sin(w.*(dt+t0))))./(ph.*pl.*2.0+ph.^2+pl.^2+w.^2)))./(ph.*pl)-(a.*du.*k.*(cos(w.*(dt+t0))-cos(t0.*w)))./(ph.*pl.*w)];

    %% Precomputation
    % compute current slip ratio
    [~, ~, ~, ~, ~, ~, SL_k, ~] = traction_model_master_3DOF(s', model);
    SL_k = SL_k(2);
    
    % compute u_dot
    du = (J(SL_k, SLstar) - J(SL_kminus1, SLstar)) / dt;

    % next step
    Wt = func(a, dt, du, k, ph, pl, t0, w, W1, W2, J(SL_k, SLstar));
    theta = Wt(2) + b*sin(w*t0); % modulate
    data.W1 = Wt(1);
    data.W2 = Wt(2);

    % convert theta to tau
    tau = [0; theta];


    %% Save data for next step
    data.SL_kminus1 = SL_k;

        

end
