omega_m_lookup = 0:10:1000;

% Motor Shaft Speed, rpm
ang_vel_RPM = omega_m_lookup .* 9.5492965964254;

% quadratic constants that connect current and max RPM of motors
a_v = 0.2667;
b_v = -66.353;
c_v = 10452 - ang_vel_RPM;

% quadratic constants that connnect current and max torque of motors
a_t = -0.0987;
b_t = 45.799;
c_t = -129.65;

% maximum possible current at the current RPM
max_current = [0, 0, 0, 0];

% calculate the maximum current possible at the current RPM
for i = 1:101
   if ang_vel_RPM(i) < 7000
       max_current(i) = 70;
   else
       max_current(i) = (-b_v - sqrt(b_v^2 - (4*a_v.*c_v(i)))) .* (1/(2*a_v));
   end
end

% calculate the maximum torque at the max current
rpm_limit = ((a_t .* (max_current.^2)) + (b_t .* max_current) + c_t) ./ 100;
for i = [1:101]
   if rpm_limit(i) < 0
      rpm_limit(i) = 0;
   end
end

motor_efficiency = 0.85;
motor_limit_power = 15000;
% If torque_limit_motor ever exceed 30, then the exact value is no longer
% needed. As in, the ceiling is 30
power_limit = (motor_limit_power .* motor_efficiency) ./ omega_m_lookup;

% Erase power limit solution above torque limit, for better data
% visualization
for i = 1:101
    if power_limit(i) > 25 
        power_limit(i) = 25;
    elseif power_limit(i) < -25 && omega_m_lookup(i) > 0
        power_limit(i) = -0.01; 
    elseif power_limit(i) < -25 && omega_m_lookup(i) < 0
        power_limit(i) = 25; 
    end
end

limits = min([rpm_limit; power_limit]);

plot(omega_m_lookup, limits)
xlabel('Motor Shaft Speed (rad/s)')
ylabel('Torque Limit (Nm)')
