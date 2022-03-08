mdl = 'Vehicle_Model_Controller_Feb25';
isModelOpen = bdIsLoaded(mdl);
open_system(mdl);

path1 = 'Vehicle_Model_Controller_Feb25/Driver Input Logic/Torque Vectoring Controller/PI Controller/P';
path2 = 'Vehicle_Model_Controller_Feb25/Driver Input Logic/Torque Vectoring Controller/PI Controller/I';
path3 = 'Vehicle_Model_Controller_Feb18/Driver Input Logic/Torque Vectoring Controller/PI Controller/T';

T_all = readtable('hard_turn.xlsx');
driver_input = timeseries(table2array(T_all(:,2)),table2array(T_all(:,1)));
P_A = timeseries(table2array(T_all(:,3)),table2array(T_all(:,1)));
B_A = timeseries(table2array(T_all(:,4)),table2array(T_all(:,1)));
steering_angle = timeseries(table2array(T_all(:,6)),table2array(T_all(:,1)));
wind_x = timeseries(table2array(T_all(:,7)),table2array(T_all(:,1)));
wind_y = timeseries(table2array(T_all(:,8)),table2array(T_all(:,1)));
wind_z = timeseries(table2array(T_all(:,9)),table2array(T_all(:,1)));
batt_temp = timeseries(table2array(T_all(:,5)),table2array(T_all(:,1)));

ds = Simulink.SimulationData.Dataset;
ds = ds.addElement(driver_input, 'driver_input');
ds = ds.addElement(P_A, 'P_A');
ds = ds.addElement(B_A, 'B_A');
ds = ds.addElement(steering_angle, 'steering_angle');
ds = ds.addElement(wind_x, 'wind_x');
ds = ds.addElement(wind_y, 'wind_y');
ds = ds.addElement(wind_z, 'wind_z');
ds = ds.addElement(batt_temp, 'batt_temp');

P_all = 5:0.25:15;
I_all = 15:2:70;

tune = [];

m1 = -2;
m2 = 20;

b1 = 68;
b2 = -100;
b3 = 148;

num1 = length(P_all);
num2 = length(I_all);
counter = 1;

for i = 1:num1
    for j = 1:num2
        I_test1 = b1 + (P_all(i) * m1);
        
        if I_test1 > I_all(j)
            tune(end+1,:) = [P_all(i), I_all(j)];
        else
            I_test2 = b3 + (P_all(i) * m1);
            I_test3 = (m2 * P_all(i));
            I_test4 = (m2 * P_all(i)) + b2;
            if (I_test2 > I_all(j)) && (I_test3 > I_all(j)) && (I_test4 < I_all(j))
                tune(end+1,:) = [P_all(i), I_all(j)];
            end
        end
    end
end

scatter(tune(:,1), tune(:,2))

for i = 1:num1
    for j = 1:num2
        in(counter) = Simulink.SimulationInput(mdl);
        A = [P_all(i),I_all(j)];
        in(counter) = in(counter).setBlockParameter(path1, 'Gain', num2str(A(1)), path2, 'Gain', num2str(A(2)), path3, 'Gain', num2str(7.75));
        counter = counter + 1;
    end
end

in = in.setExternalInput("ds.getElement('driver_input'),ds.getElement('P_A'),ds.getElement('B_A'),ds.getElement('steering_angle'),ds.getElement('wind x'),ds.getElement('wind y'),ds.getElement('wind z'),ds.getElement('batt_temp')");                       
in = in.setVariable('ds',ds);



