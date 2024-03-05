%% Import Data
load test_data.mat

time = yaw.time;
yaw_data = yaw.data;
vel_data = vel.data;

%% Parameters
N = 20;
ts = 0.015*N;
a1 = 0.8;
a2 = 0.8;

v1 = vel_data(1:end-N,1:2);
v2 = vel_data(N+1:end,1:2);

v1m = sqrt(v1(:,1).^2 + v1(:,2).^2);
v2m = sqrt(v2(:,1).^2 + v2(:,2).^2);

dot12 = dot(v1,v2,2);
mag12 = v1m.*v2m;

zero = mag12 < 1;
r = abs(dot12./mag12);
r(zero) = 1;
yaw_GPS = sign(yaw_data(1:end-N)).*real(acos(r))./ts;

%% Apply Discrete Filter
yaw_compare_1 = yaw_data(1:end-N);
yaw_compare_2 = yaw_GPS;

num = length(yaw_compare_2);

yaw_filt_1 = zeros(num,1);
yaw_filt_2 = zeros(num,1);

yaw_filt_1_ic = 0;
yaw_filt_2_ic = 0;

for i = 1:num
    yaw_filt_1(i) = a1*yaw_filt_1_ic + (1-a1)*yaw_compare_1(i);
    yaw_filt_2(i) = a2*yaw_filt_2_ic + (1-a2)*yaw_compare_2(i);

    yaw_filt_1_ic = yaw_filt_1(i);
    yaw_filt_2_ic = yaw_filt_2(i);
end

yaw_avg = (yaw_filt_1 + yaw_filt_2)./2;

figure(1)
plot(yaw_filt_1)
hold on
plot(yaw_filt_2)

legend("IMU","GPS")

% plot(yaw_avg)
% hold on
% plot(yaw_data)


%% Plotting
% figure(1)
% plot(time,yaw_data)
% 
% figure(2)