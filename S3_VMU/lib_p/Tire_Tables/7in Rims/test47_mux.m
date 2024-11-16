%% Find Data
num_entries = length(SA);
z_mux_47 = zeros(num_entries, 7);
counter = 1;

for j = 1:num_entries
    if abs(IA(j)) < 0.5 && abs(SA(j)) < 0.5
        z_mux_47(counter, 1) = FZ(j);
        z_mux_47(counter, 2) = SL(j);
        z_mux_47(counter, 3) = abs(FX(j)) / FZ(j);
        z_mux_47(counter, 4) = SA(j);
        z_mux_47(counter, 5) = IA(j);
        z_mux_47(counter, 6) = FY(j);
        z_mux_47(counter, 7) = FX(j);
        counter = counter + 1;
    end
end

z_mux_47( all(~z_mux_47,2), : ) = [];


%% Sort By FZ & Peak FX
% FZ categories
target_value = [205, 649, 860 1060];
tolerance = target_value .* 0.025;

% Peak FX
peaks = [550, 1750, 2300, 2800];
dip_from_peak = [200, 300, 500, 300];

% Initialize variables
num_data = length(z_mux_47);
FZ_mux = zeros(num_data, 7, 4);

% Filter, fill up FZ_mux
for i = 1:4
    counter = 1;
    for j = 1:num_data
        if abs(abs(z_mux_47(j, 1)) - target_value(i)) < tolerance(i)
            if abs(abs(z_mux_47(j, 7)) - peaks(i)) < dip_from_peak(i)
                FZ_mux(counter, 1, i) = z_mux_47(j, 3);
                FZ_mux(counter, 2, i) = z_mux_47(j, 7);
                FZ_mux(counter, 3, i) = z_mux_47(j, 1);
                FZ_mux(counter, 4, i) = z_mux_47(j, 2);
                FZ_mux(counter, 5, i) = z_mux_47(j, 4);
                FZ_mux(counter, 6, i) = z_mux_47(j, 5);
                FZ_mux(counter, 7, i) = z_mux_47(j, 6);
                counter = counter + 1;
            end
        end
    end
end


%% Data Analysis & Modeling
% Split up mu_x and format
FZ_200 = squeeze(FZ_mux(:,:,1));
FZ_200( all(~FZ_200,2), : ) = [];

FZ_600 = squeeze(FZ_mux(:,:,2));
FZ_600( all(~FZ_600,2), : ) = [];

FZ_800 = squeeze(FZ_mux(:,:,3));
FZ_800( all(~FZ_800,2), : ) = [];

FZ_1000 = squeeze(FZ_mux(:,:,4));
FZ_1000( all(~FZ_1000,2), : ) = [];

% Compute mu_x
mux_200 = mean(FZ_200(:,1));
mux_600 = mean(FZ_600(:,1));
mux_800 = mean(FZ_800(:,1));
mux_1000 = mean(FZ_1000(:,1));

mu_x = abs([mux_200 mux_600 mux_800 mux_1000]);

% compute FZ
FZ_200_avg = mean(FZ_200(:,3));
FZ_600_avg = mean(FZ_600(:,3));
FZ_800_avg = mean(FZ_800(:,3));
FZ_1000_avg = mean(FZ_1000(:,3));

FZ_x = [FZ_200_avg FZ_600_avg FZ_800_avg FZ_1000_avg];

% compute mu_x = f(FZ)
mu_x_eqn = polyfit(FZ_x, mu_x, 3);

data = [abs(FZ_x') mu_x'];

% display results
disp(mu_x)
disp(FZ_x)
