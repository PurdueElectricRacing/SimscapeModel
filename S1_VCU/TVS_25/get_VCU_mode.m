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
    VS_sensors = [x.TH_RAW, x.VB_RAW, x.WT_RAW, x.WM_RAW, x.GS_RAW, x.IB_RAW, x.MT_RAW, x.CT_RAW, x.IT_RAW, x.MC_RAW, x.IC_RAW, x.BT_RAW, x.TO_RAW];
    VS_boundsMin = [p.TH_lb, p.VB_lb, p.WT_lb, p.WM_lb, p.GS_lb, p.IB_lb, p.MT_lb, p.CT_lb, p.IT_lb, p.MC_lb, p.IC_lb, p.BT_lb, p.TO_lb];
    VS_boundsMax = [p.TH_ub, p.VB_ub, p.WT_ub, p.WM_ub, p.GS_ub, p.IB_ub, p.MT_ub, p.CT_ub, p.IT_ub, p.MC_ub, p.IC_ub, p.BT_ub, p.TO_ub];

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
               x.TO_RAW, x.DB_RAW, x.PI_RAW, x.PP_RAW];
    VT_boundsMin = [p.TH_lb, p.ST_lb, p.VB_lb, p.WT_lb, p.WM_lb, p.GS_lb, p.AV_lb, p.IB_lb, p.MT_lb, p.CT_lb, ...
                 p.IT_lb, p.MC_lb, p.IC_lb, p.BT_lb, p.TO_lb, p.DB_lb, p.PI_lb, p.PP_lb];
    VT_boundsMax = [p.TH_ub, p.ST_ub, p.VB_ub, p.WT_ub, p.WM_ub, p.GS_ub, p.AV_ub, p.IB_ub, p.MT_ub, p.CT_ub, ...
                 p.IT_ub, p.MC_ub, p.IC_ub, p.BT_ub, p.TO_ub, p.DB_ub, p.PI_ub, p.PP_ub];

    VT_SENSE_RAW = (VT_sensors >= VT_boundsMin) & (VT_sensors <= VT_boundsMax);
    VT_FLAGS_RAW = VT_flagCheck == VT_flags;
    VT_permit_RAW = min([VT_SENSE_RAW, VT_FLAGS_RAW]);

    y.VT_permit_buffer = [y.VT_permit_buffer(2:end), VT_permit_RAW];
    VT_permit_CF = round(mean(y.VT_permit_buffer));

    % Compute mode
    if (f.VCU_CFLAG == 1)
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