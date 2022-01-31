%% Find Data
counter = 1;
num_col = 7;
num_entries = length(SA);
z_mux_45 = zeros(num_entries, num_col);

 
for j = 1:num_entries
    if abs(IA(j)) < 0.5 && abs(SA(j)) < 0.5
        z_mux_45(counter, 1) = abs(FZ(j));
        z_mux_45(counter, 2) = SL(j);
        z_mux_45(counter, 3) = abs(FX(j) / FZ(j));
        z_mux_45(counter, 4) = SA(j);
        z_mux_45(counter, 5) = IA(j);
        z_mux_45(counter, 6) = FY(j);
        z_mux_45(counter, 7) = abs(FX(j));
        counter = counter + 1;
    end
end

z_mux_45( all(~z_mux_45,2), : ) = [];


%% Sort By FZ
% FZ categories
target_value = 1.25:2.5:1400;
n = length(target_value);
tolerance = 1.25;

% Initialize variables
num_data = length(z_mux_45);
FZ_mux = zeros(num_data, num_col, n);
temp = 0;

% Filter, fill up FZ_mux
for i = 1:n
    counter = 1;
    for j = 1:num_data
        if (abs(z_mux_45(j, 1) - target_value(i))) < tolerance
            FZ_mux(counter, 1, i) = z_mux_45(j, 3);
            FZ_mux(counter, 2, i) = z_mux_45(j, 7);
            FZ_mux(counter, 3, i) = z_mux_45(j, 1);
            FZ_mux(counter, 4, i) = z_mux_45(j, 2);
            FZ_mux(counter, 5, i) = z_mux_45(j, 4);
            FZ_mux(counter, 6, i) = z_mux_45(j, 5);
            FZ_mux(counter, 7, i) = z_mux_45(j, 6);
            counter = counter + 1;
        end
    end
end


%% Data Analysis & Modeling
mu_x = zeros(n, 1);
FZ_x = zeros(n, 1);
weights = zeros(n, 1);
filtered_FZ_mu = zeros(num_data, 1);
filtered_FZ_FZ = zeros(num_data, 1);

for i = 1:n
    % Extract a specific normal force block
    temp_FZ = squeeze(FZ_mux(:,:,i));
    temp_FZ( all(~temp_FZ,2), : ) = [];
    temp_max_FX = max(temp_FZ(:,2));
    l = length(temp_FZ(:, 1));
    tolerance = 200;
    
    % Define Filtered Data
%     counter = 1;
        
    for j = 1:l
        if (abs(temp_FZ(j,2) - temp_max_FX) < tolerance) && (temp_FZ(j,1) > 1.9)
            filtered_FZ_mu(counter) = temp_FZ(j, 1);
            filtered_FZ_FZ(counter) = temp_FZ(j, 3);
            
            counter = counter + 1;
        end
    end
    
    
%     filtered_FZ_mu( all(~filtered_FZ_mu,2), : ) = [];
%     filtered_FZ_FZ( all(~filtered_FZ_FZ,2), : ) = [];
%     mu_x(i) = abs(mean(filtered_FZ_mu));
%     FZ_x(i) = abs(mean(filtered_FZ_FZ));
%     weights(i) = length(filtered_FZ_FZ);
end


filtered_FZ_mu( all(~filtered_FZ_mu,2), : ) = [];
filtered_FZ_FZ( all(~filtered_FZ_FZ,2), : ) = [];

% Format Data
mu_x = rmmissing(mu_x);
FZ_x = rmmissing(FZ_x);
% weights( all(~weights,2), : ) = [];

% mu_x(weights < 5) = [];
% FZ_x(weights < 5) = [];
% weights(weights < 5) = [];


% compute mu_x = f(FZ)
% mu_x_eqn = polyfit(FZ_x, mu_x, 3);
% 
% data = [FZ_x mu_x weights];


limits = [0 260 700 920 1300];
num = 4;
p1 = zeros(num, 2);


for i = 1:num
    mu1 = filtered_FZ_mu(filtered_FZ_FZ < limits(i+1) & filtered_FZ_FZ > limits(i));
    FZ1 = filtered_FZ_FZ(filtered_FZ_FZ < limits(i+1) & filtered_FZ_FZ > limits(i));
    
    p1(i, :) = geomean([FZ1 mu1]);
end

data = [filtered_FZ_FZ filtered_FZ_mu];
