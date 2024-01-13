%% Function Description
% This function is the main function used for the wheel speed testbed.
% 
% required functions: readData_c
% Last Updated: 1/13/2024
% 

%% The Code
% Delete Previous Test
clear s

% Windows Serial Port
s = serialport("COM3",115200);

% Mac Serial Port
% s = serialport("/dev/tty.usbmodem103",115200);

% Erase Buffer
flush(s);

% Set the character that tells port that the message is finished
configureTerminator(s,"CR");

% Initialize data getting sent from microcontroller
s.UserData = struct("Data",[0 0 0 0 0 0 0 0],"Count",1);

% Start data transmission, provide function to run everytime data is sent
% from microcontroller
configureCallback(s,"terminator",@readData_c);