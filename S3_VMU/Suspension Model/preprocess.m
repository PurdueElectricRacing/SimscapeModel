function [FL_fixed, FL_planes, FL_lengths] = preprocess(sus_data_FL)
%PREPROCESS Summary of this function goes here
%   Detailed explanation goes here

    % read in sus point data
    % description of what each point is in file
    C = readmatrix("sus_data_FL.csv", NumHeaderLines=1, Range="C:E"); % coordinates

    % fixed points, mounted to chassis [letters]
    a = C(1,:);
    b = C(2,:);
    c = C(4,:);
    d = C(5,:);
    e = C(7,:);
    f = C(9,:);
    g = C(12,:);
    h = C(16,:);

    % free points starting position, used to calculate lengths [p#]
    p1 = C(3,:);
    p2 = C(17,:);
    p3 = C(8,:);
    p4 = C(6,:);
    p5 = C(13,:);
    p6 = C(10,:);
    p7 = C(14,:);
    p8 = C(11,:);
    p9 = C(15,:);

    % calculate lengths [l start end]
    la1 = norm(a-p1);
    lb1 = norm(b-p1);
    lc4 = norm(c-p4);
    ld4 = norm(d-p4);
    le3 = norm(e-p3);
    l12 = norm(p1-p2);
    l13 = norm(p1-p3);
    l14 = norm(p1-p4);
    l23 = norm(p2-p3);
    l24 = norm(p2-p4);
    l34 = norm(p3-p4);
    lc5 = norm(c-p5);
    ld5 = norm(d-p5);
    l56 = norm(p5-p6);
    lf6 = norm(f-p6);
    lf7 = norm(f-p7);
    l67 = norm(p6-p7);
    lg7 = norm(g-p7);
    lf8 = norm(f-p8);
    l68 = norm(p6-p8);
    l89 = norm(p8-p9);
    lh9 = norm(h-p9);



    % rocker rotation plane; equation fn dot x = fp
    fn = cross(p6-f, p7-f);
    fn = fn / norm(fn);
    fp = dot(fn, f);

    % ARB rotation plane; equation hn dot x = hp
    hn = cross(p8-h, p9-h);
    hn = hn / norm(hn);
    hp = dot(h, hn);

    % output
    FL_fixed = [a; b; c; d; e; f; g; h];
    FL_planes = [fn fp; hn hp];
    FL_lengths = [la1; lb1; lc4; ld4; l14; l34; l13; le3; l23; l12; l24];
end