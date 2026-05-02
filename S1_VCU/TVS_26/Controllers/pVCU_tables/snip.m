function clipped = snip(value, LB, UB)
    %SNIP code generation compatible version of 'clip()'
    %   clips 'value' to be between lower bound 'LB' and upper bound 'UB'
    clipped = max(min(value, UB), LB);
end