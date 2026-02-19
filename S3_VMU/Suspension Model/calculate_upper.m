% given lengths of sus beams and angle of A-arm_lower_front with vehicle reference frame,
% calculate the position of lower suspension points to find wheel position

% f       matrix of fixed points [N 3]
% l       list of lengths
% s       matrix of points solved for previously [p4]
function pts = calculate_lower(f, p, l, s)
    f = f(6, :);
    g = f(7, :);
    h = f(8, :);

    p4 = s(1,:);

    fn = p(1, 1:3);
    fp = p(1, 4);
    hn = p(2, 1:3);
    hp = p(2, 4);

    % solve point 5 given c, d, p4
    [t1, t2] = trilaterate(c, d, p4, l(12), l(13), l(14));
    % pick point with min x
    if t1(1) >= t2(1)
        p5 = t1;
    else
        p5 = t2;
    end

    % solve point 6 given f, p5, rocker plane fn dot x = fp
    [t1, t2] = sphere_sphere_plane(f, p5, l(16), l(15), fn, fp);
    % pick point with largest z
    if t1(3) <= t2(3)
        p6 = t1;
    else
        p6 = t2;
    end



    pts = [p1; p2; p3; p4];