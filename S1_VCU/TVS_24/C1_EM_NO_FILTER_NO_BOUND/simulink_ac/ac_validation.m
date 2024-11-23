% at some point, the xyz axis for accelerometer and gyroscope were switched
% this was fixed, and below is showing some testing data that validated
% this

% accel x&y are switched
R = [0.814026 -0.001896 -0.580825; -0.001896 0.99998 -0.005922067; 0.580825 0.005922067 0.8140067];
yaw = [1.34223223; 0.0611195; 2.1229372];
yaw_transformed = R*yaw;

% accel and gyro have same axis
R = [0.999171615 -0.0126475692 -0.0386794619; -0.0126475692 0.80689764 -0.590555847; 0.0386794619 0.590555847 0.806069255];
yaw = [-0.518250763; 3.50658154; 4.36318684];
yaw_transformed = R*yaw;