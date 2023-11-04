function readData(src, ~)
    % Parameters
    Tx = [0 0 250 0]; % Torque Command, 0-4095
    Startup_Size = 100; % Number of Sample before motor triggers
    Sample_Size = 350; % Number of Samples to Collect with Motor Active
    Shutoff_Size = 100; %Number of Samples to Collect after Motor Triggers

    % Read the ASCII data from the serialport object.
    data = readline(src);
    input_data = sprintf("FL%04dFR%04dRL%04dRR%04d", Tx(1), Tx(2), Tx(3), Tx(4));
    zero = sprintf("FL%04dFR%04dRL%04dRR%04d", 0, 0, 0, 0);

    if mod(src.UserData.Count, Sample_Size + Startup_Size + Shutoff_Size) > (Sample_Size + Startup_Size)
        writeline(src, zero);
    elseif mod(src.UserData.Count, Sample_Size + Startup_Size + Shutoff_Size) < Startup_Size
    else
        writeline(src, input_data);
    end
    
    % Convert the string data to numeric type and save it in the UserData
    % property of the serialport object.
    data = strsplit(data,',');
    disp(str2double(data));

    src.UserData.Data(end+1, :) = str2double(data);
    
    % Update the Count value of the serialport object.
    src.UserData.Count = src.UserData.Count + 1;
    
    if mod(src.UserData.Count, Sample_Size + Startup_Size + Shutoff_Size) >= Startup_Size + Sample_Size + Shutoff_Size-1
        configureCallback(src, "off");

        filename = 'motor_data.mat';
        load(filename);
        motor_I = [motor_I; src.UserData.Data(:,1)./100];
        motor_V = [motor_V; src.UserData.Data(:,2)./100];
        motor_W = [motor_W; src.UserData.Data(:,3).*0.104719755./10];
        motor_K = [motor_K; src.UserData.Data(:,5)./100];

        clearvars -except motor_I motor_V motor_W motor_K filename
        save(filename)
    end
end