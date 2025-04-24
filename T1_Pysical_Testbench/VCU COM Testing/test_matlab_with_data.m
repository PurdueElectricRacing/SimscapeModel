load("Input_Data/random_testing_data_cell.mat")
numSamples = size(randDataCell,1);

% reset values
p = pVCU_Master();
f = fVCU_Master();
x = xVCU_Master();
y = yVCU_Master(p);

% preallocate cell array
outputDataCell = cell(numSamples, 1);
for sample = 1:numSamples

    % load random values
    x_rand = randDataCell{sample, 1};
    f_rand = randDataCell{sample, 2};
    y_rand = randDataCell{sample, 3};

    % fill in data
    x.TH_RAW = x_rand.TH_RAW;
    x.ST_RAW = x_rand.ST_RAW;
    x.VB_RAW = x_rand.VB_RAW;
    x.WT_RAW = x_rand.WT_RAW;
    x.WM_RAW = x_rand.WM_RAW;
    x.GS_RAW = x_rand.GS_RAW;
    x.AV_RAW = x_rand.AV_RAW;
    x.IB_RAW = x_rand.IB_RAW;
    x.MT_RAW = x_rand.MT_RAW;
    x.CT_RAW = x_rand.CT_RAW;
    x.IT_RAW = x_rand.IT_RAW;
    x.MC_RAW = x_rand.MC_RAW;
    x.IC_RAW = x_rand.IC_RAW;
    x.BT_RAW = x_rand.BT_RAW;
    x.AG_RAW = x_rand.AG_RAW;
    x.TO_RAW = x_rand.TO_RAW;
    x.VT_DB_RAW = x_rand.VT_DB_RAW;
    x.TV_PP_RAW = x_rand.TV_PP_RAW;
    x.TC_TR_RAW = x_rand.TC_TR_RAW;
    x.VS_MAX_SR_RAW = x_rand.VS_MAX_SR_RAW;

    f.CS_SFLAG = f_rand.CS_SFLAG;
    f.TB_SFLAG = f_rand.TB_SFLAG;
    f.SS_SFLAG = f_rand.SS_SFLAG;
    f.WT_SFLAG = f_rand.WT_SFLAG;
    f.IV_SFLAG = f_rand.IV_SFLAG;
    f.BT_SFLAG = f_rand.BT_SFLAG;
    f.IAC_SFLAG = f_rand.IAC_SFLAG;
    f.IAT_SFLAG = f_rand.IAT_SFLAG;
    f.IBC_SFLAG = f_rand.IBC_SFLAG;
    f.IBT_SFLAG = f_rand.IBT_SFLAG;
    f.SS_FFLAG = f_rand.SS_FFLAG;
    f.AV_FFLAG = f_rand.AV_FFLAG;
    f.GS_FFLAG = f_rand.GS_FFLAG;
    f.VCU_PFLAG = f_rand.VCU_PFLAG;
    f.VCU_CFLAG = f_rand.VCU_CFLAG;

    y.PT_permit_buffer = y_rand.PT_permit_buffer;
    y.VS_permit_buffer = y_rand.VS_permit_buffer;
    y.VT_permit_buffer = y_rand.VT_permit_buffer;
    y.IB_CF_buffer = y_rand.IB_CF_buffer;
    y.zero_current_counter = y_rand.zero_current_counter;
    y.TC_highs = y_rand.TC_highs;
    y.TC_lows = y_rand.TC_lows;
    y.VT_mode = y_rand.VT_mode;

    % run one step
    y_new = class2struct(vcu_step(p,f,x,y));

    % save data to cell
    outputDataCell{sample} = y_new;

    %% write values to cell array
    outputDataCell(sample, :) = {y_new};

    %% Write values to .csv
    if sample == 1
        % overwrite file, write header
        time_header = ["struct"; "signal"];
        yVCU_header = genHeader(y_new, "yVCU");

        writematrix([yVCU_header], "Output_Data/random_testing_results_MATLAB.csv", WriteMode="overwrite");

        % pregenerate matrix to hold all data for each timestep
        headerLength = length([yVCU_header]);
        outputDataMat = zeros([numSamples, headerLength]);
    end

    % resize data to fit in one row
    yVCU_row = getData(y_new);

    % write out data to csv
    writematrix([yVCU_row], "Output_Data/random_testing_results_MATLAB.csv", WriteMode="append")

    % write out data to matrix
    outputDataMat(sample, :) = [yVCU_row];
end

% save data as mat files
save("Output_Data/random_testing_data_cell.mat", "outputDataCell")
save("Output_Data/random_testing_data_matrix.mat", "outputDataMat")

%% Functions

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