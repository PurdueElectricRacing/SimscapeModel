function plot_master_3DOF(v)
    %% Figure 1: States Dashboard
    figure(Name="States Dashboard");
    t = tiledlayout(3, 4);
    title(t,"States Dashboard")

    nexttile
    plot(v.t, v.dx)
    xlabel("Time (s)")
    title("Longitudinal Velocity [m/s]")
    
    nexttile
    plot(v.t, v.x)
    xlabel("Time (s)")
    title("Longitudinal Position [m]")
    
    nexttile
    plot(v.t, v.dz)
    xlabel("Time (s)")
    title("Vertical Velocity [m/s]")
    
    nexttile
    plot(v.t, v.z)
    xlabel("Time (s)")
    title("Longitudinal Velocity [m/s]")
    
    nexttile
    plot(v.t, v.do)
    xlabel("Time (s)")
    title("Vehicle Pitch Rate [rad/s]")
    
    nexttile
    plot(v.t, v.o)
    xlabel("Time (s)")
    title("Vehicle Pitch [rad]")
    
    nexttile
    plot(v.t, v.w)
    xlabel("Time (s)")
    title("Wheel Speed [rad/s]")
    legend("Front", "Rear", Location="southeast")

    nexttile
    plot(v.t, v.dw)
    xlabel("Time (s)")
    title("Wheel Angular Acceleration [rad/(s^2)]")
    legend("Front", "Rear", Location="best")
    
    nexttile
    plot(v.t, v.Vb)
    hold on
    plot(v.t, v.Voc)
    xlabel("Time (s)")
    title("Battery Voltage [V]")
    legend("Terminal", "Open Circuit", Location="best")
    
    nexttile
    plot(v.t, v.Ah)
    title("Battery Capacity Used [Ah]")

    nexttile
    plot(v.t, v.tau)
    hold on
    plot(v.t, v.tau_ref_mot)
    xlabel("Time (s)")
    title("Motor Torque [Nm]")
    legend("Front", "Rear", "Front Ref Out", "Rear Ref Out", Location="northeast")

    nexttile
    plot(v.t, v.dIm)
    xlabel("Time (s)")
    title("Motor Current d/dt [A/s]")
    legend("Front", "Rear", Location="northeast")
    
    %% Figure 2: Algebra Dashboard
    figure(Name="Algebra Dashboard");     
    t = tiledlayout(3, 4);
    title(t,"Algebra Dashboard")

    nexttile
    plot(v.t, v.ddx)
    xlabel("Time (s)")
    title("Longitudinal Acceleration [m/(s^2)]")

    nexttile
    plot(v.t, v.ddz)
    xlabel("Time (s)")
    title("Vertical Acceleration [m/(s^2)]")

    nexttile
    plot(v.t, v.ddo)
    xlabel("Time (s)")
    title("Pitch Acceleration [rad/(s^2)]")

    nexttile
    plot(v.t, v.Im)
    xlabel("Time (s)")
    title("Motor Current [A]")
    legend("Front", "Rear", Location="northeast")

    nexttile
    plot(v.t, v.Fx, "--")
    hold on
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot(v.t, v.Fx_max)
    xlabel("Time (s)")
    title("Longitudinal Force [N]")
    legend("Front X", "Rear X", "Front Max", "Rear Max", "Location","best")

    nexttile
    plot(v.t, v.Fz)
    xlabel("Time (s)")
    title("Normal (vertical) Force [N]")
    legend("Front", "Rear", "Location","best")

    nexttile
    plot(v.t, v.Sl)
    xlabel("Time (s)")
    title("Slip Ratio")
    legend("Front", "Rear", "Location","best")

    nexttile
    plot(v.t, v.dVb)
    xlabel("Time (s)")
    title("Battery Voltage d/dt [V/s]")

    nexttile
    plot(v.t, v.dAh)
    xlabel("Time (s)")
    title("Battery Capacity Used d/dt [Ah/s]")
    
    nexttile
    plot(v.t, v.zFR)
    xlabel("Time (s)")
    title("Chassis Vertical Position from Ground [m]")
    legend("Front", "Rear", "Location","best")

    nexttile
    plot(v.t, v.dzFR)
    xlabel("Time (s)")
    title("Chassis Vertical Velocity [m]")
    legend("Front", "Rear", "Location","best")

    nexttile
    plot(v.t, v.Vb.*sum(v.Im,2))
    xlabel("Time (s)")
    title("Power from Battery [W]")

    %% Figure 3: Derivative Dashboard  
    figure(3)
    plot(v.t, v.res)
    title("Tractive Force Residual (N)")
end