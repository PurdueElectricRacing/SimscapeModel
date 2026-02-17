function [fixed_FL, lengths_FL] = preprocess(sus_data_FL)
%PREPROCESS Summary of this function goes here
%   Detailed explanation goes here
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

    % rocker and arb rotation planes
    fn = 


end