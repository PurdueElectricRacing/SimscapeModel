%% Startup
%clearvars -except dx limit_velocity_coeffs
clc;

%% Parameters
% Initial position, vehicle coordinate system
Xi = 0;
Yi = 0;

% import data
load("PROCESSED_DATA\Track_Tables.mat");

% all generated tracks
event_names = ["acceleration", "skidpad", "austria_endurance", "l_square", "r_square", "short_oc", "grand_prix", "track_Left", "track_Right", "long_straight", "grand_prix_5", "acceleration_testing"];
sweep_names = ["ccw_steering"];

% path to all track files
PATH = "RAW_DATA/";

% selected track to update or add
track_name = event_names(12); % notepad file name

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);
opts.DataLines = [1, Inf];
opts.Delimiter = "\t";
opts.VariableNames = ["s", "d", "r"];
opts.VariableTypes = ["categorical", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, "s", "EmptyFieldRule", "auto");

% Import the data
All_data = readtable(PATH + track_name + ".txt", opts);
track_xy = table2array(All_data(:,2:end));

%% Initialize Variables
if All_data{1, 1} == "Left"
    sign_temp = -1;
else
    sign_temp = 1;
end
m = [inf];
target_radius = [track_xy(1, 2)];
num_sections = length(track_xy(:,1));
turn_direction = [0];
num_coordinates = ceil(sum(track_xy(:, 1)) / dx);
track_data = zeros(num_coordinates, 3);
x3 = [Xi];
y3 = [Yi];
x1 = [x3];
y1 = [(sign_temp*track_xy(1, 2)) + y3];
xc = [x1];
yc = [y1];
r = [inf];
psi = [0];
x0 = 0;
y0 = 0;
prev_turn = All_data{1, 1};
counter = 2;
di = [1000];
limit_velocity = [];
absolute_position_x = [track_xy(1,1)];

straights = [15 25 35 45 55 65 75]; % m
entrance_v = [5 10 15]; % m/s
exit_v = [5 10 15]; % m/s

top_data = [];

%% Generate Track
for k = exit_v
    for j = entrance_v
        for i = straights
            top_data(end+1,:) = [i j k];
        end
    end
end

num_sections = length(top_data(:,1));

for i = 1:num_sections
    % reach ss velocity
    for j = 1:400
        y3(end+1) = 0;
        x3(end+1) = x3(end) + 0.1;
        r(end+1) = inf;
        m(end+1) = inf;
        turn_direction(end+1) = 0;
        yc(end+1) = 0;
        xc(end+1) = 0;
        psi(end+1) = 0;
        di(end+1) = 400 - j + 1;
    end

    limit_velocity(end+1) = top_data(i,2);
    absolute_position_x(end+1) = absolute_position_x(end) + track_xy(2*i,1);

    % do the distance
    for j = 1:top_data(i,1)*10
        y3(end+1) = 0;
        x3(end+1) = x3(end) + 0.1;
        r(end+1) = inf;
        m(end+1) = inf;
        turn_direction(end+1) = 0;
        yc(end+1) = 0;
        xc(end+1) = 0;
        psi(end+1) = 0;
        di(end+1) = (top_data(i,1)*10) - j + 1;
    end

    limit_velocity(end+1) = top_data(i,3);
    absolute_position_x(end+1) = absolute_position_x(end) + track_xy((2*i)+1,1);

    if i == num_sections
            for j = 1:400
                y3(end+1) = 0;
                x3(end+1) = x3(end) + 0.1;
                r(end+1) = inf;
                m(end+1) = inf;
                turn_direction(end+1) = 0;
                yc(end+1) = 0;
                xc(end+1) = 0;
                psi(end+1) = 0;
                di(end+1) = 400 - j + 1;
            end
    end
end

All_data(end+1,:) = All_data(end,:);
limit_velocity(end+1) = limit_velocity(end);
limit_velocity(end+1) = limit_velocity(end);
absolute_position_x(end+1) = absolute_position_x(end) + track_xy(i+1,1);
All_data.v = limit_velocity';
All_data.p = absolute_position_x';
MIN_TRACK_DATA.(track_name) = All_data{:,2:end};
ALL_TRACK_DATA.(track_name) = [m' y3' x3' r' turn_direction' yc', xc', psi', di'];


%% Save Track Data
clearvars -except ALL_TRACK_DATA event_names sweep_names MIN_TRACK_DATA

save("PROCESSED_DATA\Track_Tables.mat")