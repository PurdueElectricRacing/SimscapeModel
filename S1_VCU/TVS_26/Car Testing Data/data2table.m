function T = data2table(path, removenan, fill)
%% load data
% path = "C:\Users\TAK\Documents\GitHub\SimscapeModel\S1_VCU\TVS_26\Car Testing Data\Data\may10-accel-skids\out_000.csv";

fprintf("loading data\n")

[data, header] = load_data(path, "all");

if string(removenan) == "removeNaN"
    fprintf("removing rows with all NaN\n")
    oldsize = size(data,1);
    keeprows = any(~isnan(data(:,2:end)),2);
    data = data(keeprows,:);
    newsize = size(data,1);
    fprintf("old: %d rows, new: %d rows, %.2f%% kept\n", oldsize, newsize, newsize / oldsize * 100)
end
if string(fill) == "filldata"
    fprintf("filling missing data\n")
    nans = sum(isnan(data),"all");
    data = fillmissing(fillmissing(data, "previous"), "next");
    fprintf("filled %d NaNs (%.2f%% of data was NaN)\n", nans, nans / numel(data));
end

%% Extract data
% generate tables
fprintf("generating table\n")
T = table();
T.time = data(:,1);

nodes = unique(header(2,2:end)); % all unique node names nodes[array of node names]
% for every node
for i = 1:length(nodes) 
    node = nodes(i);
    node_messages = unique(header(3, header(2,:) == node)); % all messages in a node
    temptable_nodes = table(); % table for current node

    % fprintf("╠═╤═%s\n", node)

    % for every message
    for j = 1:length(node_messages)
        message = node_messages(j);
        message_signals_cols = all([header(2,:) == node; header(3,:) == message], 1); % columns in data for all signals in current message
        message_signals = unique(header(4, message_signals_cols)); % get all signals for a mesage in a node
        temptable_messages = table(); % table for current message

        % fprintf("║ ├─┬─%s\n", message)

        % for every signal
        for k = 1:length(message_signals) 
            signal = message_signals(k);
            signal_cols = all([header(2,:) == node; header(3,:) == message; header(4,:) == signal], 1); % columns in data for current signal
            temptable_messages = addvars(temptable_messages, data(:, signal_cols), NewVariableNames=signal); % add signal to message table
            
            % fprintf("║ │ ├───%s\n", signal)
        end
        % fprintf("║ │\n")

        temptable_nodes = addvars(temptable_nodes, temptable_messages, NewVariableNames=message); % add message to node table
    end

    T = addvars(T, temptable_nodes, NewVariableNames=node); % add node to main table
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