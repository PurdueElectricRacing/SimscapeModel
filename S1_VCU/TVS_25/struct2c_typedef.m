function [] = struct2c_typedef(struct, output)
% Takes a struct, generates c code to fill values into struct

fid = fopen(output, 'w');

fields = string(fieldnames(struct));
numFields = length(fields);
for i = 1:numFields
    % print single values with 7 decimals, trailing zeros and . removed
    if isscalar(struct.(fields(i)))
        fprintf(fid, "float %s;", fields(i));
    
    % print array with 7 decimals, word wrap at 80 characters
    elseif ismatrix(struct.(fields(i)))
        val = struct.(fields(i));
        len_val = length(val(:));
        
        if isvector(val) || ismatrix(val) % header for arrays
            fprintf(fid, "float %s[%d];", fields(i), len_val);
        else
            error(fields(i) + " is not a vector or matrix")
        end
    else
        error(fields(i) + " is not a scalar or a matrix");
    end

    if i~=numFields
        fprintf(fid, "\n");
    end
end

fclose(fid);

end
