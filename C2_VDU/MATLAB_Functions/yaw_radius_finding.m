%% Setup Simulation Input
mdl = 'complete_plant_v2';
isModelOpen = bdIsLoaded(mdl);
open_system(mdl);

path1 = 'complete_plant_v2/Driver/Reference Generator/Vg_ref';

V_sweep = (4:1:20)';
R_sweep = 50:-1:4;

num1 = length(V_sweep);
num2 = length(R_sweep);

V_extend = ones(num1, 1);
R_extend = ones(1, num2);

V_grid = V_sweep * R_extend;
R_grid = V_extend * R_sweep;

counter = 1;
for i = 1:num1
    for j = 1:num2    
        in(counter) = Simulink.SimulationInput(mdl);
        A = [V_grid(i,j),R_grid(i,j)];
        in(counter) = in(counter).setBlockParameter(path1, 'Value', num2str(A(1)));
        
        counter = counter + 1;
    end
end


%% Define Tracks
track_Right = cell(num2*2, 3);
track_Left = cell(num2*2, 3);

counter = 0;
for i = R_sweep
    counter = counter + 1;
    track_Right(counter,1) = {'Straight'};
    track_Right(counter,2) = {10};
    track_Right(counter,3) = {0};

    track_Left(counter,1) = {'Straight'};
    track_Left(counter,2) = {10};
    track_Left(counter,3) = {0};

    counter = counter + 1;
    track_Right(counter,1) = {'Right'};
    track_Right(counter,2) = {pi*i};
    track_Right(counter,3) = {i};

    track_Left(counter,1) = {'Left'};
    track_Left(counter,2) = {pi*i};
    track_Left(counter,3) = {i};  
end

writecell(track_Right, "track_Right", "Delimiter", "tab");
writecell(track_Left, "track_Left", "Delimiter", "tab");


%% Generate Track
% PATH to the .txt files that store track data
%PATH = "C:\Users\Inver\MATLAB Drive\Top Model - Master\Function Library\";
PATH = "../Tracks/Tracks_Notepad/";
event_names = ["acceleration", "skidpad", "austria endurance", "l_square", "r_square", "short_oc", "grand prix", "track_Left", "track_Right"];
event_selection_Left = 8;
event_selection_Right = 9;
step_size = 0.1;

track_data_Left = generate_points_v2(event_selection_Left, step_size, PATH, event_names);
track_data_Right = generate_points_v2(event_selection_Right, step_size, PATH, event_names);

 
%% Test Run the Simulation
tic
out = parsim(in(6), 'ShowProgress', 'on');
toc