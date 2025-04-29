%% Function Description
%  s - state vector [23 1]
%  
%  s(1)  = dx  [m/s] - the chassis center of gravity longitudinal velocity
%  s(2)  = x   [m] - the longitudinal distance traveled by the chassis center of gravity
%  s(3)  = dy  [m/s] - the chassis center of gravity lateral velocity
%  s(4)  = y   [m] - the lateral distance traveled by the chassis center of gravity
%  s(5)  = dz  [m/s] - the chassis center of gravity vertical velocity
%  s(6)  = z   [m] - the vertical distance between the ground plane and the chassis center of gravity

%  s(7)  = do  [rad/s] - the derivative of the orientation of the vehicle wrt the lateral axis
%  s(8)  = o   [rad] - the  orientation of the vehicle wrt the lateral axis
%  s(9)  = dn  [rad/s] - the derivative of the orientation of the vehicle wrt the longitudinal axis
%  s(10) = n   [rad] - the  orientation of the vehicle wrt the longitudinal axis
%  s(11) = dp  [rad/s] - the derivative of the orientation of the vehicle wrt the vertical axis
%  s(12) = p   [rad] - the  orientation of the vehicle wrt the vertical axis

%  s(13) = wfl  [rad/s] - the differential angular velocity of the front left tire
%  s(14) = wfr  [rad/s] - the differential angular velocity of the front right tire
%  s(15) = wrl  [rad/s] - the differential angular velocity of the rear left tire
%  s(16) = wrr  [rad/s] - the differential angular velocity of the rear right tire

%  s(17) = Vb  [V] - the voltage across the terminals of the HV battery
%  s(18) = As  [A*s] - the charge drained from the HV battery, 0 corresponds to full charge

%  s(19) = Imfl [A] - the current pulled by the front left powertrain
%  s(20) = Imfr [A] - the current pulled by the front right powertrain
%  s(21) = Imrl [A] - the current pulled by the rear left powertrain
%  s(22) = Imrr [A] - the current pulled by the rear right powertrain


%% The function
function v = compute_v_master_6DOF(t, s, tauRaw, CCSA, varCAR)
    v = initialize_v;
    v.t = t;
    n = length(t);
    
    for i = 1:n
        v = compute_zi(i, s(i,:)', tauRaw(i,:)', CCSA(i,:), varCAR, v);
    end
end

function v = compute_zi(i, s, tauRaw, CCSA, varCAR, v)
    [Fx_t, Fxv, Fyv, Fz, wt, tau, toe, Fx, Fy, z, dz, SR, SA, Fx_max, Fy_max, res] = traction_model_master_6DOF(s, CCSA, varCAR);
    [ddx, dX, ddy, dY, ddz, ddo, ddn, ddp, dw] = vehicle_dynamics_model_master_6DOF(s, Fx_t, Fxv, Fyv, Fz, tau, varCAR);
    [dVb, dAs, dIm, tau_ref] = powertrain_model_master_6DOF(s, wt, tauRaw, varCAR);

    % Cartesian
    v.xyz(i,:) = [s(2) s(4) s(6)];
    v.dxyz(i,:) = [s(1) s(3) s(5)];
    v.ddxyz(i,:) = [ddx ddy ddz];

    % Polar
    v.onp(i,:) = [s(8) s(10) s(12)];
    v.donp(i,:) = [s(7) s(9) s(11)];
    v.ddonp(i,:) = [ddo ddn ddp];

    % Wheel Speed
    v.w(i,:) = wt;
    v.dw(i,:) = dw;

    % Voltage
    v.Voc(i,:) = varCAR.ns*varCAR.vt(s(18));

    v.Vb(i,:) = s(17);
    v.dVb(i,:) = dVb;

    % Current
    v.Ah(i,:) = s(18)/3600;
    v.dAs(i,:) = dAs;
    v.Im(i,:) = s(19:22);
    v.dIm(i,:) = dIm;

    % Forces
    v.Fx(i,:) = Fx_t;
    v.Fy(i,:) = Fy;
    v.Fz(i,:) = Fz;
    v.Fx_max(i,:) = Fx_max;
    v.Fy_max(i,:) = Fy_max;
    v.F_xy(i,:) = sqrt(Fx_t.^2 + Fy.^2);
    v.F_max(i,:) = sqrt(Fx_max.^2 + Fy_max.^2);
    
    % suspension
    v.z(i,:) = z;
    v.dz(i,:) = dz;
    v.toe(i,:) = toe;

    % slip
    v.S(i,:) = SR;
    v.alpha(i,:) = SA;

    % torque
    v.tau(i,:) = tau;
    v.tau_ref_mot(i,:) = tau_ref - varCAR.gm.*wt;
    v.tau_ref(i,:) = tau_ref;

    % traction residual
    v.res(i,:) = res;
end

function v = initialize_v
    % Cartesian
    v.xyz = [];
    v.dxyz = [];
    v.ddxyz = [];

    % Polar
    v.onp = [];
    v.donp = [];
    v.ddonp = [];

    % Wheel Speed
    v.w = [];
    v.dw = [];

    % Voltage
    v.Voc = [];

    v.Vb = [];
    v.dVb = [];

    % capacity
    v.Ah = [];
    v.dAs = [];

    % Current
    v.Im = [];
    v.dIm = [];

    % Forces
    v.Fx = [];
    v.Fy = [];
    v.Fz = [];
    v.Fy_max = [];
    v.Fx_max = [];
    v.F_xy = [];
    v.F_max = [];

    % supsension
    v.z = [];
    v.dz = [];
    v.toe = [];

    % slip
    v.S = [];
    v.alpha = [];

    % torque
    v.tau = [];
    v.tau_ref_mot = [];
    v.tau_ref = [];

    % traction residual
    v.res = [];
end