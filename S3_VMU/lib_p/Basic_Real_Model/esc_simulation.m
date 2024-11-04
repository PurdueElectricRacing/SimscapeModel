%% Symbolic

syms ph pl t0 du k a w y0_hat dt

w0 = sym('w', [2 1], 'real');

yt = exp(-ph*dt)*y0_hat + (du/ph)*(1-exp(-ph*dt));
xt = a*yt*sin(w*(t0 + dt));

A = dt.*[-pl 0; 1 0];
eA = expm(A);

g = eA*[k; 0]*xt;
f = int(g, dt, 0, dt);

wt = eA*w0 + f;
func = matlabFunction(wt);

clearvars -except func

%% Parameters
a = 1;
b = 0.1;
k = 0.7;
w = 10;
ph = 1;
pl = 1;
dt = 0.0001;

w1 = 0;
w2 = 0;
y0 = 0;
du0 = 0;
t0 = 0;

%% Simulate
t_vec = 0:dt:150;
N = length(t_vec) - 1;
wt = zeros(N+1,2);
theta = zeros(N+1,1);

for i = 2:N+1
    % compute next step
    wt(i,:) = func(a,dt,du0,k,ph,pl,t0,w,w1,w2,y0);
    theta(i) = wt(i,2) + b*sin(w*t_vec(i));

    % update inputs
    y0 = get_y0(theta(i));
    w1 = wt(i,1);
    w2 = wt(i,2);
    du0 = y0 - get_y0(theta(i-1));
    t0 = t_vec(i);

    % get estimate
    y0_hat = wt(i,2)-wt(i,2)^2;
end

%% Plot
figure(1)
plot(t_vec, wt(:,2))
ylabel("theta hat")

figure(2)
plot(t_vec, theta)
ylabel("perturbed estimate")

figure(3)
plot(t_vec, get_y0(theta))
ylabel("estimated y")

%% Functions
% cost function
% cost is combination of average error, 
function [cost] = cost(a, b, k, w, ph, pl)
    
end

% plant
function y0 = get_y0(x)
    y0 = -x.^4 + x.^3 + 2*x.^2 + x;
end