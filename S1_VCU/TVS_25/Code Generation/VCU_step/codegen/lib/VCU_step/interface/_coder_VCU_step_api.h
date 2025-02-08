#ifndef _CODER_VCU_STEP_API_H
#define _CODER_VCU_STEP_API_H

#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"
#include <string.h>

#ifndef typedef_struct1_T
#define typedef_struct1_T
typedef struct {
  real_T CS_SFLAG;
  real_T TB_SFLAG;
  real_T SS_SFLAG;
  real_T WT_SFLAG;
  real_T IV_SFLAG;
  real_T BT_SFLAG;
  real_T MT_SFLAG;
  real_T CO_SFLAG;
  real_T MO_SFLAG;
  real_T SS_FFLAG;
  real_T AV_FFLAG;
  real_T GS_FFLAG;
  real_T VCU_PFLAG;
} struct1_T;
#endif

#ifndef typedef_struct0_T
#define typedef_struct0_T
typedef struct {
  real_T r;
  real_T ht[2];
  real_T gr;
  real_T Ns;
  real_T ET_permit_N;
  real_T PT_permit_N;
  real_T VS_permit_N;
  real_T VT_permit_N;
  real_T CS_SFLAG_True;
  real_T TB_SFLAG_True;
  real_T SS_SFLAG_True;
  real_T WT_SFLAG_True;
  real_T IV_SFLAG_True;
  real_T BT_SFLAG_True;
  real_T MT_SFLAG_True;
  real_T CO_SFLAG_True;
  real_T MO_SFLAG_True;
  real_T SS_FFLAG_True;
  real_T AV_FFLAG_True;
  real_T GS_FFLAG_True;
  real_T VCU_PFLAG_VS;
  real_T VCU_PFLAG_VT;
  real_T TH_lb;
  real_T ST_lb;
  real_T VB_lb;
  real_T WT_lb[2];
  real_T WM_lb[2];
  real_T GS_lb;
  real_T AV_lb[3];
  real_T IB_lb;
  real_T MT_lb;
  real_T CT_lb;
  real_T IT_lb;
  real_T MC_lb;
  real_T IC_lb;
  real_T BT_lb;
  real_T AG_lb[3];
  real_T TO_lb[2];
  real_T DB_lb;
  real_T PI_lb;
  real_T PP_lb;
  real_T TH_ub;
  real_T ST_ub;
  real_T VB_ub;
  real_T WT_ub[2];
  real_T WM_ub[2];
  real_T GS_ub;
  real_T AV_ub[3];
  real_T IB_ub;
  real_T MT_ub;
  real_T CT_ub;
  real_T IT_ub;
  real_T MC_ub;
  real_T IC_ub;
  real_T BT_ub;
  real_T AG_ub[3];
  real_T TO_ub[2];
  real_T DB_ub;
  real_T PI_ub;
  real_T PP_ub;
  real_T CF_IB_filter_N;
  real_T R[9];
  real_T Batt_Voc_brk[506];
  real_T Batt_As_Discharged_tbl[506];
  real_T zero_currents_to_update_SOC;
  real_T Batt_cell_zero_SOC_voltage;
  real_T Batt_cell_zero_SOC_capacity;
  real_T Batt_cell_full_SOC_voltage;
  real_T Batt_cell_full_SOC_capacity;
  real_T MAX_TORQUE_NOM;
  real_T PT_WM_brkpt[150];
  real_T PT_VB_brkpt[50];
  real_T PT_TO_table[7500];
  real_T PT_WM_lb;
  real_T PT_WM_ub;
  real_T PT_VB_lb;
  real_T PT_VB_ub;
  real_T mT_derating_full_T;
  real_T mT_derating_zero_T;
  real_T cT_derating_full_T;
  real_T cT_derating_zero_T;
  real_T bT_derating_full_T;
  real_T bT_derating_zero_T;
  real_T bI_derating_full_T;
  real_T bI_derating_zero_T;
  real_T Vb_derating_full_T;
  real_T Vb_derating_zero_T;
  real_T Ci_derating_full_T;
  real_T Ci_derating_zero_T;
  real_T Cm_derating_full_T;
  real_T Cm_derating_zero_T;
  real_T iT_derating_full_T;
  real_T iT_derating_zero_T;
  real_T dST_DB;
  real_T r_power_sat;
  real_T TV_GS_brkpt[51];
  real_T TV_ST_brkpt[53];
  real_T TV_AV_table[2703];
  real_T TV_ST_lb;
  real_T TV_ST_ub;
  real_T TV_GS_lb;
  real_T TV_GS_ub;
  real_T TC_eps;
  real_T TC_sl_threshold;
  real_T TC_throttle_mult;
  real_T TC_highs_to_engage;
  real_T TC_lows_to_disengage;
} struct0_T;
#endif

#ifndef typedef_struct2_T
#define typedef_struct2_T
typedef struct {
  real_T TH_RAW;
  real_T ST_RAW;
  real_T VB_RAW;
  real_T WT_RAW[2];
  real_T WM_RAW[2];
  real_T GS_RAW;
  real_T AV_RAW[3];
  real_T IB_RAW;
  real_T MT_RAW;
  real_T CT_RAW;
  real_T IT_RAW;
  real_T MC_RAW;
  real_T IC_RAW;
  real_T BT_RAW;
  real_T AG_RAW[3];
  real_T TO_RAW[2];
  real_T DB_RAW;
  real_T PI_RAW;
  real_T PP_RAW;
} struct2_T;
#endif

#ifndef typedef_struct3_T
#define typedef_struct3_T
typedef struct {
  real_T ET_permit_buffer[5];
  real_T PT_permit_buffer[5];
  real_T VS_permit_buffer[5];
  real_T VT_permit_buffer[5];
  real_T VCU_mode;
  real_T IB_CF_buffer[10];
  real_T TH_CF;
  real_T ST_CF;
  real_T VB_CF;
  real_T WT_CF[2];
  real_T WM_CF[2];
  real_T GS_CF;
  real_T AV_CF[3];
  real_T IB_CF;
  real_T MT_CF;
  real_T CT_CF;
  real_T IT_CF;
  real_T MC_CF;
  real_T IC_CF;
  real_T BT_CF;
  real_T AG_CF[3];
  real_T TO_CF[2];
  real_T DB_CF;
  real_T PI_CF;
  real_T PP_CF;
  real_T Batt_SOC;
  real_T zero_current_counter;
  real_T TO_ET[2];
  real_T TO_AB_MX;
  real_T TO_DR_MX;
  real_T TO_PT[2];
  real_T WM_VS[2];
  real_T VT_mode;
  real_T TO_VT[2];
  real_T TV_AV_ref;
  real_T TV_delta_torque;
  real_T TC_highs;
  real_T TC_lows;
  real_T sl;
} struct3_T;
#endif

extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus
extern "C" {
#endif

void VCU_step(struct0_T *p, struct1_T *f, struct2_T *x, struct3_T *y);

void VCU_step_api(const mxArray *const prhs[4], const mxArray **plhs);

void VCU_step_atexit(void);

void VCU_step_initialize(void);

void VCU_step_terminate(void);

void VCU_step_xil_shutdown(void);

void VCU_step_xil_terminate(void);

#ifdef __cplusplus
}
#endif

#endif
