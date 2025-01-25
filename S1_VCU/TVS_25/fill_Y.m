function Y = fill_Y(Y, y)
    fields = fieldnames(y);
    n = length(fields);

    for i = 1:n
        Y.(fields(i)) = [Y.(fields(i)) y.(fields(i))];
    end
end