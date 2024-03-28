%% Function Description
% This function computes the maximum torque envelope for the vehicle. Given
% data at max throttle acceleration at max battery voltage, the maximum
% motor torque curve is produced.

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
t = fctt31624(:,1);
T = fctt31624(:,2);
s = fctt31624(:,3);
V = fctt31624(:,7)*10;
V2 = sqrt(fctt31624(:,4).^2 + fctt31624(:,5).^2 + fctt31624(:,6).^2);
w = fctt31624(:,8:11);

%% View Raw Data
% figure;
% plot(T)
% 
% figure;
% plot(s)

% notes: the Wide open throttle (WOT) starting at index 10391, ending 10927
% is a good candidate for computing the torque.

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
w_WOT(:,1:2) = w_WOT(:,1:2).*(2*pi/60);
w_WOT(:,3:4) = w_WOT(:,3:4).*8.75;

%% View target data
% figure;
% plot(T_WOT)
% 
% figure;
% plot(s_WOT);
% 
% figure;
% plot(V_WOT)
% hold on
% plot(V2_WOT)
% 
% figure;
% plot(w_WOT)

%% Process Target Data
start_fit = 1;
stop_fit = 300;

t_WOT_fit = t_WOT(start_fit:stop_fit);
w_WOT_fit = 0.5*(w_WOT(start_fit:stop_fit,3) + w_WOT(start_fit:stop_fit,4)).*(0.2/8.75);
V_WOT_fit = V2_WOT(start_fit:stop_fit);

% plot(V_WOT_fit)

%% Fit the data
[xData, yData] = prepareCurveData( t_WOT_fit, V_WOT_fit );
ft = fittype( 'poly2' );
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'V_WOT_fit vs. t_WOT_fit', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 't_WOT_fit', 'Interpreter', 'none' );
ylabel( 'V_WOT_fit', 'Interpreter', 'none' );
grid on

V_WOT_smooth = feval(fitresult,t_WOT_fit);
A_WOT_Smooth = 2*fitresult.p1.*t_WOT_fit + fitresult.p2;
F_WOT_smooth = (2567./9.81).*A_WOT_Smooth;
T_WOT_smooth_motor = F_WOT_smooth.*0.2./8.75;

figure;
plot(A_WOT_Smooth)
ylabel("acceleration")

% figure;
% plot(F_WOT_smooth)
% ylabel("force")

figure;
plot(T_WOT_smooth_motor)
ylabel("torque")