function [ddx, ddz, ddo] = compute_dd(s, FxFR, zFR, dzFR, model)
    % States
    dxCOG = s(1);
    o = s(6);

    % Aerodynamic Drag
    Fd = -model.cd*dxCOG^2;

    % Aerodynamic Lift
    Fl = -model.cl*dxCOG^2;

    % Supsension Forces
    Fs = model.k*(zFR - model.z0) + model.c*dzFR;

    % Derivatives
    ddx = (1/model.m)*(Fd + 2*sum(FxFR));
    ddz = (1/model.m)*(-2*sum(Fs) + Fl - model.m*model.g);
    ddo = (1/model.J)*(2*cos(o)*(Fs(1)*model.wb(1) - Fs(2)*model.wb(2)) - Fl*model.xp*cos(o));
end