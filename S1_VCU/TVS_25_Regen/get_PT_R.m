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

function y = get_PT_R(p,y)
    % compute max torque subject to motor characteristics [Nm]
    % WM_PT = max(snip(max(y.W_CF.*p.gr), p.PT_WM_lb, p.PT_WM_ub), [], "all");
    % VB_PT = snip(y.VB_CF, p.PT_VB_lb, p.PT_VB_ub);
    % motor_max_T = interp2(p.PT_WM_brkpt, p.PT_VB_brkpt, p.PT_TO_table, WM_PT, VB_PT);
    % y.TO_AB_MX = snip(motor_max_T, 0, p.MAX_TORQUE_NOM);

    % ensure all inputs to lookup tables are in range of the lookup tables
    % MT_CF_snipped = snip(y.MT_CF, p.mT_derating_full_T, p.mT_derating_zero_T);
    % CT_CF_snipped = snip(y.CT_CF, p.cT_derating_full_T, p.cT_derating_zero_T);
    IT_CF_snipped = snip(y.IT_CF, p.iT_derating_full_T, p.iT_derating_zero_T);
    % MC_CF_snipped = snip(y.MC_CF, p.Cm_derating_full_T, p.Cm_derating_zero_T);
    % IC_CF_snipped = snip(y.IC_CF, p.Ci_derating_full_T, p.Ci_derating_zero_T);
    BT_CF_snipped = snip(y.BT_CF, p.bT_derating_full_T, p.bT_derating_zero_T);
    % IB_CF_snipped = snip(y.IB_CF, p.bI_derating_full_T, p.bI_derating_zero_T);
    VB_CF_snipped = snip(y.VB_CF, p.Vb_derating_full_T, p.Vb_derating_zero_T);

    % batt temp, bat current, battery voltage, motor overload, inverter overload [Nm]
    % mT_derated = p.MAX_TORQUE_NOM * interp1([p.mT_derating_full_T, p.mT_derating_zero_T], [1,0], MT_CF_snipped);
    % cT_derated = p.MAX_TORQUE_NOM * interp1([p.cT_derating_full_T, p.cT_derating_zero_T], [1,0], CT_CF_snipped);
    iT_derated = p.MAX_TORQUE_NOM * interp1([p.iT_derating_full_T, p.iT_derating_zero_T], [1,0], IT_CF_snipped);
    % Cm_derated = p.MAX_TORQUE_NOM * interp1([p.Cm_derating_full_T, p.Cm_derating_zero_T], [1,0], MC_CF_snipped);
    % Ci_derated = p.MAX_TORQUE_NOM * interp1([p.Ci_derating_full_T, p.Ci_derating_zero_T], [1,0], IC_CF_snipped);
    bT_derated = p.MAX_TORQUE_NOM * interp1([p.bT_derating_full_T, p.bT_derating_zero_T], [1,0], BT_CF_snipped);
    % bI_derated = p.MAX_TORQUE_NOM * interp1([p.bI_derating_full_T, p.bI_derating_zero_T], [1,0], IB_CF_snipped);
    Vb_derated = p.MAX_TORQUE_NOM * interp1([p.Vb_derating_full_T, p.Vb_derating_zero_T], [1,0], VB_CF_snipped);

    y.TO_DR_MX = min([iT_derated, bT_derated, Vb_derated]);
    tau_max_regen = 2; % maximum regen torque
    % compute overall maximum torque [Nm]
    y.TO_PT = abs(tau_max_regen * y.TH_CF)
    % y.TO_PT = min(y.TO_AB_MX * y.TH_CF, p.MAX_TORQUE_NOM) * [1 1];
end
