function [V_ccw, S_ccw, Y_ccw_abs] = create_yaw_table()

%% Import CCW Data
opts = delimitedTextImportOptions("NumVariables", 12);
opts.DataLines = [5, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["VarName1", "Main", "Main_1", "Main_2", "Main_3", "Main_4", "Main_5", "Main_6", "Main_7", "Main_8", "Main_9", "Main_10", "Main_11", "Main_12"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
ccwturningSIMPLE = readtable("Vehicle Testing Source Data\2023-12-2-ccw-turning_SIMPLE.csv", opts);
ccwturningSIMPLE = table2array(ccwturningSIMPLE);
clear opts

%% Import CW Data
opts = delimitedTextImportOptions("NumVariables", 12);
opts.DataLines = [5, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["VarName1", "Main", "Main_1", "Main_2", "Main_3", "Main_4", "Main_5", "Main_6", "Main_7", "Main_8", "Main_9", "Main_10", "Main_11", "Main_12"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
cwturningSIMPLE = readtable("Vehicle Testing Source Data\2023-12-2-cw-turning_SIMPLE.csv", opts);
cwturningSIMPLE = table2array(cwturningSIMPLE);
clear opts

%% Extract Raw Data
t_ccw = ccwturningSIMPLE(:,1);
t_cw = cwturningSIMPLE(:,1);

T_ccw = ccwturningSIMPLE(:,2);
T_cw = cwturningSIMPLE(:,2);

steer_raw_ccw = ccwturningSIMPLE(:,3);
steer_raw_cw = cwturningSIMPLE(:,3);

vel_raw_ccw = ccwturningSIMPLE(:,4:6);
vel_raw_cw = cwturningSIMPLE(:,4:6);

yaw_raw_ccw = ccwturningSIMPLE(:,7:9);
yaw_raw_cw = cwturningSIMPLE(:,7:9);

acc_raw_ccw = ccwturningSIMPLE(:,10:12);
acc_raw_cw = cwturningSIMPLE(:,10:12);

ws_raw_ccw = ccwturningSIMPLE(:,13:14);
ws_raw_cw = cwturningSIMPLE(:,13:14);

%% Define Parameters
ts = 0.015; % sample rate of system
GR = 6.63;
r = 0.22; % tire radius, meters

%% Calibrate Yaw Rate
acc_steady_ccw = median(acc_raw_ccw);
acc_steady_cw = median(acc_raw_cw);
XYZs = (acc_steady_ccw + acc_steady_cw)' ./ 2;

% figure(1)
% scatter(t_ccw./ts,acc_raw_ccw)
% hold on
% yline(acc_steady_ccw)
% hold on
% yline(XYZs)
% 
% figure(2)
% scatter(t_cw./ts,acc_raw_cw)
% hold on
% yline(acc_steady_cw)
% hold on
% yline(XYZs)

% define vehicle orientation
XYZv = [0;0;sqrt(dot(XYZs,XYZs))];

% Compute the angle between the two axis using dot product formula
theta = acos(dot(XYZs,XYZv)/(norm(XYZv)^2));

% Find an axis that is orthogonal to both axis using cross product, normalize
u = cross(XYZs,XYZv);
u = u/norm(u);

% Compute cross product matrix
ux = [0 -u(3) u(2); u(3) 0   -u(1); -u(2) u(1) 0];

% Use Axis-Angle method to find the appropriate rotation matrix
R = (cos(theta)*eye(3)) + (sin(theta)*ux) + ((1-cos(theta))*(u*(u')));

% Test if the rotation matrix is correct
XYZr = R*XYZs;
error = abs(XYZr - XYZv);
disp(['After Transformation, the maximum error is ',num2str(max(error))])

% Adjust Axis for Accelerometer and Gyroscope
k = length(t_ccw);
yaw_raw_ccw = [yaw_raw_ccw(:,2) yaw_raw_ccw(:,1) yaw_raw_ccw(:,3)];

yaw_transformed_ccw = ones(k,3);
acc_transformed_ccw = ones(k,3);

for i = 1:k
    yaw_transformed_ccw(i,:) = R*(yaw_raw_ccw(i,:))';
    acc_transformed_ccw(i,:) = R*(acc_raw_ccw(i,:))';
end

k = length(t_cw);
yaw_raw_cw = [yaw_raw_cw(:,2) yaw_raw_cw(:,1) yaw_raw_cw(:,3)];

yaw_transformed_cw = ones(k,3);
acc_transformed_cw = ones(k,3);

for i = 1:k
    yaw_transformed_cw(i,:) = R*(yaw_raw_cw(i,:))';
    acc_transformed_cw(i,:) = R*(acc_raw_cw(i,:))';
end

% figure(3)
% scatter(t_ccw,yaw_transformed_ccw)
% 
% figure(4)
% scatter(t_ccw,acc_transformed_ccw)
% 
% figure(5)
% scatter(t_cw,yaw_transformed_cw)
% 
% figure(6)
% scatter(t_cw,acc_transformed_cw)

%% Calibrate Steering Angle
theta_max = max([steer_raw_ccw; steer_raw_cw]);
theta_min = min([steer_raw_ccw; steer_raw_cw]);

theta_mean = (theta_max + theta_min) / 2;

steer_cal_ccw = steer_raw_ccw - theta_mean;
steer_cal_cw = steer_raw_cw - theta_mean;

% figure(7)
% scatter([t_ccw; t_cw], [steer_raw_ccw; steer_raw_cw])
% hold on
% yline(theta_min)
% hold on
% yline(theta_max)
% hold on
% yline(theta_mean)

% figure(8)
% scatter([t_ccw; t_cw], [steer_cal_ccw; steer_cal_cw])

%% Verify Velocity Measurements
vel_cog_ccw = 10*sqrt(sum(vel_raw_ccw.*vel_raw_ccw,2));
vel_cog_cw = 10*sqrt(sum(vel_raw_cw.*vel_raw_cw,2));

ws_cog_ccw = mean(ws_raw_ccw,2).*(2*pi./(60))./(GR).*(r);
ws_cog_cw = mean(ws_raw_cw,2).*(2*pi./(60))./(GR).*(r);

% filter bad measurement
vel_filter_ccw = vel_cog_ccw < 30;
vel_filter_cw = vel_cog_cw < 30;

t_ccw_filt = t_ccw(vel_filter_ccw);
t_cw_filt = t_cw(vel_filter_cw);

vel_cog_ccw_filt = vel_cog_ccw(vel_filter_ccw);
vel_cog_cw_filt = vel_cog_cw(vel_filter_cw);

yaw_transformed_ccw_filt = yaw_transformed_ccw(vel_filter_ccw,3);
yaw_transformed_cw_filt = yaw_transformed_cw(vel_filter_cw,3);

T_ccw_filt = T_ccw(vel_filter_ccw);
T_cw_filt = T_cw(vel_filter_cw);

steer_cal_ccw_filt = steer_cal_ccw(vel_filter_ccw);
steer_cal_cw_filt = steer_cal_cw(vel_filter_cw);

% figure(9)
% scatter(t_ccw_filt./ts,vel_cog_ccw_filt)
% hold on
% scatter(t_ccw,ws_cog_ccw)
% 
% ylim([0 30])
% 
% figure(10)
% scatter(t_cw_filt./ts,vel_cog_cw_filt)
% hold on
% scatter(t_cw,ws_cog_cw)
% 
% ylim([0 30])

%% View Throttle Data
% figure(11)
% scatter([t_ccw_filt; t_cw_filt+t_ccw_filt(end)],[T_ccw_filt; T_cw_filt])

%% View Yaw Data
% figure(12)
% scatter(t_ccw_filt./ts,yaw_transformed_ccw_filt)
% 
% figure(13)
% scatter(t_cw_filt./ts,yaw_transformed_cw_filt)
% 
% figure(14)
% scatter(t_ccw_filt./ts,steer_cal_ccw_filt)
% 
% figure(15)
% scatter(t_cw_filt./ts,steer_cal_cw_filt)
% 
% figure(16)
% scatter(t_ccw_filt./ts,vel_cog_ccw_filt)
% 
% figure(17)
% scatter(t_cw_filt./ts,vel_cog_cw_filt)

V_ccw = [4.55;4.55;4.55;6.41;7.45;7.72;6.99;8.49;10.3;9.56;11.57;0;4;8;12];
Y_ccw = [0.78;0.45;0.31;1.12;0.71;0.49;1.11;0.90;0.70;0.96;0.80;0;0;0;0];
S_ccw = [90.55;51.55;41.95;100.05;53.65;43.05;110.65;60.05;44.85;71.85;52.45;0;0;0;0];

r_ccw = [5.85;10.53;15.30;5.85;10.53;15.30;5.85;10.53;15.30;10.53;15.30;inf;inf;inf;inf];
Y_ccw_abs = V_ccw ./ r_ccw;

figure(18)
% scatter3(S_ccw,V_ccw,Y_ccw)
% hold on
scatter3(S_ccw,V_ccw,Y_ccw_abs)

legend("Reg","Abs")

r_ccw_exp = V_ccw./Y_ccw;
error_r = r_ccw_exp - r_ccw;

%% Extract Data
% throttle
start_ccw_v = [8465 19722 34519 48055];
stop_ccw_v = [16356 24593 39929 51501];

start_cw_v = [9875 22047 36207 42558 58144 67292 75148 78325 86734 94451 98170 111319 114877 117325 122676 126431];
stop_cw_v = [16461 26328 40071 44255 62753 69507 78181 80598 89049 96946 100638 113754 115748 118431 126516 131023];

end