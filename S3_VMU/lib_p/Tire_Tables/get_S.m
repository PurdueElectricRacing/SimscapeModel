function S = get_S(Fz, Fx, alpha, params)
    opts = optimoptions('fsolve','Display','none');
    sol = fsolve(@get_res, 0.1, opts, Fz, Fx, alpha, params);
    g = 0;

    function res = get_res(S, Fz, Fx, alpha, params)
        x0 = Fz*params.Dx*sin(params.Cx*atan(params.Bx*S - params.Ex*atan(params.Bx*S - params.Bx*S)));
        y0 = Fz*params.Dy*sin(params.Cy*atan(params.By*alpha - params.Ey*atan(params.By*alpha)));
        theta = ((pi/4)*exp(params.a*alpha) + atan(10*alpha))*(exp((params.b*exp(params.c*alpha) + params.d)*S) + (1/pi)*atan(params.f*S*alpha));
        r = params.gamma*x0*y0*sqrt((1 + tan(theta)^2) / (y0^2 + x0^2*tan(theta)^2)) + (1-params.gamma)*(x0*y0*sqrt(1 + tan(theta)^2))/(x0*tan(theta) + y0);
        Fx_pred = r*x0*y0*sqrt(x0^2*tan(theta)^2 + y0^2);
    
        res = Fx - Fx_pred;
    end
end