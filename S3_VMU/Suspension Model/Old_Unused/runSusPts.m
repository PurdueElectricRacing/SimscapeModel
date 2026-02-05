% lengths
% L = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28];

% known/fixed
p = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27];
% p = rand(1, 27);
% p = [-13, -12, -11, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
size(p);

% unknown
u = [-13, -12, -11, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
% u = rand(1, 26);
size(u);

lengths = computeLength(u, p);
size(lengths);

% guess
x0 = [-13, -12, -11, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
x0 = rand(size(x0));
% x0 = rand(1, 26);
size(x0);

residuals = suspensionPts(x0, p, lengths);
opts = optimoptions("fsolve", Display="none");
error_array = zeros(1000, length(x0));
tic
for i = 1:1000
    x0 = u + 10 * (rand(size(x0)) - .5);
    solution = fsolve(@suspensionPts, x0, opts, p, lengths);
    error_array(i,:) = [solution - u];
end
toc
errors = sum((error_array .^ 2),2);

%% ploting
figure(1)
plot(errors)

figure(2)
x = logspace(-3, -1, 100);
plot(x, sum(errors > x))
