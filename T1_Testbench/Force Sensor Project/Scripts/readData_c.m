function readData(src, ~)
    % Parameters
    Startup_Size = 100; % Number of Sample before motor triggers
    Sample_Size = 350; % Number of Samples to Collect with Motor Active
    Shutoff_Size = 1; %Number of Samples to Collect after Motor Triggers

    
    Tx = [0, 0, 200 + (floor(src.UserData.Count / 451) * 100), 0];
    
    disp(Tx);

    % Read the ASCII data from the serialport object.
    data = readline(src);
    input_data = sprintf("FL%04dFR%04dRL%04dRR%04d", Tx(1), Tx(2), Tx(3), Tx(4));
    zero = sprintf("FL%04dFR%04dRL%04dRR%04d", 0, 0, 0, 0);


    if (mod(src.UserData.Count, 451)) > (Sample_Size + Startup_Size)
        writeline(src, zero);
    elseif (mod(src.UserData.Count, 451)) <= Startup_Size
        writeline(src, zero);
    else
        writeline(src, input_data);
    end
    
    % Convert the string data to numeric type and save it in the UserData
    % property of the serialport object.
    data = strsplit(data,',');
    disp(str2double(data));

    src.UserData.Data(end+1, :) = str2double(data);
    
    if src.UserData.Count > (8*(Startup_Size + Sample_Size+10))
        configureCallback(src, "off");
    end

    % Update the Count value of the serialport object.
    src.UserData.Count = src.UserData.Count + 1;


end