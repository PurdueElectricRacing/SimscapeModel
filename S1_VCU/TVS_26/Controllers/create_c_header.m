function [] = create_c_header(names, files, output)
fout = fopen(output, 'w');
for cnum = 1:length(names)
    lines = readlines(files(cnum));
    fprintf(fout, "typedef struct {\n");
    fprintf(fout, "    %s\n", lines);
    fprintf(fout, "} %s_struct;", names(cnum));
    if cnum ~= length(names)
        fprintf(fout, "\n\n");
    end
end
fclose(fout);
end