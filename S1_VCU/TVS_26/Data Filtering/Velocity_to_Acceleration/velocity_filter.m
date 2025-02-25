%% load data
gps_speed = readmatrix("../Testing_Data/TVS_5_10_24_N3.csv", Range='I5:I32387');
time = readmatrix("../Testing_Data/TVS_5_10_24_N3.csv", Range='A5:A32387');

%% ground truth filtered data
numPoints_smooth = 20; % number of points to either side of current point
degree_smooth = 2;
accel_true = zeros(size(time));
for i = numPoints_smooth+1:length(time)-numPoints_smooth
    poly = polyfit(time(i-numPoints_smooth:i+numPoints_smooth), ...
        gps_speed(i-numPoints_smooth:i+numPoints_smooth), ...
        degree_smooth);
    der_poly = polyder(poly);
    accel_true(i) = polyval(der_poly, time(i));
end

%% polyfit smoothed data
numPoints = 20;
degree = 1;

accel_polyfit = polyfit_filter(time, gps_speed, numPoints, degree);

%% analysis, plotting
figure(1)
plot(time, gps_speed)
ax(1)=gca;

figure(2)
plot(time,accel_true)
ax(2)=gca;

figure(3)
plot(time,accel_polyfit)
ax(3)=gca;

linkaxes(ax,'x')
linkaxes(ax(2:3), 'xy')
