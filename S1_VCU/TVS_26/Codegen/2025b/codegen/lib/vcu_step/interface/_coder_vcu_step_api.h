#ifndef _CODER_VCU_STEP_API_H
#define _CODER_VCU_STEP_API_H

#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"
#include <string.h>

#ifndef typedef_struct0_T
#define typedef_struct0_T
typedef struct {
  real_T r;
  real_T ht[2];
  real_T wb;
  real_T gr;
  real_T MAX_TO_ABS;
  real_T PB_derating_full_T;
  real_T PB_derating_half_T;
  real_T PB_derating_FR;
  real_T INV_T_derating_full_T;
  real_T INV_derating_zero_T;
  real_T IGBT_derating_full_T;
  real_T IGBT_derating_zero_T;
  real_T MT_derating_full_T;
  real_T MT_derating_zero_T;
  real_T BT_derating_full_T;
  real_T BT_derating_zero_T;
  real_T VB_derating_full_T;
  real_T VB_derating_zero_T;
  real_T IB_derating_full_T;
  real_T IB_derating_zero_T;
} struct0_T;
#endif

#ifndef typedef_struct1_T
#define typedef_struct1_T
typedef struct {
  real_T TH_RAW;
  real_T ST_RAW;
  real_T VB_RAW;
  real_T WM_RAW[4];
  real_T GS_RAW;
  real_T AV_RAW[3];
  real_T IB_RAW;
  real_T MT_RAW;
  real_T IGBT_T_RAW;
  real_T INV_T_RAW;
  real_T MC_RAW;
  real_T IC_RAW;
  real_T BT_RAW;
  real_T TO_RAW[4];
} struct1_T;
#endif

#ifndef typedef_struct2_T
#define typedef_struct2_T
typedef struct {
  real_T TH;
  real_T TH_PO;
  real_T TH_RG;
  real_T ST;
  real_T VB;
  real_T WM[4];
  real_T GS;
  real_T AV[3];
  real_T IB;
  real_T MT;
  real_T IGBT_T;
  real_T INV_T;
  real_T MC;
  real_T IC;
  real_T BT;
  real_T TO[4];
  real_T PB;
  real_T TO_BL_PO[4];
  real_T TORQUE_OUT[4];
} struct2_T;
#endif

extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus
extern "C" {
#endif

void vcu_step(struct0_T *p, struct1_T *x, struct2_T *y);

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
