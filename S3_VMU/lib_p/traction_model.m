function [FxFR, zFR, dzFR] = traction_model(s, model)
    % States
    dxCOG = s(1);
    dzCOG = s(3);
    zCOG = s(4);
    do = s(5);
    o = s(6);
    w = s(7:8);
    
    % suspension compression [m]
    zF = zCOG + model.wb(1)*sin(o);
    zR = zCOG - model.wb(2)*sin(o);
    zFR = [zF; zR];

    % suspension compression velocity [m/s]
    dzF = dzCOG + model.wb(1)*cos(o)*do;
    dzR = dzCOG - model.wb(2)*cos(o)*do;
    dzFR = [dzF; dzR];

    % tire normal force [N]
    FzFR = -(model.k*(zFR - model.z0) + (model.c*dzFR));

    % Longitudinal slip [Unitless]
    Sl = abs((dx - w*model.r) / dx);
    Sl_sign = sign(dx - w*model.r);
    
    % Coefficient of Friction [Unitless]
    mu1 = (varModel.d(1)*(1-exp(-varModel.d(2)*Sl)) - varModel.d(3)*Sl);
    mu2 = exp(-varModel.d(4)*Sl*abs(dxCOG))*(1-varModel.d(5)*FzFR.^2);
    mu = mu1*mu2;

    % Longitudinal Force [N]
    FxFR = Sl_sign*mu*FzFR;
end