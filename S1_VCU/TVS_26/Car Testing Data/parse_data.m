function [data, header] = parse_data(folderpath, cols)
    opts = detectImportOptions(folderpath);
    opts.SelectedVariableNames = cols;
    optsdata = setvartype(opts, opts.VariableNames, 'double');
    optsdata.DataLines = 5;
    data = readmatrix(folderpath, optsdata);
    optsheader = setvartype(opts, opts.VariableNames, 'string');
    optsheader.DataLines = [1 4];
    header = readmatrix(folderpath, optsheader, OutputType="string");