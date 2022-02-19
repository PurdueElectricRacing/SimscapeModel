% Set Desired Parameters
ts = 0.2:0.2:5;
os = 1:1:25;
t_vary = 1:1:10;

num1 = length(ts);
num2 = length(os);
num3 = length(t_vary);

exit_flag = zeros(num1,num2);
Tx_test = zeros(num1,num2);
yaw_error = zeros(num1,num2);
yaw_accel_error = zeros(num1,num2);
P_all = zeros(num1, num2, num3);
I_all = zeros(num1, num2, num3);
T_all = zeros(num1, num2, num3);

for i = 1:num1
    for j = 1:num2
        tic
        % Set Objective Function, x1 is ts, x2 is os
        fun = @(x) x(1) / x(2);

        % Solve Optimization Problem
        A = [];
        b = [];
        Aeq = [];
        beq = [];
        lb = [ts(i),0,0.5,0];
        ub = [5,os(j),1.5,20];
        nonlcon = @zeta_ts;
        x0 = [2 2 0.779703267412 2.50866141578];
        Tx = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon);

        % Construct Transfer Function
        s1 = 1;
        s2 = 2 * Tx(3) * Tx(4);
        s3 = Tx(4)^2;

        P = s2;
        I = s3;
        for k = 1:10
            P_all(i,j,k) = P;
            I_all(i,j) = I;
            T_all(i,j,k) = T;

            simOut = sim('Vehicle_Model_Controller_Feb18','SimulationMode','normal',...
                'SaveState','on','StateSaveName','xout',...
                'SaveOutput','on','OutputSaveName','yout',...
                'SaveFormat', 'Dataset');

            outputs = simOut.logsout;
            exit_flag_all = outputs.get('exit_flag').Values.Data;
            exit_flag(i,j) = sum(0>exit_flag_all);

            Tx_all = outputs.get('Tx').Values.Data;
            Tx_test(i,j) = max(Tx_all(617:end,1)) - min(Tx_all(617:end,1));

            yaw_accel_error_all = outputs.get('Tracking Signal').Values.Data;
            yaw_accel_error(i,j) = sqrt(mean((yaw_accel_error_all).^2));

            yaw_accel_FS = max(yaw_accel_error_all(617:end)) - min(yaw_accel_error_all(617:end));

            yaw_error_all = outputs.get('yaw_error').Values.Data;
            yaw_error(i,j) = sqrt(mean((yaw_error_all).^2));  
            toc

            test = 1;
        end
    end
end

% Analyze System
% sys = tf([s2 s3 0],[s1 s2 s3]);
% pzmap(sys)
% 
% opt = stepDataOptions;
% opt.StepAmplitude = 1/2.3;
% 
% step(sys, opt)




