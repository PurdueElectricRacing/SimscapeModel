%% Clear All
clear;
clc;

%% Define Data
data = readmatrix("testing_data.csv");
incoming_commands = data(:,1:2);
TVS_ENABLE = data(:,3);
sent_commands = [0,0; incoming_commands(1,:)];
FINISHED = ones(length(incoming_commands),1);
equal_commands = max(incoming_commands,[],2)*[1 1];

%% Define Parameters
alpha = 0.1;
dk_thresh = 0.05;

%% Test Function
for i=2:length(incoming_commands)
    disp(i)
    [sent_commands(i+1,:), ~, FINISHED(i+1)] = motor_command_filter(incoming_commands(i,:), equal_commands(i,:), TVS_ENABLE(i), TVS_ENABLE(i-1), sent_commands(i,:), FINISHED(i),alpha,dk_thresh);
    disp(FINISHED(i))
end

%% Visualize Results
plot(incoming_commands,Color="blue",Marker="x",MarkerSize=3)
hold on
plot(sent_commands(2:end,:), Color="red",Marker="+",MarkerSize=3)
hold on
plot(TVS_ENABLE,color="black",LineStyle="none",Marker=".",MarkerSize=5)
ylim([0,1])
legend("TVS Command Left", "TVS Command Right", "Filtered Command Left", "Filtered Command Right", "TVS Enable")
