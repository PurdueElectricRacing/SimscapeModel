function [] = struct2c(struct, output)
% Takes a struct, generates c code to fill values into struct

fid = fopen(output, 'w');

fields = string(fieldnames(struct));
numFields = length(fields);
for i = 1:numFields
    % print single values with 7 decimals, trailing zeros and . removed
    if isscalar(struct.(fields(i)))
        val = struct.(fields(i));
        valstr = rmzeros(sprintf("%.7f", val));
        fprintf(fid, ".%s = %s", fields(i), valstr);
        if i~=numFields
            fprintf(fid, ",\n");
        end
    
    % print array with 7 decimals, word wrap at 80 characters
    elseif ismatrix(struct.(fields(i)))
        wrapped = false;
        val = struct.(fields(i));
        len_val = length(val(:));    

        % header for array
        header = sprintf(".%s = {", fields(i));
        fprintf(fid, header);

        len_line = strlength(header);
        for j = 1:len_val
            el = val(j);
            elstr = rmzeros(sprintf("%.7f", el));

            % length of current line + unprinted new element "elstr"
            len_line = len_line + strlength(elstr) + 1 + (j~=len_val);
            
            if len_line > 80 % wrap to newline
                wrapped = true;
                if j ~= 1
                    fprintf(fid, ",");
                end
                fprintf(fid, "\n");
                len_line = strlength(elstr) + 2;
                fprintf(fid, "%s", elstr);
            else
                if j ~= 1
                    fprintf(fid, ", ");
                end
                fprintf(fid, "%s", elstr);
            end
        end

        % closing brackets
        fprintf(fid, "}");
        if i~=numFields
            fprintf(fid, ",\n");
        end
        if wrapped % print extra line of space if array was wrapped
            fprintf(fid, "\n"); 
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
