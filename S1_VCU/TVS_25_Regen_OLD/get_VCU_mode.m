%% Function Description
% This function determines the appropriate mode for the VCU according to
% which sensors can be trusted. If no sensor can be trusted, then the
% baseline (BL) mode is selected.
%
% Input      :  p - struct of all constant controller parameters
%               f - struct of all raw flag measurements
%               x - struct of all raw sensor measurements
%               y - struct of CF processed controller data at time t-1
% 
% Return     :  y - struct of CF processed controller data at time t

function y = get_VCU_mode(p,f,x,y)
    % Construct PT checking
    PT_flags = [f.CS_SFLAG, f.TB_SFLAG, f.WT_SFLAG, f.IV_SFLAG, f.BT_SFLAG, f.IAC_SFLAG, f.IAT_SFLAG, f.IBC_SFLAG, f.IBT_SFLAG];
    PT_plagCheck = [p.CS_SFLAG_True, p.TB_SFLAG_True, p.WT_SFLAG_True, p.IV_SFLAG_True, p.BT_SFLAG_True, p.IAC_SFLAG_True, p.IAT_SFLAG_True, p.IBC_SFLAG_True, p.IBT_SFLAG_True];
    PT_sensors = [x.TH_RAW, x.VB_RAW, x.WT_RAW, x.WM_RAW, x.IB_RAW, x.MT_RAW, x.CT_RAW, x.IT_RAW, x.MC_RAW, x.IC_RAW, x.BT_RAW];
    PT_boundsMin = [p.TH_lb, p.VB_lb, p.WT_lb, p.WM_lb, p.IB_lb, p.MT_lb, p.CT_lb, p.IT_lb, p.MC_lb, p.IC_lb, p.BT_lb];
    PT_boundsMax = [p.TH_ub, p.VB_ub, p.WT_ub, p.WM_ub, p.IB_ub, p.MT_ub, p.CT_ub, p.IT_ub, p.MC_ub, p.IC_ub, p.BT_ub];

    PT_SENSE_RAW = (PT_sensors >= PT_boundsMin) & (PT_sensors <= PT_boundsMax);
    PT_FLAGS_RAW = PT_plagCheck == PT_flags;
    PT_permit_RAW = min([PT_SENSE_RAW, PT_FLAGS_RAW]);

    y.PT_permit_buffer = [y.PT_permit_buffer(2:end), PT_permit_RAW];
    PT_permit_CF = round(mean(y.PT_permit_buffer));

    % Construct VS checking
    VS_flags = [f.CS_SFLAG, f.TB_SFLAG, f.WT_SFLAG, f.IV_SFLAG, f.BT_SFLAG, f.IAC_SFLAG, f.IAT_SFLAG, f.IBC_SFLAG, f.IBT_SFLAG, f.GS_FFLAG, f.VCU_PFLAG];
    VS_flagCheck = [p.CS_SFLAG_True, p.TB_SFLAG_True, p.WT_SFLAG_True, p.IV_SFLAG_True, p.BT_SFLAG_True, p.IAC_SFLAG_True, p.IAT_SFLAG_True, p.IBC_SFLAG_True, p.IBT_SFLAG_True, p.GS_FFLAG_True, p.VCU_PFLAG_VS];
    VS_sensors = [x.TH_RAW, x.VB_RAW, x.WT_RAW, x.WM_RAW, x.GS_RAW, x.IB_RAW, x.MT_RAW, x.CT_RAW, x.IT_RAW, x.MC_RAW, x.IC_RAW, x.BT_RAW, x.TO_RAW, x.VS_MAX_SR_RAW];
    VS_boundsMin = [p.TH_lb, p.VB_lb, p.WT_lb, p.WM_lb, p.GS_lb, p.IB_lb, p.MT_lb, p.CT_lb, p.IT_lb, p.MC_lb, p.IC_lb, p.BT_lb, p.TO_lb, p.VS_MAX_SR_lb];
    VS_boundsMax = [p.TH_ub, p.VB_ub, p.WT_ub, p.WM_ub, p.GS_ub, p.IB_ub, p.MT_ub, p.CT_ub, p.IT_ub, p.MC_ub, p.IC_ub, p.BT_ub, p.TO_ub, p.VS_MAX_SR_ub];

    VS_SENSE_RAW = (VS_sensors >= VS_boundsMin) & (VS_sensors <= VS_boundsMax);
    VS_FLAGS_RAW = VS_flagCheck == VS_flags;
    VS_permit_RAW = min([VS_SENSE_RAW, VS_FLAGS_RAW]);

    y.VS_permit_buffer = [y.VS_permit_buffer(2:end), VS_permit_RAW];
    VS_permit_CF = round(mean(y.VS_permit_buffer));

    % Construct VT checking
    VT_flags = [f.CS_SFLAG, f.TB_SFLAG, f.SS_SFLAG, f.WT_SFLAG, f.IV_SFLAG, f.BT_SFLAG, f.IAC_SFLAG, f.IAT_SFLAG, f.IBC_SFLAG, f.IBT_SFLAG, ...
             f.SS_FFLAG, f.AV_FFLAG, f.GS_FFLAG, f.VCU_PFLAG];
    VT_flagCheck = [p.CS_SFLAG_True, p.TB_SFLAG_True, p.SS_SFLAG_True, p.WT_SFLAG_True, p.IV_SFLAG_True, p.BT_SFLAG_True, p.IAC_SFLAG_True, p.IAT_SFLAG_True, p.IBC_SFLAG_True, p.IBT_SFLAG_True, ...
                 p.SS_FFLAG_True, p.AV_FFLAG_True, p.GS_FFLAG_True, p.VCU_PFLAG_VT];
    VT_sensors = [x.TH_RAW, x.ST_RAW, x.VB_RAW, x.WT_RAW, x.WM_RAW, x.GS_RAW, x.AV_RAW, x.IB_RAW, x.MT_RAW, x.CT_RAW, x.IT_RAW, x.MC_RAW, x.IC_RAW, x.BT_RAW, ...
               x.TO_RAW, x.VT_DB_RAW, x.TV_PP_RAW, x.TC_TR_RAW];
    VT_boundsMin = [p.TH_lb, p.ST_lb, p.VB_lb, p.WT_lb, p.WM_lb, p.GS_lb, p.AV_lb, p.IB_lb, p.MT_lb, p.CT_lb, ...
                 p.IT_lb, p.MC_lb, p.IC_lb, p.BT_lb, p.TO_lb, p.VT_DB_lb, p.TV_PP_lb, p.TC_TR_lb];
    VT_boundsMax = [p.TH_ub, p.ST_ub, p.VB_ub, p.WT_ub, p.WM_ub, p.GS_ub, p.AV_ub, p.IB_ub, p.MT_ub, p.CT_ub, ...
                 p.IT_ub, p.MC_ub, p.IC_ub, p.BT_ub, p.TO_ub, p.VT_DB_ub, p.TV_PP_ub, p.TC_TR_ub];

    VT_SENSE_RAW = (VT_sensors >= VT_boundsMin) & (VT_sensors <= VT_boundsMax);
    VT_FLAGS_RAW = VT_flagCheck == VT_flags;
    VT_permit_RAW = min([VT_SENSE_RAW, VT_FLAGS_RAW]);

    y.VT_permit_buffer = [y.VT_permit_buffer(2:end), VT_permit_RAW];
    VT_permit_CF = round(mean(y.VT_permit_buffer));
    
    % contstruct regen checking
    RG_flags = [];
    RG_flagCheck = [];
    RG_sensors = [];
    RG_boundsMin = [];
    RG_boundsMax = [];

    % regen allowed iff:    
    RG_safe = all([ ...
        y.GS_CF < 5*1000/3600, ... % speed < 5 kph
        y.TH_CF < 0, ... % throttle negative
        y.VB_CF < 550, ... % battery voltage below cuttof
        abs(y.T_CF) < 15, ... % steering angle straight
        ]); % TODO: check for stale flags for all used values
    % Compute mode
    if RG_safe
        y.VCU_mode = 5;
    
    elseif (f.VCU_CFLAG == p.VCU_CFLAG_CS)
        if VS_permit_CF
            y.VCU_mode = 3;
        else
            y.VCU_mode = 0;
        end
    else
        if VT_permit_CF
            y.VCU_mode = 4;
        elseif PT_permit_CF
            y.VCU_mode = 2;
        else
            y.VCU_mode = 1;
        end
    end
end