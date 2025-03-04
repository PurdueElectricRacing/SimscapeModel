%% Function Description
% This function computes the proportional torque control setpoints, which
% are sent to main. First, the largest allowed torque setpoint due to motor
% characteristics is computed. Next, the maximum torque subject to derating
% considerations is computed. Finally, the maximum from both of these is
% combined to compute the actual propotional torque setpoint.
%
% Input      :  p - struct of all constant controller parameters
%               y - struct of PT processed controller data at time t-1
% 
% Return     :  y - struct of PT processed controller data at time t

%% Required Sensor Values
% TH, WT, WM, VB, IB, MT, CT, IT, MC, IC, BT

function y = get_PT(p,y)
    % compute max torque subject to motor characteristics [Nm]
    WM_PT = snip(max(y.WT_CF.*p.gr), p.PT_WM_lb, p.PT_WM_ub);
    VB_PT = snip(y.VB_CF, p.PT_VB_lb, p.PT_VB_ub);
    motor_max_T = interp2(p.PT_WM_brkpt, p.PT_VB_brkpt, p.PT_TO_table, WM_PT, VB_PT);
    y.TO_AB_MX = snip(motor_max_T, 0, p.MAX_TORQUE_NOM);

    % derate for motor temp, inverter igbt temp, inverter cold plate temp,
    % batt temp, bat current, battery voltage, motor overload, inverter overload [Nm]
    mT_derated = p.MAX_TORQUE_NOM * snip(interp1([p.mT_derating_full_T, p.mT_derating_zero_T], [1,0], y.MT_CF), 0, 1);
    cT_derated = p.MAX_TORQUE_NOM * snip(interp1([p.cT_derating_full_T, p.cT_derating_zero_T], [1,0], y.CT_CF), 0, 1);
    iT_derated = p.MAX_TORQUE_NOM * snip(interp1([p.iT_derating_full_T, p.iT_derating_zero_T], [1,0], y.IT_CF), 0, 1);
    Cm_derated = p.MAX_TORQUE_NOM * snip(interp1([p.Cm_derating_full_T, p.Cm_derating_zero_T], [1,0], y.MC_CF), 0, 1);
    Ci_derated = p.MAX_TORQUE_NOM * snip(interp1([p.Ci_derating_full_T, p.Ci_derating_zero_T], [1,0], y.IC_CF), 0, 1);
    bT_derated = p.MAX_TORQUE_NOM * snip(interp1([p.bT_derating_full_T, p.bT_derating_zero_T], [1,0], y.BT_CF), 0, 1);
    bI_derated = p.MAX_TORQUE_NOM * snip(interp1([p.bI_derating_full_T, p.bI_derating_zero_T], [1,0], y.IB_CF), 0, 1);
    Vb_derated = p.MAX_TORQUE_NOM * snip(interp1([p.Vb_derating_full_T, p.Vb_derating_zero_T], [1,0], y.VB_CF), 0, 1);

    y.TO_DR_MX = min([mT_derated, cT_derated, iT_derated, Cm_derated, Ci_derated, bT_derated, bI_derated, Vb_derated]);
    
    % compute overall maximum torque [Nm]
    y.TO_PT = min(y.TO_AB_MX * y.TH_CF, y.TO_DR_MX) * [1 1];
end