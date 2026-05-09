/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_vcu_step_api.h
 *
 * MATLAB Coder version            : 24.1
 * C/C++ source code generated on  : 08-May-2026 21:02:04
 */

#ifndef _CODER_VCU_STEP_API_H
#define _CODER_VCU_STEP_API_H

/* Include Files */
#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"
#include <string.h>

/* Type Definitions */
#ifndef typedef_pVCU_struct
#define typedef_pVCU_struct
typedef struct {
  real32_T r;
  real32_T ht[2];
  real32_T wb;
  real32_T gr;
  real32_T MAX_ABS_WM;
  real32_T IB_AVG_length;
  real32_T MAX_TO_ABS_PO;
  real32_T PB_derating_full_T;
  real32_T PB_derating_half_T;
  real32_T PB_derating_FR;
  real32_T VB_derating_full_T;
  real32_T VB_derating_zero_T;
  real32_T IB_derating_full_T;
  real32_T IB_derating_zero_T;
  real32_T OV_MOT_derating_full_T;
  real32_T OV_MOT_derating_zero_T;
  real32_T OV_INV_derating_full_T;
  real32_T OV_INV_derating_zero_T;
  real32_T MAX_TO_ABS_RG;
  real32_T VB_RG_derating_full_T;
  real32_T VB_RG_derating_zero_T;
  real32_T IB_RG_derating_full_T;
  real32_T IB_RG_derating_zero_T;
  real32_T GS_RG_derating_zero;
  real32_T GS_RG_derating_full;
  real32_T INV_T_derating_full_T;
  real32_T INV_T_derating_zero_T;
  real32_T IGBT_T_derating_full_T;
  real32_T IGBT_T_derating_zero_T;
  real32_T MT_derating_full_T;
  real32_T MT_derating_zero_T;
  real32_T BT_derating_full_T;
  real32_T BT_derating_zero_T;
  real32_T AC_speed_brkpt[3];
  real32_T AC_speed_table[3];
  real32_T AC_brkpt_lb;
  real32_T AC_brkpt_ub;
  real32_T SK_YAW_des;
  real32_T SK_LR_split_des;
  real32_T SK_ST_ZERO_TV;
  real32_T SK_ST_FULL_TV;
  real32_T SK_FR_split_lb;
  real32_T SK_FR_split_ub;
  real32_T SK_LR_gain_lb;
  real32_T SK_LR_gain_ub;
  real32_T AX_TV_yaw_table[1377];
  real32_T AX_TV_yaw_GS_brkpt[51];
  real32_T AX_TV_yaw_ST_brkpt[27];
  real32_T AX_TV_split_table[1377];
  real32_T AX_TV_split_GS_brkpt[51];
  real32_T AX_TV_split_ST_brkpt[27];
  real32_T AX_FR_split_lb;
  real32_T AX_FR_split_ub;
  real32_T AX_LR_split_lb;
  real32_T AX_LR_split_ub;
  real32_T AX_LR_split_max;
  real32_T AX_LR_gain;
  real32_T TS_LR_max_ST;
  real32_T TS_FR_split_lb;
  real32_T TS_FR_split_ub;
  real32_T TS_LR_split_lb;
  real32_T TS_LR_split_ub;
} pVCU_struct;
#endif /* typedef_pVCU_struct */

#ifndef typedef_xVCU_struct
#define typedef_xVCU_struct
typedef struct {
  real32_T VCU_MODE_REQ;
  real32_T REGEN_EN;
  real32_T THROT_RAW;
  real32_T BRAKE_RAW;
  real32_T REGEN_RAW;
  real32_T ST_RAW;
  real32_T VB_RAW;
  real32_T WM_RAW[4];
  real32_T GS_RAW;
  real32_T AV_RAW[3];
  real32_T IB_RAW;
  real32_T MT_RAW;
  real32_T IGBT_T_RAW;
  real32_T INV_T_RAW;
  real32_T OV_MOT[4];
  real32_T OV_INV[4];
  real32_T BT_RAW;
  real32_T TO_RAW[4];
  real32_T RG_FR_split_RAW;
  real32_T SK_FR_split_RAW;
  real32_T SK_LR_gain_RAW;
  real32_T AX_FR_split_RAW;
  real32_T AX_LR_control_force_RAW;
  real32_T TS_FR_split_RAW;
  real32_T TS_LR_split_RAW;
} xVCU_struct;
#endif /* typedef_xVCU_struct */

#ifndef typedef_yVCU_struct
#define typedef_yVCU_struct
typedef struct {
  real32_T VCU_MODE;
  real32_T REGEN_EN;
  real32_T TH;
  real32_T TH_PO;
  real32_T TH_RG;
  real32_T ST;
  real32_T VB;
  real32_T WM[4];
  real32_T GS;
  real32_T AV[3];
  real32_T IB;
  real32_T MT;
  real32_T IGBT_T;
  real32_T INV_T;
  real32_T OV_MOT[4];
  real32_T OV_INV[4];
  real32_T BT;
  real32_T TO[4];
  real32_T IB_AVG_buffer[10];
  real32_T PB;
  real32_T WW[4];
  real32_T IB_AVG;
  real32_T TO_BL_PO[4];
  real32_T RG_FR_split;
  real32_T TO_BL_RG[4];
  real32_T AC_MW[4];
  real32_T SK_TO[4];
  real32_T SK_FR_split;
  real32_T SK_LR_gain;
  real32_T AX_TO[4];
  real32_T AX_FR_split;
  real32_T AX_LR_control_force;
  real32_T TS_TO[4];
  real32_T TS_FR_split;
  real32_T TS_LR_split;
  real32_T TORQUE_LIM_NEG[4];
  real32_T TORQUE_LIM_POS[4];
  real32_T SPEED_OUT[4];
  real32_T TORQUE_OUT[4];
} yVCU_struct;
#endif /* typedef_yVCU_struct */

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus
extern "C" {
#endif

/* Function Declarations */
void vcu_step(pVCU_struct *p, xVCU_struct *x, yVCU_struct *y);

void vcu_step_api(const mxArray *const prhs[3], const mxArray **plhs);

void vcu_step_atexit(void);

void vcu_step_initialize(void);

void vcu_step_terminate(void);

void vcu_step_xil_shutdown(void);

void vcu_step_xil_terminate(void);

#ifdef __cplusplus
}
#endif

#endif
/*
 * File trailer for _coder_vcu_step_api.h
 *
 * [EOF]
 */
