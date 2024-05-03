%% Import Data
opts = delimitedTextImportOptions("NumVariables", 5);
opts.DataLines = [5, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["Bus", "Main", "Main_1", "Main_2", "Main_3"];
opts.VariableTypes = ["double", "double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
data = readtable("C:\Users\Inver\Documents\GitHub\SimscapeModel\M1_Filters\Yaw Rate Filter\4_20_2024_data.csv", opts);
data = table2array(data);
clear opts

%% Define Parameters
N = 30;  % number of data points to filter
n = 2;   % order of polynomial to fit
dtheta_max = 180;

%% Extract Parameters
t = data(:,1);
vehHead = data(:,2);
yaw_rate = data(:,5);

%% Do filter
% Requirements:
% 1. Must Remove non-unique numbers
% 2. Must remove discontinuities in orientation
% 3. 
M = length(data(:,1)) - 40*N;
vehHead_cont = zeros(N,1);
yaw_rate_GPS = zeros(M,1);
t_GPS = zeros(M,1);

for i = 1:M
    k = 1;
    vehHead_raw(1) = vehHead(i);
    t_vec(1) = t(i);

    for l = 2:N
        while (vehHead_raw(l-1) == vehHead(i+k))
            k = k + 1;
        end
        vehHead_raw(l) = vehHead(i+k);
        t_vec(l) = t(i+k) - t_vec(1);
    end

    t_vec(1) = t_vec(1) - t(i);
    vehHead_cont(1) = vehHead_raw(1);
    for j = 1:N-1
        dtheta = vehHead_cont(j) - vehHead_raw(j+1);
        if (dtheta > dtheta_max)
            vehHead_cont(j+1) = vehHead_raw(j+1) + 2*dtheta_max;
        elseif (dtheta < -dtheta_max)
            vehHead_cont(j+1) = vehHead_raw(j+1) - 2*dtheta_max;
        else
            vehHead_cont(j+1) = vehHead_raw(j+1);
        end
    end
    coeffs = polyfit(t_vec,vehHead_cont,n);

    t_GPS(i) = t_vec(end) + t(i);
    yaw_rate_GPS(i) = (2*coeffs(1)*t_vec(end) + coeffs(2)) * (pi/180);    
end

%% Plotting
figure(1)
plot(t_GPS, -yaw_rate_GPS)
hold on
plot(t,yaw_rate)
legend("GPS","IMU")