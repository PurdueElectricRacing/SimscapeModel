%% Import Data
load("random_testing_data.mat")
% data is [numSamples, 3] cell array
% each row is {xVCU, yVCU, fVCU}

%% Populate structs with defualt values
% initialize data classes
p = pVCU_Master();
y = yVCU_Master(p);

% convert to struct
p = class2struct(p);
y = class2struct(y);


%% Run matlab controller on imputs
% setup output array
numSamples = length(randDataCell);
outputCell = cell([numSamples, 1]);

% loop through data
for sample = 1:numSamples
    % set x, f directly, since all data in them is randomly generated
    x = randDataCell{sample, 1};
    f = randDataCell{sample, 3};
    % y = randDataCell{sample, 2};
    % for y, only overwrite
    rand_yVCU_flags = randDataCell{sample, 3};

    fs = fields(rand_yVCU_flags);
    for i = 1:length(fs)
        y.(fs{i}) = rand_yVCU_flags.(fs{i});
    end
    y_out = vcu_step(p, f, x, y);
    outputCell(sample, 1) = {y_out};
end