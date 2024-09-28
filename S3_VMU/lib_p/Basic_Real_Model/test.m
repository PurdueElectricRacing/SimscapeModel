s0 = 1;

%% regulalr model
[tWhole, sWhole] = ode45(@(t,s) computeds(t, s), [0,10], s0);



tBigSteps = 0;
sBigSteps = s0;

%% steps model
for tstepstart = 0:1:9
    [t, s] = ode45(@(t,s) computeds(t, s), [tstepstart,tstepstart+1], sBigSteps(end));
    tBigSteps = [tBigSteps t(end)];
    sBigSteps = [sBigSteps s(end)];
end


plot(tWhole,sWhole, '.-')
hold on
plot(tBigSteps, sBigSteps)


function [ds] = computeds(t, s)
    ds = s;
end