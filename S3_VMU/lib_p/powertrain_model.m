function [dVoc, dVb, dAh] = powertrain_model(s, tau, model)
    % States
    wr = s(8);
    Voc = s(9);
    Vb = s(10);
    Ah = s(11);

    % Constants
    series = model.ns;  % number of battery cells in series
    parallel = model.np;  % number of battery cells in parallel
    irCell = model.ir;  % internal resistance of cell [Ω]
    cReg = model.cr;  % volatage regulating capacitor [F]

    % lookup tables
    Vcurve = model.vt; % voltage from charge disharged from cell
    Ptable = model.pt; % inverter power from motor speed and torque

    % Calculated values
    Rbatt = irCell * series / parallel; % total battery resistance [Ω]
    Im = Ptable(wr, tau(2)) * 2; % use lookup table, 2 motor powertrain

    % Derivatives
    dVb = 1/cReg * ((Voc-Vb)/Rbatt - Im);
    dVoc = differentiate(Vcurve, Ah) * series / parallel * Im / 3600;
    dAh = Im /3600;
end