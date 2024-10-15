%% Parameters That Can Change
% PATH to the .txt files that store track data
PATH = [pwd '\Tracks\Tracks_Notepad\'];

% Name of each .txt file
event_names = ["acceleration", "skidpad", "austria endurance", "l_square", "r_square", "short_oc", "grand_prix"];

% Choose which of the .txt file from the list above
event_selection = 7;

% Distance between each coordinate to be generated
step_size = 0.1; % meters

% Initial position, vehicle coordinate system
Xi = 0; % meters
Yi = 0; % meters

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
All_data = readtable(PATH + event_names(event_selection) + ".txt", opts);
track_xy = table2array(All_data(:,2:end));


%% Initial Variables
if All_data{1, 1} == "Left"
    sign_temp = -1;
else
    sign_temp = 1;
end
m = [inf];
target_radius = [track_xy(1, 2)];
num_sections = length(track_xy(:,1));
turn_direction = [0];
num_coordinates = ceil(sum(track_xy(:, 1)) / step_size);
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


%% Generate Track
for i = 1:num_sections
    % generate array of distance to decimate the current track segment
    num3 = floor(track_xy(i, 1) / step_size);
    distances = [(0:step_size:step_size*num3)]' + track_data(counter-1, 1);

    if distances(end) ~= (track_xy(i, 1) + track_data(counter-1, 1))
        distances(end+1) = (track_xy(i, 1) + track_data(counter-1, 1));
        num3 = num3 + 1;       
    end

    track_data(counter:counter+num3, 1) = distances;
    counter = counter + num3 + 1;
    num_coordinates = length(distances);
   
    % determine the center of curvature 
    if All_data{i, 1} ~= "Straight" 
        target_radius(end+1) = track_xy(i, 2);

        if All_data{i, 1} ~= prev_turn && prev_turn ~= "Straight"
            sign_center = -1;
        elseif prev_turn == "Straight" && All_data{i, 1} == "Left"
            sign_center = -1;
        elseif prev_turn == "Straight" && All_data{i, 1} == "Right"
            sign_center = 1;
        else
            sign_center = 1;
        end

        if target_radius(end-1) == 0
            target_radius(end-1) = target_radius(end);
            y0 = target_radius(end);
        end

        prev_turn = All_data{i, 1};

        x1(end+1) = x3(end) + (sign_center * (x1(end) + x0 - x3(end)) * abs(target_radius(end) / target_radius(end-1)));
        y1(end+1) = y3(end) + (sign_center * (y1(end) + y0 - y3(end)) * abs(target_radius(end) / target_radius(end-1)));
    end
   
    % initialize track straight distance by component
    x0 = 0;
    y0 = 0;

    x_ref = x3(end);
    y_ref = y3(end);

    % iterate over every distance, and figure out the x & y coordinate
    for j = 1:num_coordinates-1
        xc(end+1) = x1(end);
        yc(end+1) = y1(end);
        % solve different geometric problem depending on steering
        if All_data{i, 1} == "Straight"
            turn_direction(end+1) = 0;
            % Solve the Straight geometric problem
            d = (distances(j+1) - distances(j));            
            y_temp_1 = -d / (sqrt(m(end)^2 + 1));
            x_temp_1 = sign(-1*m(end)) * sqrt(d^2 - y_temp_1^2) + x3(end);
            y_temp_1 = -d / (sqrt(m(end)^2 + 1)) + y3(end);
            y_temp_2 = d / (sqrt(m(end)^2 + 1));
            x_temp_2 = sign(m(end)) * sqrt(d^2 - y_temp_2^2) + x3(end); 
            y_temp_2 = d / (sqrt(m(end)^2 + 1)) + y3(end);
        else
            if All_data{i, 1} == "Right"
                turn_direction(end+1) = 1;
            else
                turn_direction(end+1) = -1;
            end

            % Solve the Turning geometric problem
            theta = (distances(j+1) - distances(j)) / target_radius(end);
            a = x3(end) - x1(end);
            b = x1(end);
            c = y3(end) - y1(end);
            d = y1(end);
            x_temp_1 = a * cos(theta) + b - sqrt(c^2 * sin(theta)^2);
            y_temp_1 = c*cos(theta) + d + (a*sqrt(c^2 * sin(theta)^2)/c);
            x_temp_2 = a * cos(theta) + b + sqrt(c^2 * sin(theta)^2);
            y_temp_2 = c*cos(theta) + d - (a*sqrt(c^2 * sin(theta)^2)/c);          
        end

        % Construct Solution Matrix
        solx = [x_temp_1, x_temp_2];
        soly = [y_temp_1 y_temp_2];

        % Determine delta distance for each solution
        if i > 1
            e1 = sqrt((solx(1) - x3(end-1))^2 + (soly(1) - y3(end-1))^2);
            e2 = sqrt((solx(2) - x3(end-1))^2 + (soly(2) - y3(end-1))^2);
        else
            e1 = 1;
            e2 = 50;
        end

        % Determine new coordinates
        if e1 > e2
            x3(end+1) = solx(1);
            y3(end+1) = soly(1);
        else
            x3(end+1) = solx(2);
            y3(end+1) = soly(2);
        end

        if All_data{i, 1} == "Straight"
            m(end+1) = m(end); 
            r(end+1) = inf;

            % Track straight distance by component
            y0 = y0 + (y3(end) - y3(end-1));
            x0 = x0 + (x3(end) - x3(end-1));
        else
            % compute slope of the most recent point
            m(end+1) = (y1(end) - y3(end)) / (x3(end) - x1(end));
            r(end+1) = target_radius(end);
        end

        % compute vehicle heading
        if turn_direction(end) ~= 0
            psi(end+1) = -atan2(y1(end) - y3(end), x3(end) - x1(end)) + pi/2;

            if psi(end) > pi
                psi(end) = psi(end) - 2*pi;
            end

            r1 = (y3(end) < y1(end)) && (turn_direction(end) == 1) && abs(psi(end)) > pi/2;
            r2 = (y3(end) > y1(end)) && (turn_direction(end) == 1) && abs(psi(end)) < pi/2;
            r3 = (y3(end) < y1(end)) && (turn_direction(end) == -1) && abs(psi(end)) < pi/2;
            r4 = (y3(end) > y1(end)) && (turn_direction(end) == -1) && abs(psi(end)) > pi/2;

            if r1 || r2 || r3 || r4
                heading_adjust = 1;
                if psi(end) < 0
                    psi(end) = psi(end) + pi;
                elseif psi(end) > 0
                    psi(end) = psi(end) - pi;
                end
            end
        else
            psi(end+1) = psi(end);
        end
    end
end

track_data = [m' y3' x3' r' turn_direction' yc', xc', psi'];