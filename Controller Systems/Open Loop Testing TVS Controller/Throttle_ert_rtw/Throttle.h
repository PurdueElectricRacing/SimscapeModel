/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Throttle.h
 *
 * Code generated for Simulink model 'Throttle'.
 *
 * Model version                  : 1.88
 * Simulink Coder version         : 23.2 (R2023b) 01-Aug-2023
 * C/C++ source code generated on : Sat Mar  2 11:06:35 2024
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex-M
 * Code generation objectives:
 *    1. Execution efficiency
 *    2. RAM efficiency
 * Validation result: Not run
 */

#ifndef RTW_HEADER_Throttle_h_
#define RTW_HEADER_Throttle_h_
#ifndef Throttle_COMMON_INCLUDES_
#define Throttle_COMMON_INCLUDES_
#include "rtwtypes.h"
#endif                                 /* Throttle_COMMON_INCLUDES_ */

#include "Throttle_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

/* Block signals and states (default storage) for system '<Root>' */
typedef struct {
  real_T UnitDelay_DSTATE[2];          /* '<S1>/Unit Delay' */
  real_T UnitDelay1_DSTATE;            /* '<S1>/Unit Delay1' */
  real_T UnitDelay2_DSTATE;            /* '<S1>/Unit Delay2' */
} DW;

/* Constant parameters (default storage) */
typedef struct {
  /* Expression: tvs.tbl.k_min
   * Referenced by: '<S1>/k_min'
   */
  real_T k_min_tableData[2782];

  /* Expression: tvs.tbl.dk
   * Referenced by: '<S1>/dk'
   */
  real_T dk_tableData[2782];

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<S1>/dk'
   *   '<S1>/k_min'
   */
  uint32_T pooled3[2];
} ConstP;

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T TVSPowerRatio11AA12[2];       /* '<Root>/rTVS' */
  real_T BatteryVoltage0340V11;        /* '<Root>/V' */
  real_T MotorShaftVelocity01200rads12[2];/* '<Root>/w' */
  real_T FlagIndicatingControllerEnable0;/* '<Root>/TVS_PERMIT' */
  real_T EqualPowerRatio11AA12[2];     /* '<Root>/r_EQUAL' */
} ExtU;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T k[2];                         /* '<Root>/k' */
  real_T finish_smooth;                /* '<Root>/finish_smooth' */
} ExtY;

/* Real-time Model Data Structure */
struct tag_RTM {
  const char_T * volatile errorStatus;
  DW *dwork;
};

/* Constant parameters (default storage) */
extern const ConstP rtConstP;

/* Model entry point functions */
extern void Throttle_initialize(RT_MODEL *const rtM);
extern void Throttle_step(RT_MODEL *const rtM, ExtU *rtU, ExtY *rtY);

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Note that this particular code originates from a subsystem build,
 * and has its own system numbers different from the parent model.
 * Refer to the system hierarchy for this subsystem below, and use the
 * MATLAB hilite_system command to trace the generated code back
 * to the parent model.  For example,
 *
 * hilite_system('controller_testing_OPEN_LOOP/controller/Throttle Map')    - opens subsystem controller_testing_OPEN_LOOP/controller/Throttle Map
 * hilite_system('controller_testing_OPEN_LOOP/controller/Throttle Map/Kp') - opens and selects block Kp
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'controller_testing_OPEN_LOOP/controller'
 * '<S1>'   : 'controller_testing_OPEN_LOOP/controller/Throttle Map'
 * '<S2>'   : 'controller_testing_OPEN_LOOP/controller/Throttle Map/MATLAB Function'
 */
#endif                                 /* RTW_HEADER_Throttle_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
