%% Function Description
% Given a set of measurements from accelerometer while vehicle is static, 
% this function computes the transformation matrix R that fulfills the
% following relationship: R*a_imu_xyz = a_vehicle_xyz
% This is done by find R such that R*a_imu_xyz = [0;0;9.81] (roughly)

%% The Function
function R = ac_compute_R(ax, ay, az)
    % find a_imu_xyz
    ax_med = median(ax);
    ay_med = median(ay);
    az_med = median(az);

    XYZs = [ax_med;ay_med;az_med];

    % define a_vehicle_xyz
    XYZv = [0;0;sqrt(dot(XYZs,XYZs))];
    
    % Compute the angle between the two axis using dot product formula
    theta = acos(dot(XYZs,XYZv)/(norm(XYZv)^2));
    
    % Find an axis that is orthogonal to both axis using cross product, normalize
    u = cross(XYZs,XYZv);
    u = u/norm(u);
    
    % Compute cross product matrix
    ux = [0 -u(3) u(2); u(3) 0   -u(1); -u(2) u(1) 0];
    
    % Use Axis-Angle method to find the appropriate rotation matrix
    R = (cos(theta)*eye(3)) + (sin(theta)*ux) + ((1-cos(theta))*(u*(u')));
end