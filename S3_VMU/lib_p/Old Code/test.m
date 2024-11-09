%% Parameters
Vb = 600;
dxCOG = 10;
tauRaw = [25;25];
FzFR = [1000;1000];
wCOG = [0;0];
model = varModel_master;

%% get solution
t0 = tic;
S = [0;0];
if abs(wCOG(1)) >= 0.1
    S(1) = (wCOG(1)*model.r0 + model.Sm*dxCOG) / dxCOG;
else
    [FxFR_t, FxFR_s] = get_val_3DOF(model.Sm, FzFR(1), tauRaw(1), Vb, dxCOG, model);
    if FxFR_s <= FxFR_t
        S(1) = model.Sm;
    else
        S(1) = get_S_bisect(0, FxFR_s, FxFR_t, 0, model.Sm, FzFR(1), tauRaw(1), Vb, dxCOG, model);
    end
end
t1 = toc(t0);

function S = get_S_bisect(Fx_l, Fx_h, FxFR_t, S_l, S_h, FzFR, tauRaw, Vb, dxCOG, model)
    [FxFR_t, FxFR_s, S] = get_bis_3DOF(Fx_l, Fx_h, FxFR_t, S_l, S_h, FzFR, tauRaw, Vb, dxCOG, model);
    dF = FxFR_t - FxFR_s;

    while abs(dF) > 1
        if dF > 0
            Fx_l = FxFR_s;
            S_l = S;
        else
            Fx_h = FxFR_s;
            S_h = S;
        end
        [FxFR_t, FxFR_s, S] = get_bis_3DOF(Fx_l, Fx_h, FxFR_t, S_l, S_h, FzFR, tauRaw, Vb, dxCOG, model);
        dF = FxFR_t - FxFR_s;
        disp(1)
    end

    [FxFR_t, FxFR_s, S, tau, wt] = get_bis_3DOF(Fx_l, Fx_h, FxFR_t, S_l, S_h, FzFR, tauRaw, Vb, dxCOG, model);
end

function [FxFR_t, FxFR_s, tau, wt] = get_val_3DOF(S, FzFR, tauRaw, Vb, dxCOG, model)
    % tire wheel speed [rad/s]
    wt = (S + 1).*(dxCOG ./ model.r0);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = min(tauRaw, model.mt(wt.*model.gr, Vb)) - model.rr.*FzFR.*tanh(model.ai.*wt) - model.gm.*wt;

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
    tau = min(tauRaw, model.mt(wt.*model.gr, Vb)) - model.rr.*FzFR.*tanh(model.ai.*wt) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    FxFR_t = (tau*model.gr/model.r0);

    % applied tractive force [N]
    FxFR_s = FzFR.*model.Dx.*sin(model.Cx.*atan(model.Bx.*S - model.Ex.*(model.Bx.*S - atan(model.Bx.*S))));
end