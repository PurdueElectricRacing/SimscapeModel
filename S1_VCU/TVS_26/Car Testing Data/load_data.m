%% Function Description
% Loads data from a daq-app generated csv, selecting certain columns
% Inputs
%   folderpath   .csv file to open
%   cols         array of column numbers to fetch, "all" to get all columns
%
% Outputs
%   data         array of data, rows are timesteps, columns are datsets
%   header       first 4 rows of csv, contains info on where in CAN data came from
function [data, header] = load_data(folderpath, cols)
    % options for all
    opts = detectImportOptions(folderpath);

    % default to all columns, otherwise use selected
    if string(cols) ~= "all"
        opts.SelectedVariableNames = cols;
    end

    % data
    optsdata = setvartype(opts, opts.VariableNames, 'double');
    optsdata.DataLines = 5; % data starts on line 5
    data = readmatrix(folderpath, optsdata);

    % headers
    optsheader = setvartype(opts, opts.VariableNames, 'string');
    optsheader.DataLines = [1 4];
    header = readmatrix(folderpath, optsheader, OutputType="string");
