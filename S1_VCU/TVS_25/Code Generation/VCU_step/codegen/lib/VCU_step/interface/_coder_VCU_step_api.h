#ifndef _CODER_VCU_STEP_API_H
#define _CODER_VCU_STEP_API_H

#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"
#include <string.h>

#ifndef typedef_fVCU_struct
#define typedef_fVCU_struct
typedef struct {
  real32_T CS_SFLAG;
  real32_T TB_SFLAG;
  real32_T SS_SFLAG;
  real32_T WT_SFLAG;
  real32_T IV_SFLAG;
  real32_T BT_SFLAG;
  real32_T MT_SFLAG;
  real32_T CO_SFLAG;
  real32_T MO_SFLAG;
  real32_T SS_FFLAG;
  real32_T AV_FFLAG;
  real32_T GS_FFLAG;
  real32_T VCU_PFLAG;
} fVCU_struct;
#endif

#ifndef typedef_pVCU_struct
#define typedef_pVCU_struct
typedef struct {
  real32_T r;
  real32_T ht[2];
  real32_T gr;
  real32_T Ns;
  real32_T ET_permit_N;
  real32_T PT_permit_N;
  real32_T VS_permit_N;
  real32_T VT_permit_N;
  real32_T CS_SFLAG_True;
  real32_T TB_SFLAG_True;
  real32_T SS_SFLAG_True;
  real32_T WT_SFLAG_True;
  real32_T IV_SFLAG_True;
  real32_T BT_SFLAG_True;
  real32_T MT_SFLAG_True;
  real32_T CO_SFLAG_True;
  real32_T MO_SFLAG_True;
  real32_T SS_FFLAG_True;
  real32_T AV_FFLAG_True;
  real32_T GS_FFLAG_True;
  real32_T VCU_PFLAG_VS;
  real32_T VCU_PFLAG_VT;
  real32_T TH_lb;
  real32_T ST_lb;
  real32_T VB_lb;
  real32_T WT_lb[2];
  real32_T WM_lb[2];
  real32_T GS_lb;
  real32_T AV_lb[3];
  real32_T IB_lb;
  real32_T MT_lb;
  real32_T CT_lb;
  real32_T IT_lb;
  real32_T MC_lb;
  real32_T IC_lb;
  real32_T BT_lb;
  real32_T AG_lb[3];
  real32_T TO_lb[2];
  real32_T DB_lb;
  real32_T PI_lb;
  real32_T PP_lb;
  real32_T TH_ub;
  real32_T ST_ub;
  real32_T VB_ub;
  real32_T WT_ub[2];
  real32_T WM_ub[2];
  real32_T GS_ub;
  real32_T AV_ub[3];
  real32_T IB_ub;
  real32_T MT_ub;
  real32_T CT_ub;
  real32_T IT_ub;
  real32_T MC_ub;
  real32_T IC_ub;
  real32_T BT_ub;
  real32_T AG_ub[3];
  real32_T TO_ub[2];
  real32_T DB_ub;
  real32_T PI_ub;
  real32_T PP_ub;
  real32_T CF_IB_filter_N;
  real32_T R[9];
  real32_T Batt_Voc_brk[506];
  real32_T Batt_As_Discharged_tbl[506];
  real32_T zero_currents_to_update_SOC;
  real32_T Batt_cell_zero_SOC_voltage;
  real32_T Batt_cell_zero_SOC_capacity;
  real32_T Batt_cell_full_SOC_voltage;
  real32_T Batt_cell_full_SOC_capacity;
  real32_T MAX_TORQUE_NOM;
  real32_T PT_WM_brkpt[150];
  real32_T PT_VB_brkpt[50];
  real32_T PT_TO_table[7500];
  real32_T PT_WM_lb;
  real32_T PT_WM_ub;
  real32_T PT_VB_lb;
  real32_T PT_VB_ub;
  real32_T mT_derating_full_T;
  real32_T mT_derating_zero_T;
  real32_T cT_derating_full_T;
  real32_T cT_derating_zero_T;
  real32_T bT_derating_full_T;
  real32_T bT_derating_zero_T;
  real32_T bI_derating_full_T;
  real32_T bI_derating_zero_T;
  real32_T Vb_derating_full_T;
  real32_T Vb_derating_zero_T;
  real32_T Ci_derating_full_T;
  real32_T Ci_derating_zero_T;
  real32_T Cm_derating_full_T;
  real32_T Cm_derating_zero_T;
  real32_T iT_derating_full_T;
  real32_T iT_derating_zero_T;
  real32_T dST_DB;
  real32_T r_power_sat;
  real32_T TV_GS_brkpt[51];
  real32_T TV_ST_brkpt[53];
  real32_T TV_AV_table[2703];
  real32_T TV_ST_lb;
  real32_T TV_ST_ub;
  real32_T TV_GS_lb;
  real32_T TV_GS_ub;
  real32_T TC_eps;
  real32_T TC_sl_threshold;
  real32_T TC_throttle_mult;
  real32_T TC_highs_to_engage;
  real32_T TC_lows_to_disengage;
} pVCU_struct;
#endif

