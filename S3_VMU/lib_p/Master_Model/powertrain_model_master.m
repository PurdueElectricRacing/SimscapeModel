function [dVoc, dVb, dAh, Im] = powertrain_model_master(s, tau, wt, model)
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
    ImF = Ptable(wt(1).*model.gr, tau(1));
    ImR = Ptable(wt(2).*model.gr, tau(2));

    if ~model.regen_active
        ImF = max(0, ImF);
        ImR = max(0, ImR);
    end

    Im = (2*(ImF + ImR)) / Vb; % use lookup table, 4 motor powertrain

    % derivatives
    Ib = (Voc-Vb) / Rbatt;
    dVb = (1/cReg) * (Ib - Im);
    dVoc = ((differentiate(Vcurve, Ah) * series) / parallel) * (Ib / 3600);
    dAh = (Voc-Vb) / Rbatt / 3600;
end