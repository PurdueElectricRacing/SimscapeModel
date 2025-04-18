%% must have p struct initialized
% make sure TVS_25 folder is in PATH
p = pVCU_Master();

%% Constants
numSamples = 100;

% pregenerate cell array to hold all structs for each timestep
randDataCell = cell([numSamples, 3]);

for sample = 1:numSamples
    %% generate one set of random inputs
    % time
    r.time = (sample - 1) * 00.15;

    % all xVCU values
    r_xVCU.TH_RAW = randData(p.TH_lb, p.TH_ub);
    r_xVCU.ST_RAW = randData(p.ST_lb, p.ST_ub);
    r_xVCU.VB_RAW = randData(p.VB_lb, p.VB_ub);
    r_xVCU.WT_RAW = randData(p.WT_lb, p.WT_ub);
    r_xVCU.WM_RAW = randData(p.WM_lb, p.WM_ub);
    r_xVCU.GS_RAW = randData(p.GS_lb, p.GS_ub);
    r_xVCU.AV_RAW = randData(p.AV_lb, p.AV_ub);
    r_xVCU.IB_RAW = randData(p.IB_lb, p.IB_ub);
    r_xVCU.MT_RAW = randData(p.MT_lb, p.MT_ub);
    r_xVCU.CT_RAW = randData(p.CT_lb, p.CT_ub);
    r_xVCU.IT_RAW = randData(p.IT_lb, p.IT_ub);
    r_xVCU.MC_RAW = randData(p.MC_lb, p.MC_ub);
    r_xVCU.IC_RAW = randData(p.IC_lb, p.IC_ub);
    r_xVCU.BT_RAW = randData(p.BT_lb, p.BT_ub);
    r_xVCU.AG_RAW = randData(p.AG_lb, p.AG_ub);
    r_xVCU.TO_RAW = randData(p.TO_lb, p.TO_ub);
    r_xVCU.VT_DB_RAW = randData(p.VT_DB_lb, p.VT_DB_ub);
    r_xVCU.TV_PP_RAW = randData(p.TV_PP_lb, p.TV_PP_ub);
    r_xVCU.TC_TR_RAW = randData(p.TC_TR_lb, p.TC_TR_ub);
    r_xVCU.VS_MAX_SR_RAW = randData(p.VS_MAX_SR_lb, p.VS_MAX_SR_ub);
    
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

    % yVCU buffers values
    % overwrite the buffers used to hold past values so inputs don't depend on
    % past inputs
    r_yVCU.PT_permit_buffer = randData(zeros(1,p.PT_permit_N), ones(1,p.PT_permit_N));
    r_yVCU.VS_permit_buffer = randData(zeros(1,p.VS_permit_N), ones(1,p.VS_permit_N));
    r_yVCU.VT_permit_buffer = randData(zeros(1,p.VT_permit_N), ones(1,p.VT_permit_N));

    %% write values to cell array
    randDataCell(sample, :) = {r_xVCU, r_fVCU, r_yVCU};

    %% Write values to .csv
    if sample == 1
        % overwrite file, write header
        time_header = ["struct"; "signal"];
        xVCU_header = genHeader(r_xVCU, "xVCU");
        fVCU_header = genHeader(r_fVCU, "fVCU");
        yVCU_header = genHeader(r_yVCU, "yVCU");

        writematrix([xVCU_header, fVCU_header, yVCU_header], "random_testing_data.csv", WriteMode="overwrite");

        % pregenerate matrix to hold all data for each timestep
        headerLength = length([xVCU_header, fVCU_header, yVCU_header]);
        randDataMat = zeros([numSamples, headerLength]);
    end

    % resize data to fit in one row
    xVCU_row = getData(r_xVCU);
    fVCU_row = getData(r_fVCU);
    yVCU_row = getData(r_yVCU);

    % write out data to csv
    writematrix([xVCU_row, fVCU_row, yVCU_row], "random_testing_data.csv", WriteMode="append")

    % write out data to matrix
    randDataMat(sample, :) = [xVCU_row, fVCU_row, yVCU_row];
end

% save cell array as mat file
save("random_testing_data_cell.mat", "randDataCell")
save("random_testing_data_matrix.mat", "randDataMat")


%% Functions

% generates array of random real numbers in range [min, max]
% output size matchest size of min and max
% rounds to 4 significant figues for sending over CAN
function x = randData(min, max)
    x = arrayfun(@(min, max) (rand(1)*(max-min)+min), min, max);
    x = round(x, 4, "significant");
end

% generate a header for a struct
% row 1 is the the struct name
% row 2 is the struct field names
function header = genHeader(struct, name)
    lentotal = sum(cellfun(@(f) (length(struct.(f))),fields(struct)));
    headerStruct = repmat(name,[1,lentotal]);

    headerFields = cellfun(@(f) (repmat(string(f),[1, length(struct.(f))])), fields(struct), 'UniformOutput', false);
    headerFields = [headerFields{:}];

    header = [headerStruct; headerFields];
end

% gets data from a struct, resizes all fields to column vectors and
% concatenates
function data = getData(struct)
    data = cell2mat(cellfun(@(x) ([x(:)]), struct2cell(struct), 'UniformOutput', false));
    data = data';
    % data = cellfun(@(f) (struct.(f)), fields(struct), 'UniformOutput', false);
    % data = [data{:}];
end