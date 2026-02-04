% given lengths of sus beams and z height of point 1,
% calculate the position of all other suspensoin points

% f    matrix of fixed points [N 3]
% l    list of lengths
% z1   z coordinate of node 1
function pts = solveSusPoints(f, l, alpha)
    a = f(1, :);
    b = f(2, :);
    c = f(3, :);
    d = f(4, :);
    e = f(5, :);
    
    % calculate z-coordinate of point 1
    z1 = l(2) * sin(alpha) + b(3);

    % solve point 1 given its z-coord
    [t1, t2] = sphere_sphere_plane(a, b, l(1), l(2), z1);
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
    % pick point with smallest |x|
    if t1(1) <= t2(1)
        p2 = t1;
    else
        p2 = t2;
    end

    pts = [p1; p2; p3; p4];