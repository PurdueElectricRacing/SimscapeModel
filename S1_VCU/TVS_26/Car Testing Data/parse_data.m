function [data] = parse_data(raw_data, header)
    % no_nan_rows = find(all(isnan(raw_data(:,2:end)),2));
    data = raw_data(any(~isnan(raw_data(:,2:end)),2),:);