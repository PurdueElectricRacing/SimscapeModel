%% define p
p = varController_Master_TVS();

%% get inputs
file_name = "TVS_5_10_24_N3";
folder_name = "Testing_Data/";
path_name = folder_name + file_name + ".csv";
X = make_inputs_csv_5_10_24(path_name);

%% Initialize tracking
Y = init_Y();

%% execute controller
for i = 1:n
    % fill in x
    x = fill_x(X,i);

    % do step
    y = tvs_step(p,x,y);

    % fill in Y
    Y = fill_Y(y, i);
end

%% save outputs
save(folder_name + "Y_" + file_name, "Y")