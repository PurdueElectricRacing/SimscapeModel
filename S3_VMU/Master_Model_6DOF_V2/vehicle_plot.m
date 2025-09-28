function vehicle_plot(v, modelName, model)
    %% Figure 1: States Dashboard
    figure(Name="States Dashboard: " + modelName);
    t = tiledlayout(2, 4);
    title(t,"States Dashboard: " + modelName)

    nexttile
    plot(v.t, v.dxyz)
    title("CG Velocity")
    legend("dx", "dy", "dz")
    
    nexttile
    plot(v.t, v.xyz)
    title("CG Position (m)")
    legend("x", "y", "z")
    
    nexttile
    plot(v.t, v.donp)
    title("Orientation Velocity (rad/s)")
    legend("Roll", "Pitch", "Yaw")
    
    nexttile
    plot(v.t, v.onp)
    title("Orientation (rad)")
    legend("Roll", "Pitch", "Yaw")
    
    nexttile
    plot(v.t, v.w)
    title("Tire Wheel Speed (rad/s)")
    legend("FL", "FR", "RL", "RR", Location="northwest")
    
    nexttile
    plot(v.t, v.Voc)
    hold on
    plot(v.t, v.Vb)
    title("Voltage (V)")
    legend("Open Circuit", "Battery")
    
    nexttile
    plot(v.t, v.Ah)
    title("Capacity Used [Ah]")

    nexttile
    plot(v.t, v.Im)
    title("Motor Current [A]")
    legend("FL", "FR", "RL", "RR", Location="northwest")
    
    %% Figure 2: Derivative Dashboard
    figure(Name="Derivative Dashboard: " + modelName);     
    t = tiledlayout(2, 4);
    title(t,"Derivative Dashboard: " + modelName)

    nexttile
    plot(v.t, v.ddxyz)
    title("CG Acceleration (m/s^2)")
    legend("ddx", "ddy", "ddz")

    nexttile
    plot(v.t, v.dxyz)
    title("CG Velocity")
    legend("dx", "dy", "dz")

    nexttile
    plot(v.t, v.ddonp)
    title("Orientation Acceleration (rad/s^2)")
    legend("Roll", "Pitch", "Yaw")

    nexttile
    plot(v.t, v.donp)
    title("Orientation Velocity (rad/s)")
    legend("Roll", "Pitch", "Yaw")

    % nexttile
    % plot(v.t, v.dw)
    % title("Wheel Angular Acceleration (rad/s^2)")
    % legend("FL", "FR", "RL", "RR", Location="northwest")

    nexttile
    plot(v.t, v.dVb)
    title("Battery Voltage Velocity (V/s)")

    nexttile
    plot(v.t, v.dAs)
    title("Capacity Used Velocity (A)")

    nexttile
    plot(v.t, v.dIm)
    title("Motor Current Velocity (A/s)")
    legend("FL", "FR", "RL", "RR", Location="northwest")

    nexttile
    plot(v.t, v.Im_ref)
    hold on
    plot(v.t, v.Im)
    title("Reference Current (A)")
    legend("FL", "FR", "RL", "RR", Location="northwest")

    %% Figure 3: Algebra Dashboard [FIX]
    figure(Name="Algebra Dashboard: " + modelName);     
    t = tiledlayout(3, 4);
    title(t,"Algebra Dashboard: " + modelName)

    nexttile
    plot(v.t, v.Fxv(:,1:2), "--")
    % hold on
    % ax = gca;
    % ax.ColorOrderIndex = 1;
    % plot(v.t, v.Fx_max(:,1:2))
    title("Front X Force (N)")
    % legend("FL", "FR", "FL Max", "FR Max")

    nexttile
    plot(v.t, v.Fxv(:,3:4), "--")
    % hold on
    % ax = gca;
    % ax.ColorOrderIndex = 1;
    % plot(v.t, v.Fx_max(:,3:4))
    title("Rear X Force (N)")
    % legend("RL", "RR", "RL Max", "RR Max")

    nexttile
    plot(v.t, v.Fyv(:,1:2), "--")
    % hold on
    % ax = gca;
    % ax.ColorOrderIndex = 1;
    % plot(v.t, v.Fy_max(:,1:2))
    title("Front Y Force (N)")
    % legend("FL", "FR", "FL Max", "FR Max")

    nexttile
    plot(v.t, v.Fyv(:,3:4), "--")
    % hold on
    % ax = gca;
    % ax.ColorOrderIndex = 1;
    % plot(v.t, v.Fy_max(:,3:4))
    title("Rear Y Force (N)")
    % legend("RL", "RR", "RL Max", "RR Max")

    nexttile
    plot(v.t, v.Fz)
    title("Z force (N)")
    legend("FL", "FR", "RL", "RR", Location="northwest")

    nexttile
    plot(v.t, v.S)
    title("Slip Ratio")
    legend("FL", "FR", "RL", "RR", Location="southwest")

    nexttile
    plot(v.t, v.alpha)
    title("Slip Angle (rad)")
    legend("FL", "FR", "RL", "RR", Location="northwest")

    nexttile
    plot(v.t, v.Vb.*sum(v.Im,2))
    title("Power to Motors (W)")

    nexttile
    plot(v.t, v.dz)
    title("Corner Vertical Velocity (m/s)")
    legend("FL", "FR", "RL", "RR")
    
    nexttile
    plot(v.t, v.z)
    title("Corner Vertical Position (m)")
    legend("FL", "FR", "RL", "RR")

    nexttile
    plot(v.t, v.tau_tire)
    plot(v.t, v.tau_motor)
    title("Motor Torque (Nm)")
    % legend("FL", "FR", "RL", "RR", Location="northwest")

    nexttile
    plot(v.t, v.res)
    title("Theta Residual")
    legend("FL", "FR", "RL", "RR")


    %% Figure 4: Extra Visualization
    figure(Name="Extra Dashboard: " + modelName);     
    t = tiledlayout(3, 4);
    title(t,"Extra Dashboard: " + modelName)

    nexttile
    range_max = max(max(v.xyz(:, 2), max(v.xyz(:, 1))));
    range_min = min(min(v.xyz(:, 2), min(v.xyz(:, 1))));
    plot(v.xyz(:,2), v.xyz(:,1))
    xlabel("Lateral Position (m)")
    ylabel("Longitudinal Position (m)")
    xlim([range_min-0.01 range_max+0.01])
    ylim([range_min-0.01 range_max+0.01])

    nexttile
    plot(v.t, v.res_power(:, 1)); hold on
    plot(v.t, v.res_power(:, 2) + 10^-7);
    plot(v.t, v.res_power(:, 3) + 2*10^-7);
    plot(v.t, v.res_power(:, 4) + 3*10^-7); hold off
    xlabel("time (s)")
    ylabel("power residual (W)")
    legend("FL", "FR", "RL", "RR")
    title("Power Residual")

    % nexttile
    % plot(v.t, v.F_xy(:,1:2), "--")
    % hold on
    % ax = gca;
    % ax.ColorOrderIndex = 1;
    % plot(v.t, v.F_max(:,1:2))
    % 
    % xlabel("Time (s)")
    % ylabel("Force (N)")
    % legend("FL", "FR", "FL Max", "FR Max")
    % 
    % nexttile
    % plot(v.t, v.F_xy(:,3:4), "--")
    % hold on
    % ax = gca;
    % ax.ColorOrderIndex = 1;
    % plot(v.t, v.F_max(:,3:4))
    % 
    % xlabel("Time (s)")
    % ylabel("Force (N)")
    % legend("RL", "RR", "RL Max", "RR Max")
    % 
    % nexttile
    % plot(v.t, v.toe)
    % 
    % xlabel("Time (s)")
    % ylabel("Toe (Rad)")
    % legend("FL", "FR", "RL", "RR")

    nexttile
    plot(v.t, v.Fyv(:,1:2), "--")
    title("Front Y Force (N)")
    legend("FL", "FR")

    nexttile
    plot(v.t, v.Fyv(:,3:4), "--")
    title("Rear Y Force (N)")
    legend("RL", "RR")

    nexttile
    plot(v.t, v.dxv)
    hold on
    plot(v.t, v.dyv)
    title("Vehicle Velocity (m/s)")
    legend("X", "Y")
end