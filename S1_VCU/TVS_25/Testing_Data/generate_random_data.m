%% Constants
numSamples = 100;

for sample = 1:numSamples
    %% generate one set of random inputs
    % time
    r.time = (sample - 1) * 0.15;

    % all xVCU values
    r.TH_RAW = randnum(p.TH_lb, p.TH_ub);
    r.ST_RAW = randnum(p.ST_lb, p.ST_ub);
    r.VB_RAW = randnum(p.VB_lb, p.VB_ub);
    r.WT_RAW = randnum(p.WT_lb, p.WT_ub);
    r.WM_RAW = randnum(p.WM_lb, p.WM_ub);
    r.GS_RAW = randnum(p.GS_lb, p.GS_ub);
    r.AV_RAW = randnum(p.AV_lb, p.AV_ub);
    r.IB_RAW = randnum(p.IB_lb, p.IB_ub);
    r.MT_RAW = randnum(p.MT_lb, p.MT_ub);
    r.CT_RAW = randnum(p.CT_lb, p.CT_ub);
    r.IT_RAW = randnum(p.IT_lb, p.IT_ub);
    r.MC_RAW = randnum(p.MC_lb, p.MC_ub);
    r.IC_RAW = randnum(p.IC_lb, p.IC_ub);
    r.BT_RAW = randnum(p.BT_lb, p.BT_ub);
    r.AG_RAW = randnum(p.AG_lb, p.AG_ub);
    r.TO_RAW = randnum(p.TO_lb, p.TO_ub);
    r.VT_DB_RAW = randnum(p.VT_DB_lb, p.VT_DB_ub);
    r.TV_PP_RAW = randnum(p.TV_PP_lb, p.TV_PP_ub);
    r.TC_TR_RAW = randnum(p.TC_TR_lb, p.TC_TR_ub);
    r.VS_MAX_SR_RAW = randnum(p.VS_MAX_SR_lb, p.VS_MAX_SR_ub);
    
    % yVCU buffers values
    % overwrite the buffers used to hold past values so inputs don't depend on
    % past inputs
    r.PT_permit_buffer = randnum(zeros(1,p.PT_permit_N), ones(1,p.PT_permit_N));
    r.VS_permit_buffer = randnum(zeros(1,p.VS_permit_N), ones(1,p.VS_permit_N));
    r.VT_permit_buffer = randnum(zeros(1,p.VT_permit_N), ones(1,p.VT_permit_N));
    
    % fVCU flags
    r.CS_SFLAG = randi([0, 1]);
    r.TB_SFLAG = randi([0, 1]);
    r.SS_SFLAG = randi([0, 1]);
    r.WT_SFLAG = randi([0, 1]);
    r.IV_SFLAG = randi([0, 1]);
    r.BT_SFLAG = randi([0, 1]);
    r.IAC_SFLAG = randi([0, 1]);
    r.IAT_SFLAG = randi([0, 1]);
    r.IBC_SFLAG = randi([0, 1]);
    r.IBT_SFLAG = randi([0, 1]);
    r.SS_FFLAG = randi([0, 1]);
    r.AV_FFLAG = randi([0, 1]);
    r.GS_FFLAG = randi([0, 3]);
    r.VCU_PFLAG = randi([0, 2]);
    r.VCU_CFLAG = randi([0, 2]);

    %% Write values to .csv
    if sample == 1 % overwrite file, write header
        header = cellfun(@(el) (repmat(string(el),[1, length(r.(el))])), fs, 'UniformOutput', false);
        
        writematrix([header{:}], "random_testing_data.csv", WriteMode="overwrite");
    end
    row = cellfun(@(el) (r.(el)), fs, 'UniformOutput', false);
    writematrix([row{:}], "random_testing_data.csv", WriteMode="append")
end



function x = randnum(min, max)
    x = arrayfun(@(min, max) (rand(1)*(max-min)+min), min, max);
end
