%% Function Description
% This function computes the maximum torque envelope for the vehicle. Given
% data at max throttle acceleration at max battery voltage, the maximum
% motor torque curve is produced.

%% Set Constants
r = 0.2; % tire radius [m]
gr = 8.75; % gear ratio
m = 262; % vehicle mass [kg]

%% Import Data
opts = spreadsheetImportOptions("NumVariables", 11);
opts.Sheet = "data";
opts.DataRange = "A5:K31984";
opts.VariableNames = ["VarName1", "Main", "Main_1", "Main_2", "Main_3", "Main_4", "Main_5", "Main_6", "Main_7", "Main_8", "Main_9"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
fctt31624 = readtable("fctt_3_16_24.xlsx", opts, "UseExcel", false);
fctt31624 = table2array(fctt31624);
clear opts

%% Parse Data
t = fctt31624(:,1); % time (s)
T = fctt31624(:,2); % throttle (%)
s = fctt31624(:,3); % steering angle (deg)
V = fctt31624(:,7); % gps ground speed (m/s)
V2 = sqrt(fctt31624(:,4).^2 + fctt31624(:,5).^2 + fctt31624(:,6).^2);
w = fctt31624(:,8:11); % wheel speed

%% View Raw Data
% figure;
% plot(t,T)
% 
% xlabel("time (s)")
% ylabel("Throttle (%)")
% 
% figure;
% plot(t,s)
% 
% xlabel("time (s)")
% ylabel("Steering Angle (deg)")

% notes: the Wide open throttle (WOT) starting at index 10391, ending 10927
% is a good candidate for computing the torque. However, this test was
% conducted at an open circuit voltage of 272V, so performance is
% diminished

%% Get target data
start = 10391+10;
stop = 10927;

t_WOT = t(start:stop); % time, seconds
T_WOT = T(start:stop); % throttle, percent
s_WOT = s(start:stop); % center column steering angle, deg
V_WOT = V(start:stop); % vehicle ground speed, m/s
V2_WOT = V2(start:stop); % vehicle ground speed, m/s
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
% plot(t_WOT,V_WOT)
% hold on
% plot(t_WOT,V2_WOT)
% 
% xlabel("time (s)")
% ylabel("Velocity")
% legend("GPS Ground Speed", "GPS Magnitude")
% 
% figure;
% plot(t_WOT,w_WOT)
% 
% xlabel("time (s)")
% ylabel("Wheel Speed")
% legend("Left MC", "Right MC", "Left Disc", "Right Disc")

%% Process Target Data
start_fit = 1;
stop_fit = 300;

t_WOT_fit = t_WOT(start_fit:stop_fit);
w_WOT_fit = 0.5*(w_WOT(start_fit:stop_fit,3) + w_WOT(start_fit:stop_fit,4)).*(r/gr);
V_WOT_fit = V2_WOT(start_fit:stop_fit);

% figure;
% plot(V_WOT_fit)
% 
% xlabel("time (s)")
% ylabel("Velocity")

%% Fit the data (can also be done with polyval)
[xData, yData] = prepareCurveData( t_WOT_fit, V_WOT_fit );
ft = fittype( 'poly2' );
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure;
plot( fitresult, xData, yData );
legend('raw', 'fit', 'Location', 'best');
xlabel( 'time (s)');
ylabel( 'Velocity (m/s)');
grid on

% compute acceleration by differentiating the polynomial fit of velocity
V_WOT_smooth = feval(fitresult,t_WOT_fit);
A_WOT_Smooth = 2*fitresult.p1.*t_WOT_fit + fitresult.p2;
F_WOT_smooth = m.*A_WOT_Smooth;
T_WOT_smooth_motor = F_WOT_smooth.*(r/gr);

%% View Results
figure;
plot(t_WOT_fit, A_WOT_Smooth)

xlabel("time (s)")
ylabel("acceleration (m/s^2)")

figure;
plot(t_WOT_fit, F_WOT_smooth)
ylabel("Net Force (N)")

figure;
plot(t_WOT_fit, T_WOT_smooth_motor)
ylabel("Net Torque (Nm)")