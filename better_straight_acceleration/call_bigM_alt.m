function [Tx, bigM_flag] = call_bigM_alt(b, A, beq, Aeq, lb, ub)
% input
% A, Aeq, lb, ub   [1 * 4] double matrix
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

% minimize positive yaw
Tx_sign = [1, 1, 1, 1]; % 1 = positive, - 1 = negative

c_bigM=[Aeq(1), Aeq(2), Aeq(3), Aeq(4)]';
b_bigM=[b, beq-0.0108, lb(1), lb(2), lb(3), lb(4), ...
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

inq_bigM=[-1, 1, 1, 1, 1, 1, -1, -1, -1, -1];

% detect Tx that are surely negative, negate them
for j = 1:4
    if((b_bigM(j+2) < 0) && (b_bigM(j+6) < 0))
       b_bigM(j+2)      = - b_bigM(j+2);
       b_bigM(j+6)      = - b_bigM(j+6);
       c_bigM(j)        = - c_bigM(j);
       A_bigM(1, j)     = - A_bigM(1, j);
       A_bigM(2, j)     = - A_bigM(2, j);
       inq_bigM(j+2)    = - 1;
       inq_bigM(j+6)    =   1;
       Tx_sign(j)       = - 1;
    end
end

% construct Tableau
p = bigM(A_bigM,b_bigM,c_bigM,inq_bigM,'min');
% solve Tableau
[Tx_pos, bigM_flag_pos] = p.solve; 

% negate back
for j = 1:4
    if(Tx_sign(j) == -1)
        Tx_pos(j) = - Tx_pos(j);
    end
end

positive_yaw_error = abs(dot(Aeq, Tx_pos) - beq);

% maximize negative yaw
Tx_sign = [1, 1, 1, 1]; % 1 = positive, - 1 = negative

c_bigM=[Aeq(1), Aeq(2), Aeq(3), Aeq(4)]';
b_bigM=[b, beq+0.0108, lb(1), lb(2), lb(3), lb(4), ...
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

inq_bigM=[-1, -1, 1, 1, 1, 1, -1, -1, -1, -1];

% detect Tx that are surely negative, negate them
for j = 1:4
    if((b_bigM(j+2) < 0) && (b_bigM(j+6) < 0))
       b_bigM(j+2)      = - b_bigM(j+2);
       b_bigM(j+6)      = - b_bigM(j+6);
       c_bigM(j)        = - c_bigM(j);
       A_bigM(1, j)     = - A_bigM(1, j);
       A_bigM(2, j)     = - A_bigM(2, j);
       inq_bigM(j+2)    = - 1;
       inq_bigM(j+6)    =   1;
       Tx_sign(j)       = - 1;
    end
end

% construct Tableau
p = bigM(A_bigM,b_bigM,c_bigM,inq_bigM,'max');
% solve Tableau
[Tx_neg, bigM_flag_neg] = p.solve; 

% negate back
for j = 1:4
    if(Tx_sign(j) == -1)
        Tx_neg(j) = - Tx_neg(j);
    end
end

negative_yaw_error = abs(beq - dot(Aeq, Tx_neg));

if(negative_yaw_error < positive_yaw_error)
    Tx = Tx_neg;
    bigM_flag = bigM_flag_neg;
else
    Tx = Tx_pos;
    bigM_flag = bigM_flag_pos;    
end

% if(bigM_flag_pos == 0)
%   Tx = Tx_neg;
%   bigM_flag = bigM_flag_neg;
% else
%   Tx = Tx_pos;
%   bigM_flag = bigM_flag_pos;   
% end


end