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
        WT_SFLAG; % Wheel speed sensor CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        IV_SFLAG; % battery current and voltage CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        BT_SFLAG; % max battery cell temperature CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        MT_SFLAG; % max motor temperature CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        CT_SFLAG; % max motor controller temperature CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        MO_SFLAG; % motor torque CAN signal stale flag
                  % Stale = 1, Not Stale = 0
        SS_FFLAG; % steering sensor proper sensor function flag
                  % Properly Functioning = 1, Improperly Functioning = 0
        AV_FFLAG; % angular velocity sensor proper sensor function flag
                  % Properly Functioning = 1, Improperly Functioning = 0
        GS_FFLAG; % gps proper sensor function flag
                  % Properly Functioning = 3, Improperly Functioning = 0 or 1 or 2
        VT_PFLAG; % variable torque permit flag
                  % Permit VT = 1, Do not permit VT = 0
    end

    %% f Methods
    methods
        function f = fVCU_Master()
            f.CS_SFLAG = 0;
            f.TB_SFLAG = 0;
            f.SS_SFLAG = 0;
            f.WT_SFLAG = 0;
            f.IV_SFLAG = 0;
            f.BT_SFLAG = 0;
            f.MT_SFLAG = 0;
            f.CT_SFLAG = 0;
            f.MO_SFLAG = 0;
            f.SS_FFLAG = 1;
            f.AV_FFLAG = 1;
            f.GS_FFLAG = 3;
            f.VT_PFLAG = 1;
        end
    end
end