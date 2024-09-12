function plot_master(v)
    %% Figure 1: States Dashboard
    figure;
    
    tiledlayout(3, 4)
    
    nexttile
    plot(v.t, v.dx)
    title("X vel")
    
    nexttile
    plot(v.t, v.x)
    title("X distance")
    
    nexttile
    plot(v.t, v.dz)
    title("Z vel")
    
    nexttile
    plot(v.t, v.z)
    title("Z distance")
    
    nexttile
    plot(v.t, v.do)
    title("pitch rate")
    
    nexttile
    plot(v.t, v.o)
    title("pitch")
    
    nexttile
    plot(v.t, v.w)
    title("wheel speed")
    legend("Front", "Rear")
    
    nexttile
    plot(v.t, v.Voc)
    hold on
    plot(v.t, v.Vb)
    title("Voltage")
    legend("Voc", "Vb")
    
    nexttile
    plot(v.t, v.Ah)
    title("Ah")
    
    %% Figure 2: Algebra Dashboard
    figure;
    
    tiledlayout(3, 4)
    
    nexttile
    plot(v.t, v.ddx)
    title("X acc")

    nexttile
    plot(v.t, v.ddz)
    title("Z acc")

    nexttile
    plot(v.t, v.ddo)
    title("pitch acc")

    nexttile
    plot(v.t, v.Im)
    title("Motor I")

    nexttile
    plot(v.t, v.Fx)
    hold on
    plot(v.t, v.Fx_max)
    title("X force")
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
    title("Vb vel")

    nexttile
    plot(v.t, v.dVoc)
    title("Voc vel")

    nexttile
    plot(v.t, v.dAh)
    title("Ah vel")
    
    nexttile
    plot(v.t, v.zFR)
    title("z FR")
    legend("Front", "Rear")

    nexttile
    plot(v.t, v.dzFR)
    title("dz FR")
    legend("Front", "Rear")
end