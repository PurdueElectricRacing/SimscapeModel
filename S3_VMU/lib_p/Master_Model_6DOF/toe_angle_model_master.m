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

function toe = compute_toe_master(p, CCSA_input)
    CCSA_input = 120.00;

    Toe1_An_deg = sign(CCSA_input)*abs(polyval(p, CCSA_input))
    % = sign(CCSA_input)*abs(p(1)*(CCSA_input^3) + p(2)*(CCSA_input^2) + p(3)*(CCSA_input) + p(4));
    Toe2_An_deg = sign(CCSA_input)*abs(polyval(p, (-CCSA_input)))
    % = sign(CCSA_input)*abs(p(1)*((-CCSA_input)^3) + p(2)*((-CCSA_input)^2) + p(3)*((-CCSA_input)) + p(4));
    Toe1_An_rad = deg2rad(Toe1_An_deg);
    Toe2_An_rad = deg2rad(Toe2_An_deg);

    toe = [Toe1_An_rad; Toe2_An_rad]

end


