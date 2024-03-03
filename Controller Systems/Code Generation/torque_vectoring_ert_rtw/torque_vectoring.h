/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: torque_vectoring.h
 *
 * Code generated for Simulink model 'torque_vectoring'.
 *
 * Model version                  : 1.15
 * Simulink Coder version         : 23.2 (R2023b) 01-Aug-2023
 * C/C++ source code generated on : Sat Mar  2 20:00:00 2024
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex-M
 * Code generation objectives:
 *    1. Execution efficiency
 *    2. RAM efficiency
 * Validation result: All passed
 */

#ifndef RTW_HEADER_torque_vectoring_h_
#define RTW_HEADER_torque_vectoring_h_
#ifndef torque_vectoring_COMMON_INCLUDES_
#define torque_vectoring_COMMON_INCLUDES_
#include "rtwtypes.h"
#endif                                 /* torque_vectoring_COMMON_INCLUDES_ */

#include "torque_vectoring_types.h"

/* Block signals and states (default storage) for system '<Root>' */
typedef struct {
  dsp_simulink_MovingAverage_to_T obj; /* '<S2>/Moving Average1' */
  dsp_simulink_MovingAverage_h_T obj_m;/* '<S3>/Moving Average1' */
} DW_torque_vectoring_T;

/* Constant parameters (default storage) */
typedef struct {
  /* Pooled Parameter (Expression: lb)
   * Referenced by:
   *   '<S3>/Constant5'
   *   '<S3>/Saturation'
   */
  real_T pooled1[19];

  /* Computed Parameter: uDLookupTable_maxIndex
   * Referenced by: '<S4>/2-D Lookup Table'
   */
  uint32_T uDLookupTable_maxIndex[2];
} ConstP_torque_vectoring_T;

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T R[9];                         /* '<Root>/R' */
  boolean_T F_raw[13];                 /* '<Root>/F_raw' */
  real_T D_raw[19];                    /* '<Root>/D_raw' */
  real_T dphi;                         /* '<Root>/dphi' */
  real_T TVS_P;                        /* '<Root>/TVS_P' */
  real_T TVS_I;                        /* '<Root>/TVS_I' */
} ExtU_torque_vectoring_T;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T rTVS[2];                      /* '<Root>/rTVS' */
  real_T rEQUAL[2];                    /* '<Root>/rEQUAL' */
  real_T w[2];                         /* '<Root>/w' */
  real_T V;                            /* '<Root>/V' */
  real_T TVS_STATE;                    /* '<Root>/TVS_STATE' */
  boolean_T F_TVS[51];                 /* '<Root>/F_TVS' */
  real_T sig_trunc[19];                /* '<Root>/sig_trunc' */
  real_T sig_filt[18];                 /* '<Root>/sig_filt' */
} ExtY_torque_vectoring_T;

/* Parameters (default storage) */
struct P_torque_vectoring_T_ {
  real_T I_FUSE;                       /* Variable: I_FUSE
                                        * Referenced by: '<S4>/I_FUSE'
                                        */
  real_T PLb;                          /* Variable: PLb
                                        * Referenced by: '<S4>/Gain4'
                                        */
  real_T Tmc[2];                       /* Variable: Tmc
                                        * Referenced by: '<S4>/T_mc to Max Power Level'
                                        */
  real_T Tmo[2];                       /* Variable: Tmo
                                        * Referenced by: '<S4>/T_m to Max Power Level'
                                        */
  real_T dIb[2];                       /* Variable: dIb
                                        * Referenced by: '<S4>/Battery to Max Power Level'
                                        */
  real_T half_track[2];                /* Variable: half_track
                                        * Referenced by: '<S4>/P_gain'
                                        */
  real_T k_TL[2];                      /* Variable: k_TL
                                        * Referenced by:
                                        *   '<S4>/Battery to Max Power Level'
                                        *   '<S4>/T_m to Max Power Level'
                                        *   '<S4>/T_mc to Max Power Level'
                                        */
  real_T r_power_sat;                  /* Variable: r_power_sat
                                        * Referenced by: '<S4>/Gain4'
                                        */
  real_T s[53];                        /* Variable: s
                                        * Referenced by: '<S4>/2-D Lookup Table'
                                        */
  real_T ub[19];                       /* Variable: ub
                                        * Referenced by:
                                        *   '<S3>/Constant4'
                                        *   '<S3>/Saturation'
                                        */
  real_T v[51];                        /* Variable: v
                                        * Referenced by: '<S4>/2-D Lookup Table'
                                        */
  real_T yaw_table[2703];              /* Variable: yaw_table
                                        * Referenced by: '<S4>/2-D Lookup Table'
                                        */
};

/* Block parameters (default storage) */
extern P_torque_vectoring_T torque_vectoring_P;

/* Block signals and states (default storage) */
extern DW_torque_vectoring_T torque_vectoring_DW;

/* External inputs (root inport signals with default storage) */
extern ExtU_torque_vectoring_T torque_vectoring_U;

/* External outputs (root outports fed by signals with default storage) */
extern ExtY_torque_vectoring_T torque_vectoring_Y;

/* Constant parameters (default storage) */
extern const ConstP_torque_vectoring_T torque_vectoring_ConstP;

/* Model entry point functions */
extern void torque_vectoring_initialize(void);
extern void torque_vectoring_step(void);
extern void torque_vectoring_terminate(void);

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
 * '<Root>' : 'torque_vectoring'
 * '<S1>'   : 'torque_vectoring/torque_vectoring'
 * '<S2>'   : 'torque_vectoring/torque_vectoring/State Estimation'
 * '<S3>'   : 'torque_vectoring/torque_vectoring/State Machine'
 * '<S4>'   : 'torque_vectoring/torque_vectoring/Torque Vectoring'
 * '<S5>'   : 'torque_vectoring/torque_vectoring/Torque Vectoring/Saturation Dynamic'
 * '<S6>'   : 'torque_vectoring/torque_vectoring/Torque Vectoring/compute_r_TVS'
 */
#endif                                 /* RTW_HEADER_torque_vectoring_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
