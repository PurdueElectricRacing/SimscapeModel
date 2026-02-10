vehicleCOG = [5 9 1];

pitch = pi/4;
roll = 0;
yaw = 0;

z = yaw;
y = pitch;
x = roll;

cx = cos(x);
sx = sin(x);
cy = cos(y);
sy = sin(y);
cz = cos(z);
sz = sin(z);

R = [cz*cy, cz*sy*sx-sz*cx, cz*sy*cx+sz*sx; ...
     sz*cy, sz*sy*sx+cz*cx, sz*sy*cx-cz*sx; ...
     -sy,   cy*sx,          cy*cx];

R'*[0 0 -1]'

function [new_pt] = convertCoords