% given lengths of sus beams and angle of A-arm_lower_front with vehicle reference frame,
% calculate the position of lower suspension points to find wheel position

% f       matrix of fixed points [N 3]
% l       list of lengths
% alpha   angle of link 2 with horizontal plane
function pts = calculate_lower(fixed, l, alpha)
    a = fixed(1, :);
    b = fixed(2, :);
    c = fixed(3, :);
    d = fixed(4, :);
    e = fixed(5, :);
    
    % calculate z-coordinate of point 1
    z1 = l(2) * sin(alpha) + a(3);

    % solve point 1 given its z-coord; normal vector of plane is z-axis
    [t1, t2] = sphere_sphere_plane(a, b, l(1), l(2), [0 0 1], z1);
    % pick point with largest |y|
    if abs(t1(2)) >= abs(t2(2))
        p1 = t1;
    else
        p1 = t2;
    end

    % solve point 4 given c, d, p1
    [t1, t2] = trilaterate(c, d, p1, l(3), l(4), l(5));
    % pick point with largest |y|
    if abs(t1(2)) >= abs(t2(2))
        p4 = t1;
    else
        p4 = t2;
    end

    % solve point 3 given e, p1, p4
    [t1, t2] = trilaterate(e, p1, p4, l(8), l(7), l(6));
    % pick point with largest |y|
    if abs(t1(2)) >= abs(t2(2))
        p3 = t1;
    else
        p3 = t2;
    end

    % solve point 2 given p1, p3, p4
    [t1, t2] = trilaterate(p1, p3, p4, l(10), l(9), l(11));
    % pick point with largest |y|
    if abs(t1(2)) >= abs(t2(2))
        p2 = t1;
    else
        p2 = t2;
    end

    pts = [p1; p2; p3; p4];