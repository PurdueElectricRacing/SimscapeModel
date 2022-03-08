% First Layer
mean_yaw_error = zeros(1, 1329);
std_yaw_error = zeros(1, 1329);
mean_track_error = zeros(1, 1329);
std_track_error = zeros(1, 1329);
P_matrix = [];
I_matrix = [];

% Second Layer
better_means_yaw = [];
better_stds_yaw = [];
better_means_track = [];
better_stds_track = [];
better_product = [];
P_first = [];
I_first = [];
i_first = [];

% Get Results
yaw_error = [];


% Product
P_second = [];
I_second = [];

% for i = 1:num1
%     for j = 1:num2
%         P_matrix(end+1) = P_all(i);
%         I_matrix(end+1) = I_all(j);
%     end
% end


for i = 1:651
   yaw_error_avg_temp = out(i).logsout.get('yaw_error').Values.Data;
   track_error_avg_temp = out(i).logsout.get('tracking_error').Values.Data;
   
   mean_yaw_error(i) = mean(abs(yaw_error_avg_temp));
   std_yaw_error(i) = std(yaw_error_avg_temp);
   
   mean_track_error(i) = mean(abs(track_error_avg_temp));
   std_track_error(i) = std(track_error_avg_temp);
end


for i = 1:651
%     if (abs(mean_yaw_error(i)) < 1) && (abs(std_yaw_error(i)) < 1)
      if P_all(i) > 3.5 && I_all(i) > 20 && I_all(i) < ((12.7*P_all(i))+1.26)
%         if (abs(mean_track_error(i)) < 1) && (abs(std_track_error(i)) < 2)
            better_means_yaw(end+1) = mean_yaw_error(i);
            better_stds_yaw(end+1) = std_yaw_error(i);
            better_means_track(end+1) = mean_track_error(i);
            better_stds_track(end+1) = std_track_error(i);
            P_first(end+1) = P_all(i);
            I_first(end+1) = I_all(i);
            i_first(end+1) = i;
%         end
      end
%     end
end

product = better_means_yaw .* better_means_track;
num4 = length(product);

for i = 1:num4
    if (abs(product(i)) < .0001)
        better_product(end+1) = product(i);
        P_second(end+1) = P_first(i);
        I_second(end+1) = I_first(i);
    end
end

num6 = length(i_first);
time_data = out(1).logsout.get('yaw_error').Values.Time;

for i = 1:num6
    yaw_error(end+1,:) = out(i).logsout.get('yaw_error').Values.Data;
end

% Plotting
m = -2;
b1 = 68;
b2 = 0;
x1 = 0:2:28;
x2 = 3;
x3 = 3:1:20;
y1 = (m .* x1) + b1;
y2 = 15;
y3 = (20 .* x3) + b2;
y4 = y3 - 100;
y5 = y1 + 80;


figure(1)
scatter(better_means_yaw, better_stds_yaw)

figure(8)
scatter(P_all, I_all)

figure(7)
scatter3(P_first, I_first, product)

figure(2)
scatter(better_means_track, better_stds_track)

figure(3)
scatter(P_second, I_second)

figure(4)
scatter(P_first, I_first)
hold on
plot(x1, y1)
hold on
xline(x2)
hold on
yline(y2)
hold on
plot(x3, y3)
hold on
plot(x3, y4)
hold on
plot(x1, y5)

figure(5)
scatter(time_data, yaw_error(1, :))