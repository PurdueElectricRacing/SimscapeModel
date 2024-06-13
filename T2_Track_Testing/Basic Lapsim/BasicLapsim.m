%% Simulation Values
SOCVoltage = [5 30 50 65 75 82 86 90 94 97 100]; % Pack OC voltage [V]
SOCVals = 0:.1:1; % State of Charge [% Remaining]

BattCapacity = 1000; % Total Pack Capacity to 0 SOC [J]
RBatt = 1; % Battery Internal Resistance [Ω]

LoadCurrent= 1; % Current draw [A]
