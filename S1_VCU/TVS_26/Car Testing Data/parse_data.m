function [data, header] = parse_data(folderpath, cols)
    % options for all
    opts = detectImportOptions(folderpath);
    opts.SelectedVariableNames = cols;

    % data
    optsdata = setvartype(opts, opts.VariableNames, 'double');
    optsdata.DataLines = 5; % data starts on line 5
    data = readmatrix(folderpath, optsdata);

    % headers
    optsheader = setvartype(opts, opts.VariableNames, 'string');
    optsheader.DataLines = [1 4];
    header = readmatrix(folderpath, optsheader, OutputType="string");

    % 