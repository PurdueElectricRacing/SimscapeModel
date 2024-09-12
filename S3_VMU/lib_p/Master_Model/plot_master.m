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
    plot(v.t, v.w(:,1))
    title("front w")
    
    nexttile
    plot(v.t, v.w(:,2))
    title("rear w")
    
    nexttile
    plot(v.t, v.Voc)
    title("Voc")
    
    nexttile
    plot(v.t, v.Vb)
    title("Vb")
    
    nexttile
    plot(v.t, v.Ah)
    title("Ah")
    
    %% Figure 2: Algebra Dashboard
    figure;
    
    tiledlayout(3, 4)
    
    nexttile
    plot(v.t, v.w)
    title("X vel")
    
    % nexttile
    % plot(v.t, x0(:,2))
    % title("X distance")
    % 
    % nexttile
    % plot(v.t, x0(:,3))
    % title("Z vel")
    % 
    % nexttile
    % plot(v.t, x0(:,4))
    % title("Z distance")
    % 
    % nexttile
    % plot(v.t, x0(:,5))
    % title("pitch rate")
    % 
    % nexttile
    % plot(v.t, x0(:,6))
    % title("pitch")
    % 
    % nexttile
    % plot(v.t, x0(:,7))
    % title("front w")
    % 
    % nexttile
    % plot(v.t, x0(:,8))
    % title("rear w")
    % 
    % nexttile
    % plot(v.t, x0(:,9))
    % title("Voc")
    % 
    % nexttile
    % plot(v.t, x0(:,10))
    % title("Vb")
    % 
    % nexttile
    % plot(v.t, x0(:,11))
    % title("Ah")
    % 
    % nexttile
    % plot(v.t, x0(:,1) - x0(:,8)*varCAR.r0)
    % title("m/s")
end