%% Import Data
load test_data.mat

time = yaw.time;
yaw_data = yaw.data;
vel_data = vel.data;

%% Apply DSP
N = 2;
ts = 0.015;
tsN = ts*N;
idx = (1:length(vel_data))';

% apply uniqueness filter
mag_vel = sqrt(vel_data(:,1).^2 + vel_data(:,2).^2 + vel_data(:,3).^2);
unique_VN = abs((vel_data(1:end-1,1) - vel_data(2:end,1))) > 0.00001;
unique_VE = abs((vel_data(1:end-1,2) - vel_data(2:end,2))) > 0.00001;
not_moving = mag_vel < 2;

unique_data_flag = (unique_VN & unique_VE) | not_moving(2:end);
unique_idx = [1; idx(unique_data_flag)+1];
unique_vel = [vel_data(1,:); vel_data(unique_data_flag,1) vel_data(unique_data_flag,2) vel_data(unique_data_flag,2)];
unique_yaw = yaw_data(unique_idx);

% compute raw values in change in orientation
dt = (unique_idx(2:end-N) - unique_idx(1:end-1-N))*ts;
v1 = unique_vel(1:end-1-N,1:2);
v2 = unique_vel(2:end-N,1:2);
v1m = sqrt(v1(:,1).^2 + v1(:,2).^2);
v2m = sqrt(v2(:,1).^2 + v2(:,2).^2);
dot12 = dot(v1,v2,2);
mag12 = v1m.*v2m;

% apply magnitude filter
zero = mag12 < 10;
r = abs(dot12./mag12);
r(zero) = 1;

% compute change in orientation
yaw_GPS = sign(unique_yaw(1:end-1-N)).*real(acos(r))./dt;

%% Visualize Raw Computation
yaw_compare_1 = yaw_data(1:end-N);
yaw_compare_2 = yaw_GPS;

figure(1)
plot(yaw_compare_1)
hold on
plot(unique_idx(1:end-1-N),yaw_compare_2)
legend("IMU","GPS")

%% Apply Discrete Filter
a1 = 0.8;
a2 = 0.8;

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

%% Visualize Filtered Signal
figure(2)
plot(yaw_filt_1)
hold on
plot(unique_idx(1:end-1-N),yaw_filt_2)
legend("IMU","GPS")