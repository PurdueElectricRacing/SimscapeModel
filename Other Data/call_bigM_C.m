function [T1, T2, T3, T4, flag] = call_bigM_C(T2F, b, A, beq, Aeq, lb, ub, sign, yaw_err_limit)

% T2F, A, Aeq, lb, ub:  [1 * 4] single (float) matrix
% sign:                 [1 * 4] single (float) matrix for indicating sign
%                                                               of Tx
% b, A, yaw_err_limit:                 single (float)

% force single instead of MATLAB defualt double
T1 = single(0);
T2 = single(0);
T3 = single(0);
T4 = single(0);
flag = int32(0);
coder.cinclude("bigM_v2_func.h");

% use pass by address to output T1, T2, T3, T4
flag = coder.ceval("bigM_func", T2F(1), T2F(2), T2F(3), T2F(4), ...
                            b, A(1), A(2), A(3), A(4), ...
                            beq, Aeq(1), Aeq(2), Aeq(3), Aeq(4), ...
                            lb(1), lb(2), lb(3), lb(4), ...
                            ub(1), ub(2), ub(3), ub(4), ...
                            coder.ref(T1), coder.ref(T2), coder.ref(T3), coder.ref(T4), ...
                            sign(1), sign(2), sign(3), sign(4), ...
                            yaw_err_limit);

end