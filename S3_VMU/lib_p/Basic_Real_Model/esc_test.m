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

dt=1;a=1;w=1;p=1;Y_k=1;Y_km1=0;
H1 = 1;
X1 = X_H(H1, a, w, 0);
H2 = H_Y(H1, p, dt, Y_k, Y_km1);
X2 = X_H(H2, a, w, 1);
Tall = 0:.01:1;
Hall = zeros(size(Tall));
Hall(1) = H1;
Xall = zeros(size(Tall));
for i=2:length(Tall)
    Xall(i) = interp_X(H1, p, dt, Y_k, Y_km1, a, w, Tall(i));
end
plot(0,X1, Marker="o"); hold on
plot(1,X2, Marker="o");
plot(Tall,Xall)

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

function [W_kp1] = Thetahat_X(W_k, H_k, p, dt, Y_k, Y_km1, a, w, t)
   expAx = @(x) ([exp(-p*x), 0; (1-exp(-p*x))/p, 1]); % exp(A*x)
   d = @(t) ([k * interp_X(H_k,p,dt,Y_k,Y_km1,a,w,t); 0]);
   W_kp1 = expAx(dt) * W_k + integral(@(tau) (expAx(tau)*d(tau+t)), 0, dt,ArrayValued=true);
end