#ifndef typedef_xVCU_struct
#define typedef_xVCU_struct
typedef struct {
  real32_T TH_RAW;
  real32_T ST_RAW;
  real32_T VB_RAW;
  real32_T WT_RAW[2];
  real32_T WM_RAW[2];
  real32_T GS_RAW;
  real32_T AV_RAW[3];
  real32_T IB_RAW;
  real32_T MT_RAW;
  real32_T CT_RAW;
  real32_T IT_RAW;
  real32_T MC_RAW;
  real32_T IC_RAW;
  real32_T BT_RAW;
  real32_T AG_RAW[3];
  real32_T TO_RAW[2];
  real32_T DB_RAW;
  real32_T PI_RAW;
  real32_T PP_RAW;
} xVCU_struct;
#endif

#ifndef typedef_yVCU_struct
#define typedef_yVCU_struct
typedef struct {
  real32_T ET_permit_buffer[5];
  real32_T PT_permit_buffer[5];
  real32_T VS_permit_buffer[5];
  real32_T VT_permit_buffer[5];
  real32_T VCU_mode;
  real32_T IB_CF_buffer[10];
  real32_T TH_CF;
  real32_T ST_CF;
  real32_T VB_CF;
  real32_T WT_CF[2];
  real32_T WM_CF[2];
  real32_T GS_CF;
  real32_T AV_CF[3];
  real32_T IB_CF;
  real32_T MT_CF;
  real32_T CT_CF;
  real32_T IT_CF;
  real32_T MC_CF;
  real32_T IC_CF;
  real32_T BT_CF;
  real32_T AG_CF[3];
  real32_T TO_CF[2];
  real32_T DB_CF;
  real32_T PI_CF;
  real32_T PP_CF;
  real32_T zero_current_counter;
  real32_T Batt_SOC;
  real32_T Batt_Voc;
  real32_T TO_ET[2];
  real32_T TO_AB_MX;
  real32_T TO_DR_MX;
  real32_T TO_PT[2];
  real32_T WM_VS[2];
  real32_T VT_mode;
  real32_T TO_VT[2];
  real32_T TV_AV_ref;
  real32_T TV_delta_torque;
  real32_T TC_highs;
  real32_T TC_lows;
  real32_T sl;
} yVCU_struct;
#endif

extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus
extern "C" {
#endif

void VCU_step_api(const mxArray *const prhs[4], const mxArray **plhs);

void VCU_step_atexit(void);

void VCU_step_initialize(void);

void VCU_step_terminate(void);

void VCU_step_xil_shutdown(void);

void VCU_step_xil_terminate(void);

void vcu_step(pVCU_struct *p, fVCU_struct *f, xVCU_struct *x, yVCU_struct *y);

#ifdef __cplusplus
}
#endif

#endif
