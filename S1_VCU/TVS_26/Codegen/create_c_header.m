function [] = create_c_header(names, postscript, files, output)
fout = fopen(output, 'w');

% copy c header data from .txt files, copy into c header file
for cnum = 1:length(names)
    lines = readlines(files(cnum));
    fprintf(fout, "typedef struct {\n");
    fprintf(fout, "    %s\n", lines);
    fprintf(fout, "} %s_struct;", names(cnum));
    if cnum ~= length(names)
        fprintf(fout, "\n\n");
    end
end
fprintf(fout, postscript);
fclose(fout);
end