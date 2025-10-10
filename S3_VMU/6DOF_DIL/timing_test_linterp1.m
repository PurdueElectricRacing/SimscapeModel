%% setup
clear all
x_lin = linspace(0, 99, 10);

z = x_lin .^ 2;

x_test = x_lin(1):1:x_lin(end) + 0.5;


%% empty loop
z_loop = zeros(length(x_test));

t0 = tic;
for i = 1:length(x_test)
    z_loop(i) = x_test(i);
end
t_loop = toc(t0)

%% interp1 linear
z_interp1 = zeros(length(x_test), 1);

t0 = tic;
for i = 1:length(x_test)
    z_interp1(i) = interp1(x_lin, z, x_test(i));
end
t_interp1 = toc(t0)

%% custom linear grid interp1
z_linterp1 = zeros(length(x_test), 1);

t0 = tic;
x(1) = (length(x_lin)-1)/(x_lin(end)-x_lin(1));
x(2) = (1-x_lin(1)*x(1));

for i = 1:length(x_test)
    z_linterp1(i) = linterp1(x, z', x_test(i));
end
t_linterp1= toc(t0)

%% output
sprintf("linterp2 is %2.2fx faster than interp2", t_interp1/t_linterp1)

figure(1)
scatter(x_lin,z, "ro"); hold on
scatter(x_test, z_interp1', "b.")
scatter(x_test, z_linterp1', "g.")
xlabel("x")
ylabel("y")
hold off

figure(2)
scatter(x_test, z_interp1' - z_linterp1', "g.")