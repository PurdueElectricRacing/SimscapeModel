function [FxFR_MAX, zFR, dzFR] = traction_model(s, tau, model)
    % States
    dxCOG = s(1);
    dzCOG = s(3);
    zCOG = s(4);
    do = s(5);
    o = s(6);
    wCHA = s(7:8);
    
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
    disp(FzFR)

    % Longitudinal slip [Unitless]
    w = dxCOG/model.r0 + (dxCOG / (model.r0 - model.k0*tau(2)/model.r0));
    Sl = abs((dxCOG - w*model.r0) / dxCOG);
    
    % Coefficient of Friction [Unitless]
    mu1 = (model.d(1).*(1-exp(-model.d(2).*Sl)) - model.d(3).*Sl);
    mu2 = exp(-model.d(4).*Sl.*abs(dxCOG)).*(1-model.d(5).*FzFR.^2);
    mu = mu1.*mu2;

    % Maximum Longitudinal Force [N]
    FxFR_MAX = mu.*FzFR;
end