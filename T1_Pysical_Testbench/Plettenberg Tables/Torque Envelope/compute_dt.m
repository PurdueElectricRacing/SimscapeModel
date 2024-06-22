%% Function Description
% This function computes the maximum torque envelope for the vehicle. Given
% data at max throttle acceleration at max battery voltage, the maximum
% motor torque curve is produced.

%% Set Constants
r = 0.2; % tire radius [m]
gr = 8.75; % gear ratio
m = 280; % vehicle mass [kg]

%% Import Data
opts = spreadsheetImportOptions("NumVariables", 15);
opts.Sheet = "data";
opts.DataRange = "A5:O30192";
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
fctt041424 = readtable("grissom_04_14_24.xlsx", opts, "UseExcel", false);
fctt041424 = table2array(fctt041424);
clear opts

%% Parse Data
t = fctt041424(:,1); % time (s)
T = fctt041424(:,2); % throttle (%)
s = fctt041424(:,3); % steering angle (deg)
V = sqrt(fctt041424(:,4).^2 + fctt041424(:,5).^2 + fctt041424(:,6).^2);
w = fctt041424(:,7:10); % wheel speed

%% View Raw Data
% figure;
% plot(T)
% 
% xlabel("time (s)")
% ylabel("Throttle (%)")
% 
% figure;
% plot(s)
% 
% xlabel("time (s)")
% ylabel("Steering Angle (deg)")

% notes: the Wide open throttle (WOT) starting at index 677, ending 1156
% is a good candidate for computing the torque. However, this test was
% conducted at an open circuit voltage of 272V, so performance is
% diminished

%% Get target data
start = 686;
stop = 1156;

t_WOT = t(start:stop); % time, seconds
T_WOT = T(start:stop); % throttle, percent
s_WOT = s(start:stop); % center column steering angle, deg
V_WOT = V(start:stop); % vehicle ground speed, m/s
w_WOT = w(start:stop,:); % wheel speed, [motor RPM motor RPM tire rad/s tire rad/s]

% convert wheel speed all to motor shaft rad/s
w_WOT(:,1:2) = w_WOT(:,1:2).*(pi/30);
w_WOT(:,3:4) = w_WOT(:,3:4).*gr;

%% View target data
% figure;
% plot(t_WOT,T_WOT)
% 
% xlabel("time (s)")
% ylabel("Throttle (%)")
% 
% figure;
% plot(t_WOT,s_WOT);
% 
% xlabel("time (s)")
% ylabel("Steering Angle (deg)")
% 
% figure;
plot(t_WOT,V_WOT)

xlabel("time (s)")
ylabel("Velocity")

%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( t_WOT, V_WOT );
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.9;
[fitresult, gof] = fit( xData, yData, ft, opts );

%% get finely discretized speed
dt = 0.01;
t0 = 10.29;
t = t0:dt:19;
V = feval(fitresult,t);

% plot(t, V)

%% get distance
x = cumsum(V)*dt;

plot(t-t0, x)