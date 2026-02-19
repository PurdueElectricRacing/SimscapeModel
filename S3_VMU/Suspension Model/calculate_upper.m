% given lengths of sus beams and angle of A-arm_lower_front with vehicle reference frame,
% calculate the position of lower suspension points to find wheel position

% f       matrix of fixed points [N 3]
% p       planes [fn_x fn_y fn_z fp; hn_x hn_y hn_z hp]
% l       list of lengths
% s       matrix of points solved for previously [p4]
function pts = calculate_upper(fixed, l, planes, s)


    c = fixed(3, :);
    d = fixed(4, :);
    f = fixed(6, :);
    g = fixed(7, :);
    h = fixed(8, :);

    p4 = s(1,:);

    fn = planes(1, 1:3);
    fp = planes(1, 4);
    hn = planes(2, 1:3);
    hp = planes(2, 4);

    % solve point 5 given c, d, p4
    [t1, t2] = trilaterate(c, d, p4, l(12), l(13), l(14));
    % pick point with min x
    if t1(1) >= t2(1)
        p5 = t1;
    else
        p5 = t2;
    end

    % solve point 6 given f, p5, rocker plane fn dot x = fp
    [t1, t2] = sphere_sphere_plane(f, p5, l(17), l(15), fn, fp);
    % pick point with largest z
    if t1(3) >= t2(3)
        p6 = t1;
    else
        p6 = t2;
    end

    
    % solve point 7 given f, p6, rocker plane fn dot x = fp
    [t1, t2] = sphere_sphere_plane(f, p6, l(19), l(16), fn, fp);
    % pick point with largest z
    if t1(3) >= t2(3)
        p7 = t1;
    else
        p7 = t2;
    end

    % solve point 9 given h, 7, ARB plane hn dot x = hp
    [t1, t2] = sphere_sphere_plane(h, p7, l(22), l(21), hn, hp);
    % pick point with smaller z
    if t1(3) <= t2(3)
        p9 = t1;
    else
        p9 = t2;
    end

    % solve point 8 fiven fn, 6, rocker plane fn dot x = fp
    [t1, t2] = sphere_sphere_plane(f, p6, l(20), l(18), fn, fp);
    % pick point with larger z
    if t1(3) <= t2(3)
        p8 = t1;
    else
        p8 = t2;
    end


    pts = [p5; p6; p7; p8; p9];