function plot_master_3DOF(v, modelName, model)
    %% Figure 1: States Dashboard
    figure(Name="States Dashboard: " + modelName);
    t = tiledlayout(3, 4);
    title(t,"States Dashboard: " + modelName)

    nexttile
    plot(v.t, v.dx)
    title("CG X Velocity")
    
    nexttile
    plot(v.t, v.x)
    title("CG X Position")
    
    nexttile
    plot(v.t, v.dz)
    title("CG Z Velocity")
    
    nexttile
    plot(v.t, v.z)
    title("CG Z Position")
    
    nexttile
    plot(v.t, v.do)
    title("Pitch Rate")
    
    nexttile
    plot(v.t, v.o)
    title("Pitch")
    
    nexttile
    plot(v.t, v.w)
    title("Wheel Speed")
    legend("Front", "Rear", Location="northwest")
    
    nexttile
    plot(v.t, v.Vb)
    title("Voltage")
    
    nexttile
    plot(v.t, v.Ah)
    title("Capacity Used [Ah]")

    nexttile
    plot(v.t, v.tau)
    hold on
    plot(v.t, v.tau_ref_mot)
    title("Motor Torque")
    legend("Front", "Rear", "Front Ref Out", "Rear Ref Out", Location="northwest")

    nexttile
    plot(v.t, v.dIm)
    title("Motor Current d/dt [A/s]")
    legend("Front", "Rear", Location="northwest")
    
    %% Figure 2: Algebra Dashboard
    figure(Name="Algebra Dashboard: " + modelName);     
    t = tiledlayout(3, 4);
    title(t,"Algebra Dashboard: " + modelName)

    nexttile
    plot(v.t, v.ddx)
    title("X Acceleration")

    nexttile
    plot(v.t, v.ddz)
    title("Z Acceleration")

    nexttile
    plot(v.t, v.ddo)
    title("Pitch Acceleration")

    nexttile
    plot(v.t, v.Im)
    title("Motor Current")
    legend("Front", "Rear", Location="northwest")

    nexttile
    plot(v.t, v.Fx, "--")
    hold on
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot(v.t, v.Fx_max)
    title("X Force")
    legend("Front X", "Rear X", "Front Max", "Rear Max")

    nexttile
    plot(v.t, v.Fz)
    title("Z force")
    legend("Front", "Rear")

    nexttile
    plot(v.t, v.Sl)
    title("Slip Ratio")

    nexttile
    plot(v.t, v.dVb)
    title("Battery Voltage d/dt")

    nexttile
    plot(v.t, v.dAh)
    title("Capacity Used d/dt [Ah/s]")
    
    nexttile
    plot(v.t, v.zFR)
    title("Wheel Z Position")
    legend("Front", "Rear")

    nexttile
    plot(v.t, v.dzFR)
    title("Wheel Z Velocity")
    legend("Front", "Rear")

     %% Figure 3: Derivative Dashboard
    figure(Name="Derivative Dashboard: " + modelName);     
    t = tiledlayout(3, 4);
    title(t,"Derivative Dashboard: " + modelName)

    nexttile
    plot(v.t, v.dx)
    title("X Velocity")

    nexttile
    plot(v.t, v.ddx)
    title("X Acceleration")

    nexttile
    plot(v.t, v.dz)
    title("Z Velocity")

    nexttile
    plot(v.t, v.ddz)
    title("Z Acceleration")

    nexttile
    plot(v.t, v.do)
    title("Pitch Velocity")

    nexttile
    plot(v.t, v.ddo)
    title("Pitch Acceleration")

    nexttile
    plot(v.t, v.dw)
    title("Wheel Angular Acceleration")

    nexttile
    plot(v.t, v.dIm)
    title("Motor Current Velocity")
    legend("Front", "Rear", Location="northwest")

    nexttile
    plot(v.t, v.dVb)
    title("Battery Voltage d/dt")

    nexttile
    plot(v.t, v.dAh)
    title("Capacity Used d/dt [Ah/s]")
end