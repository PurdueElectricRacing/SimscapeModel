function res = get_res_6DOF(x, FzFR, tauRaw, alpha, Vb, dxCOG, model)
    % wheel speed [rad/s]
    wm = (x(1) + 1).*(dxCOG ./ model.r0);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = min(tauRaw, model.mt(wm, Vb)) - model.rr.*FzFR.*tanh(model.ai.*wm) - model.gm.*wm;

    % possible applied tractive force [N]
    FxFR = (tau.*model.gr./model.r0);

    % find maximum Fx and Fy forces [N]
    x0 = FzFR*model.Dx*sin(model.Cx*atan(model.Bx*x(1) - model.Ex*(model.Bx*x(1) - atan(model.Bx*x(1)))));
    y0 = FzFR*model.Dy*sin(model.Cy*atan(model.By*alpha - model.Ey*(model.By*alpha - atan(model.By*alpha))));
    
    if (x0 >= 0) && (x0 <= model.eps)
        x0 = 1;
    elseif (x0 <= 0) && (x0 >= -model.eps)
        x0 = -model.eps;
    end

    if (y0 >= 0) && (y0 <= model.eps)
        y0 = model.eps;
    elseif (y0 <= 0) && (y0 >= -model.eps)
        y0 = -model.eps;
    end

    % find force split between Fx and Fy [rad]
    theta = ((pi/4)*exp(model.ao*alpha) + atan(10*alpha))*(exp((model.bo*exp(model.co*alpha) + model.do)*x(1)) + (1/pi)*atan(model.fo*x(1)*alpha));
    
    % find combined normalized force radius [unitless]
    % r = params.gamma*x0*y0*sqrt((1 + tan(theta)^2) / (y0^2 + x0^2*tan(theta)^2)) + (1-params.gamma)*(x0*y0*sqrt(1 + tan(theta)^2))/(x0*tan(theta) + y0);
    r = 1;

    % compute Fy assuming Fx is correct [N]
    FyFR = FxFR*tan(theta);

    % compute residuals
    res = abs(r^2 - (FxFR / x0)^2 - (FyFR / y0)^2);
end