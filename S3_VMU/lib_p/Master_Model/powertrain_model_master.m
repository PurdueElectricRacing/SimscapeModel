%% Function Description
% This function computes the electrical powertrain stuff. 
%
% Input: 
% s: state vector [11 1]
% tau: torque applied onto tire [2 1]
% wt: tire angular velocity [2 1]
% model: vehicle model constants
%
% Output:
% dVoc: time derivative of battery open circuit voltage
% dVb: time derivative of the battery terminal voltage
% dAh: time derivative of the battery capacity
% Im: total motor current
%
% Authors:
% Trevor Koessler
% Demetrius Gulewicz
%
% Last Modified: 11/09/24
% Last Author: Demetrius Gulewicz

%% The Function
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
    Pm = Ptable(wt.*model.gr, tau + model.gm.*wt); % Input power for each motor

    if ~model.regen_active
        Pm = max(0, Pm);
    end

    Im = (2*sum(Pm)) / Vb; % use lookup table, 4 motor powertrain

    % derivatives
    Ib = (Voc-Vb) / Rbatt;
    dVb = (1/cReg) * (Ib - Im);
    dVoc = ((differentiate(Vcurve, Ah) * series) / parallel) * (Ib / 3600);
    dAh = Ib / 3600;
end