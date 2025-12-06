function [F_members, F_reactions] = solveSusForces(x, p, L, F_tire, k_shock, L0_shock)
% x = known pts (26 vals)
% p = fixed pts (27 vals)
% F_tire = vertical force at ground contact
% k_shock = shock spring constant
% L0_shock = shock init length

% UNKNOWN PTS
% rocker axis 2nd pt
x_U1 = x(1); y_U1 = x(2); z_U1 = x(3);

% push rod rocker end
x_U2 = x(4); y_U2 = x(5); z_U2 = x(6);

% damper to rocker point
x_U3 = x(7); y_U3 = x(8); z_U3 = x(9);

x_U4 = x(10); y_U4 = x(11); z_U4 = x(12);

% push rod wishbone end
x_U5 = x(13); y_U5 = x(14); z_U5 = x(15);

% upper wishbone outer ball joint
x_U6 = x(16); y_U6 = x(17); z_U6 = x(18);

% inner track road ball joint
x_U7 = x(19); y_U7 = x(20); z_U7 = x(21);

% lower wishbone outer ball joint
x_U8 = x(22); y_U8 = x(23); z_U8 = x(24);

% tire ground contact
x_G = x(25); y_G = x(26);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIXED PTS
% ARB left side pt
x_1 = p(1); y_1 = p(2); z_1 = p(3);

% ARB right side pt
x_2 = p(4); y_2 = p(5); z_2 = p(6);

% skipped 3 just because 
% rocker axis 1st pt
x_4 = p(7); y_4 = p(8); z_4 = p(9);

x_5 = p(10); y_5 = p(11); z_5 = p(12);

% upper wishbone front pivot
x_6 = p(13); y_6 = p(14); z_6 = p(15);

% upper wishbone rear pivot
x_7 = p(16); y_7 = p(17); z_7 = p(18);

% lower wishbone front pivot
x_8 = p(19); y_8 = p(20); z_8 = p(21);

% lower wishbone rear pivot
x_9 = p(22); y_9 = p(23); z_9 = p(24);

% outer track rod ball joint
x_10 = p(25); y_10 = p(26); z_10 = p(27); 

% z at tire ground contact
z_G = 0;

% shock to body point
x_shock = p(28); % x of back right shock 
y_shock = p(29); % y of back right shock
z_shock = p(30); % y of back right shock

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LENGTHS
L(1) = sqrt((x_U3-x_5)^2+(y_U3-y_5)^2+(z_U3-z_5)^2);
L(2) = sqrt((x_U3-x_4)^2+(y_U3-y_4)^2+(z_U3-z_4)^2);
L(3) = sqrt((x_U2-x_5)^2+(y_U2-y_5)^2+(z_U2-z_5)^2);
L(4) = sqrt((x_U2-x_4)^2+(y_U2-y_4)^2+(z_U2-z_4)^2);
L(5) = sqrt((x_U1-x_5)^2+(y_U1-y_5)^2+(z_U1-z_5)^2);
L(6) = sqrt((x_U1-x_4)^2+(y_U1-y_4)^2+(z_U1-z_4)^2);
L(7) = sqrt((x_U1-x_U2)^2+(y_U1-y_U2)^2+(z_U1-z_U2)^2);
L(8) = sqrt((x_U3-x_U2)^2+(y_U3-y_U2)^2+(z_U3-z_U2)^2);
L(9) = sqrt((x_U2-x_U5)^2+(y_U2-y_U5)^2+(z_U2-z_U5)^2);
L(10) = sqrt((x_U5-x_6)^2+(y_U5-y_6)^2+(z_U5-z_6)^2);
L(11) = sqrt((x_U5-x_U6)^2+(y_U5-y_U6)^2+(z_U5-z_U6)^2);
L(12) = sqrt((x_U6-x_6)^2+(y_U6-y_6)^2+(z_U6-z_6)^2);
L(13) = sqrt((x_U5-x_7)^2+(y_U5-y_7)^2+(z_U5-z_7)^2);
L(14) = sqrt((x_U6-x_7)^2+(y_U6-y_7)^2+(z_U6-z_7)^2);
L(15) = sqrt((x_U6-x_U7)^2+(y_U6-y_U7)^2+(z_U6-z_U7)^2);
L(16) = sqrt((x_U6-x_U8)^2+(y_U6-y_U8)^2+(z_U6-z_U8)^2);
L(17) = sqrt((x_U6-x_G)^2+(y_U6-y_G)^2+(z_U6-z_G)^2);
L(18) = sqrt((x_U7-x_U8)^2+(y_U7-y_U8)^2+(z_U7-z_U8)^2);
L(19) = sqrt((x_U7-x_G)^2+(y_U7-y_G)^2+(z_U7-z_G)^2);
L(20) = sqrt((x_U8-x_G)^2+(y_U8-y_G)^2+(z_U8-z_G)^2);
L(21) = sqrt((x_U7-x_10)^2+(y_U7-y_10)^2+(z_U7-z_10)^2);
L(22) = sqrt((x_U8-x_9)^2+(y_U8-y_9)^2+(z_U8-z_9)^2);
L(23) = sqrt((x_U8-x_8)^2+(y_U8-y_8)^2+(z_U8-z_8)^2);
L(24) = sqrt((x_U4-x_U1)^2+(y_U4-y_U1)^2+(z_U4-z_U1)^2);
L(25) = sqrt((x_U4-x_1)^2+(y_U4-y_1)^2+(z_U4-z_1)^2);
L(26) = sqrt((x_U4-x_2)^2+(y_U4-y_2)^2+(z_U4-z_2)^2);

