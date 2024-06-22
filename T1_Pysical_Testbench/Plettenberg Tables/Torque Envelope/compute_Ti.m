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
% 
% figure;
% plot(t_WOT,w_WOT)
% 
% xlabel("time (s)")
% ylabel("Wheel Speed")
% legend("Left MC", "Right MC", "Left Disc", "Right Disc")

%% Process Target Data
start_fit = 1;
stop_fit = 280;

t_WOT_fit = t_WOT(start_fit:stop_fit) - t_WOT(start_fit);
w_WOT_fit = 0.5*(w_WOT(start_fit:stop_fit,3) + w_WOT(start_fit:stop_fit,4)).*(r/gr);
V_WOT_fit = V_WOT(start_fit:stop_fit);

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

xlabel("Time (s)")
ylabel("Chassis Longitudinal Acceleration (m/s^2)")

figure;
plot(t_WOT_fit, F_WOT_smooth)

xlabel("Time (s)")
ylabel("Net Force (N)")

figure;
plot(t_WOT_fit, T_WOT_smooth_motor)

xlabel("Time (s)")
ylabel("Net Torque (Nm)")

figure;
plot(V_WOT_smooth.*gr./r, T_WOT_smooth_motor)

xlabel("Motor Shaft Speed (rad/s)")
ylabel("Motor Torque (Nm)")

%% compute max torque available
mux = 1.3;
wb = 1.535; % m
wbf = .54*wb;
wbr = .46*wb;

Fn = m*9.81/4;
FN_r = (2*Fn*wbf - (m.*A_WOT_Smooth./2)) ./ (wbr + wbf);
Tr_r = FN_r*mux*(r/gr);

figure;
plot(t_WOT_fit,Tr_r,"Color","black","LineStyle","-")
hold on
plot(t_WOT_fit, T_WOT_smooth_motor,"Color","#D7031C","LineStyle","--")

xlabel("Time (s)")
ylabel("Net Torque (Nm)")
legend("Max","Experiment")