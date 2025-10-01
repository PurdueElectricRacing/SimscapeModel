function vehicle_plot(v, modelName, model)
    %% Figure 1: States Dashboard
    figure(Name="States Dashboard: " + modelName);
    t = tiledlayout(2, 4);
    title(t,"States Dashboard: " + modelName)

    nexttile
    plot(v.t, v.dxz)
    title("CG Velocity")
    legend("dx", "dz")
    
    nexttile
    plot(v.t, v.xz)
    title("CG Position (m)")
    legend("x", "z")
    
    nexttile
    plot(v.t, v.do)
    title("Orientation Velocity (rad/s)")
    legend("Pitch")
    
    nexttile
    plot(v.t, v.o)
    title("Orientation (rad)")
    legend("Pitch")
    
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
    plot(v.t, v.tau_motor)
    hold on
    plot(v.t, v.tau_tire)
    title("Motor Torque [Nm]")
    legend("FL", "FR", "RL", "RR", Location="northwest")
    
    %% Figure 2: Derivative Dashboard
    figure(Name="Derivative Dashboard: " + modelName);     
    t = tiledlayout(2, 4);
    title(t,"Derivative Dashboard: " + modelName)

    nexttile
    plot(v.t, v.ddxz)
    title("CG Acceleration (m/s^2)")
    legend("ddx", "ddz")

    nexttile
    plot(v.t, v.dxz)
    title("CG Velocity")
    legend("dx", "dz")

    nexttile
    plot(v.t, v.ddo)
    title("Orientation Acceleration (rad/s^2)")
    legend("Pitch")

    nexttile
    plot(v.t, v.do)
    title("Orientation Velocity (rad/s)")
    legend("Pitch")

    nexttile
    plot(v.t, v.dVb)
    title("Battery Voltage Velocity (V/s)")

    nexttile
    plot(v.t, v.dAs)
    title("Capacity Used Velocity (A)")

    nexttile
    plot(v.t, v.dT)
    title("Motor Torque Velocity (Nm/s)")
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
    plot(v.t, v.Fz)
    title("Z force (N)")
    legend("FL", "FR", "RL", "RR", Location="northwest")

    nexttile
    plot(v.t, v.S)
    title("Slip Ratio")
    legend("FL", "FR", "RL", "RR", Location="southwest")

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
    plot(v.t, v.res)
    title("Wheel Speed Residual")
    legend("FL", "FR", "RL", "RR")

    %% Figure 4: Extra Visualization
    figure(Name="Extra Dashboard: " + modelName);     
    t = tiledlayout(3, 4);
    title(t,"Extra Dashboard: " + modelName)

    nexttile
    range_max = max(0.1, max(v.xz(:, 1)));
    range_min = min(-0.1, min(v.xz(:, 1)));
    plot(zeros(length(v.xz(:,1)),1), v.xz(:,1))
    xlabel("Lateral Position (m)")
    ylabel("Longitudinal Position (m)")
    xlim([range_min-0.01 range_max+0.01])
    ylim([range_min-0.01 range_max+0.01])

    nexttile
    plot(v.t, v.dxv)
    title("Vehicle Velocity (m/s)")
    legend("X", "Y")
end