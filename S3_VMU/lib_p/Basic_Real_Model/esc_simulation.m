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

%% Initial Parameters
a = 1;
b = 0.1;
k = 1;
w = 10 *2*pi;
ph = 1;
pl = 1;
dt = 0.015;

W1 = 0;
W2 = 1;
y0 = 3;
du0 = 0;
t0 = 0;
tf = 20;

%% minimize

% parameters
lb = [0 0 0 0 0 0];
ub = [100 100 10 100 100 100];
% opts = optimoptions("patternsearch", "UseCompletePoll",false, "UseCompleteSearch",true, "UseParallel",false);
% x_best = patternsearch(@(x) (cost(x, func)), [a, b, k, w, ph, pl], [], [], [], [], lb, ub, [], opts);

opts = optimoptions("ga", "PopulationSize",1000, "UseParallel",true);
x_best = ga(@(x) (cost(x, func, false)), 6, [], [], [], [], lb, ub, [], [], opts);

fprintf("a: %f\nb: %f\nk: %f\nw: %f\nph: %f\npl: %f", x_best)
a_best = x_best(1);
b_best = x_best(2);
k_best = x_best(3);
w_best = x_best(4);
ph_best = x_best(5);
pl_best = x_best(6);

%% Simulate fmincon best fit
best_output = cost(x_best, func, true);
%[t_vec, theta, theta_hat, y] = simulate(a_best, b_best, k_best, w_best, ph_best, pl_best, dt, W1, W2, y0, du0, t0, tf, func);

figure(1)
plot(best_output.t_vec, best_output.theta_hat)
xlabel("time")
ylabel("theta hat (unmodulated plant input)")

figure(2)
plot(best_output.t_vec, best_output.theta)
xlabel("time")
ylabel("theta (moduluated plant input)")

figure(3)
plot(best_output.t_vec, best_output.y); hold on
plot(best_output.t_vec, best_output.y_smooth)

xlabel("time")
ylabel("plant output")

%% Functions
% cost function
function [cost] = cost(x, func, FullOutput)
    % run simulation
    a = x(1);
    b = x(2);
    k = x(3);
    w = x(4);
    ph = x(5);
    pl = x(6);
    
    dt = 0.015;
    
    W1 = 0;
    W2 = 1;
    y0 = 3;
    du0 = 0;
    t0 = 0;
    tf = 20;

    [t_vec, theta, theta_hat, y] = simulate(a, b, k, w, ph, pl, dt, W1, W2, y0, du0, t0, tf, func);
    
    % check for bad outputs
    if sum(isnan(y)) ~= 0
        cost = 10000;
        return
    end

    % smooth out y
    y_smooth = movmean(y, round(2*pi/w/dt)+1);

    % determine 10% settling time
    y_f = y_smooth(end);

    y_dif = (abs(y_f-y_smooth)); 
    tau_dif = (y_f - y0) * 0.1;
    tau = t_vec(find(y_dif>tau_dif,1, "last"));

    if isempty(tau)
        tau = 10000;
    end

    % determine amplitude of oscillation at end
    y_amp = max(y(end-100:end)) - min(y(end-100:end));

    % determine amplitdue of oscillation of unmodulated signal (theta hat)
    theta_hat_amp = max(theta_hat(end-100:end)) - min(theta_hat(end-100:end));

    % calculuate total cost
    error = 0;
    cost = tau + error + y_amp + theta_hat_amp;

    % output internal calculations if requested
    if FullOutput
        output.cost = cost;
        output.tau = tau;
        output.y_amp = y_amp;
        output.theta_hat_amp = theta_hat_amp;
        output.error = error;

        output.t_vec = t_vec;
        output.theta = theta;
        output.theta_hat = theta_hat;
        output.y = y;
        output.y_smooth = y_smooth;
        output.y_f = y_f;
        output.y_dif = y_dif;
        output.tau_dif = tau_dif;
      

        cost = output;
    end

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

        % add noise
        y0 = y0 + 0.1*(rand(1)-0.5);
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