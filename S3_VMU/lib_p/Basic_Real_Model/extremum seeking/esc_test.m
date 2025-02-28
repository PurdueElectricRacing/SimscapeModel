%% test
ans=1;
%% code

% dt=.01;
% t=1:dt:10;
% y=sin(2*t)+5;
% h=zeros(size(t));
% 
% for i=2:length(t)-1
%     h(i+1) = H_Y(h(i), 1, dt, y(i), y(i-1));
% end
% 
% plot(t,y); hold on
% plot(t,h)


dt = 0.1;
a = 1;
b = 0.05;
w = 1;
p = 1;
k = 1;


t_All = (0:dt:5000)';
%Y_all = sin(0.5.*t_All) + 1;
Y_all = zeros(size(t_All));
H_all = zeros(size(t_All));
X_all = zeros(size(t_All));
W_all = zeros(length(t_All),2);
Theta_all = zeros(size(t_All));

for i = 2:length(t_All)-1
    H_all(i+1) = H_Y(H_all(i), p, dt, Y_all(i), Y_all(i-1));
    X_all(i+1) = X_H(H_all(i+1), a, w, t_All(i+1));
    W_all(i+1,:) = Thetahat_X(W_all(i,:)', H_all(i), p, dt, Y_all(i), Y_all(i-1), a, w, t_All(i+1), k)';
    Theta_all(i+1) = Theta_Thetahat(W_all(i+1, 2), b, w, t_All(i+1));
    Y_all(i+1) = Y_Theta(Theta_all(i+1));
end

figure(1)
plot(t_All, Y_all); hold on
plot(t_All, H_all)
plot(t_All, X_all)
plot(t_All, W_all(:,2))
plot(t_All, Theta_all)
plot(t_All, Y_all)
legend("Y", "H", "X", "Thetahat", "Theta", "Y")
figure(2)
plot(t_All, Y_all); hold on
plot(t_All, W_all(:,2))

%% Functions
function [Y] = Y_Theta(theta)
    Y = theta - theta^2;
end

function [H_kp1] = H_Y(H_k, p, dt, Y_k, Y_km1)
    H_kp1 = exp(-p*dt)*H_k + (Y_k-Y_km1)/(dt*p)*(1-exp(-p*dt));
end

function [X_k] = X_H(H_k, a, w, t)
    X_k = H_k*a*sin(w*t);
end

function [X_t] = interp_X(H_k, p, dt, Y_k, Y_km1, a, w, t)
    H_t = H_Y(H_k, p, t, Y_k, Y_km1);
    X_t = X_H(H_t, a, w, t);
end

function [W_kp1] = Thetahat_X(W_k, H_k, p, dt, Y_k, Y_km1, a, w, t, k)
   expAx = @(x) ([exp(-p*x), 0; (1-exp(-p*x))/p, 1]); % exp(A*x)
   d = @(t) ([k * interp_X(H_k,p,dt,Y_k,Y_km1,a,w,t); 0]);
   W_kp1 = expAx(dt) * W_k + integral(@(tau) (expAx(tau)*d(tau+t)), 0, dt, ArrayValued=true);
end

function [theta] = Theta_Thetahat(Thetahat, b, w, t)
    theta = Thetahat + b*sin(w*t);
end