incoming_commands = [[1 .5; 1 .5; 1 .5;]; ones(25,2)-.25];
sent_commands = [incoming_commands(1,:);zeros(size(incoming_commands))];
TVS_ENABLE = [1 1 1,zeros(1,length(incoming_commands)-3)];

for i=1:length(incoming_commands)
    sent_commands(i+1,:) = motor_command_filter(incoming_commands(i,:), sent_commands(i,:), TVS_ENABLE(i));
end
plot(incoming_commands,Color="blue",Marker="x",MarkerSize=3)
hold on
plot(sent_commands(2:end,:), Color="red",Marker="+",MarkerSize=3)
ylim([0,1])
