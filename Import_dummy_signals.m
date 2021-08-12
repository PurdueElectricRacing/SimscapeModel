filename = 'Vehicle Inport Parameters';
sheetname_1 = 'Constant Inports';
dynamic_parameters = ["BatteryTemperatureK","SteeringAngle",
                      "WindXYZ","Understeergradient"];

[NUM,TXT,RAW_1]=xlsread(filename,sheetname_1);
constant_param = string(RAW_1);

for i = 1:4
    sheetname_2 = dynamic_parameters(i);
    [NUM,TXT,RAW_2]=xlsread(filename,sheetname_2);
    dynamic_param = string(RAW_2);
    sig_1 = Simulink.Signal;
    sig_1.DataType = 'int8';
    sig_1.InitialValue = dynamic_param(1,2);
    sig_1.SampleTime = [inf, 0];
    sig_1.Unit = 'rad/s';
    assignin('base', dynamic_parameters(i), sig_1)
end

for i = 1:6
    sig_1 = Simulink.Signal;
    sig_1.DataType = 'int8';
    sig_1.InitialValue = constant_param(i,2);
    sig_1.SampleTime = [inf, 0];
    sig_1.Unit = 'rad/s';
    assignin('base', constant_param(i,1), sig_1)
end