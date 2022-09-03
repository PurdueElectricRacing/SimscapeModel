mdl = 'complete_plant';
isModelOpen = bdIsLoaded(mdl);
open_system(mdl);

path1 = 'complete_plant/Driver/final_velocity';
path2 = 'complete_plant/Driver/distance_traveled';

path3 = 'complete_plant/Vehicle Model/distance_traveled';
path4 = 'complete_plant/Vehicle Model/initial_velocity';

path5 = 'complete_plant/Vehicle Model/Drivetrain/gr';
path6 = 'complete_plant/Electronics/Torque Vectoring Micro Controller/gr';
path7 = 'complete_plant/Electronics/Torque Vectoring FPGA/gr';

path8 = 'complete_plant/Vehicle Model/Motor and Battery/omega';
path9 = 'complete_plant/Vehicle Model/Tires/Front Tires';
path10 = 'complete_plant/Vehicle Model/Tires/Rear Tires';

path11 = 'complete_plant/Vehicle Model/Motor and Battery/gr';

gr_sweep = (6:0.2:10)';
distance_sweep = 10:10:70;

num1 = length(gr_sweep);
num2 = length(distance_sweep);

gr_extend = ones(1, num2);
distance_extend = ones(num1, 1);

gr_grid = gr_sweep * gr_extend;
distance_grid = distance_extend * distance_sweep;

exit_velocity = [5 10 15];
entrance_velocity = [5 10 15];

num3 = length(entrance_velocity);

counter = 1;
for k = 1:num3
    for i = 1:num1
        for j = 1:num2
            exit_v = exit_velocity(k);
            entrance_v = entrance_velocity(k);
    
            in(counter) = Simulink.SimulationInput(mdl);
            A = [gr_grid(i,j),distance_grid(i,j),exit_v, entrance_v];
            in(counter) = in(counter).setBlockParameter(path1, 'Value', num2str(A(4)), path2, 'Value', num2str(A(2)), path3, 'Value', num2str(A(2)));
            in(counter) = in(counter).setBlockParameter(path4, 'Value', num2str(A(3)), path5, 'Gain', num2str(A(1)), path6, 'Gain', num2str(A(1)));
            in(counter) = in(counter).setBlockParameter(path7, 'Gain', num2str(A(1)), path8, 'InitialCondition', join(["[", num2str([1 1 1 1] .* A(3)), "]"]), path9, 'omegao', num2str(A(3)/0.2228169203));
            in(counter) = in(counter).setBlockParameter(path10, 'omegao', num2str(A(3)/0.2228169203), path11, 'Gain', num2str(A(1)));
            
            counter = counter + 1;
        end
    end
end
tic
out = parsim(in, 'ShowProgress', 'on');
toc