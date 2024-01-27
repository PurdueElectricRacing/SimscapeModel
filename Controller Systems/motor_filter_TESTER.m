clear;
clc;
data = readmatrix("testing_data.csv");
incoming_commands = data(:,1:2);
TVS_ENABLE = data(:,3);
sent_commands = [0,0; incoming_commands(1,:)];
FINISHED = ones(length(incoming_commands));

for i=2:length(incoming_commands)
    disp(i)
    [sent_commands(i+1,:), FINISHED(i+1)] = motor_command_filter(incoming_commands(i,:), sent_commands(i,:), TVS_ENABLE(i), TVS_ENABLE(i-1), FINISHED(i));
    disp(FINISHED(i))
end
plot(incoming_commands,Color="blue",Marker="x",MarkerSize=3)
hold on
plot(sent_commands(2:end,:), Color="red",Marker="+",MarkerSize=3)
plot(TVS_ENABLE,color="black",LineStyle="none",Marker=".",MarkerSize=5)
ylim([0,1])
