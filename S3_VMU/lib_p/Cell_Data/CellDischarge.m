% Description:
%   Loads constant-current discharge curves for 21700 cell
%   Offsets battery voltage to obtain open-circuit voltage
%   Curve fit and export data

%% Import Data
% Imports data into arrays formatted:
%   [capacity drained {Ah}, batteryvoltage {V}]
A5 = table2array(readtable("21700 Constant-Current Discharge Curves.xlsx", Sheet="5A", ReadVariableNames=false)); % 5A Discharge
A10 = table2array(readtable("21700 Constant-Current Discharge Curves.xlsx", Sheet="10A", ReadVariableNames=false)); % 10A Discharge
A20 = table2array(readtable("21700 Constant-Current Discharge Curves.xlsx", Sheet="20A", ReadVariableNames=false)); % 20A Discharge
A30 = table2array(readtable("21700 Constant-Current Discharge Curves.xlsx", Sheet="30A", ReadVariableNames=false)); % 30 Discharge
A40 = table2array(readtable("21700 Constant-Current Discharge Curves.xlsx", Sheet="40A", ReadVariableNames=false)); % 40A Discharge
CellIR = 0.0144; % Cell Internal Resistance [Ω]

%% Plot Raw Data
figure(Name="Raw Dishcrage Curves")
title("Cell Constant Current Discharge Curves")
xlabel("Capacity Drained [Ah]")
ylabel("Cell Voltage [V]")
hold on
plot(A5(:,1),A5(:,2))
plot(A10(:,1),A10(:,2))
plot(A20(:,1),A20(:,2))
plot(A30(:,1),A30(:,2))
plot(A40(:,1),A40(:,2))
legend(["5A","10A","20A","30A","40A"])

%% Find Cell Open Circuit Voltage
% Add resistive loss to voltage
A5Voc = [A5(:,1) A5(:,2) + 5 * CellIR];
A10Voc = [A10(:,1) A10(:,2) + 10 * CellIR];
A20Voc = [A20(:,1) A20(:,2) + 20 * CellIR];
A30Voc = [A30(:,1) A30(:,2) + 30 * CellIR];
A40Voc = [A40(:,1) A40(:,2) + 40 * CellIR];

%% Plot Cell Open Circuit Voltage
figure(Name="Adjusted Discharge Curves")
title("Cell Constant Current Discharge Curves (Estimated Voc)")
xlabel("Capacity Drained [Ah]")
ylabel("Cell Estimated Open Circuit Voltage [V]")
hold on
plot(A5Voc(:,1), A5Voc(:,2))
plot(A10Voc(:,1), A10Voc(:,2))
plot(A20Voc(:,1), A20Voc(:,2))
plot(A30Voc(:,1), A30Voc(:,2))
plot(A40Voc(:,1), A40Voc(:,2))
legend(["5Aoc","10Aoc","20Aoc","30Aoc","40Aoc"])

%% Combine all Offset Data, Convert to Scatterplot
AllCurrentCapacity = [A5Voc(:,1); A10Voc(:,1);  A20Voc(:,1);  A30Voc(:,1);  A40Voc(:,1)];
AllCurrentVoc = [A5Voc(:,2); A10Voc(:,2); A20Voc(:,2); A30Voc(:,2); A40Voc(:,2)];

%% Fit: 'Discharge Curve'.
[xData, yData] = prepareCurveData( AllCurrentCapacity, AllCurrentVoc );

% Set up fittype and options.
ft = fittype( 'poly7' );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure(Name="Fitted Curve");
hold on

xPts = 0:.01:4.43;
plot(xPts, fitresult(xPts));
scatter(xData, yData,".")

% formating
xlabel('AllCurrentCapacity');
ylabel('AllCurrentVoc');
ylim([0,4.5])
legend(["Fitted Curve" "Raw Data"])
grid on

%% Export Curve Fit as .csv file

% interpoalte curve fit
AhDischarged = (0:.01:5)';
Voc = fitresult(AhDischarged);

% trim data to include only one negative voltage point
AhDischarged = AhDischarged(1:sum(Voc>0)+1);
Voc = Voc(1:sum(Voc>0)+1);

% lerp last point to have Voc = 0
x = Voc(end-1) / (Voc(end)-Voc(end-1));
AhDischarged(end) = x * (AhDischarged(end-1) - AhDischarged(end)) + AhDischarged(end-1);
Voc(end) = x * (Voc(end-1) - Voc(end)) + Voc(end-1);

% export data as csv
%writematrix([AhDischarged Voc], "CellVoltageCurve.csv")

% export data as .mat file
save("CellDischarge.mat", "fitresult")