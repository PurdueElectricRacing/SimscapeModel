max_torque = 0;
max_torques = zeros(1, 29);
max_rpm = zeros(1, 29);
voltages = (60:10:340);
rpm_no_load = [1901.4 2225.1 2545.5 2858.5 3168.8 3481.0 3776.5 4103.2 4416.2 4735.6 5053.0 5358.8 5648.8 5968.3 0 6597.0 6895.6 7204.3 7508.2 7816.1 8132.9 8445.9 8747.4 9060.4 9288.4 9606.0 9907.0 10204.8 10531.2];
current_no_load = [2.8 2.7 2.9 2.8 2.9 2.9 3 2.9 3 3.1 3.1 3.2 3.3 3.3 0 3.2 3.3 3.4 3.4 3.4 3.3 3.5 3.5 3.5 3.4 3.4 3.4 3.4 3.5];
all_torque = [];
all_rpm = [];
all_efficiency = [];

for i = 1:1:29
    if voltages(i) ~= 200
        rpm_data = motor_data(:, 3, i);
        torque_data = motor_data(:, 6, i);
        max_rpm(i) = pchip(torque_data, rpm_data, 2500);
        valid_region = max_rpm(i) < rpm_data;
        valid_rpm = [rpm_no_load(i)+voltages(i); rpm_data(valid_region); max_rpm(i)];
        valid_torque = [0; torque_data(valid_region); 2500];
        num_elem = length(valid_torque);
        efficiency_data = [0; motor_data(2:num_elem, 7, i)] ./ 100;
    else
        current_range = [0.1 (5:1:30) (32:1:70) 72]';
        valid_rpm = valid_rpm + (10*31.85);
        p_in = current_range .* 200;
        p_out = valid_rpm .* valid_torque .* 0.104719755 ./ 100;
        efficiency_data = p_out ./ p_in;
    end

    figure(1)
    plot(valid_rpm, valid_torque)
    hold on

    figure(2)
    scatter3(valid_rpm, valid_torque, efficiency_data)
    hold on

    all_torque = [all_torque; valid_torque];
    all_rpm = [all_rpm; valid_rpm];
    all_efficiency = [all_efficiency; efficiency_data];

    if i == 1
        current_range = [0.1 (5:1:30) (32:1:70) (72:1:75)]';
        extrapolate_voltage = 60;
        for j = 1:1:5
            extrapolate_voltage = extrapolate_voltage - 10;
            valid_rpm = valid_rpm - (10*32.3);
            max_torque_LV = pchip(valid_rpm, valid_torque, 0);
            valid_region = 0 < valid_rpm;
            if max_torque_LV < 2500
                valid_rpm = [valid_rpm(valid_region); 0];
                valid_torque = [valid_torque(valid_region); max_torque_LV];
            else
                valid_rpm = valid_rpm(valid_region);
                valid_torque = valid_torque(valid_region);
            end

            num_elem = length(valid_torque);

            p_in = current_range(1:num_elem) .* extrapolate_voltage;
            p_out = valid_rpm .* valid_torque .* 0.104719755 ./ 100;
            efficiency_data = p_out ./ p_in;

            figure(1)
            plot(valid_rpm, valid_torque)
            hold on

            figure(2)
            scatter3(valid_rpm, valid_torque, efficiency_data)
            hold on
            all_torque = [all_torque; valid_torque];
            all_rpm = [all_rpm; valid_rpm];
            all_efficiency = [all_efficiency; efficiency_data];
        end
    end

    max_torque = max_torque + max(torque_data);
    max_torques(i) = max(torque_data);
end

all_rpm = [all_rpm; 0; max(all_rpm); max(all_rpm); 0];
all_torque = [all_torque; 0; 2500; 0; 2500];
all_efficiency = [all_efficiency; 0.001; 0.9; 0.001; 0.001];


figure(3)
scatter3(all_torque, all_rpm, all_efficiency)
xlabel('Torque (Ncm)')
ylabel('Angular Velocity (RPM)')
zlabel('Efficiency (Unitless)')

figure(2)
xlabel('Angular Velocity (RPM)')
ylabel('Torque (Ncm)')
zlabel('Efficiency (Unitless)')

figure(1)
xlabel('Angular Velocity (RPM)')
ylabel('Torque (Ncm)')