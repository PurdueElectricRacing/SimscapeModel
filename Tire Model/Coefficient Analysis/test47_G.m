%% Find Data
num_entries = length(SA);
z_G_47 = zeros(num_entries, 6);
counter = 1;

for j = 1:num_entries
    if abs(SA(j)) < 0.5 && abs(SL(j)) < 0.05
        z_G_47(counter, 1) = abs(FZ(j));
        z_G_47(counter, 2) = SL(j);
        z_G_47(counter, 3) = SA(j);
        z_G_47(counter, 4) = IA(j);
        z_G_47(counter, 5) = FY(j);
        z_G_47(counter, 6) = FX(j);
        counter = counter + 1;
    end
end

z_G_47( all(~z_G_47,2), : ) = [];


%% Sort By FZ
% FZ categories
target_value = [198, 644, 855 1073];
tolerance = target_value.*0.05;

% Initialize variables
num_data = length(z_G_47);
FZ_mux = zeros(num_data, 6, 4);

% Filter, fill up FZ_mux
for i = 1:4
    counter = 1;
    for j = 1:num_data
        if abs(abs(z_G_47(j, 1)) - target_value(i)) < tolerance(i)
            FZ_mux(counter, 1, i) = z_G_47(j, 1);
            FZ_mux(counter, 2, i) = z_G_47(j, 2);
            FZ_mux(counter, 3, i) = z_G_47(j, 3);
            FZ_mux(counter, 4, i) = z_G_47(j, 4);
            FZ_mux(counter, 5, i) = z_G_47(j, 5);
            FZ_mux(counter, 6, i) = z_G_47(j, 6);
            counter = counter + 1;
        end
    end
end


%% Data Analysis & Modeling
% Split up mu_y and format
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

FZ_y = [FZ_200_avg FZ_600_avg FZ_800_avg FZ_1000_avg];

% Find G at each FZ
FY_IA_200 = polyfit(FZ_200(:,4), FZ_200(:,5), 1);
FY_IA_600 = polyfit(FZ_600(:,4), FZ_600(:,5), 1);
FY_IA_800 = polyfit(FZ_800(:,4), FZ_800(:,5), 1);
FY_IA_1000 = polyfit(FZ_1000(:,4), FZ_1000(:,5), 1);

FY_IA = [FY_IA_200(1) FY_IA_600(1) FY_IA_800(1) FY_IA_1000(1)];

% compute G = f(FZ)
G_47 = polyfit(FZ_y, FY_IA, 3);

data = [abs(FZ_y') FY_IA'];

% display results
disp(FY_IA)
disp(FZ_y)
