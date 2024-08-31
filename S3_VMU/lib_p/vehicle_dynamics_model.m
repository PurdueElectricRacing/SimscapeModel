function [ddx, ddz, ddo, dw] = vehicle_dynamics_model(s, tau, FxFR_MAX, zFR, dzFR, model)
    % States
    dxCOG = s(1);
    o = s(6);

    % Aerodynamic Drag
    Fd = -model.cd*dxCOG^2;

    % Aerodynamic Lift
    Fl = -model.cl*dxCOG^2;
    disp(Fl)

    % Supsension Forces
    model.c = ppval(model.ct, dzFR);
    Fs = model.k.*(zFR - model.z0) + model.c.*dzFR;

    % Tire Forces
    FxFR = min(tau.*model.gr./model.r0, FxFR_MAX);

    % Derivatives
    ddx = (1/model.m)*(Fd + 2*sum(FxFR));
    ddz = (1/model.m)*(-2*sum(Fs) + Fl - model.m*model.g);
    ddo = (1/(20*model.Jv))*(2*cos(o)*(Fs(1)*model.wb(1) - Fs(2)*model.wb(2)) + Fl*model.xp*cos(o));
    dw = (1/model.Jw)*(tau.*model.gr - (model.r0.*FxFR - model.k0.*FxFR.^2)) + ddx/model.r0;
end