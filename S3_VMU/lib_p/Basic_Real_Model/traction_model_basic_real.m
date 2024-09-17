% This is a copy over powertrain_model, but further restricts torque to
% avoid slipping

function [FxFR, zFR, dzFR, w, tau, FzFR, Sl, Fx_max] = traction_model_basic_real(s, tauRaw, model)
    % States
    dxCOG = s(1);
    dzCOG = s(3);
    zCOG = s(4);
    do = s(5);
    o = s(6);
    wCOG = s(7:8);
    Vb = s(10);

    % possible tractive force, constrained by the motor [N]
    wm = model.gr*((dxCOG/model.r0) + wCOG(2)); % this is not quite right
    tauMax = model.mt(wm, Vb);
    tau = min(tauRaw, tauMax).*model.ge;
    FxFR = tau.*model.gr./model.r0;

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

    % Wheel Slip [Unitless]
    Fx_max = model.Ft(model.Sm*[1;1], FzFR);

    % restrict torque to max_Fx*r/gr
    tau = min(tau, Fx_max*model.r0 / model.gr);

    Sl = [0;0];
    if (FxFR(1) <= Fx_max(1)) && (abs(wCOG(1)) < 0.01)
       Sl(1) = model.St(FxFR(1), FzFR(1));
    else
       Sl(1) = model.Sm + abs(wCOG(1))*model.r0/dxCOG;
       FxFR(1) = sign(wCOG(1))*model.Ft(min(Sl(1),1), FzFR(1));
    end

    if (FxFR(2) <= Fx_max(2)) && (abs(wCOG(2)) < 0.01)
       Sl(2) = model.St(FxFR(2), FzFR(2));
    else
       Sl(2) = model.Sm + abs(wCOG(2))*model.r0/dxCOG;
       FxFR(2) = sign(wCOG(2))*model.Ft(min(Sl(2),1), FzFR(2));
    end

    % wheel speed [rad/s]
    w = (Sl + 1).*(dxCOG ./ model.r0);
end