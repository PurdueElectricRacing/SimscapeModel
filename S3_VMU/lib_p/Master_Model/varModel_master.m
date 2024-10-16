classdef varModel_master < handle
    %% Vehicle Properties
    properties
        m;   % vehicle mass [kg]
        g;   % gravitational constant [m/s^2]
        zs;  % height when springs are at static weight [m]
        z0;  % height when springs are at 0 force [m]
        O0;  % orientation of the vehicle body at 0 force [rad]
        r0;  % unloaded tire radius [front rear] [m]
        k;   % suspension spring constant [front rear] [N/m]
        c;   % damping constant [front rear] [Ns/m]
        wb;  % vehicle wheelbase [front rear] [m]
        ht;  % vehicle half track [front rear] [m]
        cl;  % coefficient of lift [kg/m]
        cd;  % coeficient of drag [kg/m]
        Jv;  % pitching moment [kg*m^2]
        Jw;  % Tire moment of inertia [kg*m^2]
        gr;  % Gear ratio [unitless]
        gm;  % gearbox/tire energy transmission damping [Nm*s/rad]
        xp;  % Distance from center of gravity to center of pressure [m]
        ns;  % Number of battery cells in series [unitless]
        np;  % Number of battery cells in parallel [unitless]
        ir;  % Internal resistance of cell [Ohm]
        cr;  % Capacitance of voltage regulating capacitor [F]
        v0;  % unloaded battery voltage at full state of charge [V]
        Sm;  % slip ratio at peak traction [unitless]
        rr;  % rolling resistance [N/N]
        ai;  % minimum 

        ct; % lookup table for damper coefficients [m/s] -> [Ns/m]
        vt; % lookup table for cell volatge as cell disharged [Ah] -> [V]
        pt; % lookup table for motor power [rad/s, Nm] -> [W]
        mt; % lookup table for max torque [rad/s, V] -> [Nm]
        St; % lookup table for slip ratio [N, N] -> [unitless]
        Ft; % lookup table for tractive force [unitless, N] -> [N]
    end

    methods
        %% Initialization Function
        function varVehicle = varModel_master()
            % Empirical Constants
            varVehicle.ct = varVehicle.get_c_tbl;

            % Exact Constants
            varVehicle.m = 219 + 71;
            varVehicle.g = 9.81;
            varVehicle.r0 = 0.2;
            varVehicle.k = 43780*2*[1;1];
            varVehicle.c = ppval(varVehicle.ct, [0; 0]);
            varVehicle.wb = 1.535*[1-0.46; 0.46];
            varVehicle.ht = [1.34; 1.27];
            varVehicle.cl = 0.5*2.11*1.225*1;
            varVehicle.cd = 0.5*1.15*1.225*1.4;
            varVehicle.Jv = 200;
            varVehicle.Jw = 0.3;
            varVehicle.gr = 11.34;
            varVehicle.ai = 400./varVehicle.gr;
            varVehicle.gm = 0.001;
            varVehicle.xp = 0.1*varVehicle.wb(1);
            varVehicle.ns = 145;
            varVehicle.np = 3;
            varVehicle.vt = varVehicle.get_v_table;
            varVehicle.pt = varVehicle.get_p_table;
            varVehicle.mt = varVehicle.get_t_table;
            [S_tbl, F_tbl, sl_fx_max_rounded] = varVehicle.get_S_table;
            varVehicle.St = S_tbl;
            varVehicle.Ft = F_tbl;
            varVehicle.Sm = sl_fx_max_rounded;
            varVehicle.ir = 0.0093;
            varVehicle.cr = 0.00015;
            varVehicle.v0 = varVehicle.ns*feval(varVehicle.vt, 0);
            varVehicle.rr = 0.0005;

            % Dependent Parameters
            varVehicle.zs = 0.182;
            [z0, O0] = varVehicle.get_z0_O0(varVehicle);
            varVehicle.z0 = z0;
            varVehicle.O0 = O0;
        end
    end

    methods(Static)
        function c_tbl = get_c_tbl()
            load('Damper_Tables\c_tbl.mat', 'c_tbl')
        end

        function VAhcurve = get_v_table()
            load('Battery_Tables\P45BCellDischarge.mat', 'VAhcurve')
        end

        function motorPtable = get_p_table()
            load('Motor_Tables\motorPowerTable.mat', 'motorPtable')
        end

        function motorMaxTtable = get_t_table()
            load('Motor_Tables\motorMaxTtable.mat', 'motorMaxTtable')
        end

        function [S_tbl, F_tbl, sl_fx_max_rounded] = get_S_table()
            load('Tire_Tables\SL_table.mat', 'S_tbl', 'F_tbl', 'sl_fx_max_rounded')
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
            theta0 = pi - double(sol.theta);
            zF = double(sol.zF);
            zR = double(sol.zR);
        end
    end
end