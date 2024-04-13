V = (0:1:20) .* ones(201,1);
theta = ((0:0.026:0.52) .* ones(201,1))';

k = 0.24/9.81;
l = sum([0.7922471, 0.7828529]);

V = V(:);
theta = theta(:);

yaw = (V .* theta) ./ (l + (k.*V.^2));

figure(1)
scatter3(V, theta, yaw)

figure(2)
scatter(V, yaw)

figure(3)
scatter(theta, yaw)