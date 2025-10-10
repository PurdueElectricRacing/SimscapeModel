%% setup
clear all
x_lin = linspace(0, 100, 10);
y_lin = linspace(100, 2000, 20);

[x_lin_grid, y_lin_grid] = meshgrid(x_lin, y_lin);
z = x_lin_grid .* y_lin_grid;

x_test = x_lin(1):1:x_lin(end) + 0.5;
y_test = y_lin(1):1:y_lin(end) + 0.5;
[x_test_grid, y_test_grid] = meshgrid(x_test, y_test);

%% empty loop
z_loop = zeros(length(x_test), length(y_test));

t0 = tic;
for i = 1:length(x_test)
    for j = 1:length(y_test)
        z_loop(i, j) = i+j;
    end
end
t_loop = toc(t0)

%% interp2 linear
z_interp2 = zeros(length(x_test), length(y_test));

t0 = tic;
for i = 1:length(x_test)
    for j = 1:length(y_test)
        z_interp2(i, j) = interp2(x_lin_grid, y_lin_grid, z, x_test(i), y_test(j));
    end
end
t_interp2 = toc(t0)

%% custom linear grid interp2
z_linterp2 = zeros(length(x_test), length(y_test));

t0 = tic;
x(1) = (length(x_lin)-1)/(x_lin(end)-x_lin(1));
x(2) = (1-x_lin(1)*x(1));
y(1) = (length(y_lin)-1)/(y_lin(end)-y_lin(1));
y(2) = (1-y_lin(1)*y(1));

for i = 1:length(x_test)
    for j = 1:length(y_test)
        z_linterp2(i, j) = linterp2(x, y, z', x_test(i), y_test(j));
    end
end
t_linterp2 = toc(t0)

%% output
sprintf("linterp2 is %2.2fx faster than interp2", t_interp2/t_linterp2)

figure(1)
surf(x_lin_grid, y_lin_grid, z, FaceColor="red", FaceAlpha=0.5)
hold on
scatter3(x_test_grid, y_test_grid, z_interp2', "b.")
scatter3(x_test_grid, y_test_grid, z_linterp2', "g.")
xlabel("x")
ylabel("y")
hold off

figure(2)
scatter3(x_test_grid, y_test_grid, z_interp2' - z_linterp2', "g.")