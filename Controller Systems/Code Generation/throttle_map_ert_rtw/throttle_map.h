/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: throttle_map.h
 *
 * Code generated for Simulink model 'throttle_map'.
 *
 * Model version                  : 1.11
 * Simulink Coder version         : 23.2 (R2023b) 01-Aug-2023
 * C/C++ source code generated on : Sat Mar  2 16:15:58 2024
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex-M
 * Code generation objectives:
 *    1. Execution efficiency
 *    2. RAM efficiency
 * Validation result: Not run
 */

#ifndef RTW_HEADER_throttle_map_h_
#define RTW_HEADER_throttle_map_h_
#ifndef throttle_map_COMMON_INCLUDES_
#define throttle_map_COMMON_INCLUDES_
#include "rtwtypes.h"
#endif                                 /* throttle_map_COMMON_INCLUDES_ */

#include "throttle_map_types.h"

/* Block signals and states (default storage) for system '<Root>' */
typedef struct {
  real_T UnitDelay_DSTATE[2];          /* '<S1>/Unit Delay' */
  real_T UnitDelay1_DSTATE;            /* '<S1>/Unit Delay1' */
  real_T UnitDelay2_DSTATE;            /* '<S1>/Unit Delay2' */
} DW_throttle_map_T;

/* Constant parameters (default storage) */
typedef struct {
  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<S1>/dk'
   *   '<S1>/k_min'
   */
  uint32_T pooled1[2];
} ConstP_throttle_map_T;

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T rTVS[2];                      /* '<Root>/rTVS' */
  real_T rEQUAL[2];                    /* '<Root>/rEQUAL' */
  real_T V;                            /* '<Root>/V' */
  real_T w[2];                         /* '<Root>/w' */
  real_T TVS_STATE;                    /* '<Root>/TVS_STATE' */
} ExtU_throttle_map_T;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T k[2];                         /* '<Root>/k' */
  real_T TVS_PERMIT;                   /* '<Root>/TVS_PERMIT' */
} ExtY_throttle_map_T;

/* Parameters (default storage) */
struct P_throttle_map_T_ {
  real_T FINISHED_SMOOTHENING_IC;      /* Variable: FINISHED_SMOOTHENING_IC
                                        * Referenced by: '<S1>/Unit Delay2'
                                        */
  real_T LAST_TVS_PERMIT_IC;           /* Variable: LAST_TVS_PERMIT_IC
                                        * Referenced by: '<S1>/Unit Delay1'
                                        */
  real_T V[26];                        /* Variable: V
                                        * Referenced by:
                                        *   '<S1>/dk'
                                        *   '<S1>/k_min'
                                        */
  real_T alpha;                        /* Variable: alpha
                                        * Referenced by: '<S1>/MATLAB Function'
                                        */
  real_T dk[2782];                     /* Variable: dk
                                        * Referenced by: '<S1>/dk'
                                        */
  real_T dk_thresh;                    /* Variable: dk_thresh
                                        * Referenced by: '<S1>/MATLAB Function'
                                        */
  real_T k_IC[2];                      /* Variable: k_IC
                                        * Referenced by: '<S1>/Unit Delay'
                                        */
  real_T k_min[2782];                  /* Variable: k_min
                                        * Referenced by: '<S1>/k_min'
                                        */
  real_T w[107];                       /* Variable: w
                                        * Referenced by:
                                        *   '<S1>/dk'
                                        *   '<S1>/k_min'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_throttle_map_T {
  DW_throttle_map_T *dwork;
};

/* Block parameters (default storage) */
extern P_throttle_map_T throttle_map_P;

/* Constant parameters (default storage) */
extern const ConstP_throttle_map_T throttle_map_ConstP;

/* Model entry point functions */
extern void throttle_map_initialize(RT_MODEL_throttle_map_T *const
  throttle_map_M);
extern void throttle_map_step(RT_MODEL_throttle_map_T *const throttle_map_M,
  ExtU_throttle_map_T *throttle_map_U, ExtY_throttle_map_T *throttle_map_Y);
extern void throttle_map_terminate(RT_MODEL_throttle_map_T *const throttle_map_M);

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'throttle_map'
 * '<S1>'   : 'throttle_map/throttle_map'
 * '<S2>'   : 'throttle_map/throttle_map/MATLAB Function'
 */
#endif                                 /* RTW_HEADER_throttle_map_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
