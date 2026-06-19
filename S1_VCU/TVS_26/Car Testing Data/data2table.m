function T = data2table(path, nameValueArgs)
%% Arguments
% parse args
arguments
    path
    nameValueArgs.fillMissing
    nameValueArgs.printTable
    nameValueArgs.nodeRow
    nameValueArgs.messageRow
    nameValueArgs.signalRow
    nameValueArgs.dataRow
    nameValueArgs.nameColumn
end
nodeRow = nameValueArgs.nodeRow;
messageRow = nameValueArgs.messageRow;
signalRow = nameValueArgs.signalRow;
dataRow = nameValueArgs.dataRow;
nameColumn = nameValueArgs.nameColumn;
fillMissing = nameValueArgs.fillMissing;

% set nameValueArgs to nice values

%% load data
% path = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\june-14-morning\out_005_2026_06_14__09_51_49.csv";
fprintf("loading data\n")
% detect opts
opts = detectImportOptions(path);
% load headers
optsHeader = setvartype(opts, opts.VariableNames, 'string'); % string type
optsHeader.DataLines = [nodeRow nodeRow+1]; % node name row
nodeHeader = readmatrix(path, optsHeader);
optsHeader.DataLines = [messageRow messageRow+1]; % message name row
messageHeader = readmatrix(path, optsHeader);
optsHeader.DataLines = [signalRow signalRow+1]; % signal name rows
signalHeader = readmatrix(path, optsHeader);
header = [nodeHeader; messageHeader; signalHeader]; % combine into header matrix
% load data
optsdata = setvartype(opts, opts.VariableNames, 'double');
optsdata.DataLines = dataRow;
data = readmatrix(path, optsdata);

% [data, header] = load_data(path);



% if nameValueArgs.fillNaN == true
%     fprintf("removing rows with all NaN\n")
%     oldsize = size(data,1);
%     keeprows = any(~isnan(data(:,2:end)),2);
%     data = data(keeprows,:);
%     newsize = size(data,1);
%     fprintf("old: %d rows, new: %d rows, %.2f%% kept\n", oldsize, newsize, newsize / oldsize * 100)
% end
if fillMissing == true
    fprintf("filling missing data\n")
    missing = sum(isnan(data),"all");
    data = fillmissing(fillmissing(data, "previous"), "next");
    fprintf("filled %d missing (%.2f%% of data was missing)\n", missing, missing / numel(data));
end

%% Extract data
% generate tables
fprintf("generating table\n")
T = table();
T.time = data(:,1);
% T.realtime = data(:,1);

nodes = unique(header(1,nameColumn:end)); % all unique node names nodes[array of node names]
% for every node
for i = 1:length(nodes) 
    node = nodes(i);
    node_messages = unique(header(2, header(1,:) == node)); % all messages in a node
    temptable_nodes = table(); % table for current node

    % fprintf("╠═╤═%s\n", node)

    % for every message
    for j = 1:length(node_messages)
        message = node_messages(j);
        message_signals_cols = all([header(1,:) == node; header(2,:) == message], 1); % columns in data for all signals in current message
        message_signals = unique(header(3, message_signals_cols)); % get all signals for a mesage in a node
        temptable_messages = table(); % table for current message

        % fprintf("║ ├─┬─%s\n", message)

        % for every signal
        for k = 1:length(message_signals) 
            signal = message_signals(k);
            signal_cols = all([header(1,:) == node; header(2,:) == message; header(3,:) == signal], 1); % columns in data for current signal
            temptable_messages = addvars(temptable_messages, data(:, signal_cols), NewVariableNames=signal); % add signal to message table
            
            % fprintf("║ │ ├───%s\n", signal)
        end
        % fprintf("║ │\n")

        temptable_nodes = addvars(temptable_nodes, temptable_messages, NewVariableNames=message); % add message to node table
    end

    T = addvars(T, temptable_nodes, NewVariableNames=node); % add node to main table
end

%% exit early if not printing table
if nameValueArgs.printTable == true
else
    return
end

%% print list
for i = 1:length(nodes) 
    node = nodes(i);
    node_messages = unique(header(3, header(2,:) == node)); % all messages in a node

    if i == length(nodes)
        fprintf("╚═╤═")
    else
        fprintf("╠═╤═")
    end
    fprintf(" %s\n", node)
    % for every message
    for j = 1:length(node_messages)
        message = node_messages(j);
        message_signals_cols = all([header(2,:) == node; header(3,:) == message], 1); % columns in data for all signals in current message
        message_signals = unique(header(4, message_signals_cols)); % get all signals for a mesage in a node

        if i == length(nodes)
            fprintf("  ")
        else
            fprintf("║ ")
        end
        if j == length(node_messages)
            fprintf("└─┬─")
        else
            fprintf("├─┬─")
        end
        fprintf(" %s\n", message)
        % for every signal
        for k = 1:length(message_signals) 
            signal = message_signals(k);

            % fprintf("║ │ ├───%s\n", signal)
            if i == length(nodes)
                fprintf("  ")
            else
                fprintf("║ ")
            end
            if j == length(node_messages)
                fprintf("  ")
            else
                fprintf("│ ")
            end
            if k == length(message_signals)
                fprintf("└───")
            else
                fprintf("├───")
            end
            fprintf(" %s\n", signal)
        end
    end
end

% 	░	▒	▓	│	┤	╡	╢	╖	╕	╣	║	╗	╝	╜	╛	┐
% C	└	┴	┬	├	─	┼	╞	╟	╚	╔	╩	╦	╠	═	╬	╧
% D	╨	╤	╥	╙	╘	╒	╓	╫	╪	┘	┌	█	▄	▌	▐	▀