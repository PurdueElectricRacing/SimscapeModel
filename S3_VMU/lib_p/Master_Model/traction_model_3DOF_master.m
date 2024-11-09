%% Things to do:
% 3. make presentation slides
% 5. document this function
% 6. integrate this same function type into longitudinal model
% 8. update peak Slip ratio in accordance with new tire model?
% 9. round everything to 3 decimal places to make sure that dw is 0 when
% peak force is achieved.
% 10. figure out why slipping is so bad
% 11. determine if smoothening torque is better
% 12. determine if torque map at high end is bad (too steep)
% 13. figure out why suspension is so sus
% 14. figure out why sensitivity to J
% 15. figure out what to do about non monotonic regions for interval
% bisection
% 16. final solution is smooth fsolve, but bisection gives close result
% 17. instead of providing actual slip ratio, provide derivative to relax
% the problem
% 18. remove slip ratio discontinuity by have differentiable slip ratio

function [FxFR, zFR, dzFR, wt, tau, FzFR, S, FxFR_max] = traction_model_3DOF_master(s, tauRaw, model)
    % states
    dxCOG = s(1);
    dzCOG = s(3);
    zCOG = s(4);
    do = s(5);
    o = s(6);
    wCOG = s(7:8);
    Vb = s(10);

    % suspension compression [m]
    zF = zCOG + model.wb(1)*sin(o);
    zR = zCOG - model.wb(2)*sin(o);
    zFR = [zF; zR];

    % suspension compression velocity [m/s]
    dzF = dzCOG + model.wb(1)*cos(o)*do;
    dzR = dzCOG - model.wb(2)*cos(o)*do;
    dzFR = [dzF; dzR];

    % tire normal force [N]
    FzFR = -(model.k.*(zFR - model.z0) + (model.c.*dzFR));

    % compute slip ratio
    S = [0;0];
    if abs(wCOG(1)) >= 0.1
        S(1) = (wCOG(1)*model.r0 + model.Sm*dxCOG) / dxCOG;
    else
        [FxFR_t, FxFR_s] = get_Fx_3DOF(model.Sm, FzFR(1), tauRaw(1), Vb, dxCOG, model);
        if abs(FxFR_s) <= abs(FxFR_t)
            S(1) = model.Sm;
        else
            S(1) = get_S_bisect(-FxFR_s, FxFR_s, FxFR_t, -model.Sm, model.Sm, FzFR(1), tauRaw(1), Vb, dxCOG, model);
            S(1) = fsolve(@get_res_3DOF, S(1), model.opts, FzFR(1), tauRaw(1), Vb, dxCOG, model);
        end
    end

    if abs(wCOG(2)) >= 0.1
        S(2) = (wCOG(2)*model.r0 + model.Sm*dxCOG) / dxCOG;
    else
        [FxFR_t, FxFR_s] = get_Fx_3DOF(model.Sm, FzFR(2), tauRaw(2), Vb, dxCOG, model);
        if FxFR_s <= FxFR_t
            S(2) = model.Sm;
        else
            S(2) = get_S_bisect(-FxFR_s, FxFR_s, FxFR_t, -model.Sm, model.Sm, FzFR(2), tauRaw(2), Vb, dxCOG, model);
            S(2) = fsolve(@get_res_3DOF, S(2), model.opts, FzFR(2), tauRaw(2), Vb, dxCOG, model);
        end
    end

    % get torque and tractive force
    [tau, FxFR, FxFR_max, wt] = get_val_3DOF(S, FzFR, tauRaw, Vb, dxCOG, model);
end

function S = get_S_bisect(Fx_l, Fx_h, FxFR_t, S_l, S_h, FzFR, tauRaw, Vb, dxCOG, model)
    [FxFR_t, FxFR_s, S] = get_bis_3DOF(Fx_l, Fx_h, FxFR_t, S_l, S_h, FzFR, tauRaw, Vb, dxCOG, model);
    % dF = (FxFR_t - FxFR_s);

    % for i = 1:1
    %     if dF > 0
    %         S_l = S;
    %         Fx_l = FxFR_s;
    %     else
    %         S_h = S;
    %         Fx_h = FxFR_s;
    %     end
    %     [FxFR_t, FxFR_s, S] = get_bis_3DOF(Fx_l, Fx_h, FxFR_t, S_l, S_h, FzFR, tauRaw, Vb, dxCOG, model);
    %     dF = FxFR_t - FxFR_s;
    % end
    % 
    % [FxFR_t, FxFR_s, S, tau, wt] = get_bis_3DOF(Fx_l, Fx_h, FxFR_t, S_l, S_h, FzFR, tauRaw, Vb, dxCOG, model);
end

function [FxFR_t, FxFR_s, tau, wt] = get_Fx_3DOF(S, FzFR, tauRaw, Vb, dxCOG, model)
    % tire wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = min(tauRaw, model.mt(wt.*model.gr, Vb)) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    FxFR_t = (tau*model.gr/model.r0);

    % applied tractive force [N]
    FxFR_s = FzFR.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));
end

function [FxFR_t, FxFR_s, S, tau, wt] = get_bis_3DOF(Fx_l, Fx_h, Fx_t, S_l, S_h, FzFR, tauRaw, Vb, dxCOG, model)
    % guess the slip ratio
    m = (Fx_h - Fx_l) / (S_h - S_l);
    b = Fx_l - m*S_l;
    S = (Fx_t - b) / m;

    % tire wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = min(tauRaw, model.mt(wt.*model.gr, Vb)) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    FxFR_t = (tau*model.gr/model.r0);

    % applied tractive force [N]
    FxFR_s = FzFR.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));
end

function res = get_res_3DOF(S, FzFR, tauRaw, Vb, dxCOG, model)
    % tire wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = min(tauRaw, model.mt(wt.*model.gr, Vb)) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    FxFR_t = (tau*model.gr/model.r0);

    % applied tractive force [N]
    FxFR_s = FzFR.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));

    % compute residual
    res = FxFR_t - FxFR_s;
end

function [tau, FxFR, FxFR_max, wt] = get_val_3DOF(S, FzFR, tauRaw, Vb, dxCOG, model)
    % tire wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = min(tauRaw, model.mt(wt.*model.gr, Vb*[1;1])) - model.gm.*wt;

    % applied tractive force [N]
    FxFR = FzFR.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));

    % maximum tractive force [N]
    FxFR_max = FzFR.*model.Dx.*sin(model.Cx.*atan(model.Bx.*model.Sm - model.Ex.*(model.Bx.*model.Sm - atan(model.Bx.*model.Sm))));
end