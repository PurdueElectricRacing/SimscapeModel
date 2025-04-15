% Test cases to simulate various situations for vehicle_dynamics_model_master_6DOF
% Test case 1, the vehicle is at rest.
% Inputs
s = zeros(23,1); % All states zero (vehicle at rest)
Fx_t = zeros(4,1);
Fy = zeros(4,1);
Fz = model.m*model.g/4 * ones(4,1);
wt = zeros(4,1);
tau = zeros(4,1);
toe = zeros(4,1);

% Test case 2, the vehicle is accelerating in a straight line
% Inputs
s = [20; 0; 0; 0; 0; 0; 0; 0; 0; 0; zeros(13,1)]; % Moving forward at 20 m/s
Fx_t = [500; 500; 500; 500]; % Equal drive force on all wheels
Fy = zeros(4,1);
Fz = [2500; 2500; 3000; 3000]; % More normal force on the rear tires
wt = [20/0.3; 20/0.3; 20/0.3; 20/0.3]; % Wheel speeds matching vehicle speed
tau = [100; 100; 100; 100]; % Equal torque on all wheels
toe = zeros(4,1); % No steering

% Test case 3, the vehicle is deccelerating in a straight line
% Inputs
s = [20; 0; 0; 0; 0; 0; 0; 0; 0; 0; zeros(13,1)]; % Moving forward at 20 m/s
Fx_t = [-500; -500; -500; -500]; % Equal drive force on all wheels
Fy = zeros(4,1);
Fz = [3000; 3000; 2500; 2500]; % More normal force on the rear tires
wt = [20/0.3; 20/0.3; 20/0.3; 20/0.3]; % Wheel speeds matching vehicle speed
tau = [100; 100; 100; 100]; % Equal torque on all wheels
toe = zeros(4,1); % No steering

% Test case 4, the vehicle is cornering hard right
% Inputs
s = [20; 0; 5; 0; 0; 0; 0; 0; 0; 0.1; zeros(13,1)]; % Moving forward at 20 m/s with 5 m/s lateral
Fx_t = [200; 200; 100; 100]; % More drive on front wheels
Fy = [1000; 1000; 800; 800]; % Significant lateral forces
Fz = [3000; 3000; 2000; 2000]; % Weight transfer to front and outer wheels
wt = [20/0.3; 20/0.3; 20/0.3; 20/0.3]; % Wheel speeds matching vehicle speed
tau = [80; 80; 40; 40];
toe = [30; 30; 0; 0]; % Front wheels steered

% Test case 5, the vehicle is cornering hard left @ high speed
% Inputs
s = [50; 0; 10; 0; 0; 0; 0; 0; 0; 0.3; zeros(13,1)]; % Fast with lateral motion
Fx_t = [1000; 1000; 500; 500];
Fy = [-2000; -2000; -1500; -1500]; % Significant lateral forces
Fz = [4000; 4000; 1000; 1000]; % Weight transfer to front and outer wheels
wt = [50/0.3; 50/0.3; 50/0.3; 50/0.3];
tau = [200, 200, 100, 100];
toe = [-30; -30; 0; 0]; % Front wheels steered

% Test case 6, the vehicle is cornering hard right @ high speed
% Inputs
s = [50; 0; 10; 0; 0; 0; 0; 0; 0; 0.3; zeros(13,1)]; % Fast with lateral motion
Fx_t = [1000; 1000; 500; 500];
Fy = [2000; 2000; 1500; 1500];
Fz = [4000; 4000; 1000; 1000]; % Extreme weight transfer
wt = [50/0.3; 50/0.3; 50/0.3; 50/0.3];
tau = [200; 200; 100; 100];
toe = [30; 30; 0; 0]; % Large steering angle