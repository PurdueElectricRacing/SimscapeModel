function s = class2struct(c)
    s = struct;

    fields = string(fieldnames(c));
    n = length(fields);

    for i = 1:n
        s.(fields(i)) = c.(fields(i));
    end
end