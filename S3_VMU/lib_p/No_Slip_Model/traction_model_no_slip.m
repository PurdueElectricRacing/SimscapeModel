% This is a copy over powertrain_model, but further restricts torque to
% avoid slipping

function [FxFR, zFR, dzFR, w, tau, FzFR, Sl, FxFR_max] = traction_model_no_slip(s, tauRaw, model)
    % States
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

    % restrict torque to max_Fx*r/gr
    tau = min(tau, FxFR_max*model.r0 / model.gr);

    % applied tractive force [N]
    FxFR = (tau.*model.gr./model.r0);

    % slip ratio
    Sl = model.St(FxFR, FzFR);

    % wheel speed [rad/s]
    w = (Sl + 1).*(dxCOG ./ model.r0);
end