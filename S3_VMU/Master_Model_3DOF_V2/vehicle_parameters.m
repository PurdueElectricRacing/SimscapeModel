classdef vehicle_parameters < handle
    %% Vehicle Properties
    properties
        % vehicle mass
        m_s;    % vehicle sprung mass [kg]
        m_us;   % vehicle unspring mass [kg]
        m;      % vehicle total mass [kg]

        Ixx;  % rolling moment [kg*m^2]
        Iyy;  % pitching moment [kg*m^2]
        Izz;  % yaw moment [kg*m^2]

        g;    % gravitational constant [m/s^2]

        % chassis geometry
        wb_s0;  % suspension wheel base along suspension plane [FL FR RL RR] [m]
        hs_s0;  % suspension half track along suspension plane [FL FR RL RR] [m]
        LN;     % minimum distance from suspension plane to vehicle COG [m]
        
        % aerodynamic parameters
        cl;  % coefficient of lift [kg/m]
        cd;  % coeficient of drag [kg/m]
        xp;  % Horizontal distance from center of gravity to center of pressure, positive is in front of COG [m]
        zp;  % Vertical distance from center of gravity to center of pressure, positive is above COG [m]
        
        % lookup tables
        % ct; % lookup table for damper coefficients [m/s] -> [Ns/m]
        % vt; % lookup table for cell volatge as cell disharged [Ah] -> [V]
        % pt; % lookup table for motor power [rad/s, Nm] -> [W]
        % mt; % lookup table for max torque [rad/s, V] -> [Nm]

        % nominal suspension parameters
        L0;  % Shock free length [FL FR RL RR] [m]
        z0;  % height of bottom of shock to ground [FL FR RL RR] [m]

        % supsension parameters
        k;   % suspension spring constant [FL FR RL RR] [N/m]
        kL;  % suspension anti-roll constant [FL FR RL RR] [N/rad]
        st;  % static toe [rad]
        p;   % cubic coefficients for toe [deg] -> [deg]
        
        % gearbox parameters
        gr;  % Gear ratio [unitless]
        gm;  % gearbox/tire energy transmission damping [Nm*s/rad]
        
        % electrical parameters
        ns;  % Number of battery cells in series [count]
        np;  % Number of battery cells in parallel [count]
        ir;  % Internal resistance of cell [Ω]
        Rb;  % Total battery resistance [Ω]
        cr;  % Capacitance of voltage regulating capacitor [F]
        v0;  % unloaded battery voltage at full state of charge [V]
        torque_const;

        % motor parameters
        T_ABS_MAX; % Absolute maximum torque per motor [FL FR RL RR] [Nm]
        tn;  % nominal torque for motor [Nm]
        ta;  % Absolute Maximum torque for motor [Nm]
        Oa;  % Absolute Maximum overload [%]
        Ox;  % Set of sample values for overload interp1
        Tx;  % Set of sample values for torque interp1
        Oc;  % Constant for overload function

        % tire parameters
        r0;  % unloaded tire radius [front rear] [m]
        Jw;  % Tire moment of inertia [kg*m^2]
        rr;  % rolling resistance coefficient [N/N]
        ai;  % smoothening parameter for rolling resistance

        Bx;  % Longitudinal magic tire model B coefficient
        Cx;  % Longitudinal magic tire model C coefficient
        Dx;  % Longitudinal magic tire model D coefficient
        Ex;  % Longitudinal magic tire model E coefficient

        By;  % Lateral magic tire model B coefficient
        Cy;  % Lateral magic tire model C coefficient
        Dy;  % Lateral magic tire model D coefficient
        Ey;  % Lateral magic tire model E coefficient

        % Brake disc parameters
        mu_k; % kinetic coefficient of friction
        mu_s; % static coefficient of friction
        D_b;  % brake actuator bore diameter [m]
        R_m;  % mean radius of brake pad force [m]
        N_p;  % number of pads

        % numerical parameters
        epsSA; % minimum velocity to apply normal slip angle formula [m/s]
        epsSR; % minimum velocity to apply normal slip ratio formula [m/s]
        epsP;  % minimum power consumption for residual calculation [W]
        epsT;  % minimum torque for residual calculation [Nm]
        sN;    % distance to trigger event function for accleration event [m]

        % cursed simulink function garbage
        ct_in;
        ct_out;
        vt_in;
        vt_out;
        pt_in1;
        pt_in2;
        pt_out;
        mt_in1;
        mt_in2;
        mt_out;

        % min and max for interpolation tables
        w_min;
        w_max;
        dz_min;
        dz_max;
        T_min;
        T_max;
    end

    methods
        %% Initialization Function
        function varVehicle = vehicle_parameters()
            % vehicle mass
            varVehicle.m_s = 220; % 26: 225
            varVehicle.m_us = 70; % 26: 65
            varVehicle.m = varVehicle.m_s + varVehicle.m_us;

            varVehicle.Ixx = 100;
            varVehicle.Iyy = 100;
            varVehicle.Izz = 100;

            % chassis geometry
            varVehicle.wb_s0 = 1.535*[1-0.46; 1-0.46; 0.46; 0.46];
            varVehicle.hs_s0 = [1.34; 1.34; 1.27; 1.27]./2;
            varVehicle.LN = 0.1;

            varVehicle.g = 9.81;
            
            % aerodynamic parameters
            varVehicle.cl = 0.5*2.11*1.225*2;
            varVehicle.cd = 0.5*1.15*1.225*2;
            varVehicle.xp = 0.1*varVehicle.wb_s0(1);
            varVehicle.zp = 0.01;

            % Lookup tables
            ct = varVehicle.get_c_tbl;
            varVehicle.ct_in = ct.GridVectors{1,1};
            varVehicle.ct_out = ct.Values;

            vt = varVehicle.get_v_table;
            varVehicle.vt_in = vt.GridVectors{1,1};
            varVehicle.vt_out = vt.Values;

            % motor lookup tables
            [motPcurve_6DOF, maxTcurve_6DOF, motTcurve_6DOF] = varVehicle.get_mot_table();
            
            pt = motPcurve_6DOF;
            varVehicle.pt_in1 = pt.GridVectors{1,1};
            varVehicle.pt_in2 = pt.GridVectors{1,2};
            varVehicle.pt_out = pt.Values;

            mt = maxTcurve_6DOF;
            varVehicle.mt_in1 = mt.GridVectors{1,1};
            varVehicle.mt_in2 = mt.GridVectors{1,2};
            varVehicle.mt_out = mt.Values;

            % supsension parameters
            varVehicle.k = 43780*[1;1;1;1];
            varVehicle.kL = [2000; 2000; 2000; 2000];
            varVehicle.z0 = [0.1; 0.1; 0.1; 0.1];
            varVehicle.L0 = [0.1; 0.1; 0.1; 0.1];
            varVehicle.st = 0*deg2rad([-0.16; 0.16; 0.08; -0.08]);
            varVehicle.p = varVehicle.get_p;

            % gearbox parameters
            varVehicle.gr = 11.34;
            varVehicle.gm = 0.01;

            % electrical parameters
            varVehicle.ns = 145;
            varVehicle.np = 3;
            varVehicle.ir = 0.0093;
            varVehicle.Rb = varVehicle.ir * varVehicle.ns / varVehicle.np;
            varVehicle.cr = 0.00015;
            varVehicle.v0 = varVehicle.ns*vt(0);
            varVehicle.torque_const = 100;

            % motor parameters
            varVehicle.T_ABS_MAX = [21; 21; 21; 21];
            varVehicle.tn = 9.8;
            varVehicle.ta = 21;
            varVehicle.Oa = 100;
            varVehicle.Ox = [0,70,100];
            varVehicle.Tx = [21,21,9.8];
            varVehicle.Oc = 1;

            % tire parameters
            varVehicle.r0 = 0.2;
            varVehicle.Jw = 0.3; % include angular acceleration at some point
            varVehicle.rr = 0.0003;
            varVehicle.ai = 400./varVehicle.gr;

            [fit_FX_pure, fit_FY_pure] = varVehicle.get_S_tables();

            varVehicle.Bx = fit_FX_pure.B;
            varVehicle.Cx = fit_FX_pure.C;
            varVehicle.Dx = (3/3)*fit_FX_pure.D;
            varVehicle.Ex = fit_FX_pure.E;

            varVehicle.By = fit_FY_pure.B;
            varVehicle.Cy = fit_FY_pure.C;
            varVehicle.Dy = (3/3)*fit_FY_pure.D;
            varVehicle.Ey = fit_FY_pure.E;

            % Brake disc parameters
            varVehicle.mu_k = 0.4; % kinetic coefficient of friction
            varVehicle.mu_s = 0.4; % static coefficient of friction
            varVehicle.D_b = 0.05; % brake actuator bore diameter [m]
            varVehicle.R_m = 0.05; % mean radius of brake pad force [m]
            varVehicle.N_p = 2;    % number of pads

            % numerical parameters
            varVehicle.epsSA = 0.1;
            varVehicle.epsSR = 0.1;
            varVehicle.epsP = 1;
            varVehicle.epsT = 0.1;

            varVehicle.sN = 75;

            % min and max for interpolation tables
            varVehicle.w_min = min(varVehicle.pt_in1) / varVehicle.gr;
            varVehicle.w_max = max(varVehicle.pt_in1) / varVehicle.gr;

            varVehicle.dz_min = min(varVehicle.ct_in);
            varVehicle.dz_max = max(varVehicle.ct_in);

            varVehicle.T_min = -21;
            varVehicle.T_max = 21;
        end
    end

    methods(Static)
        function VCcurve_6DOF = get_c_tbl()
            load('Vehicle_Data\Mk25ll_6DOF.mat', 'VCcurve_6DOF')
        end

        function VAs_tbl_6DOF = get_v_table()
            load('Vehicle_Data\P45BCellDischarge_6DOF.mat', 'VAs_tbl_6DOF')
        end

        function [motPcurve_6DOF, maxTcurve_6DOF, motTcurve_6DOF] = get_mot_table()
            load('Vehicle_Data\AMK_FSAE_6DOF.mat', 'motPcurve_6DOF', 'maxTcurve_6DOF', 'motTcurve_6DOF')
        end

        function p_Toe_6DOF = get_p()
            load('Vehicle_Data/Toe_6DOF.mat', 'p_Toe_6DOF')
        end

        function [FZSFXcurve, FZSFYcurve] = get_S_tables()
            load("Vehicle_Data\TIRE_R20_6DOF.mat", "FZSFXcurve", "FZSFYcurve")
        end
    end
end
