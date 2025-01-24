classdef fVCU_Master < handle
    %% f properties
    properties
    % Traction Control (TC) variables
        CS_SFLAG; % Car state CAN signal stale flag
        TB_SFLAG; % Throttle-brake CAN signal stale flag
        SS_SFLAG; % steering sensor CAN signal stale flag
        IV_SFLAG; % battery current and voltage CAN singal stale flag
        BT_SFLAG; % max battery cell temperature CAN signal stale flag
        MT_SFLAG; % max motor temperature CAN signal stale flag
        CT_SFLAG; % max motor controller temperature CAN signal stale flag
        MO_SFLAG; % motor torque CAN signal stale flag
        SS_FFLAG; % steering sensor proper sensor function flag
        AV_FFLAG; % angular velocity sensor proper sensor function flag
        GS_FFLAG; % gps proper sensor function flag
        TV_PFLAG; % torque vectoring permit flag
    end

    %% f Methods
    methods
        function f = fVCU_Master()
            f.CS_SFLAG = 0;
            f.TB_SFLAG = 0;
            f.SS_FFLAG = 0;
            f.IV_SFLAG = 0;
            f.BT_SFLAG = 0;
            f.MT_SFLAG = 0;
            f.CT_SFLAG = 0;
            f.MO_SFLAG = 0;
            f.SS_FFLAG = 1;
            f.AV_FFLAG = 1;
            f.GS_FFLAG = 3;
            f.TV_PFLAG = 1;
        end
    end
end