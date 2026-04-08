#ifndef _CODER_VCU_STEP_API_H
#define _CODER_VCU_STEP_API_H

#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"
#include <string.h>

#ifndef typedef_struct0_T
#define typedef_struct0_T
typedef struct {
  real32_T r;
  real32_T ht[2];
  real32_T wb;
  real32_T gr;
  real32_T MAX_TO_ABS_PO;
  real32_T MAX_TO_ABS_RG;
  real32_T PB_derating_full_T;
  real32_T PB_derating_half_T;
  real32_T PB_derating_FR;
  real32_T INV_T_derating_full_T;
  real32_T INV_T_derating_zero_T;
  real32_T IGBT_T_derating_full_T;
  real32_T IGBT_T_derating_zero_T;
  real32_T MT_derating_full_T;
  real32_T MT_derating_zero_T;
  real32_T BT_derating_full_T;
  real32_T BT_derating_zero_T;
  real32_T VB_derating_full_T;
  real32_T VB_derating_zero_T;
  real32_T IB_derating_full_T;
  real32_T IB_derating_zero_T;
  real32_T VB_RG_derating_full_T;
  real32_T VB_RG_derating_zero_T;
  real32_T IB_RG_derating_full_T;
  real32_T IB_RG_derating_zero_T;
  real32_T GS_RG_derating_zero;
  real32_T GS_RG_derating_full;
} struct0_T;
#endif

#ifndef typedef_struct1_T
#define typedef_struct1_T
typedef struct {
  real32_T TH_RAW;
  real32_T ST_RAW;
  real32_T VB_RAW;
  real32_T WM_RAW[4];
  real32_T GS_RAW;
  real32_T AV_RAW[3];
  real32_T IB_RAW;
  real32_T MT_RAW;
  real32_T IGBT_T_RAW;
  real32_T INV_T_RAW;
  real32_T MC_RAW;
  real32_T IC_RAW;
  real32_T BT_RAW;
  real32_T TO_RAW[4];
} struct1_T;
#endif

#ifndef typedef_struct2_T
#define typedef_struct2_T
typedef struct {
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
  real32_T MC;
  real32_T IC;
  real32_T BT;
  real32_T TO[4];
  real32_T PB;
  real32_T TO_BL_PO[4];
  real32_T TO_BL_RG[4];
  real32_T TORQUE_OUT[4];
} struct2_T;
#endif

extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus
extern "C" {
#endif

void VCU_step(struct0_T *p, struct1_T *x, struct2_T *y);

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
