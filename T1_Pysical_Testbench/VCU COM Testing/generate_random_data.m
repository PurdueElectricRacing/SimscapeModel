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
    x_rand.TH_RAW = randData(p.TH_lb, p.TH_ub);
    x_rand.ST_RAW = randData(p.ST_lb, p.ST_ub);
    x_rand.VB_RAW = randData(p.VB_lb, p.VB_ub);
    x_rand.WT_RAW = randData(p.WT_lb, p.WT_ub);
    x_rand.WM_RAW = randData(p.WM_lb, p.WM_ub);
    x_rand.GS_RAW = randData(p.GS_lb, p.GS_ub);
    x_rand.AV_RAW = randData(p.AV_lb, p.AV_ub);
    x_rand.IB_RAW = randData(p.IB_lb, p.IB_ub);
    x_rand.MT_RAW = randData(p.MT_lb, p.MT_ub);
    x_rand.CT_RAW = randData(p.CT_lb, p.CT_ub);
    x_rand.IT_RAW = randData(p.IT_lb, p.IT_ub);
    x_rand.MC_RAW = randData(p.MC_lb, p.MC_ub);
    x_rand.IC_RAW = randData(p.IC_lb, p.IC_ub);
    x_rand.BT_RAW = randData(p.BT_lb, p.BT_ub);
    x_rand.AG_RAW = randData(p.AG_lb, p.AG_ub);
    x_rand.TO_RAW = randData(p.TO_lb, p.TO_ub);
    x_rand.VT_DB_RAW = randData(p.VT_DB_lb, p.VT_DB_ub);
    x_rand.TV_PP_RAW = randData(p.TV_PP_lb, p.TV_PP_ub);
    x_rand.TC_TR_RAW = randData(p.TC_TR_lb, p.TC_TR_ub);
    x_rand.VS_MAX_SR_RAW = randData(p.VS_MAX_SR_lb, p.VS_MAX_SR_ub);
    
    % fVCU flags
    f_rand.CS_SFLAG = randi([0, 1]);
    f_rand.TB_SFLAG = randi([0, 1]);
    f_rand.SS_SFLAG = randi([0, 1]);
    f_rand.WT_SFLAG = randi([0, 1]);
    f_rand.IV_SFLAG = randi([0, 1]);
    f_rand.BT_SFLAG = randi([0, 1]);
    f_rand.IAC_SFLAG = randi([0, 1]);
    f_rand.IAT_SFLAG = randi([0, 1]);
    f_rand.IBC_SFLAG = randi([0, 1]);
    f_rand.IBT_SFLAG = randi([0, 1]);
    f_rand.SS_FFLAG = randi([0, 1]);
    f_rand.AV_FFLAG = randi([0, 1]);
    f_rand.GS_FFLAG = randi([0, 3]);
    f_rand.VCU_PFLAG = randi([0, 2]);
    f_rand.VCU_CFLAG = randi([0, 2]);

    % yVCU values
    % overwrite the variables used to hold past values so inputs don't depend on
    % past inputs
    y_rand.PT_permit_buffer = randData(zeros(1,p.PT_permit_N), ones(1,p.PT_permit_N));
    y_rand.VS_permit_buffer = randData(zeros(1,p.VS_permit_N), ones(1,p.VS_permit_N));
    y_rand.VT_permit_buffer = randData(zeros(1,p.VT_permit_N), ones(1,p.VT_permit_N));
    y_rand.VCU_mode = randData(1,4);
    y_rand.IB_CF_buffer = randData(p.IB_lb, p.IB_ub) + cumsum(randData(-ones(1, p.CF_IB_filter_N), ones(1, p.CF_IB_filter_N)));
    y_rand.zero_current_counter = randi([0, 100]);
    y_rand.TC_highs = randi([0, 1000]);
    y_rand.TC_lows = randi([0, 1000]);
    y_rand.VT_mode = randi([1, 2]);
    %% write values to cell array
    randDataCell(sample, :) = {x_rand, f_rand, y_rand};

    %% Write values to .csv
    if sample == 1
        % overwrite file, write header
        time_header = ["struct"; "signal"];
        xVCU_header = genHeader(x_rand, "xVCU");
        fVCU_header = genHeader(f_rand, "fVCU");
        yVCU_header = genHeader(y_rand, "yVCU");

        writematrix([xVCU_header, fVCU_header, yVCU_header], "Input_Data/random_testing_data.csv", WriteMode="overwrite");

        % pregenerate matrix to hold all data for each timestep
        headerLength = length([xVCU_header, fVCU_header, yVCU_header]);
        randDataMat = zeros([numSamples, headerLength]);
    end

    % resize data to fit in one row
    xVCU_row = getData(x_rand);
    fVCU_row = getData(f_rand);
    yVCU_row = getData(y_rand);

    % write out data to csv
    writematrix([xVCU_row, fVCU_row, yVCU_row], "Input_Data/random_testing_data.csv", WriteMode="append")

    % write out data to matrix
    randDataMat(sample, :) = [xVCU_row, fVCU_row, yVCU_row];
end

% save data as mat files
save("Input_Data/random_testing_data_cell.mat", "randDataCell")
save("Input_Data/random_testing_data_matrix.mat", "randDataMat")


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
end