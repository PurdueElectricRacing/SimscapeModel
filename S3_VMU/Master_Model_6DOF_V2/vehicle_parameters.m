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
        ct; % lookup table for damper coefficients [m/s] -> [Ns/m]
        vt; % lookup table for cell volatge as cell disharged [Ah] -> [V]
        pt; % lookup table for motor power [rad/s, Nm] -> [W]
        mt; % lookup table for max torque [rad/s, V] -> [Nm]
        tt; % lookup table for torque [rad/s, W] -> [Nm]

        % nominal suspension parameters
        L0;  % Shock free length [FL FR RL RR] [m]
        z0;  % height of bottom of shock to ground [FL FR RL RR] [m]

        % supsension parameters
        k;   % suspension spring constant [front rear] [N/m]
        c;   % damping constant [front rear] [Ns/m]
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
        Lm;  % motor inductance [H]
        Rm;  % motor resistance [Ohm]
        v0;  % unloaded battery voltage at full state of charge [V]

        % motor parameters
        T_ABS_MAX; % Absolute maximum torque per motor [FL FR RL RR] [Nm]

        % tire parameters
        r0;  % unloaded tire radius [front rear] [m]
        Jw;  % Tire moment of inertia [kg*m^2]
        rr;  % rolling resistance coefficient [N/N]
        ai;  % smoothening parameter for rolling resistance

        Sm;  % slip ratio at peak traction [unitless]
        Am;  % slip angle at peak traction [rad]

        Bx;  % Longitudinal magic tire model B coefficient
        Cx;  % Longitudinal magic tire model C coefficient
        Dx;  % Longitudinal magic tire model D coefficient
        Ex;  % Longitudinal magic tire model E coefficient

        By;  % Lateral magic tire model B coefficient
        Cy;  % Lateral magic tire model C coefficient
        Dy;  % Lateral magic tire model D coefficient
        Ey;  % Lateral magic tire model E coefficient

        ao;  % Orientation magic tire model A coefficient
        bo;  % Orientation magic tire model B coefficient
        co;  % Orientation magic tire model C coefficient
        do;  % Orientation magic tire model D coefficient
        fo;  % Orientation magic tire model F coefficient

        bR;  % gain coefficient for combined slip model
        aR;  % power coefficient for combined slip model

        % numerical parameters
        epsSA;
        epsSR;
        sN;
    end

    methods
        %% Initialization Function
        function varVehicle = vehicle_parameters()
            % vehicle mass
            varVehicle.m_s = 180 + 71;
            varVehicle.m_us = 40;
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
            varVehicle.ct = varVehicle.get_c_tbl;
            varVehicle.vt = varVehicle.get_v_table;

            % motor lookup tables
            [motPcurve_6DOF, maxTcurve_6DOF, motTcurve_6DOF] = varVehicle.get_mot_table();
            varVehicle.pt = motPcurve_6DOF;
            varVehicle.mt = maxTcurve_6DOF;
            varVehicle.tt = motTcurve_6DOF;

            % supsension parameters
            varVehicle.k = 1.25*43780*[1;1;1;1];
            varVehicle.z0 = [0.1; 0.1; 0.1; 0.1];
            varVehicle.L0 = [0.1; 0.1; 0.1; 0.1];
            varVehicle.st = zeros(4,1);
            varVehicle.p = varVehicle.get_p;

            % gearbox parameters
            varVehicle.gr = 11.34;
            varVehicle.gm = 0.01;

            % electrical parameters
            varVehicle.ns = 145;
            varVehicle.np = 3;
            varVehicle.ir = 0.0093;
            varVehicle.Rb = varVehicle.ir * varVehicle.ns / varVehicle.np;
            varVehicle.Lm = 0.005;
            varVehicle.Rm = 0.25;
            varVehicle.cr = 0.00015;
            varVehicle.v0 = varVehicle.ns*varVehicle.vt(0);

            % motor parameters
            varVehicle.T_ABS_MAX = [21; 21; 21; 21];

            % tire parameters
            varVehicle.r0 = 0.2;
            varVehicle.Jw = 0.3;
            varVehicle.rr = 0.0003;
            varVehicle.ai = 400./varVehicle.gr;

            [fit_FX_pure, fit_FY_pure, fit_theta, Sm, Am] = varVehicle.get_S_tables();

            varVehicle.Sm = Sm;
            varVehicle.Am = Am;

            varVehicle.Bx = fit_FX_pure.B;
            varVehicle.Cx = fit_FX_pure.C;
            varVehicle.Dx = (3/3)*fit_FX_pure.D;
            varVehicle.Ex = fit_FX_pure.E;

            varVehicle.By = fit_FY_pure.B;
            varVehicle.Cy = fit_FY_pure.C;
            varVehicle.Dy = (3/3)*fit_FY_pure.D;
            varVehicle.Ey = fit_FY_pure.E;

            varVehicle.ao = fit_theta.a;
            varVehicle.bo = fit_theta.b;
            varVehicle.co = fit_theta.c;
            varVehicle.do = fit_theta.d;
            varVehicle.fo = fit_theta.f;

            varVehicle.bR = 0;
            varVehicle.aR = 1;

            % numerical parameters
            varVehicle.epsSA = 0.1; % minimum velocity to apply normal slip angle formula [m/s]
            varVehicle.epsSR = 0.1; % minimum velocity to apply normal slip ratio formula [m/s]
            varVehicle.sN = 75;
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

        function [FZSFXcurve, FZSFYcurve, SLSA0Curve, Sm, Am] = get_S_tables()
            load("Vehicle_Data\TIRE_R20_6DOF.mat", "FZSFXcurve", "FZSFYcurve", "SLSA0Curve", "Sm", "Am")
        end
    end
end
