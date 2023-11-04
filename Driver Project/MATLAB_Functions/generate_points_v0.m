%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);
opts.DataLines = [1, Inf];
opts.Delimiter = "\t";
opts.VariableNames = ["s", "d", "r"];
opts.VariableTypes = ["categorical", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, "s", "EmptyFieldRule", "auto");
event_name = ["acceleration", "skidpad", "austria endurance", "l_square", "r_square", "short_oc"];

% Import the data
austriaendurance_sections = readtable("C:\Users\Inver\OneDrive\Desktop\LapSim Project\" + event_name(6) + ".txt", opts);
austriaendurance_data = table2array(austriaendurance_sections(:,2:end));
clear opts

%% Initial All Variables
step_size = 0.05;
multiply_factor = 1 / step_size;
num1 = length(austriaendurance_data(:,1));
num2 = ceil(sum(austriaendurance_data(:, 1)) * multiply_factor);
track_data = zeros(num2, 3);
target_radius = [austriaendurance_data(1, 2)];

if austriaendurance_sections{1, 1} == "Left"
    sign_temp = -1;
else
    sign_temp = 1;
end

x3 = [0];
y3 = [0];
x1 = [0];
y1 = [sign_temp*austriaendurance_data(1, 2)];
turn_direction = [0];
theta = [0];
m_x = [1];
m_y = [0];
m = [inf];
actual_radius = [0];
x0 = 0;
y0 = 0;
prev_turn = austriaendurance_sections{1, 1};
counter = 2;

%% Generate Track
for i = 1:num1
    % generate array of distance to decimate the current track segment
    num3 = floor(austriaendurance_data(i, 1) * multiply_factor);
    distances = [(0:step_size:step_size*num3)]' + track_data(counter-1, 1);

    if distances(end) ~= (austriaendurance_data(i, 1) + track_data(counter-1, 1))
        distances(end+1) = (austriaendurance_data(i, 1) + track_data(counter-1, 1));
        num3 = num3 + 1;       
    end

    track_data(counter:counter+num3, 1) = distances;
    counter = counter + num3 + 1;
    num2 = length(distances);
    
    % determine the center of curvature 
    if austriaendurance_sections{i, 1} ~= "Straight" 
        target_radius(end+1) = austriaendurance_data(i, 2);

        if austriaendurance_sections{i, 1} ~= prev_turn
            sign_center = -1;
        else
            sign_center = 1;
        end

        if target_radius(end-1) == 0
            target_radius(end-1) = target_radius(end);
            y0 = target_radius(end);
        end

        prev_turn = austriaendurance_sections{i, 1};

        x1(end+1) = x3(end) + (sign_center * (x1(end) + x0 - x3(end)) * abs(target_radius(end) / target_radius(end-1)));
        y1(end+1) = y3(end) + (sign_center * (y1(end) + y0 - y3(end)) * abs(target_radius(end) / target_radius(end-1)));
    end
     
    x0 = 0;
    y0 = 0;

    % iterate over every distance, and figure out the x & y coordinate
    for j = 1:num2-1
        if austriaendurance_sections{i, 1} == "Straight"
            turn_direction(end+1) = 0;
            theta(end+1) = 0;
            d = (distances(j+1) - distances(j));
            m(end+1) = m(end);
            m_y(end+1) = (sign(m_y(end)) * d) / (sqrt(m(end)^2 + 1));
            m_x(end+1) = sign(m_x(end)) * sqrt(d^2 - m_y(end)^2);

            y0 = y0 + m_y(end);
            x0 = x0 + m_x(end);

            x3(end+1) = x3(end) + m_x(end);
            y3(end+1) = y3(end) + m_y(end);
            actual_radius(end+1) = inf;
        else
            if austriaendurance_sections{i, 1} == "Left"
                turn_direction(end+1) = -1;
            else
                turn_direction(end+1) = 1;
            end

            theta(end+1) = (distances(j+1) - distances(j)) / target_radius(end);

            a = x3(end) - x1(end);
            b = x1(end);
            c = y3(end) - y1(end);
            d = y1(end);
            
            x_temp1 = a * cos(theta(end)) + b - sqrt(c^2 * sin(theta(end)^2));
            y_temp1 = c*cos(theta(end)) + d + (a*sqrt(c^2 * sin(theta(end)^2))/c);

            x_temp2 = a * cos(theta(end)) + b + sqrt(c^2 * sin(theta(end)^2));
            y_temp2 = c*cos(theta(end)) + d - (a*sqrt(c^2 * sin(theta(end)^2))/c);

            solx = [x_temp1, x_temp2];
            soly = [y_temp1 y_temp2];

            if (x3(end) == y3(end)) && (x3(end) == 0)
                x3(end+1) = solx(2);
                y3(end+1) = soly(2);
            else
                sol1_m = (y1(end) - soly(1)) / (solx(1) - x1(end));
                sol2_m = (y1(end) - soly(2)) / (solx(2) - x1(end));

                if austriaendurance_sections{i, 1} == "Left"
                    if (sol1_m > m(end)) && (sign(sol1_m) == sign(m(end)))% && ((sol2_m < m(end)) || (sign(sol2_m) ~= sign(m(end))))
                        x3(end+1) = solx(1);
                        y3(end+1) = soly(1);
                    elseif (sol2_m > m(end)) && (sign(sol2_m) == sign(m(end)))% && (sol1_m < m(end)) || (sign(sol1_m) ~= sign(m(end)))
                        x3(end+1) = solx(2);
                        y3(end+1) = soly(2);
                    elseif (sign(sol1_m) ~= sign(m(end))) %&& (sign(sol2_m) == sign(m(end)))
                        x3(end+1) = solx(1);
                        y3(end+1) = soly(1);
                    elseif (sign(sol2_m) ~= sign(m(end))) %&& (sign(sol1_m) == sign(m(end)))
                        x3(end+1) = solx(2);
                        y3(end+1) = soly(2);  
                    else
                        x3 = 0;
                        y3 = 0;
                    end
                else
                    if (sol1_m < m(end)) && (sign(sol1_m) == sign(m(end)))% && ((sol2_m > m(end)) || (sign(sol2_m) ~= sign(m(end))))
                        x3(end+1) = solx(1);
                        y3(end+1) = soly(1);
                    elseif (sol2_m < m(end)) && (sign(sol2_m) == sign(m(end)))% && (sol1_m > m(end)) || (sign(sol1_m) ~= sign(m(end)))
                        x3(end+1) = solx(2);
                        y3(end+1) = soly(2);
                    elseif (sign(sol1_m) ~= sign(m(end)))% && (sign(sol2_m) == sign(m(end)))
                        x3(end+1) = solx(1);
                        y3(end+1) = soly(1);
                    elseif (sign(sol2_m) ~= sign(m(end))) %&& (sign(sol1_m) == sign(m(end)))
                        x3(end+1) = solx(2);
                        y3(end+1) = soly(2); 
                    else
                        x3 = 0;
                        y3 = 0;
                    end
                end
            end

            m(end+1) = (y1(end) - y3(end)) / (x3(end) - x1(end));
            m_x(end+1) = (x3(end) - x1(end));
            m_y(end+1) = (y1(end) - y3(end));
            actual_radius(end+1) = sqrt((y1(end) - y3(end))^2 + (x3(end) - x1(end))^2);
        end
    end
end
