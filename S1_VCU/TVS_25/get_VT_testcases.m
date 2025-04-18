% Test cases for get_VT

ST_CF_v = [5 5 35 35 -5 -5 -35 -35];
VT_DB_CF_v = [20 20 20 20 20 20 20 20];
dST_DB_v = [10 10 10 10 10 10 10 10];
VT_mode_current_v = [1 2 1 2 1 2 1 2];
VT_mode_output_v = zeros(size(ST_CF_v));
VT_expected = [1 1 2 2 1 1 2 2];

for i = 1 : length(ST_CF_v)
    y.ST_CF = ST_CF_v(i);
    y.VT_DB_CF = VT_DB_CF_v(i);
    p.dST_DB = dST_DB_v(i);
    y = get_VT(p, y);
    VT_mode_output_v(i) = y.VT_mode;
end