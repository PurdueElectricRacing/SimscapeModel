function [FxFR_MAX, zFR, dzFR] = traction_model(s, model)
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

    % Tire angular velocity
    dxB = dxCOG + wCHA*(model.r0 - model.k1*1);

    % Longitudinal slip [Unitless]
    Sl = abs((dxCOG - dxB) / dxCOG);
    Sl_sign = sign(dxCOG - dxB);
    
    % Coefficient of Friction [Unitless]
    mu1 = (model.d(1).*(1-exp(-model.d(2).*Sl)) - model.d(3).*Sl);
    mu2 = exp(-model.d(4).*Sl.*abs(dxCOG)).*(1-model.d(5).*FzFR.^2);
    mu = mu1.*mu2;

    % Maximum Longitudinal Force [N]
    FxFR_MAX = Sl_sign.*mu.*FzFR;
end