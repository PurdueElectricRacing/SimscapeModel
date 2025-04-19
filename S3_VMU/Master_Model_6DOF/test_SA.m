%% Get Model
model = varModel_master_6DOF;

%% Constants
psi = 0.1;
wb = model.wb;
ht = model.ht;
eps = model.eps;
Sy = model.Sy;
Sx = model.Sx;
toe = [0.05; 0.05; 0.05; 0.05];

thetaR = atan(ht./wb);
R = sqrt(wb.^2 + ht.^2);

%% Generate Input Data
x_vec = linspace(-10,10,20);
y_vec = linspace(-10,10,20);
[x_grid, y_grid] = meshgrid(x_vec, y_vec);
x_all = x_grid(:);
y_all = y_grid(:);

%% Evaluate Function
SA = rad2deg(atan(-y_all-Sy(1).*wb(1).*psi ./ x_all+Sx(1).*ht(1).*psi + eps));
SA2 = rad2deg(atan2(-y_all-Sy(1).*wb(1).*psi, x_all+Sx(1).*ht(1).*psi + eps));

%% Evaluate New SA Function
Vr = psi.*R(1);
Vxr = Vr.*cos(thetaR(1));
Vyr = Vr.*sin(thetaR(1));
Vxc = Vxr + x_all;
Vyc = Vyr + y_all;
alpha_v = atan(Vyc ./ (Vxc+eps));
SA3 = alpha_v - toe(1);

SA4 = atan((y_all + psi.*model.Cy(1))./(x_all + psi.*model.Cx(1) + model.eps));
SA5 = SA4.*tanh(abs(x_all));

%% Plot Function
figure(1)
scatter3(x_all, y_all, SA4)
hold on
scatter3(x_all, y_all, SA5)

xlabel("Long")
ylabel("Lat")
zlabel("SA")