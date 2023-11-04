function readData(src, ~)
    % Parameters
    Startup_Size = 100; % Number of Sample before motor triggers
    Sample_Size = 350; % Number of Samples to Collect with Motor Active
    Shutoff_Size = 1; %Number of Samples to Collect after Motor Triggers

    
    Tx = [0];
    
    % Read the ASCII data from the serialport object.
    data = readline(src);
    input_data = sprintf("%04d", Tx(1));
    %zero = sprintf("FL%04dFR%04dRL%04dRR%04d", 0);


    writeline(src, input_data);
    
    % Convert the string data to numeric type and save it in the UserData
    % property of the serialport object.
    data = strsplit(data,',');
    disp(str2double(data));

    src.UserData.Data(end+1, :) = str2double(data);
    
    if src.UserData.Count > ((Startup_Size + Sample_Size+10))
        configureCallback(src, "off");
        
        readings = src.UserData.Data(:,1);

        clearvars -except readings
        save('force_data.mat')
    end

    % Update the Count value of the serialport object.
    src.UserData.Count = src.UserData.Count + 1;

end