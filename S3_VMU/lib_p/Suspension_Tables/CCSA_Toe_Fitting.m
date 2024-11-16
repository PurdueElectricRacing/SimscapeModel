% All infput angle data for CCSA and Tire Toe Angle is in degrees
% datatable = Data read from CSV for steering angle and Toe Angle of tyres
% CCSA_deg = Centre Column Steering Angle (deg)
% Tire1_deg = Tire1 Toe Angle (deg)
% Tire2_deg = Tire2 Toe Angle (deg)
% CCSA_x = CCSA_Deg data from datatable
% Toe_y = Tire1 Toe Angle data from datatable
% p = variable storing polyfit coefficients
% f1 = variable storing values evaluated by polyval for graphing
% CCSA_input = CCSA (deg) being input to obtain a Toe Angle 
% Toe_An_deg = Toe Angle calculated for input CCSA based on polyfit (deg)
% Toe_An_rad = Toe Angle in Radians (rad)


datatable = readtable('PER-CCSA-data.csv');
CCSA_x = datatable.CCSA_deg_;
Toe_y = datatable.Tire1_deg_;
p = polyfit(CCSA_x,Toe_y,3);
f1 = polyval(p, CCSA_x);
plot(CCSA_x,Toe_y,'o');
hold on;
plot(CCSA_x,f1,'r--');

CCSA_input = 120.00;

Toe_An_deg = p(1)*(CCSA_input^3) + p(2)*(CCSA_input^2) + p(3)*(CCSA_input) + p(4);

Toe_An_rad = deg2rad(Toe_An_deg);

save('ToeAngleFit.mat', 'p');

