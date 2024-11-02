%% Define Symbols
syms a b c d e f
X = sym("x",[4 1]);
p = [a b c d e f];

%% Define system of equations
A = [-a a 0 0; a -a-c 0 c; 0 0 -d-e d; 0 c d -c-d];
b = [b; 0; e*f; 0];
eqns = A*X + b == 0;

%% Solve system
sol = solve(eqns, X);
x1v = double(subs(sol.x1, p, [2100 4000 250 300 250 280]));