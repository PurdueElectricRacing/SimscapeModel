function [x1, x2] = sphere_sphere_plane(c1, c2, r1, r2, h)
% find intersection plane for sphere 1 with sphere 2
% intersection plane n1 dot x = p1
n1 = c1 - c2;
n1 = n1 / norm(n1);
p1 = -(r1^2 - r2^2 - dot(c1,c1) + dot(c2,c2)) / (2*norm(c1-c2));


% Given z heigh corresponds to plane <0 0 1> dot x = p2
% n2 = c1 - c3;
n2 = [0 0 1];
% n2 = n2 / norm(n2);
% p2 = -(r1^2 - r3^2 - dot(c1,c1) + dot(c3,c3)) / (2*norm(c1-c3));
p2 = h;

% find intersection line between the two planes
% in the form r = r0 + a t, (r0 is origin, a is direction, t is paramater)
a = cross(n1, n2);
r0 = (p1 * cross(n2, a) + p2 * cross(a, n1)) / dot(a, a);

% find intersection between the line and sphere 1
% solution is found using quadratic formula with coefficients qa, qb, qc
qa = dot(a,a);
qb = 2 * dot(a, r0 - c1);
qc = dot(r0 - c1, r0 - c1) - r1^2;

% find both solutions
t1 = (-qb + sqrt(qb^2 - 4*qa*qc)) / (2*qa);
t2 = (-qb - sqrt(qb^2 - 4*qa*qc)) / (2*qa);

% solution gives point as parameter along intersection line
% use line equation to find points
x1 = r0 + a * t1;
x2 = r0 + a * t2;