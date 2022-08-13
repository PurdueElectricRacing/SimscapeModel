function [Tx, bigM_flag] = call_bigMz_brake(T2F, b, A, beq, Aeq, lb, ub)
% input
% T2F, A, Aeq, lb, ub   [1 * 4] double matrix
% b, A                  double
%
% output
% Tx                    [1 * 4] double matrix, torque output
% flag                  int, -1 = default output
%                             0 = infeasible
%                             1 = max interation reached (20)
%                             2 = problem is unbounded
%                             3 = optimal solution !!!

% setup

c_bigM=[T2F(1), T2F(2), T2F(3), T2F(4)]';
b_bigM=[b, beq, lb(1), lb(2), lb(3), lb(4), ...
    ub(1), ub(2), ub(3), ub(4)]';
A_bigM=[A(1), A(2), A(3), A(4); ...
        Aeq(1), Aeq(2), Aeq(3), Aeq(4); ...
        1, 0, 0, 0; ...
        0, 1, 0, 0; ...
        0, 0, 1, 0; ...
        0, 0, 0, 1; ...
        1, 0, 0, 0; ...
        0, 1, 0, 0; ...
        0, 0, 1, 0; ...
        0, 0, 0, 1];

inq_bigM=[-1, 0, 1, 1, 1, 1, -1, -1, -1, -1];

% detect Tx that are surely negative, negate them

% construct Tableau
p = bigM(A_bigM,b_bigM,c_bigM,inq_bigM,'max');
% solve Tableau
[Tx, bigM_flag] = p.solve; 

% negate back
for j = 1:4
   Tx(j) = - Tx(j);
end

% end