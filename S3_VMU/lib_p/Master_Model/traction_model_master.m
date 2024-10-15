function [FxFR, zFR, dzFR, w, tau, FzFR, Sl, FxFR_max] = traction_model_master(s, tauRaw, model)
    % states
    dxCOG = s(1);
    dzCOG = s(3);
    zCOG = s(4);
    do = s(5);
    o = s(6);
    wCOG = s(7:8);
    Vb = s(10);

    % approximate vehicle wheel speed [rad/s]
    % This is a numerical method that converges to the correct answer as dt
    % -> 0 (not true, but want it to be true)
    wm = model.gr*((dxCOG/model.r0) + wCOG);

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

    % peak tractive force [Unitless]
    FxFR_max = model.Ft(model.Sm*[1;1], FzFR);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = min(tauRaw, model.mt(wm, Vb*[1;1])) - model.rr.*FzFR.*tanh(model.ai.*wm) - model.gm.*wm;

    % possible applied tractive force [N]
    FxFR = (tau.*model.gr./model.r0);

    Sl = [0;0];
    if (FxFR(1) <= FxFR_max(1)) && (abs(wCOG(1)) < 0.01)
       Sl(1) = model.St(FxFR(1), FzFR(1));
    else
       Sl(1) = model.Sm + abs(wCOG(1))*model.r0/dxCOG;
       FxFR(1) = sign(wCOG(1))*model.Ft(min(Sl(1),1), FzFR(1));
    end

    if (FxFR(2) <= FxFR_max(2)) && (abs(wCOG(2)) < 0.01)
       Sl(2) = model.St(FxFR(2), FzFR(2));
    else
       Sl(2) = model.Sm + abs(wCOG(2))*model.r0/dxCOG;
       FxFR(2) = sign(wCOG(2))*model.Ft(min(Sl(2),1), FzFR(2));
    end

    % closer to correct wheel speed [rad/s]
    w = (Sl + 1).*(dxCOG ./ model.r0);
end