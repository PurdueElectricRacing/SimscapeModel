FZ = 200:10:1200;

% kx model
A1 = 0;
A2 = 39.8344;
A3 = 813.0780;

% mu_x model
B1 = 0.000001287;
B2 = -0.002325;
B3 = 3.797;

% mu_y model
C1 = -0.000000002541;
C2 = 0.000005279;
C3 = -0.003943;
C4 = 3.634;

% C model
FZ_C = [0 204.13 427.04 668.1 895.72 1124.40 1324.40];
C_param = [0 13757.41 21278.97 26666.02 30253.47 30313.18 30313.18];



kx = (A2 * FZ) + A3;
mu_x = (B1 .* FZ .^2) + (B2 .* FZ) + B3;
mu_y = (C1 .* FZ .^3) + (C2 .* FZ .^ 2) + (C3 .* FZ) + C4;
C = pchip(FZ_C, C_param, abs(FZ));



figure(1)
subplot(2,2,1)
plot(FZ, kx)
xlabel('Normal Force (N)')
ylabel('Longitudinal Stiffness (N/rad)')
grid on

subplot(2,2,3)
plot(FZ, mu_x)
xlabel('Normal Force (N)')
ylabel('Longitudinal Coefficient of Friction')
grid on

subplot(2,2,4)
plot(FZ, mu_y)
xlabel('Normal Force (N)')
ylabel('Lateral Coefficient of Friction')
grid on

subplot(2,2,2)
plot(FZ, C)
xlabel('Normal Force (N)')
ylabel('Cornering Stiffness (N/rad)')
grid on