%% Vehicle Parameters
model = varModel_master_6DOF;

%% Constant Parameters
% SA = 6.162596843663441e-20;
% Fz = 4.222366741746806e+02;
% P = 1.176432426460618e+03;
% dxCOG = 0.323192246082083;

% SA = -1.286234494151512e-05;
% Fz = 1.638320455261808e+03;
% P = -3.042904527959951e+05;
% dxCOG = 27.795202800937260;

% SA = -1.264047511370802e-05;
% Fz = 1.277103725273920e+03;
% P = 1.629722518419306e+04;
% dxCOG = 32.705774802577764;

% SA = 0.006985780820666;
% Fz = 7.113757451176218e+02;
% P = 0.011026778715006;
% dxCOG = -2.471539259361498e-08;

% SA = -0.001091540800652;
% Fz = 7.088202522298517e+02;
% P = 0;
% dxCOG = 1.325200702172682e-07;

% SA = -0.245575170433355;
% Fz = 1.346045147747818e+03;
% P = 2.893925832412890e+04;
% dxCOG = 20.279972722953826;

SA = -0.031958308546261;
Fz = 7.112250000000000e+02;
P = 8.886323514103757e-12;
dxCOG = 0;

N = 20;
SR = [0 linspace(-model.Sm, model.Sm, N)];
res = zeros(N+1,1);

%% Evaluate Residual for Each S Guess
for i = 1:N+1
 res(i,1) = get_res_6DOF(SR(i), SA, Fz, P, dxCOG, model);
end

%% Plot Residuals
figure(1)
scatter(SR, res)

xlabel("S")
ylabel("Residual")

%% Function Bank
function res = get_res_6DOF(SR, SA, Fz, P, dxCOG, model)
    % wheel speed [rad/s]
    wt = (SR + 1).*(dxCOG ./ model.r0);

    % limit slip
    SR = max(min(SR,1),-1);

    % possible tractive torque, constrained by the motor, accounting for losses [Nm]
    tau = model.tt(wt.*model.gr, P) - model.gm.*wt;

    % possible tractive force, constrained by the motor, accounting for losses [N]
    Fx = (tau.*model.gr./model.r0);

    % find maximum Fx and Fy forces, ratio, magnitude between them [N N rad none]
    Fx0 = Fz.*model.Dx.*sin(model.Cx.*atan(model.Bx.*SR - model.Ex.*(model.Bx.*SR - atan(model.Bx.*SR))));
    Fy0 = Fz.*model.Dy.*sin(model.Cy.*atan(model.By.*SA - model.Ey.*(model.By.*SA - atan(model.By.*SA))));

    xr = SR./model.Sm;
    yr = SA./model.Am;
    Br = sqrt(1 + ((model.bR.*xr.^(2*model.aR).*yr.^(2*model.aR))./((xr.^(2*model.aR)+yr.^(2*model.aR)).^2)));
    X = abs(Br.*xr.^model.aR) ./ (sqrt(xr.^(2*model.aR)+yr.^(2*model.aR)));
    Y = abs(Br.*yr.^model.aR) ./ (sqrt(xr.^(2*model.aR)+yr.^(2*model.aR)));
    rx = max(0,min(X,1));
    ry = max(0,min(Y,1));

    res = rx.*Fx0 - Fx;
end