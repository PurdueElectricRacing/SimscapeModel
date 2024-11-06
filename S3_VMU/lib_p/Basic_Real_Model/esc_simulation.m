%% Symbolic

syms ph pl t0 du k a w y0_hat dt

w0 = sym('w', [2 1], 'real');

yt = exp(-ph*dt)*y0_hat + (du/ph)*(1-exp(-ph*dt));
xt = a*yt*sin(w*(t0 + dt));

A = dt.*[-pl 0; 1 0];
eA = expm(A);

g = eA*[k; 0]*xt;
f = int(g, dt, 0, dt);

Wt = eA*w0 + f;
func = matlabFunction(Wt);

clearvars -except func

%% Parameters
a = 1;
b = 0.1;
k = 0.7;
w = 100 / (2*pi);
ph = 1;
pl = 1;
dt = 0.01;

W1 = 0;
W2 = 1;
y0 = 3;
du0 = 0;
t0 = 0;
tf=20;

% simulate
[t_vec, theta, theta_hat, y] = simulate(a, b, k, w, ph, pl, dt, W1, W2, y0, du0, t0, tf, func);

%% Plot
figure(1)
plot(t_vec, theta_hat)
ylabel("theta hat")

figure(2)
plot(t_vec, theta)
ylabel("perturbed estimate")

figure(3)
plot(t_vec, y)
ylabel("plant output (y)")

%% fmincon
%fmincon()

%% Functions
% cost function
% cost is combination of average error, 
function [cost] = cost(x)
    % run simulation
    a = x(1);
    b = x(2);
    k = x(3);
    w = x(4);
    ph = x(5);
    pl = x(6);
    
    dt = 0.01;
    
    W1 = 0;
    W2 = 1;
    y0 = 3;
    du0 = 0;
    t0 = 0;
    tf=20;

    [t_vec, theta, theta_hat, y] = simulate(a, b, k, w, ph, pl, dt, W1, W2, y0, du0, t0, tf, func);

end

% simulate
function [t, theta, theta_hat, y] = simulate(a, b, k, w, ph, pl, dt, W1, W2, y0, du0, t0, tf, func)
    %setupt
    t_vec = 0:dt:tf;
    N = length(t_vec) - 1;
    Wt = zeros(N+1,2); Wt(1,:) = [W1 W2];
    theta = zeros(N+1,1); theta(1) = Wt(1,2) + b*sin(w*t_vec(1));
    
    % simulate
    for i = 2:N+1
        % compute next step
        Wt(i,:) = func(a,dt,du0,k,ph,pl,t0,w,W1,W2,y0);
        theta(i) = Wt(i,2) + b*sin(w*t_vec(i));
    
        % update inputs
        y0 = get_y0(theta(i));
        W1 = Wt(i,1);
        W2 = Wt(i,2);
        du0 = y0 - get_y0(theta(i-1));
        t0 = t_vec(i);
    end

    % outputs
    t = t_vec;
    theta_hat = Wt(:,2);
    y = get_y0(theta);
end

% plant
function y0 = get_y0(x)
    y0 = -x.^4 + x.^3 + 2*x.^2 + x;
end