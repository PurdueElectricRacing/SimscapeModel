%% initialize data structs
p = pVCU_Master();
f = fVCU_Master();
x = xVCU_Master();
y = yVCU_Master();

%% get all integer and rational inputs
file_name = "TVS_5_10_24_N3";
folder_name = "Testing_Data/";
F = table2array(readtable(folder_name + file_name + ".xlsx", "Sheet", "Flag"));
X = table2array(readtable(folder_name + file_name + ".xlsx", "Sheet", "Data"));

%% Initialize tracking
% Y = init_Y();

%% execute controller
n = length(F(:,1));
for i = 1:n
    % fill in f
    f = fill_f(F, f, i);

    % fill in x
    x = fill_x(X, x, i);

    % do step
    y = tvs_step(p,f,x,y);

    % fill in Y
    Y = fill_Y(y, i);
end

%% save outputs
save(folder_name + "Y_" + file_name, "Y")