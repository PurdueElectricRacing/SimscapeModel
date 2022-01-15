%% Find Data
num_entries = length(SA);
z_muy_33 = zeros(num_entries, 7);
counter = 1;

for j = 1:num_entries
    if abs(IA(j)) < 0.5
        z_muy_33(counter, 1) = FZ(j);
        z_muy_33(counter, 2) = SL(j);
        z_muy_33(counter, 3) = abs(FY(j) / FZ(j));
        z_muy_33(counter, 4) = SA(j);
        z_muy_33(counter, 5) = IA(j);
        z_muy_33(counter, 6) = abs(FY(j));
        z_muy_33(counter, 7) = abs(FX(j));
        counter = counter + 1;
    end
end

z_muy_33( all(~z_muy_33,2), : ) = [];


%% Sort By FZ & Peak FY
% FZ categories
target_value = [207 431 656 876 1101];
tolerance = target_value.*0.025;

% Peak FY
peaks = [670 1250, 1820, 2310 2760];
dip_from_peak = [70, 150, 170, 140 201];

% Initialize variables
num_data = length(z_muy_33);
FZ_mux = zeros(num_data, 7, 5);

% Filter, fill up FZ_mux
for i = 1:5
    counter = 1;
    for j = 1:num_data
        if abs(abs(z_muy_33(j, 1)) - target_value(i)) < tolerance(i)
            if abs(abs(z_muy_33(j, 6)) - peaks(i)) < dip_from_peak(i)
                FZ_mux(counter, 1, i) = z_muy_33(j, 3);
                FZ_mux(counter, 2, i) = z_muy_33(j, 6);
                FZ_mux(counter, 3, i) = z_muy_33(j, 1);
                FZ_mux(counter, 4, i) = z_muy_33(j, 2);
                FZ_mux(counter, 5, i) = z_muy_33(j, 4);
                FZ_mux(counter, 6, i) = z_muy_33(j, 5);
                FZ_mux(counter, 7, i) = z_muy_33(j, 7);
                counter = counter + 1;
            end
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

% Compute mu_y
muy_200 = mean(FZ_200(:,1));
muy_400 = mean(FZ_400(:,1));
muy_600 = mean(FZ_600(:,1));
muy_800 = mean(FZ_800(:,1));
muy_1000 = mean(FZ_1000(:,1));

mu_y = abs([muy_200 muy_400 muy_600 muy_800 muy_1000]);

% compute FZ
FZ_200_avg = mean(FZ_200(:,3));
FZ_400_avg = mean(FZ_400(:,3));
FZ_600_avg = mean(FZ_600(:,3));
FZ_800_avg = mean(FZ_800(:,3));
FZ_1000_avg = mean(FZ_1000(:,3));

FZ_y = [FZ_200_avg FZ_400_avg FZ_600_avg FZ_800_avg FZ_1000_avg];

% compute mu_y = f(FZ)
mu_y_eqn = polyfit(FZ_y, mu_y, 3);

data = [abs(FZ_y') mu_y'];

% display results
disp(mu_y)
disp(FZ_y)
