function [Tarb_L, Tarb_R] = calculate_arb_forces(L_fixed, L_planes, L_solved, R_fixed, R_planes, R_solved)
    % fixed points
    h_L = L_fixed(8,:);
    h_R = R_fixed(8,:);

    % solved points
    p9_L = L_solved(9,:);
    p9_R = R_solved(9,:);

    % rotation axis
    hn_L = L_planes(2,1:3);
    hn_R = R_planes(2,1:3);
    

    % Calculate unit vectors in direction of ARB arms
    d_arb_L = (p9_L - h_L) / norm(p9_L - h_L);
    d_arb_R = (p9_r - h_R) / norm(p9_R - h_r);

    % calcualte angle of twist
    theta = acos(dot(d_arb_L, d_arb_R));

    % calculate force
    
end