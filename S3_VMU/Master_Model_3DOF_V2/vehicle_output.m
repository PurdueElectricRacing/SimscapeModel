%% Function Description
%  s - state vector [22 1]
%  
%  s(1)  = dxCOG  [m/s] - the X velocity in fixed coordinate system [m/s]
%  s(2)  = xCOG   [m] - the X position in fixed coordinate system [m]
%  s(3)  = dyCOG  [m/s] - the Y velocity in fixed coordinate system [m/s]
%  s(4)  = yCOG   [m] - the Y position in fixed coordinate system [m]
%  s(5)  = dzCOG  [m/s] - the Z velocity in fixed coordinate system [m/s]
%  s(6)  = zCOG   [m] - the Z position in fixed coordinate system [m]

%  s(7)  = dnCOG  [rad/s] - the derivative of the orientation of the vehicle wrt the longitudinal axis
%  s(8) = nCOG   [rad] - the  orientation of the vehicle wrt the longitudinal axis
%  s(9)  = doCOG  [rad/s] - the derivative of the orientation of the vehicle wrt the lateral axis
%  s(10)  = oCOG   [rad] - the  orientation of the vehicle wrt the lateral axis
%  s(11) = dpCOG  [rad/s] - the derivative of the orientation of the vehicle wrt the vertical axis
%  s(12) = pCOG   [rad] - the  orientation of the vehicle wrt the vertical axis

%  s(13) = Vb  [V] - the voltage across the terminals of the HV battery
%  s(14) = As  [A*s] - the charge drained from the HV battery, 0 corresponds to full charge

%  s(15) = taufl [Nm] - the actual torque applied to the front left motor
%  s(16) = taufr [Nm] - the actual torque applied to the front right motor
%  s(17) = taurl [Nm] - the actual torque applied to the rear left motor
%  s(18) = taurr [Nm] - the actual torque applied to the rear right motor

%  s(19) = SRfl  [rad/s] - the slip ratio of the front left tire
%  s(20) = SRfr  [rad/s] - the slip ratio of the front right tire
%  s(21) = SRrl  [rad/s] - the slip ratio of the rear left tire
%  s(22) = SRrr  [rad/s] - the slip ratio of the rear right tire

%% The function
function v = vehicle_output(t, s, tauRaw, P, varCAR)
    v = initialize_v;
    v.t = t;
    n = length(t);
    
    for i = 1:n
        v = compute_zi(i, s(i,:)', tauRaw(i,:)', P(i,:), varCAR, v);
    end
end

function v = compute_zi(i, s, tauRaw, P, model, v)
    % interp simulink
    vt = @(x1) (interp1(model.vt_in, model.vt_out, x1));

    [xS, yS, zS, dxS, dzS, xT, yT, zT] = vehicle_suspension(s, model);
    w = vehicle_slip(s, model);
    [sum_Fxa, sum_Fza, sum_My, res_torque, Fxv, Fz, tire_tau_from_tire, dxv] = vehicle_forces(s, P, w, xT, zS, dzS, model);
    der = vehicle_dynamics(s, sum_Fxa, sum_Fza, sum_My, model);
    [dVb, dAs, dT, Im_ref, Im] = vehicle_powertrain(s, tauRaw, w, model);
    
    % Cartesian
    v.xz(i,:) = [s(2) s(4)];
    v.dxz(i,:) = [s(1) s(3)];
    v.ddxz(i,:) = [der(1) der(3)];

    % Polar
    v.o(i,:) = [s(6)];
    v.do(i,:) = [s(5)];
    v.ddo(i,:) = [der(5)];

    % Wheel Speed
    v.w(i,:) = w;

    % Voltage
    v.Voc(i,:) = model.ns*vt(s(8));

    v.Vb(i,:) = s(7);
    v.dVb(i,:) = dVb;

    % Powertrain
    v.Ah(i,:) = s(8)/3600;
    v.dAs(i,:) = dAs;
    v.Im(i,:) = Im;
    v.dT(i,:) = dT;
    v.Im_ref(i,:) = Im_ref;

    % Forces
    v.Fxv(i,:) = Fxv;
    v.Fz(i,:) = Fz;
    
    % suspension
    v.z(i,:) = zS;
    v.dz(i,:) = dzS;

    % slip
    v.S(i,:) = s(11:12);
    v.dxv(i,:) = dxv;

    % torque
    v.tau_tire(i,:) = (tire_tau_from_tire ./ model.gr) + model.gm.*w;
    v.tau_motor(i,:) = s(9:10);

    % traction residual
    v.res(i,:) = res_torque;
end

function v = initialize_v
    % Cartesian
    v.xz = [];
    v.dxz = [];
    v.ddxz = [];

    % Polar
    v.o = [];
    v.do = [];
    v.ddo = [];

    % Wheel Speed
    v.w = [];

    % Voltage
    v.Voc = [];

    v.Vb = [];
    v.dVb = [];

    % Powertrain
    v.Ah = [];
    v.dAs = [];
    v.Im = [];
    v.dT = [];
    v.Im_ref = [];

    % Forces
    v.Fxv = [];
    v.Fz = [];

    % supsension
    v.z = [];
    v.dz = [];

    % slip
    v.S = [];
    v.dxv = [];

    % torque
    v.tau_tire = [];
    v.tau_motor = [];

    % traction residual
    v.res = [];
end