%% Find Data
num_entries = length(SA);
z_mux_47 = zeros(num_entries, 6);
counter = 1;

for j = 1:num_entries
    if abs(IA(j)) < 0.5 && abs(SA(j)) < 0.5 && abs(SL(j)) < 0.03
        z_mux_47(counter, 1) = abs(FZ(j));
        z_mux_47(counter, 2) = abs(SL(j));
        z_mux_47(counter, 3) = SA(j);
        z_mux_47(counter, 4) = IA(j);
        z_mux_47(counter, 5) = abs(FY(j));
        z_mux_47(counter, 6) = abs(FX(j));
        counter = counter + 1;
    end
end

z_mux_47( all(~z_mux_47,2), : ) = [];


%% Sort By FZ
% FZ categories
target_value = [205, 649, 860 1060];
tolerance = target_value .* 0.025;

% Initialize variables
num_data = length(z_mux_47);
FZ_mux = zeros(num_data, 6, 4);

% Filter, fill up FZ_mux
for i = 1:4
    counter = 1;
    for j = 1:num_data
        if abs(abs(z_mux_47(j, 1)) - target_value(i)) < tolerance(i)
            FZ_mux(counter, 1, i) = z_mux_47(j, 1);
            FZ_mux(counter, 2, i) = z_mux_47(j, 2);
            FZ_mux(counter, 3, i) = z_mux_47(j, 3);
            FZ_mux(counter, 4, i) = z_mux_47(j, 4);
            FZ_mux(counter, 5, i) = z_mux_47(j, 5);
            FZ_mux(counter, 6, i) = z_mux_47(j, 6);
            counter = counter + 1;
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

% compute FZ
FZ_200_avg = mean(FZ_200(:,1));
FZ_600_avg = mean(FZ_600(:,1));
FZ_800_avg = mean(FZ_800(:,1));
FZ_1000_avg = mean(FZ_1000(:,1));

FZ_x = [FZ_200_avg FZ_600_avg FZ_800_avg FZ_1000_avg];

% Find kx at each FZ
FY_KX_200 = polyfit(FZ_200(:,2), FZ_200(:,6), 1);
FY_KX_600 = polyfit(FZ_600(:,2), FZ_600(:,6), 1);
FY_KX_800 = polyfit(FZ_800(:,2), FZ_800(:,6), 1);
FY_KX_1000 = polyfit(FZ_1000(:,2), FZ_1000(:,6), 1);

FY_KX = [FY_KX_200(1) FY_KX_600(1) FY_KX_800(1) FY_KX_1000(1)];

% compute kx = f(FZ)
kx_eqn = polyfit(FZ_x, FY_KX, 3);

% manual check
data = [abs(FZ_x') FY_KX'];

% display results
disp(FY_KX)
disp(FZ_x)
