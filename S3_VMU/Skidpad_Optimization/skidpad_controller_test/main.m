taustar = [5; 5; 5; 5];

fmincon(@(x) (cost(x, taustar)), taustar, [], [])


function J = cost(tau, taustar)
    J = sum((tau - taustar) .^ 2);
end