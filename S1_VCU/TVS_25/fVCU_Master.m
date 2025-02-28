classdef fVCU_Master < handle
    %% f properties
    properties
    % Flags indicating operating status of vehicle
        CS_SFLAG; % Car state CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        TB_SFLAG; % Throttle-brake CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        SS_SFLAG; % steering sensor CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        WT_SFLAG; % Wheel speed measurements CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        IV_SFLAG; % battery current and voltage CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        BT_SFLAG; % max battery cell temperature CAN signal stale flag
                  % Stale = 1, Not Stale = 0

        % MT_SFLAG; % motor/inverter temperatures CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        % CO_SFLAG; % motor/inverter overload CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        % MO_SFLAG; % motor torque/speed CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        IAC_SFLAG; % inverter A critical CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        IAT_SFLAG; % inverter A temperatures CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        IBC_SFLAG; % inverter B critical CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        IBT_SFLAG; % inverter B temperatures CAN signal stale flag
                  % Stale = 1, Not Stale = 0
          
        SS_FFLAG; % steering sensor proper sensor function flag
                  % Properly Functioning = 1, Improperly Functioning = 0
        AV_FFLAG; % angular velocity sensor proper sensor function flag
                  % Properly Functioning = 1, Improperly Functioning = 0
        GS_FFLAG; % gps proper sensor function flag
                  % Properly Functioning = 3, Improperly Functioning = 0 or 1 or 2
        VCU_PFLAG; % VCU mode permit
                   % VS = 1, VT = 2, Neither = 0
        VCU_CFLAG % VCU speed control mode
                  % Speedxontrol = 1, Torquecontrol = 2
    end

    %% f methods
    methods
        function f = fVCU_Master()
            f.CS_SFLAG = 0;
            f.TB_SFLAG = 0;
            f.SS_SFLAG = 0;
            f.WT_SFLAG = 0;
            f.IV_SFLAG = 0;
            f.BT_SFLAG = 0;
            % f.MT_SFLAG = 0;
            % f.CO_SFLAG = 0;
            % f.MO_SFLAG = 0;

            f.IAC_SFLAG = 0;
            f.IAT_SFLAG = 0;
            f.IBC_SFLAG = 0;
            f.IBT_SFLAG = 0;

            f.SS_FFLAG = 1;
            f.AV_FFLAG = 1;
            f.GS_FFLAG = 3;
            f.VCU_PFLAG = 1;
            f.VCU_CFLAG = 1;
        end
    end
end