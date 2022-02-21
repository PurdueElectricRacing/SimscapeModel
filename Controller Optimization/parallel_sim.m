mdl = 'Vehicle_Model_Controller_Feb18';
isModelOpen = bdIsLoaded(mdl);
open_system(mdl);

path1 = 'Vehicle_Model_Controller_Feb18/Driver Input Logic/Torque Vectoring Controller/PI Controller/P';
path2 = 'Vehicle_Model_Controller_Feb18/Driver Input Logic/Torque Vectoring Controller/PI Controller/I';
path3 = 'Vehicle_Model_Controller_Feb18/Driver Input Logic/Torque Vectoring Controller/PI Controller/T';

T = readtable('max_turn.xlsx');
driver_input = timeseries(table2array(T(:,2)),table2array(T(:,1)));
P_A = timeseries(table2array(T(:,3)),table2array(T(:,1)));
B_A = timeseries(table2array(T(:,4)),table2array(T(:,1)));
steering_angle = timeseries(table2array(T(:,6)),table2array(T(:,1)));
wind_x = timeseries(table2array(T(:,7)),table2array(T(:,1)));
wind_y = timeseries(table2array(T(:,8)),table2array(T(:,1)));
wind_z = timeseries(table2array(T(:,9)),table2array(T(:,1)));
batt_temp = timeseries(table2array(T(:,5)),table2array(T(:,1)));

ds = Simulink.SimulationData.Dataset;
ds = ds.addElement(driver_input, 'driver_input');
ds = ds.addElement(P_A, 'P_A');
ds = ds.addElement(B_A, 'B_A');
ds = ds.addElement(steering_angle, 'steering_angle');
ds = ds.addElement(wind_x, 'wind_x');
ds = ds.addElement(wind_y, 'wind_y');
ds = ds.addElement(wind_z, 'wind_z');
ds = ds.addElement(batt_temp, 'batt_temp');

ts = 0.1:0.1:5;
os = 1:1:25;
T_all = 1:1:10;

num1 = length(ts);
num2 = length(os);
num3 = length(T_all);

exit_flag = zeros(num1,num2, num3);
Tx_test = zeros(num1,num2, num3);
yaw_error = zeros(num1,num2, num3);
yaw_accel_error = zeros(num1,num2, num3);
P_all = zeros(num1, num2);
I_all = zeros(num1, num2);

counter = 1;
tic

for i = 1:num1
    for j = 1:num2
        for k = 1:num3
            zeta = sqrt((log(os(j)/100))^2 / ((pi)^2 + (log(os(j)/100))^2));
            wn = log(0.02 * sqrt(1 - zeta^2)) / (-zeta*ts(i));
            
            P = 2 * wn * zeta;
            I = wn^2;
            T = T_all(k);
            
            P_all(i,j,k) = P;
            I_all(i,j,k) = I;
                      
            in(counter) = Simulink.SimulationInput(mdl);
            A = [P_all(i,j),I_all(i,j),T_all(k)];
            in(counter) = in(counter).setBlockParameter(path1, 'Gain', num2str(A(1)), path2, 'Gain', num2str(A(2)), path3, 'Gain', num2str(A(3)));
            counter = counter + 1;
        end
    end
end
toc

in = in.setExternalInput("ds.getElement('driver_input'),ds.getElement('P_A'),ds.getElement('B_A'),ds.getElement('steering_angle'),ds.getElement('wind x'),ds.getElement('wind y'),ds.getElement('wind z'),ds.getElement('batt_temp')");                       
in = in.setVariable('ds',ds);


% out = parsim(in, 'ShowProgress', 'on');