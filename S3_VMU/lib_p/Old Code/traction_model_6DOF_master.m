%% Things to do:
% 3. make presentation slides
% 5. document this function
% 6. integrate this same function type into longitudinal model

function [FxFR, FyFR, w] = traction_model_6DOF_master(s, tauRaw, model)
    if (abs(wCOG(1)) < 0.1)
        S = fmincon(@get_res_6DOF, 0.1, [], [], [], [], 0, model.Sm, [], model.opts, FzFR, tauRaw, alpha, Vb, dxCOG, model);
    else
        S = (wCOG*model.r0 + model.Sm*dxCOG) / dxCOG;
    end

    [FxFR, FyFR, w] = get_val_6DOF(S, FzFR, tauRaw, alpha, Vb, dxCOG, model);
end

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
    r = 1;

    % compute Fy assuming Fx is correct [N]
    FyFR = FxFR*tan(theta);

    % compute residuals
    res = abs(r^2 - (FxFR / x0)^2 - (FyFR / y0)^2);
end

function [FxFR, FyFR, wm] = get_val_6DOF(x, FzFR, tauRaw, alpha, Vb, dxCOG, model)
    % wheel speed [rad/s]
    wm = (x(1) + 1).*(dxCOG ./ model.r0);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = min(tauRaw, model.mt(wm, Vb)) - model.rr.*FzFR.*tanh(model.ai.*wm) - model.gm.*wm;

    % possible applied tractive force [N]
    FxFR = (tau.*model.gr./model.r0);

    % find force split between Fx and Fy [rad]
    theta = ((pi/4)*exp(model.ao*alpha) + atan(10*alpha))*(exp((model.bo*exp(model.co*alpha) + model.do)*x(1)) + (1/pi)*atan(model.fo*x(1)*alpha));

    % compute Fy assuming Fx is correct [N]
    FyFR = FxFR*tan(theta);
end