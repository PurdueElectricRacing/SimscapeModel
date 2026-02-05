function [res] = suspensionPts(x, p, L)
% UNKNOWN PTS
% rocker axis 2nd pt
x_U1 = x(1);
y_U1 = x(2);
z_U1 = x(3);

% push rod rocker end
x_U2 = x(4);
y_U2 = x(5);
z_U2 = x(6);

% damper to rocker point
x_U3 = x(7);
y_U3 = x(8);
z_U3 = x(9);

x_U4 = x(10);
y_U4 = x(11);
z_U4 = x(12);

% push rod wishbone end
x_U5 = x(13);
y_U5 = x(14);
z_U5 = x(15);

% upper wishbone outer ball joint
x_U6 = x(16);
y_U6 = x(17);
z_U6 = x(18);

% inner track road ball joint
x_U7 = x(19);
y_U7 = x(20);
z_U7 = x(21);

% lower wishbone outer ball joint
x_U8 = x(22);
y_U8 = x(23);
z_U8 = x(24);

x_G = x(25);
y_G = x(26);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIXED PTS
% damper to body point
%x_BR = p(1); % x of back right shock
%y_BR = p(2); % y of back right shock
%z_BR = p(3); % y of back right shock

x_1 = p(1);
y_1 = p(2);
z_1 = p(3);

x_2 = p(4);
y_2 = p(5);
z_2 = p(6);

% skipped 3 just because 

% rocker axis 1st pt
x_4 = p(7);
y_4 = p(8);
z_4 = p(9);

x_5 = p(10);
y_5 = p(11);
z_5 = p(12);

% upper wishbone front pivot
x_6 = p(13);
y_6 = p(14);
z_6 = p(15);

% upper wishbone rear pivot
x_7 = p(16);
y_7 = p(17);
z_7 = p(18);

% lower wishbone front pivot
x_8 = p(19);
y_8 = p(20);
z_8 = p(21);

% lower wishbone rear pivot
x_9 = p(22);
y_9 = p(23);
z_9 = p(24);

% outer track rod ball joint
x_10 = p(25);
y_10 = p(26);
z_10 = p(27);

% z at ground (known bottom of tire)
z_G = 0;

% RESIDUALS
% res(1) = (((x_U3-x_BR)^2+(y_U3-y_BR)^2+(z_U3-z_BR)^2) - L(1)^2); % for guessPt3
res(1) = (((x_U3-x_5)^2+(y_U3-y_5)^2+(z_U3-z_5)^2) - L(1)^2); % for guessPt3
res(2) = (((x_U3-x_4)^2+(y_U3-y_4)^2+(z_U3-z_4)^2) - L(2)^2); % for guessPt3
res(3) = (((x_U2-x_5)^2+(y_U2-y_5)^2+(z_U2-z_5)^2) - L(3)^2); % for guessPt2
res(4) = (((x_U2-x_4)^2+(y_U2-y_4)^2+(z_U2-z_4)^2) - L(4)^2); % for guessPt2
res(5) = (((x_U1-x_5)^2+(y_U1-y_5)^2+(z_U1-z_5)^2) - L(5)^2); % for guessPt1
res(6) = (((x_U1-x_4)^2+(y_U1-y_4)^2+(z_U1-z_4)^2) - L(6)^2); % for guessPt1
res(7) = (((x_U1-x_U2)^2+(y_U1-y_U2)^2+(z_U1-z_U2)^2) - L(7)^2); % for guessPt1/2
res(8) = (((x_U3-x_U2)^2+(y_U3-y_U2)^2+(z_U3-z_U2)^2) - L(8)^2); % for guessPt3/2
res(9) = (((x_U2-x_U5)^2+(y_U2-y_U5)^2+(z_U2-z_U5)^2) - L(9)^2); % for guessPt2/5
res(10) = (((x_U5-x_6)^2+(y_U5-y_6)^2+(z_U5-z_6)^2) - L(10)^2); % for guessPt5
res(11) = (((x_U5-x_U6)^2+(y_U5-y_U6)^2+(z_U5-z_U6)^2) - L(11)^2); % for guessPt5
res(12) = (((x_U6-x_6)^2+(y_U6-y_6)^2+(z_U6-z_6)^2) - L(12)^2); % for guessPt6
res(13) = (((x_U5-x_7)^2+(y_U5-y_7)^2+(z_U5-z_7)^2) - L(13)^2); % for guessPt5
res(14) = (((x_U6-x_7)^2+(y_U6-y_7)^2+(z_U6-z_7)^2) - L(14)^2); % for guessPt6
res(15) = (((x_U6-x_U7)^2+(y_U6-y_U7)^2+(z_U6-z_U7)^2) - L(15)^2); % for guessPt6/7
res(16) = (((x_U6-x_U8)^2+(y_U6-y_U8)^2+(z_U6-z_U8)^2) - L(16)^2); % for guessPt6/8
res(17) = (((x_U6-x_G)^2+(y_U6-y_G)^2+(z_U6-z_G)^2) - L(17)^2); % for guessPt6/9
res(18) = (((x_U7-x_U8)^2+(y_U7-y_U8)^2+(z_U7-z_U8)^2) - L(18)^2); % for guessPt7/8
res(19) = (((x_U7-x_G)^2+(y_U7-y_G)^2+(z_U7-z_G)^2) - L(19)^2); % for guessPt7/9
res(20) = (((x_U8-x_G)^2+(y_U8-y_G)^2+(z_U8-z_G)^2) - L(20)^2); % for guessPt8/9
res(21) = (((x_U7-x_10)^2+(y_U7-y_10)^2+(z_U7-z_10)^2) - L(21)^2); % for guessPt7
res(22) = (((x_U8-x_9)^2+(y_U8-y_9)^2+(z_U8-z_9)^2) - L(22)^2); % for guessPt8
res(23) = (((x_U8-x_8)^2+(y_U8-y_8)^2+(z_U8-z_8)^2) - L(23)^2); % for guessPt8
res(24) = (((x_U4-x_U1)^2+(y_U4-y_U1)^2+(z_U4-z_U1)^2) - L(24)^2); % for guessPt4/1
res(25) = (((x_U4-x_1)^2+(y_U4-y_1)^2+(z_U4-z_1)^2) - L(25)^2); % for guessPt4
res(26) = (((x_U4-x_2)^2+(y_U4-y_2)^2+(z_U4-z_2)^2) - L(26)^2); % for guessPt4
% res(28) = (((x_U4-x_6)^2+(y_U4-y_6)^2+(z_U4-z_6)^2) - L(28)^2); % for guessPt4
