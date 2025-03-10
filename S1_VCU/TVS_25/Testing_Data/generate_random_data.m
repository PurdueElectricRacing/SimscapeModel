%% create file
fid = fopen("random_testing_data.csv","w");

% generate one set of random inputs
TH_RAW = randnum(p.TH_lb, p.TH_ub, 1);
ST_RAW = randnum(-90, 90, 1);
VB_RAW = randnum(400, 595, 1);
WT_RAW = randnum(0, 75);

function x = randnum(min, max)
    x = rand(1) * (max-min) + min;
end