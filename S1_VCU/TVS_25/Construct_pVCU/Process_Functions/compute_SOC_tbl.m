% Description:
%   Loads constant-current discharge curves for 21700 cell
%   Offsets battery voltage to obtain open-circuit voltage
%   Curve fit and export data
%   Data source:https://www.e-cigarette-forum.com/threads/bench-test-results-molicel-p45b-50a-4500mah-21700%E2%80%A6an-incredible-cell.974244/

function [Voc, AsDischarged] = compute_SOC_tbl()
    %% Import Data
    % Imports data into arrays formatted:
    %   [capacity drained {Ah}, batteryvoltage {V}]
    A5 = table2array(readtable("P45B-21700 Constant-Current Discharge Curves.xlsx", Sheet="5A", ReadVariableNames=false)); % 5A Discharge
    A10 = table2array(readtable("P45B-21700 Constant-Current Discharge Curves.xlsx", Sheet="10A", ReadVariableNames=false)); % 10A Discharge
    A20 = table2array(readtable("P45B-21700 Constant-Current Discharge Curves.xlsx", Sheet="20A", ReadVariableNames=false)); % 20A Discharge
    A30 = table2array(readtable("P45B-21700 Constant-Current Discharge Curves.xlsx", Sheet="30A", ReadVariableNames=false)); % 30 Discharge
    A40 = table2array(readtable("P45B-21700 Constant-Current Discharge Curves.xlsx", Sheet="40A", ReadVariableNames=false)); % 40A Discharge
    CellIR = 0.0093; % Cell Internal Resistance [Ω]
    
    %% Find Cell Open Circuit Voltage
    % Add resistive loss to voltage
    A5Voc = [A5(:,1) A5(:,2) + 5 * CellIR];
    A10Voc = [A10(:,1) A10(:,2) + 10 * CellIR];
    A20Voc = [A20(:,1) A20(:,2) + 20 * CellIR];
    A30Voc = [A30(:,1) A30(:,2) + 30 * CellIR];
    A40Voc = [A40(:,1) A40(:,2) + 40 * CellIR];
    
    %% Combine all Offset Data, Convert to Scatterplot
    AllCurrentCapacity = [A5Voc(:,1); A10Voc(:,1);  A20Voc(:,1);  A30Voc(:,1);  A40Voc(:,1)].*3600;
    AllCurrentVoc = [A5Voc(:,2); A10Voc(:,2); A20Voc(:,2); A30Voc(:,2); A40Voc(:,2)];
    
    %% Fit: 'Discharge Curve'.
    [xData, yData] = prepareCurveData( AllCurrentCapacity, AllCurrentVoc );
    
    % Set up fittype and options.
    ft = fittype( 'poly7' );
    
    % Fit model to data.
    [VAscurve, ~] = fit(xData, yData, ft);
    
    % interpolate curve fit
    AsDischarged = (0:.01:5.25)*3600;
    Voc = VAscurve(AsDischarged);
    
    % trim data to include only one negative voltage point
    AsDischarged = AsDischarged(1:sum(Voc>0)+1);
    Voc = Voc(1:sum(Voc>0)+1);
    
    % interp last point to have Voc = 0
    x = Voc(end-1) / (Voc(end)-Voc(end-1));
    AsDischarged(end) = x * (AsDischarged(end-1) - AsDischarged(end)) + AsDischarged(end-1);
    Voc(end) = x * (Voc(end-1) - Voc(end)) + Voc(end-1);
end