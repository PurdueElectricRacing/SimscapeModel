vehicleCOG = [5 9 1];

n = [0 0 1];


conv = @convertCoords;

function [new_pt] = convertCoords(pt, pitch, roll, yaw)
    zrot = yaw;
    yrot = pitch;
    xrot = -roll;
    
    cx = cos(xrot);
    sx = sin(xrot);
    cy = cos(yrot);
    sy = sin(yrot);
    cz = cos(zrot);
    sz = sin(zrot);
    
    R = [cz*cy, cz*sy*sx-sz*cx, cz*sy*cx+sz*sx; ...
         sz*cy, sz*sy*sx+cz*cx, sz*sy*cx-cz*sx; ...
         -sy,   cy*sx,          cy*cx]';

    % pt = pt .* [1 1 -1]; % flip z coordinates
    new_pt = R * pt'; % transform
    % new_pt = new_pt .* [1 1 -1]'; % re-flip z
end