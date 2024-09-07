%% Setup functions

% Battery Constants
parallel = 5;
series = 150;
Rcell = 0.0144;
Creg = 0.006;
Vcell = feval(VAhcurve, 0);

Rbatt = Rcell * series / parallel;

% y = [Vb, Voc, Im, Ah]
% p = {series, parallel, Creg, Rbatt, VAhcurve}
function [dydt] = odesys(t, y, p)
    % initialize dydt
    dydt = zeros(4,1);

    % y-values
    Vb = y(1);
    Voc = y(2);
    Im = y(3);
    Ah = y(4);

    % parameters
    series = p{1};
    parallel = p{2};
    Creg = p{3};
    Rbatt = p{4};
    VAhcurve = p{5};
    
    dydt(1) = 1/Creg * ((Voc-Vb)/Rbatt - Im);
    dydt(2) = differentiate(VAhcurve, Ah) * series / parallel * Im / 3600;
    dydt(3) = 0;
    dydt(4) = Im / 3600; 
end

%% setup solver
F = ode;
F.ODEFcn = @odesys;
F.Parameters = {series, parallel, Creg, Rbatt, VAhcurve};
F.InitialValue = [Vcell*series Vcell*series 10 0];
F.Solver = "ode23t";

%% run solver
sol = solve(F, 0, 500);
t = sol.Time;
y = sol.Solution;

%% plot results
tiledlayout(2,2)

nexttile
plot(t,y(1,:), '-o')

hold on
plot(t,y(2,:), '-o')
legend("Vb","Voc")

nexttile
plot(t,y(3,:), '-o')
legend("Im")

nexttile
plot(t,y(4,:), '-o')
legend("Ah")