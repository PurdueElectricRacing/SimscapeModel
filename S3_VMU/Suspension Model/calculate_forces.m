function [forces] = calculate_forces(fixed, planes, solved, Tarb, model)

    % fixed = FL_fixed; planes = FL_planes; solved = FL_solved;

    % fixed points
    a = fixed(1,:);
    b = fixed(2,:);
    c = fixed(3,:);
    d = fixed(4,:);
    e = fixed(5,:);
    f = fixed(6,:);
    g = fixed(7,:);
    h = fixed(8,:);

    % solved points
    p1 = solved(1,:);
    p2 = solved(2,:);
    p3 = solved(3,:);
    p4 = solved(4,:);
    p5 = solved(5,:);
    p6 = solved(6,:);
    p7 = solved(7,:);
    p8 = solved(8,:);
    p9 = solved(9,:);


    % direction unit vectors, pointing from first point to second point
    da1 = (p1-a) / norm(p1-a);
    db1 = (p1-b) / norm(p1-b);
    dc4 = (p4-c) / norm(p4-c);
    dc5 = (p5-c) / norm(p5-c);
    dd4 = (p4-d) / norm(p4-d);
    dd5 = (p5-d) / norm(p5-d);
    de3 = (p3-e) / norm(p3-e);
    df6 = (p6-f) / norm(p6-f);
    df7 = (p7-f) / norm(p7-f);
    df8 = (p8-f) / norm(p8-f);
    dg8 = (p8-g) / norm(p8-g);
    dh9 = (p9-h) / norm(p9-h);
    d12 = (p2-p1) / norm(p2-p1);
    d13 = (p3-p1) / norm(p3-p1);
    d14 = (p4-p1) / norm(p4-p1);
    d23 = (p3-p2) / norm(p3-p2);
    d24 = (p4-p2) / norm(p4-p2);
    d34 = (p4-p3) / norm(p4-p3);
    d45 = (p5-p4) / norm(p5-p4);
    d56 = (p6-p5) / norm(p6-p5);
    d67 = (p7-p6) / norm(p7-p6);
    d68 = (p8-p6) / norm(p8-p6);
    d79 = (p9-p7) / norm(p9-p7);
    
    % rotation axis
    hn = planes(2,1:3);
    fn = planes(1,1:3);

    % Forces 
    % F# is force in linkage #
    % forces in a link positive in tension, negative in comporession
    % foces at a point are positive away from point, negative towards point
    
    %calculate spring force [N]
    Fspring = model.k*(p8 - model.spring.nominal);
    
    % calculate F21 given torque from ARB
    F21 = -Tarb/(dot(hn,cross((p9-h),-d79)));

    % calcualte F15 given sum of moments around point f normal axis
    Mfsp = dot((cross((p8-f),(Fspring*-dg8))),fn);
    Mf21 = dot((cross((p7-f),(F21*d79))),fn);
    Mf = Mfsp + Mf21;
    F15 = -Mf/(dot(fn,cross((p6-f),-d56)));

    % calcualte F12, F13, F14 given F15
    A = [-dc5' -dd5' -d45'];
    B = -(d56)' * F15;
    x = A\B;
    F12 = x(1);
    F13 = x(2);
    F14 = x(3);
    
    % BASIC METHOD
    % Assume force in steering tierod is 0 (ignore link 6, 7, 9)
    % Ignore link 11

    % Calculate F5, F3, F4 given F14 using sum forces @ 4
    A = [-dc4' -dd4' -d14'];
    B = -(d45)' * F14;
    x = A\B;
    F5 = x(3);
    
    % Calculate Fz (tire force) using sum moments about ab, assume Fz acts
    % on lower A-arm
    n1 = (b-a)/norm(b-a); % axis of rotation
    rF5 = p1-a; % position of force F5
    M5 = dot(n1, cross(rF5, F5*d14)); % moment from force 5
    rFz = p2-a; % position of force Fz.
    dFz = [0 0 1]; % direction of force Fz
    M2 = dot(n1, cross(rFz, dFz)); % unit moment from Fz
    Fz = -M5 / M2; % Use sum of moments to find Fz needed to balance

    % Store calculated forces in the output variable
    forces = Fz;
end