classdef varModel_master_6DOF < handle
    %% Vehicle Properties
    properties
        % vehicle parameters
        m;   % vehicle mass [kg]
        g;   % gravitational constant [m/s^2]
        wb;  % vehicle wheelbase [front rear] [m]
        ht;  % vehicle half track [front rear] [m]
        Ixx;  % rolling moment [kg*m^2]
        Iyy;  % pitching moment [kg*m^2]
        Izz;  % yaw moment [kg*m^2]
        
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

        % supsension parameters
        k;   % suspension spring constant [front rear] [N/m]
        c;   % damping constant [front rear] [Ns/m]
        zs;  % height when springs are at static weight [m]
        z0;  % height when springs are at 0 force [m]
        O0;  % orientation of the vehicle body at 0 force [rad]
        st;  % static toe [rad]
        p;   % cubic coefficients for toe [deg] -> [deg]

        % slip angle calculation
        Sx; % sign vector for x
        Sy; % sign vector for y 
        
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
        eps;  % finite difference delta for getting gradient of tire force
        epsS; % finite difference delta for Slip ratio gradient
        epsF; % smallest force that is allowed [N]
        epsT; % smallest force in expression for theta [N]
        tolX; % tolerance on force residual for longitudinal tire force [N]
        tolB; % bracket tolerance on force residual for longitudinal tire force [N]
        imax; % maximum number of iterations for finding slip ratio
        r_traction_scale; % parameter to smoothen the traction ratio
        r_vx_body_angle; % parameter to smoothen body angle
        dS_max;

        optsODE;
        optsSOL;
    end

    methods
        %% Initialization Function
        function varVehicle = varModel_master_6DOF()
            % vehicle/geometric parameters
            varVehicle.m = 219 + 71;
            varVehicle.g = 9.81;
            varVehicle.wb = 1.535*[1-0.46; 1-0.46; 0.46; 0.46];
            varVehicle.ht = [1.34; 1.34; 1.27; 1.27]./2;
            varVehicle.Ixx = 100;
            varVehicle.Iyy = 100;
            varVehicle.Izz = 100;

            % aerodynamic parameters
            varVehicle.cl = 0.5*2.11*1.225*2;
            varVehicle.cd = 0.5*1.15*1.225*2;
            varVehicle.xp = 0.1*varVehicle.wb(1);
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
            varVehicle.zs = 0.182;
            [z0, O0] = varVehicle.get_z0_O0(varVehicle);
            varVehicle.z0 = z0;
            varVehicle.O0 = O0;
            varVehicle.st = zeros(4,1);
            varVehicle.p = varVehicle.get_p;
            varVehicle.Sx = [1; -1; 1; -1];
            varVehicle.Sy = [1; 1; -1; -1];
            varVehicle.Cx = [1; -1; -1; 1].*sqrt(varVehicle.wb.^2 + varVehicle.ht.^2).*cos(atan(varVehicle.ht./varVehicle.wb));
            varVehicle.Cy = [1; 1; -1; -1].*sqrt(varVehicle.wb.^2 + varVehicle.ht.^2).*sin(atan(varVehicle.ht./varVehicle.wb));

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
            varVehicle.Dx = (2/3)*fit_FX_pure.D;
            varVehicle.Ex = fit_FX_pure.E;

            varVehicle.By = fit_FY_pure.B;
            varVehicle.Cy = fit_FY_pure.C;
            varVehicle.Dy = (1/3)*fit_FY_pure.D;
            varVehicle.Ey = fit_FY_pure.E;

            varVehicle.ao = fit_theta.a;
            varVehicle.bo = fit_theta.b;
            varVehicle.co = fit_theta.c;
            varVehicle.do = fit_theta.d;
            varVehicle.fo = fit_theta.f;

            varVehicle.bR = 0;
            varVehicle.aR = 1;

            % numerical parameters
            varVehicle.eps = 0.000001;
            varVehicle.epsS = 1e-8;
            varVehicle.epsF = 0.01;
            varVehicle.epsT = 30;
            varVehicle.tolX = 1e-12;
            varVehicle.tolB = 10;
            varVehicle.imax = 10;
            varVehicle.r_traction_scale = 10;
            varVehicle.r_vx_body_angle = 0.5;
            varVehicle.dS_max = 0.02;
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

        function [z0, theta0] = get_z0_O0(varVehicle)
            syms zCOG zF zR theta z0

            eqn1 = zCOG == zF - varVehicle.wb(1)*sin(theta);
            eqn2 = zCOG == zR + varVehicle.wb(2)*sin(theta);
            eqn3 = 0 == 2*(varVehicle.k(1)*(zF-z0) + varVehicle.k(2)*(zR-z0)) + varVehicle.m*varVehicle.g;
            eqn4 = 0 == (varVehicle.wb(1)*varVehicle.k(1)*(zF-z0) - varVehicle.wb(2)*varVehicle.k(2)*(zR-z0));
            eqn5 = zCOG == varVehicle.zs;

            eqns = [eqn1; eqn2; eqn3; eqn4; eqn5];

            sol = solve(eqns);
            z0 = double(sol.z0);
            theta0 = double(sol.theta);
            zF = double(sol.zF);
            zR = double(sol.zR);
        end
    end
end
