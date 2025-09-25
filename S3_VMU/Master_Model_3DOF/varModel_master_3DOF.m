classdef varModel_master_3DOF < handle
    %% Vehicle Properties
    properties
        % vehicle parameters
        m;   % vehicle mass [kg]
        g;   % gravitational constant [m/s^2]
        wb;  % vehicle wheelbase [front rear] [m]
        Jv;  % pitching moment [kg*m^2]
        
        % aerodynamic parameters
        cl;  % coefficient of lift [kg/m]
        cd;  % coeficient of drag [kg/m]
        xp;  % longitudinal distance from COG to COP, positive mean COP in front of COG
        zp;  % vertical distance from COG to COP, positive mean COP above of COG

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
        tn;  % nominal torque for motor [Nm]
        ta;  % Absolute Maximum torque for motor [Nm]
        Oa;  % Absolute Maximum overload [%]
        Od;  % Picked derating overload value [ratio]
        dS;  % Torque derating relation [slope]
        Ox;  % Set of sample values for overload interp1
        Tx;  % Set of sample values for torque interp1
        Oc;  % Constant for overload function

        % tire parameters
        r0;  % unloaded tire radius [front rear] [m]
        Jw;  % Tire moment of inertia [kg*m^2]
        rr;  % rolling resistance coefficient [N/N]
        ai;  % smoothening parameter for rolling resistance

        Sm;  % slip ratio at peak traction [unitless]

        Bx;  % Longitudinal magic tire model B coefficient
        Cx;  % Longitudinal magic tire model C coefficient
        Dx;  % Longitudinal magic tire model D coefficient
        Ex;  % Longitudinal magic tire model E coefficient

        % numerical parameters
        eps;  % finite difference delta for getting gradient of tire force
        tolX; % tolerance on force residual for longitudinal tire force
        imax; % maximum number of iterations for finding slip ratio
    end

    methods
        %% Initialization Function
        function varVehicle = varModel_master_3DOF()
            % vehicle/geometric parameters
            varVehicle.m = 219 + 71;
            varVehicle.g = 9.81;
            varVehicle.wb = 1.535*[1-0.46; 0.46];
            varVehicle.Jv = 100;

            % aerodynamic parameters
            varVehicle.cl = 0.5*2.11*1.225*2;
            varVehicle.cd = 0.5*1.15*1.225*2;
            varVehicle.xp = 0.05;
            varVehicle.zp = 0.05;

            % Lookup tables
            varVehicle.ct = varVehicle.get_c_tbl;
            varVehicle.vt = varVehicle.get_v_table;

            % motor lookup tables
            [motPcurve_3DOF, maxTcurve_3DOF, motTcurve_3DOF] = varVehicle.get_mot_table();
            varVehicle.pt = motPcurve_3DOF;
            varVehicle.mt = maxTcurve_3DOF;
            varVehicle.tt = motTcurve_3DOF;

            % supsension parameters
            varVehicle.k = 1.25*43780*[1;1];
            varVehicle.zs = 0.182;
            [z0, O0] = varVehicle.get_z0_O0(varVehicle);
            varVehicle.z0 = z0;
            varVehicle.O0 = O0;
            
            % gearbox parameters
            varVehicle.gr = 11.34;
            varVehicle.gm = 0.01;

            % electrical parameters
            varVehicle.ns = 76;
            varVehicle.np = 5;
            varVehicle.ir = 0.0093;
            varVehicle.Rb = varVehicle.ir * varVehicle.ns / varVehicle.np;
            varVehicle.Lm = 0.005;
            varVehicle.Rm = 0.25;
            varVehicle.cr = 0.00015;
            varVehicle.v0 = varVehicle.ns*varVehicle.vt(0);
            varVehicle.tn = 9.8;
            varVehicle.ta = 21;
            varVehicle.Oa = 100;
            varVehicle.Od = 0.3;
            varVehicle.dS = (varVehicle.tn-varVehicle.ta)/(varVehicle.Oa-varVehicle.Od);
            varVehicle.Ox = [0,70,100];
            varVehicle.Tx = [21,21,9.8];
            varVehicle.Oc = 0.5; %Sample value

            % tire parameters
            varVehicle.r0 = 0.2;
            varVehicle.Jw = 0.3;
            varVehicle.rr = 0.0003;
            varVehicle.ai = 400./varVehicle.gr;

            [fit_FX_pure, Sm] = varVehicle.get_S_tables();
            varVehicle.Sm = Sm;
            varVehicle.Bx = fit_FX_pure.B;
            varVehicle.Cx = fit_FX_pure.C;
            varVehicle.Dx = (2/3)*fit_FX_pure.D;
            varVehicle.Ex = fit_FX_pure.E;

            % numerical parameters
            varVehicle.eps = 0.000001;
            varVehicle.tolX = 1e-10;
            varVehicle.imax = 10;
        end
    end

    methods(Static)
        function VCcurve_3DOF = get_c_tbl()
            load('Vehicle_Data\Mk25ll_3DOF.mat', 'VCcurve_3DOF')
        end

        function VAs_tbl_3DOF = get_v_table()
            load('Vehicle_Data\P45BCellDischarge_3DOF.mat', 'VAs_tbl_3DOF')
        end

        function [FZSFXcurve, Sm] = get_S_tables()
            load("Vehicle_Data\TIRE_R20_3DOF.mat", "FZSFXcurve", "Sm")
        end

        function [motPcurve_3DOF, maxTcurve_3DOF, motTcurve_3DOF] = get_mot_table()
            load('Vehicle_Data\AMK_FSAE_3DOF.mat', 'motPcurve_3DOF', 'maxTcurve_3DOF', 'motTcurve_3DOF')
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