% clear s
% s = serialport("/dev/tty.usbmodem103",115200);

% motor_I = [0];
% motor_V = [0];
% motor_W = [0];
% motor_K = [0];
%  
% save('motor_data.mat')
% clear;
% clc;

clear s

s = serialport("COM3",115200);
flush(s);
configureTerminator(s,"CR");
s.UserData = struct("Data",0,"Count",1);
configureCallback(s,"terminator",@readData_f);