function [dVoc, dVb, dAh, Im] = powertrain_model_master(s, tau, w, model)
    % states
    Voc = s(9);
    Vb = s(10);
    Ah = s(11);

    % constants
    series = model.ns;  % number of battery cells in series
    parallel = model.np;  % number of battery cells in parallel
    irCell = model.ir;  % internal resistance of cell [Ω]
    cReg = model.cr;  % volatage regulating capacitor [F]

    % lookup tables
    Vcurve = model.vt; % voltage from charge discharged from cell
    Ptable = model.pt; % inverter power from motor speed and torque

    % calculated values
    Rbatt = irCell * series / parallel; % total battery resistance [Ω]
    Im = 2 * (Ptable(w(1).*model.gr, tau(1)) + Ptable(w(2).*model.gr, tau(2))) / Vb; % use lookup table, 4 motor powertrain

    % derivatives
    Ib = (Vb-Voc) / Rbatt;
    dVb = (1/cReg) * ((Voc-Vb)/Rbatt - Im);
    dVoc = ((differentiate(Vcurve, Ah) * series) / parallel) * (Ib / 3600);
    dAh = (Voc-Vb) / Rbatt / 3600;
end