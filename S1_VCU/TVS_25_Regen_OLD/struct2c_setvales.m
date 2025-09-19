function [] = struct2c_setvales(struct, name, output)
% Takes a struct, generates c code to set values of a struct
% !does not overwrite output file!

fid = fopen(output, 'a');

fields = string(fieldnames(struct));
numFields = length(fields);
for i = 1:numFields
    % print single values with 7 decimals, trailing zeros and . removed
    if isscalar(struct.(fields(i)))
        val = struct.(fields(i));
        valstr = rmzeros(sprintf("%.7f", val));
        fprintf(fid, "%s->%s = %s;\n", name, fields(i), valstr);
    
    % print array with 7 decimals, word wrap at 80 characters
    elseif ismatrix(struct.(fields(i)))
        val = struct.(fields(i));
        header = sprintf("%s->%s", name, fields(i));
        for j = 1:length(val)
            elstr = rmzeros(sprintf("%.7f", val(j)));
            fprintf(fid, header);
            fprintf(fid, "[%i] = %s;\n", j-1, elstr);
        end
    else
        error(fields(i) + " is not a scalar or a matrix");
    end
end

fclose(fid);

function [str] = rmzeros(str)
    str = strip(strip(str, "right", "0"), "right", ".");
end
end