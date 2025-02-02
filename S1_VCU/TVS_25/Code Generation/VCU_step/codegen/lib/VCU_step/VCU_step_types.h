/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: VCU_step_types.h
 *
 * MATLAB Coder version            : 23.2
 * C/C++ source code generated on  : 01-Feb-2025 21:19:15
 */

#ifndef VCU_STEP_TYPES_H
#define VCU_STEP_TYPES_H

/* Include Files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_struct1_T
#define typedef_struct1_T
typedef struct {
  double CS_SFLAG;
  double TB_SFLAG;
  double SS_SFLAG;
  double WT_SFLAG;
  double IV_SFLAG;
  double BT_SFLAG;
  double MT_SFLAG;
  double CT_SFLAG;
  double MO_SFLAG;
  double SS_FFLAG;
  double AV_FFLAG;
  double GS_FFLAG;
  double VS_PFLAG;
  double VT_PFLAG;
} struct1_T;
#endif /* typedef_struct1_T */

#ifndef typedef_struct0_T
#define typedef_struct0_T
typedef struct {
  double r;
  double ht[2];
  double gr;
  double Ns;
  double CS_SFLAG_True;
  double TB_SFLAG_True;
  double SS_SFLAG_True;
  double WT_SFLAG_True;
  double IV_SFLAG_True;
  double BT_SFLAG_True;
  double MT_SFLAG_True;
  double CT_SFLAG_True;
  double MO_SFLAG_True;
  double SS_FFLAG_True;
  double AV_FFLAG_True;
  double GS_FFLAG_True;
  double VS_PFLAG_True;
  double VT_PFLAG_True;
  double TH_lb;
  double ST_lb;
  double VB_lb;
  double WT_lb[2];
  double WM_lb[2];
  double GS_lb;
  double AV_lb[3];
  double IB_lb;
  double MT_lb;
  double CT_lb;
  double IT_lb;
  double MC_lb;
  double IC_lb;
  double BT_lb;
  double AG_lb[3];
  double TO_lb[2];
  double DB_lb;
  double PI_lb;
  double PP_lb;
  double TH_ub;
  double ST_ub;
  double VB_ub;
  double WT_ub[2];
  double WM_ub[2];
  double GS_ub;
  double AV_ub[3];
  double IB_ub;
  double MT_ub;
  double CT_ub;
  double IT_ub;
  double MC_ub;
  double IC_ub;
  double BT_ub;
  double AG_ub[3];
  double TO_ub[2];
  double DB_ub;
  double PI_ub;
  double PP_ub;
  double CF_IB_filter;
  double R[9];
  double Batt_Voc_brk[506];
  double Batt_As_Discharged_tbl[506];
  double zero_currents_to_update_SOC;
  double Batt_cell_zero_SOC_voltage;
  double Batt_cell_zero_SOC_capacity;
  double Batt_cell_full_SOC_voltage;
  double Batt_cell_full_SOC_capacity;
  double MAX_TORQUE_NOM;
  double PT_WM_brkpt[150];
  double PT_VB_brkpt[50];
  double PT_TO_table[7500];
  double PT_WM_lb;
  double PT_WM_ub;
  double PT_VB_lb;
  double PT_VB_ub;
  double mT_derating_full_T;
  double mT_derating_zero_T;
  double cT_derating_full_T;
  double cT_derating_zero_T;
  double bT_derating_full_T;
  double bT_derating_zero_T;
  double bI_derating_full_T;
  double bI_derating_zero_T;
  double Vb_derating_full_T;
  double Vb_derating_zero_T;
  double Ci_derating_full_T;
  double Ci_derating_zero_T;
  double Cm_derating_full_T;
  double Cm_derating_zero_T;
  double iT_derating_full_T;
  double iT_derating_zero_T;
  double dST_DB;
  double r_power_sat;
  double TV_GS_brkpt[51];
  double TV_ST_brkpt[53];
  double TV_AV_table[2703];
  double TV_ST_lb;
  double TV_ST_ub;
  double TV_GS_lb;
  double TV_GS_ub;
  double TC_eps;
  double TC_sl_threshold;
  double TC_throttle_mult;
  double TC_highs_to_engage;
  double TC_lows_to_disengage;
} struct0_T;
#endif /* typedef_struct0_T */

#ifndef typedef_struct2_T
#define typedef_struct2_T
typedef struct {
  double TH_RAW;
  double ST_RAW;
  double VB_RAW;
  double WT_RAW[2];
  double WM_RAW[2];
  double GS_RAW;
  double AV_RAW[3];
  double IB_RAW;
  double MT_RAW;
  double CT_RAW;
  double IT_RAW;
  double MC_RAW;
  double IC_RAW;
  double BT_RAW;
  double AG_RAW[3];
  double TO_RAW[2];
  double DB_RAW;
  double PI_RAW;
  double PP_RAW;
} struct2_T;
#endif /* typedef_struct2_T */

#ifndef typedef_struct3_T
#define typedef_struct3_T
typedef struct {
  double VCU_mode;
  double IB_CF_vec[10];
  double TH_CF;
  double ST_CF;
  double VB_CF;
  double WT_CF[2];
  double WM_CF[2];
  double GS_CF;
  double AV_CF[3];
  double IB_CF;
  double MT_CF;
  double CT_CF;
  double IT_CF;
  double MC_CF;
  double IC_CF;
  double BT_CF;
  double AG_CF[3];
  double TO_CF[2];
  double DB_CF;
  double PI_CF;
  double PP_CF;
  double Batt_SOC;
  double zero_current_counter;
  double TO_ET[2];
  double TO_AB_MX;
  double TO_DR_MX;
  double TO_PT[2];
  double WM_VS[2];
  double VT_mode;
  double TO_VT[2];
  double TC_highs;
  double TC_lows;
  double sl;
} struct3_T;
#endif /* typedef_struct3_T */

#endif
/*
 * File trailer for VCU_step_types.h
 *
 * [EOF]
 */
