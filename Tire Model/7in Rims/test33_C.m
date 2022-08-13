%% Find Data
num_entries = length(SA);
z_C_33 = zeros(num_entries, 6);
counter = 1;

for j = 1:num_entries
    if abs(IA(j)) < 0.5 && abs(SA(j)) < 1
        z_C_33(counter, 1) = abs(FZ(j));
        z_C_33(counter, 2) = SL(j);
        z_C_33(counter, 3) = abs(SA(j) .* (pi / 180));
        z_C_33(counter, 4) = IA(j);
        z_C_33(counter, 5) = abs(FY(j));
        z_C_33(counter, 6) = abs(FX(j));
        counter = counter + 1;
    end
end

z_C_33( all(~z_C_33,2), : ) = [];


%% Sort By FZ
% FZ categories
target_value = [207 431 656 876 1101];
tolerance = target_value.*0.05;

% Initialize variables
num_data = length(z_C_33);
FZ_mux = zeros(num_data, 6, 5);

% Filter, fill up FZ_mux
for i = 1:5
    counter = 1;
    for j = 1:num_data
        if abs(abs(z_C_33(j, 1)) - target_value(i)) < tolerance(i)
            FZ_mux(counter, 1, i) = z_C_33(j, 1);
            FZ_mux(counter, 2, i) = z_C_33(j, 2);
            FZ_mux(counter, 3, i) = z_C_33(j, 3);
            FZ_mux(counter, 4, i) = z_C_33(j, 4);
            FZ_mux(counter, 5, i) = z_C_33(j, 5);
            FZ_mux(counter, 6, i) = z_C_33(j, 6);
            counter = counter + 1;
        end
    end
end


%% Data Analysis & Modeling
% Split up mu_y and format
FZ_200 = squeeze(FZ_mux(:,:,1));
FZ_200( all(~FZ_200,2), : ) = [];

FZ_400 = squeeze(FZ_mux(:,:,2));
FZ_400( all(~FZ_400,2), : ) = [];

FZ_600 = squeeze(FZ_mux(:,:,3));
FZ_600( all(~FZ_600,2), : ) = [];

FZ_800 = squeeze(FZ_mux(:,:,4));
FZ_800( all(~FZ_800,2), : ) = [];

FZ_1000 = squeeze(FZ_mux(:,:,5));
FZ_1000( all(~FZ_1000,2), : ) = [];

% compute FZ
FZ_200_avg = mean(FZ_200(:,1));
FZ_400_avg = mean(FZ_400(:,1));
FZ_600_avg = mean(FZ_600(:,1));
FZ_800_avg = mean(FZ_800(:,1));
FZ_1000_avg = mean(FZ_1000(:,1));

FZ_y = [FZ_200_avg FZ_400_avg FZ_600_avg FZ_800_avg FZ_1000_avg];

% Find C at each FZ
FY_SA_200 = polyfit(FZ_200(:,3), FZ_200(:,5), 1);
FY_SA_400 = polyfit(FZ_400(:,3), FZ_400(:,5), 1);
FY_SA_600 = polyfit(FZ_600(:,3), FZ_600(:,5), 1);
FY_SA_800 = polyfit(FZ_800(:,3), FZ_800(:,5), 1);
FY_SA_1000 = polyfit(FZ_1000(:,3), FZ_1000(:,5), 1);

FY_SA = [FY_SA_200(1) FY_SA_400(1) FY_SA_600(1) FY_SA_800(1) FY_SA_1000(1)];

% compute G = f(FZ)
C_47 = polyfit(FZ_y, FY_SA, 3);

data = [abs(FZ_y') FY_SA'];

% display results
disp(FY_SA)
disp(FZ_y)
