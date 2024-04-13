load('proper_motor_data.mat');

%% Filter out the dead tests by killing data values associated with the motor not moving
harr_motor_I = motor_I(motor_W ~= 0);
harr_motor_K = motor_K(motor_W ~= 0);
harr_motor_V = motor_V(motor_W ~= 0);
harr_motor_W = motor_W(motor_W ~= 0);

%Graph it
%scatter3(harr_motor_W, harr_motor_V .* harr_motor_K ./ 100, harr_motor_I);

%% Filter out the time between tests by killing data values associated with no power being sent

double_filter_I = harr_motor_I(harr_motor_K ~= 0);
double_filter_K = harr_motor_K(harr_motor_K ~= 0);
double_filter_V = harr_motor_V(harr_motor_K ~= 0);
double_filter_W = harr_motor_W(harr_motor_K ~= 0);

%Graph it
%scatter3(double_filter_W, double_filter_V .* double_filter_K ./ 100, double_filter_I);

%% Filter out the test transition by killing the ten values associated with a change in the motorK values

prevI = 5;

newK = [];
newI = [];
newV = [];
newW = [];

for i = 2:1:length(double_filter_K)
    
    if((double_filter_K(i) - double_filter_K(i-1)) ~= 0)
        newK = cat(1,newK,double_filter_K(prevI:i-5));
        newI = cat(1,newI,double_filter_I(prevI:i-5));
        newV = cat(1,newV,double_filter_V(prevI:i-5));
        newW = cat(1,newW,double_filter_W(prevI:i-5));

        prevI = i+5;
    end

end

figure;
plot([1:length(newI)],newI,"b",[1:length(newK)],newK,"r");

figure
scatter3(newW, newV .* newK ./ 100, newI);

% %% Current Sensor Noise Analysis
% fs = 1/0.015; % sampling frequency
% pos_test = [1; find(newK(2:end) - newK(1:end-1)) + 1];
% 
% curr_TD = newI(pos_test(1):pos_test(2));
% curr_freq = fft(curr_TD);
% num_elem = length(curr_TD);
% f = fs*(0:(num_elem/2))/num_elem;
% 
% P2 = abs(curr_freq/num_elem);
% P1 = P2(1:num_elem/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% 
% plot(f,P1) 
% title("Single-Sided Amplitude Spectrum of X(t)")
% xlabel("f (Hz)")
% ylabel("|P1(f)|")
% 
% %% Parse beginning of each test set
% Data_Jump_Size = 341;
% 
% k_data_points = zeros(20,1);
% for i = 1:size(newK,1)
%     k_data_points(i,:) = i + (Data_Jump_Size * (i-1));
% end
% 
% i_data_points = zeros(20,1);
% for i = 1:size(newI,1)
%     i_data_points(i,:) = i + (Data_Jump_Size * (i-1));
% end
% 
% v_data_points = zeros(20,1);
% for i = 1:size(newV,1)
%     i_data_points(i,:) = i + (Data_Jump_Size * (i-1));
% end
% 
% w_data_points = zeros(20,1);
% for i = 1:size(newW,1)
%     w_data_points(i,:) = i + (Data_Jump_Size * (i-1));
% end
% 
% x_axis_points = zeros(1,20);
% for i = 1:size(k_data_points,1)
%     x_axis_points(i,:) = i * 1:size(v_data_points,1);
% end
% 
% plot(x_axis_points, w_data_points, i_data_points)
% title("torque")
% xlabel("Motor Command x Voltage")
% ylabel("Wheel speed")
% zlabel("Current")