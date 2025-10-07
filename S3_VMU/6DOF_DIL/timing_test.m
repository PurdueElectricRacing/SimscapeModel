x_lin = 500:1:1500;
y_lin = 1000:1:2000;

[x_lin_grid, y_lin_grid] = meshgrid(x_lin, y_lin);
z = x_lin_grid + y_lin_grid;

[x_nonlin_grid, y_nonlin_grid] = meshgrid(x_lin+rand(size(x_lin)), y_lin+rand(size(y_lin)));


t0 = tic;
for i = (0:20:999) + 0.5
    for j = (0:20:999) + 0.5
        interp2(x_lin_grid, y_lin_grid, z, i, j);
    end
end
t_lin = toc(t0)

t0 = tic;
for i = (0:20:990) + 0.5
    for j = (0:20:990) + 0.5
        interp2(x_nonlin_grid, y_nonlin_grid, z, i, j);
    end
end
t_nonlin = toc(t0)

t0 = tic;
x(1) = (length(x_lin)-1)/(x_lin(end)-x_lin(1));
x(2) = (1-x_lin(1)*x(1));
for i = (0:20:990) + 0.5
    for j = (0:20:990) + 0.5
        linterp2(x_lin, y_lin, z, i, j);
    end
end
t_linterp2 = toc(t0)