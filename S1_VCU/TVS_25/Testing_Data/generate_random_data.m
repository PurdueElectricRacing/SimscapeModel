%% Constants
numSamples = 1;

for sample = 1:numSamples
    %% generate one set of random inputs
    % time
    r.time = (sample - 1) * 0.15;

    % all xVCU values
    r_xVCU.TH_RAW = randnum(p.TH_lb, p.TH_ub);
    r_xVCU.ST_RAW = randnum(p.ST_lb, p.ST_ub);
    r_xVCU.VB_RAW = randnum(p.VB_lb, p.VB_ub);
    r_xVCU.WT_RAW = randnum(p.WT_lb, p.WT_ub);
    r_xVCU.WM_RAW = randnum(p.WM_lb, p.WM_ub);
    r_xVCU.GS_RAW = randnum(p.GS_lb, p.GS_ub);
    r_xVCU.AV_RAW = randnum(p.AV_lb, p.AV_ub);
    r_xVCU.IB_RAW = randnum(p.IB_lb, p.IB_ub);
    r_xVCU.MT_RAW = randnum(p.MT_lb, p.MT_ub);
    r_xVCU.CT_RAW = randnum(p.CT_lb, p.CT_ub);
    r_xVCU.IT_RAW = randnum(p.IT_lb, p.IT_ub);
    r_xVCU.MC_RAW = randnum(p.MC_lb, p.MC_ub);
    r_xVCU.IC_RAW = randnum(p.IC_lb, p.IC_ub);
    r_xVCU.BT_RAW = randnum(p.BT_lb, p.BT_ub);
    r_xVCU.AG_RAW = randnum(p.AG_lb, p.AG_ub);
    r_xVCU.TO_RAW = randnum(p.TO_lb, p.TO_ub);
    r_xVCU.VT_DB_RAW = randnum(p.VT_DB_lb, p.VT_DB_ub);
    r_xVCU.TV_PP_RAW = randnum(p.TV_PP_lb, p.TV_PP_ub);
    r_xVCU.TC_TR_RAW = randnum(p.TC_TR_lb, p.TC_TR_ub);
    r_xVCU.VS_MAX_SR_RAW = randnum(p.VS_MAX_SR_lb, p.VS_MAX_SR_ub);
    
    % yVCU buffers values
    % overwrite the buffers used to hold past values so inputs don't depend on
    % past inputs
    r_yVCU.PT_permit_buffer = randnum(zeros(1,p.PT_permit_N), ones(1,p.PT_permit_N));
    r_yVCU.VS_permit_buffer = randnum(zeros(1,p.VS_permit_N), ones(1,p.VS_permit_N));
    r_yVCU.VT_permit_buffer = randnum(zeros(1,p.VT_permit_N), ones(1,p.VT_permit_N));
    
    % fVCU flags
    r_fVCU.CS_SFLAG = randi([0, 1]);
    r_fVCU.TB_SFLAG = randi([0, 1]);
    r_fVCU.SS_SFLAG = randi([0, 1]);
    r_fVCU.WT_SFLAG = randi([0, 1]);
    r_fVCU.IV_SFLAG = randi([0, 1]);
    r_fVCU.BT_SFLAG = randi([0, 1]);
    r_fVCU.IAC_SFLAG = randi([0, 1]);
    r_fVCU.IAT_SFLAG = randi([0, 1]);
    r_fVCU.IBC_SFLAG = randi([0, 1]);
    r_fVCU.IBT_SFLAG = randi([0, 1]);
    r_fVCU.SS_FFLAG = randi([0, 1]);
    r_fVCU.AV_FFLAG = randi([0, 1]);
    r_fVCU.GS_FFLAG = randi([0, 3]);
    r_fVCU.VCU_PFLAG = randi([0, 2]);
    r_fVCU.VCU_CFLAG = randi([0, 2]);

    %% Write values to .csv
    if sample == 1 % overwrite file, write header
        xVCU_header = genHeader(r_xVCU, "xVCU");
        yVCU_header = genHeader(r_yVCU, "yVCU");
        fVCU_header = genHeader(r_xVCU, "fVCU");
    

        writematrix([xVCU_header, yVCU_header, fVCU_header], "random_testing_data.csv", WriteMode="overwrite");
        
    end
    xVCU_row = getData(r_xVCU);
    yVCU_row = getData(r_yVCU);
    fVCU_row = getData(r_fVCU);

    writematrix([xVCU_row, yVCU_row, fVCU_row], "random_testing_data.csv", WriteMode="append")
end



function x = randnum(min, max)
    x = arrayfun(@(min, max) (rand(1)*(max-min)+min), min, max);
end

function header = genHeader(struct, name)
    lentotal = sum(cellfun(@(f) (length(struct.(f))),fields(struct)));
    headerStruct = repmat(name,[1,lentotal]);

    headerFields = cellfun(@(f) (repmat(string(f),[1, length(struct.(f))])), fields(struct), 'UniformOutput', false);
    headerFields = [headerFields{:}];

    header = [headerStruct; headerFields];
end

function data = getData(struct)
    data = cellfun(@(f) (struct.(f)), fields(struct), 'UniformOutput', false);
    data = [data{:}];
end