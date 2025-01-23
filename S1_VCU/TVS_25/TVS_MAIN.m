%% define p
p = varController_Master_TVS();

%% get binary and rational inputs
file_name = "TVS_5_10_24_N3";
folder_name = "Testing_Data/";
F = table2array(readtable(folder_name + file_name + ".xlsx", "Sheet", "Flag"));
X = table2array(readtable(folder_name + file_name + ".xlsx", "Sheet", "Data"));

%% Initialize tracking
Y = init_Y();

%% execute controller
for i = 1:n
    % fill in f
    f = fill_f(F,i);

    % fill in x
    x = fill_x(X,i);

    % do step
    y = tvs_step(p,f,x,y);

    % fill in Y
    Y = fill_Y(y, i);
end

%% save outputs
save(folder_name + "Y_" + file_name, "Y")