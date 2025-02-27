%% Function Description
%  s - state vector [12 1]
%  
%  s(1)  = dx  [m/s] - the chassis center of gravity longitudinal velocity
%  s(2)  = x   [m] - the longitudinal distance traveled by the chassis center of gravity
%  s(3)  = dz  [m/s] - the chassis center of gravity vertical velocity
%  s(4)  = z   [m] - the vertical distance between the ground plane and the chassis center of gravity
%  s(5)  = do  [rad/s] - the derivative of the orientation of the vehicle wrt the horizontal axis
%  s(6)  = o   [rad] - the  orientation of the vehicle wrt the horizontal axis
%  s(7)  = wf  [rad/s] - the differential angular velocity of the front tires
%  s(8)  = wr  [rad/s] - the differential angular velocity of the rear tires
%  s(9)  = Vb  [V] - the voltage across the terminals of the HV battery
%  s(10) = Ah  [A*hr] - the charge drained from the HV battery, 0 corresponds to full charge
%  s(11) = Imf [A] - the current pulled by the front powertrain
%  s(12) = Imr [A] - the current pulled by the rear powertrain

%% The function
function v = compute_v_master_3DOF(t, s, tauRaw, varCAR)
    v = initialize_v;
    v.t = t;
    n = length(t);
    
    for i = 1:n
        v = compute_zi(i, s(i,:)', tauRaw(i,:)', varCAR, v);
    end
end

function v = compute_zi(i, s, tauRaw, varCAR, v)
    [Fx, Fz, wt, tau, z, dz, S, Fx_max] = traction_model_master_3DOF(s, varCAR);
    [ddx, ddz, ddo, dw] = vehicle_dynamics_model_master_3DOF(s, Fx, Fz, wt, tau, varCAR);
    [dVb, dAs, dIm, tau_ref] = powertrain_model_master_3DOF(s, wt, tauRaw, varCAR);

    % Longitudinal
    v.x(i,:) = s(2);
    v.dx(i,:) = s(1);
    v.ddx(i,:) = ddx;

    % Vertical
    v.z(i,:) = s(4);
    v.dz(i,:) = s(3);
    v.ddz(i,:) = ddz;

    v.zFR(i,:) = z;
    v.dzFR(i,:) = dz;

    % Orientation
    v.o(i,:) = s(6);
    v.do(i,:) = s(5);
    v.ddo(i,:) = ddo;

    % Voltage
    v.Voc(i,:) = varCAR.ns*varCAR.vt(s(10));

    v.Vb(i,:) = s(9);
    v.dVb(i,:) = dVb;

    % Current
    v.Ah(i,:) = s(10)/3600;
    v.dAh(i,:) = dAs/3600;
    v.Im(i,:) = s(11:12);
    v.dIm(i,:) = dIm;

    % Forces
    v.Fx(i,:) = Fx;
    v.Fz(i,:) = Fz;
    v.Fx_max(i,:) = Fx_max;
    
    % Wheel Speed
    v.w(i,:) = wt;
    v.dw(i,:) = dw;

    v.Sl(i,:) = S;

    % torque
    v.tau(i,:) = tau;
    v.tau_ref_mot(i,:) = tau_ref - varCAR.gm.*wt;
    v.tau_ref(i,:) = tau_ref;
end

function v = initialize_v
    % Longitudinal
    v.x = [];
    v.dx = [];
    v.ddx = [];

    % Vertical
    v.z = [];
    v.dz = [];
    v.ddz = [];

    v.zFR = [];
    v.dzFR = [];

    % Orientation
    v.o = [];
    v.do = [];
    v.ddo = [];

    % Voltage
    v.Voc = [];
    v.dVoc = [];

    v.Vb = [];
    v.dVb = [];

    % Current
    v.Ah = [];
    v.dAh = [];
    v.Im = [];
    v.dIm = [];

    % Forces
    v.Fx = [];
    v.Fz = [];
    v.Fx_max = [];
    
    % Wheel Speed
    v.w = [];
    v.dw = [];

    v.Sl = [];

    % torque
    v.tau = [];
    v.tau_ref_mot = [];
    v.tau_ref = [];
end