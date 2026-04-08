function [] = create_c_init(names, files, output)
fout = fopen(output, 'w');
for cnum = 1:length(names)
    lines = readlines(files(cnum));
    fprintf(fout, "%s_struct init_%s(void) {\n", names(cnum), names(cnum));
    fprintf(fout, "    %s_struct %s = {\n", names(cnum), names(cnum));
    fprintf(fout, "        %s\n", lines);
    fprintf(fout, "    };\n");
    fprintf(fout,"}\n");
    if cnum ~= length(names)
        fprintf(fout, "\n\n");
    end
end
fclose(fout);
end