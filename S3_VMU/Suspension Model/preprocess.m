function [fixed_FL, lengths_FL] = preprocess(sus_data_FL)
%PREPROCESS Summary of this function goes here
%   Detailed explanation goes here

    % read in sus point data
    % description of what each point is in file
    C = readmatrix("sus_data_FL.csv",NumHeaderLines=1, Range="C:E"); % coordinates

    % fixed points
    a = C(1,:);
    b = C(2,:);
    c = C(4,:);
    d = C(5,:);
    e = C(7,:);
    f = C(9,:);
    g = C(12,:);
    h = C(16,:);

    % free points starting position, used to calculate lengths
    f1 = C(3,:);
    f2 = C(17,:);
    f3 = C(8,:);
    f4 = C(6,:);
    f5 = C(13,:);
    f6 = C(10,:);
    f7 = C(11,:);
    f8 = C(14,:);
    f9 = C(15,:);

    % calculate lengths
    la1 = norm(a-f1);
    lb1 = norm(b-f1);
    lc4 = norm(c-f4);
    ld4 = norm(d-f4);
    le3 = norm(e-f3);
    l12 = norm(f1-f2);
    l13 = norm(f1-f3);
    l24 = norm(f2-f4);
    lc5 = norm(c-f5);
    ld5 = norm(d-f5);
    l56 = norm(f5-f6);
    lf6 = norm(f-f6);
    lf7 = norm(f-f7);
    l67 = norm(f6-f7);
    lg7 = norm(g-f7);
    lf8 = norm(f-f8);
    l68 = norm(f6-f8);
    l89 = norm(f8-f9);
    lh9 = norm(h-f9);



    % rocker rotation plane; equation fn dot x = fp
    fn = cross(f6-f, f7-f);
    fn = fn / norm(fn);
    fp = dot(fn, f);

    % ARB rotation plane; equation hn dot x = hp
    hn = cross(f8-h, f9-h);
    hn = hn / norm(hn);
    hp = dot(h, hn);

    % output
    fixed_FL = 
    
end