% additional shock length (could be specified) 
L(27) = sqrt((x_U3-x_shock)^2+(y_U3-y_shock)^2+(z_U3-z_shock)^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UNIT VECTORS
% shock separate from rest
unit_shock = [x_U3 - x_shock; y_U3 - y_shock; z_U3 - z_shock] / L(27);

unit_U3to5 = [x_U3 - x_5; y_U3 - y_5; z_U3 - z_5] / L(1);
unit_U3to4 = [x_U3 - x_4; y_U3 - y_4; z_U3 - z_4] / L(2);
unit_U2to5 = [x_U2 - x_5; y_U2 - y_5; z_U2 - z_5] / L(3);
unit_U2to4 = [x_U2 - x_4; y_U2 - y_4; z_U2 - z_4] / L(4);
unit_U1to5 = [x_U1 - x_5; y_U1 - y_5; z_U1 - z_5] / L(5);
unit_U1to4 = [x_U1 - x_4; y_U1 - y_4; z_U1 - z_4] / L(6);
unit_U1toU2 = [x_U1 - x_U2; y_U1 - y_U2; z_U1 - z_U2] / L(7);
unit_U3toU2 = [x_U3 - x_U2; y_U3 - y_U2; z_U3 - z_U2] / L(8);
unit_U2toU5 = [x_U2 - x_U5; y_U2 - y_U5; z_U2 - z_U5] / L(9);
unit_U5to6 = [x_U5 - x_6; y_U5 - y_6; z_U5 - z_6] / L(10);
unit_U5toU6 = [x_U5 - x_U6; y_U5 - y_U6; z_U5 - z_U6] / L(11);
unit_U6to6 = [x_U6 - x_6; y_U6 - y_6; z_U6 - z_6] / L(12);
unit_U5to7 = [x_U5 - x_7; y_U5 - y_7; z_U5 - z_7] / L(13);
unit_U6to7 = [x_U6 - x_7; y_U6 - y_7; z_U6 - z_7] / L(14);
unit_U6toU7 = [x_U6 - x_U7; y_U6 - y_U7; z_U6 - z_U7] / L(15);
unit_U6toU8 = [x_U6 - x_U8; y_U6 - y_U8; z_U6 - z_U8] / L(16);
unit_U6toG = [x_U6 - x_G; y_U6 - y_G; z_U6 - z_G] / L(17);
unit_U7toU8 = [x_U7 - x_U8; y_U7 - y_U8; z_U7 - z_U8] / L(18);
unit_U7toG = [x_U7 - x_G; y_U7 - y_G; z_U7 - z_G] / L(19);
unit_U8toG = [x_U8 - x_G; y_U8 - y_G; z_U8 - z_G] / L(20);
unit_U7to10 = [x_U7 - x_10; y_U7 - y_10; z_U7 - z_10] / L(21);
unit_U8to9 = [x_U8 - x_9; y_U8 - y_9; z_U8 - z_9] / L(22);
unit_U8to8 = [x_U8 - x_8; y_U8 - y_8; z_U8 - z_8] / L(23);
unit_U4toU1 = [x_U4 - x_U1; y_U4 - y_U1; z_U4 - z_U1] / L(24);
unit_U4to1 = [x_U4 - x_1; y_U4 - y_1; z_U4 - z_1] / L(25);
unit_U4to2 = [x_U4 - x_2; y_U4 - y_2; z_U4 - z_2] / L(26);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Shock force
L_shock_current = L(27);  % current shock length
F_shock = k_shock * (L_shock_current - L0_shock);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forces in non-fixed members 
F_members(1) = F_U1U2;
F_members(2) = F_U4U1;
F_members(3) = F_U3U2;
F_members(4) = F_U2U5;
F_members(5) = F_U5U6;
F_members(6) = F_U6U7;
F_members(7) = F_U6U8;
F_members(8) = F_U7U8;
F_members(9) = F_U6G;
F_members(10) = F_U7G;
F_members(11) = F_U8G;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reactions
F_reactions(1) = R_U1_5;
F_reactions(2) = R_U1_4;
F_reactions(3) = R_U2_5;
F_reactions(4) = R_U2_4;
F_reactions(5) = R_U3_5;
F_reactions(6) = R_U3_4;
F_reactions(7) = R_U4_1;
F_reactions(8) = R_U4_2;
F_reactions(9) = R_U5_6;
F_reactions(10) = R_U5_7;
F_reactions(11) = R_U6_6;
F_reactions(12) = R_U6_7;
F_reactions(13) = R_U7_10;
F_reactions(14) = R_U8_9;
F_reactions(15) = R_U8_8;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EQUILIBRIUM EQUATIONS
% structure (using node U3 [damper to rocker pt] as example)
% Forces acting on U3:
%   - F(1) along link to x_5
%   - F(2) along link to x_4  
%   - F(8) along link to U2
%   - Shock force F_shock (specify this)

% U1 equilibrium:
eqU1_x = F_reactions(1)*unit_U1to5(1) + F_reactions(2)*unit_U1to4(1) + ...
    F_members(1)*unit_U1toU2(1) + F_members(2)*unit_U4toU1(1);
eqU1_y = F_reactions(1)*unit_U1to5(2) + F_reactions(2)*unit_U1to4(2) + ...
    F_members(1)*unit_U1toU2(2) + F_members(2)*unit_U4toU1(2);
eqU1_z = F_reactions(1)*unit_U1to5(3) + F_reactions(2)*unit_U1to4(3) + ...
    F_members(1)*unit_U1toU2(3) + F_members(2)*unit_U4toU1(3);

% U2 equilibrium:
eqU2_x = F_reactions(3)*unit_U2to5(1) + F_reactions(4)*unit_U2to4(1) + ...
    F_members(1)*unit_U1toU2(1) + F_members(3)*unit_U3toU2(1) + ...
    F_members(4)*unit_U2toU5(1);
eqU2_y = F_reactions(3)*unit_U2to5(2) + F_reactions(4)*unit_U2to4(2) + ...
    F_members(1)*unit_U1toU2(2) + F_members(3)*unit_U3toU2(2) + ...
    F_members(4)*unit_U2toU5(2);
eqU2_z = F_reactions(3)*unit_U2to5(3) + F_reactions(4)*unit_U2to4(3) + ...
    F_members(1)*unit_U1toU2(3) + F_members(3)*unit_U3toU2(3) + ...
    F_members(4)*unit_U2toU5(3);

% U3 equilibrium:
eqU3_x = F_reactions(5)*unit_U3to5(1) + F_reactions(6)*unit_U3to4(1) + ...
    F_members(3)*unit_U3toU2(1) + F_shock*unit_shock(1);
eqU3_y = F_reactions(5)*unit_U3to5(2) + F_reactions(6)*unit_U3to4(2) + ...
    F_members(3)*unit_U3toU2(2) + F_shock*unit_shock(2);
eqU3_z = F_reactions(5)*unit_U3to5(3) + F_reactions(6)*unit_U3to4(3) + ...
    F_members(3)*unit_U3toU2(3) + F_shock*unit_shock(3);

% U4 equilibrium:
eqU4_x = F_members(2)*unit_U4toU1(1) + F_reactions(7)*unit_U4to1(1) + ...
    F_reactions(8)*unit_U4to2(1);
eqU4_y = F_members(2)*unit_U4toU1(2) + F_reactions(7)*unit_U4to1(2) + ...
    F_reactions(8)*unit_U4to2(2);
eqU4_z = F_members(2)*unit_U4toU1(3) + F_reactions(7)*unit_U4to1(3) + ...
    F_reactions(8)*unit_U4to2(3);

% U5 equilibrium:
eqU5_x = F_members(4)*unit_U2toU5(1) + F_reactions(9)*unit_U5to6(1) + ...
    F_members(5)*unit_U5toU6(1) + F_reactions(10)*unit_U5to7(1);
eqU5_y = F_members(4)*unit_U2toU5(2) + F_reactions(9)*unit_U5to6(2) + ...
    F_members(5)*unit_U5toU6(2) + F_reactions(10)*unit_U5to7(2);
eqU5_z = F_members(4)*unit_U2toU5(3) + F_reactions(9)*unit_U5to6(3) + ...
    F_members(5)*unit_U5toU6(3) + F_reactions(10)*unit_U5to7(3);

% U6 equilibrium:
eqU6_x = F_members(5)*unit_U5toU6(1) + F_reactions(11)*unit_U6to6(1) + ...
    F_reactions(12)*unit_U6to7(1) + F_members(6)*unit_U6toU7(1) + ...
    F_members(7)*unit_U6toU8(1) + F_members(9)*unit_U6toG(1);
eqU6_y = F_members(5)*unit_U5toU6(2) + F_reactions(11)*unit_U6to6(2) + ...
    F_reactions(12)*unit_U6to7(2) + F_members(6)*unit_U6toU7(2) + ...
    F_members(7)*unit_U6toU8(2) + F_members(9)*unit_U6toG(2);
eqU6_z = F_members(5)*unit_U5toU6(3) + F_reactions(11)*unit_U6to6(3) + ...
    F_reactions(12)*unit_U6to7(3) + F_members(6)*unit_U6toU7(3) + ...
    F_members(7)*unit_U6toU8(3) + F_members(9)*unit_U6toG(3);

% U7 equilibrium:
eqU7_x = F_members(6)*unit_U6toU7(1) + F_members(8)*unit_U7toU8(1) + ...
    F_members(10)*unit_U7toG(1) + F_reactions(13)*unit_U7to10(1);
eqU7_y = F_members(6)*unit_U6toU7(2) + F_members(8)*unit_U7toU8(2) + ...
    F_members(10)*unit_U7toG(2) + F_reactions(13)*unit_U7to10(2);
eqU7_z = F_members(6)*unit_U6toU7(3) + F_members(8)*unit_U7toU8(3) + ...
    F_members(10)*unit_U7toG(3) + F_reactions(13)*unit_U7to10(3);

% U8 equilibrium:
eqU8_x = F_members(7)*unit_U6toU8(1) + F_members(8)*unit_U7toU8(1) + ...
    F_members(11)*unit_U8toG(1) + F_reactions(14)*unit_U8to9(1) + ...
    F_reactions(15)*unit_U8to8(1);
eqU8_y = F_members(7)*unit_U6toU8(2) + F_members(8)*unit_U7toU8(2) + ...
    F_members(11)*unit_U8toG(2) + F_reactions(14)*unit_U8to9(2) + ...
    F_reactions(15)*unit_U8to8(2);
eqU8_z = F_members(7)*unit_U6toU8(3) + F_members(8)*unit_U7toU8(3) + ...
    F_members(11)*unit_U8toG(3) + F_reactions(14)*unit_U8to9(3) + ...
    F_reactions(15)*unit_U8to8(3);

% G equilibrium:
eqG_x = F_members(9)*unit_U6toG(1) + F_members(10)*unit_U7toG(1) + ...
    F_members(11)*unit_U8toG(1);
eqG_y = F_members(9)*unit_U6toG(1) + F_members(10)*unit_U7toG(1) + ...
    F_members(11)*unit_U8toG(1);
eqG_z = F_members(9)*unit_U6toG(1) + F_members(10)*unit_U7toG(1) + ...
    F_members(11)*unit_U8toG(1) + F_tire;
