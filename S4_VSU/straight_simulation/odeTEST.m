% Battery Constants
parallel = 5;
series = 150;
Rcell = 0.0144;
Creg = 0.006;
Vcell = feval(fitresult, 0);

Rbatt = Rcell * series / parallel;



% [Vb Voc, Im, Ah]
function [ddt] = odesys(t,y, C, Rbatt, fitresult, series, parallel)
    ddt = [1/C * ((y(2) - y(1)) / Rbatt - y(3)); differentiate(fitresult, y(4)) * y(3) / 3600 * series; 0; y(3) / 3600];
end

tspan = [0 1000];
y0 = [Vcell*series Vcell*series 10 0];
[t,y] = ode23t(@(t,y) odesys(t,y, Creg, Rbatt, fitresult, series, parallel),tspan,y0);

figure(1)
plot(t,y(:,1:2))
legend("Vb", "Voc")

figure(2)
plot(t,y(:,3))
legend("Im")

figure(3)
plot(t,y(:,4))
legend("Ah")