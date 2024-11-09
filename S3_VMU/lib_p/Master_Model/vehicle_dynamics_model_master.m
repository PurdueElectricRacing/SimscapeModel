function [ddx, ddz, ddo, dw] = vehicle_dynamics_model_master(s, tau, FxFR, zFR, dzFR, FzFR, model)
    % states
    dxCOG = s(1);
    o = s(6);
    wt = s(7:8);

    % aerodynamic Drag [N] (at the center of pressure)
    Fd = -model.cd*dxCOG^2;

    % aerodynamic Lift [N] (at the center of pressure)
    Fl = -model.cl*dxCOG^2;

    % supsension Forces [N] (spring and damper forces)
    model.c = ppval(model.ct, dzFR);
    Fs = model.k.*(zFR - model.z0) + model.c.*dzFR;

    % tractive Force [N] (force at contact patch, minus rolling resistance at the axle)
    Fx = FxFR - model.rr.*FzFR.*tanh(model.ai.*wt);

    % derivatives
    ddx = (1/model.m)*(Fd + 2*sum(Fx));
    ddz = (1/model.m)*(-2*sum(Fs) + Fl - model.m*model.g);
    ddo = (1/(model.Jv))*(2*sum(Fx)*(mean(zFR)) + 2*cos(o)*(Fs(2)*model.wb(2) - Fs(1)*model.wb(1)) + Fl*model.xp*cos(o));
    dw = (1/model.Jw)*round(tau.*model.gr - model.r0.*FxFR, 2);
end