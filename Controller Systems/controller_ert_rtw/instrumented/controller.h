/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: controller.h
 *
 * Code generated for Simulink model 'controller'.
 *
 * Model version                  : 1.34
 * Simulink Coder version         : 23.2 (R2023b) 01-Aug-2023
 * C/C++ source code generated on : Sat Nov 18 12:50:43 2023
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex-M
 * Code generation objectives:
 *    1. Execution efficiency
 *    2. RAM efficiency
 * Validation result: Not run
 */

#ifndef RTW_HEADER_controller_h_
#define RTW_HEADER_controller_h_
#ifndef controller_COMMON_INCLUDES_
#define controller_COMMON_INCLUDES_
#include "rtwtypes.h"
#endif                                 /* controller_COMMON_INCLUDES_ */

#include "controller_types.h"
#include "zero_crossing_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

/* Block signals and states (default storage) for system '<Root>' */
typedef struct {
  dsp_simulink_MovingAverage obj;      /* '<S6>/Moving Average3' */
  real_T IdentityMatrix[9];            /* '<S9>/IdentityMatrix' */
  real_T R[9];                         /* '<S9>/Add' */
  real_T ma_x[3];                      /* '<S6>/Moving Average3' */
  real_T UnitDelay_DSTATE[4];          /* '<S4>/Unit Delay' */
} DW;

/* Zero-crossing (trigger) state */
typedef struct {
  ZCSigState Subsystem3_Trig_ZCE;      /* '<S3>/Subsystem3' */
} PrevZCX;

/* Invariant block signals (default storage) */
typedef struct {
  const real_T lb_offset[4];           /* '<S5>/lb_offset' */
} ConstB;

/* Constant parameters (default storage) */
typedef struct {
  /* Computed Parameter: IdentityMatrix_IDMatrixData
   * Referenced by: '<S9>/IdentityMatrix'
   */
  real_T IdentityMatrix_IDMatrixData[9];

  /* Expression: dk_grid
   * Referenced by: '<S4>/dk'
   */
  real_T dk_tableData[2782];

  /* Expression: k_grid_min
   * Referenced by: '<S4>/k_min'
   */
  real_T k_min_tableData[2782];

  /* Pooled Parameter (Expression: [tvs.power_control.ABS_MAX_TRQ_CMD 0])
   * Referenced by:
   *   '<S5>/Temperature to MC Current Limit Map'
   *   '<S5>/Temperature to Motor Current Limit Map'
   */
  real_T pooled6[2];

  /* Expression: [0 tvs.power_control.ABS_MAX_TRQ_CMD]
   * Referenced by: '<S5>/1-D Lookup Table2'
   */
  real_T uDLookupTable2_tableData[2];

  /* Expression: [-flipud(tvs.yaw_control.max_yaw_table_ref(2:end,1:34)); tvs.yaw_control.max_yaw_table_ref(:,1:34)]'
   * Referenced by: '<S5>/2-D Lookup Table'
   */
  real_T uDLookupTable_tableData[1802];

  /* Expression: tvs.yaw_control.max_v_bp(1:34)
   * Referenced by: '<S5>/2-D Lookup Table'
   */
  real_T uDLookupTable_bp01Data[34];

  /* Expression: [-fliplr(tvs.yaw_control.max_s_bp(2:end)) tvs.yaw_control.max_s_bp]
   * Referenced by: '<S5>/2-D Lookup Table'
   */
  real_T uDLookupTable_bp02Data[53];

  /* Expression: suspension.steering.Aeq_left
   * Referenced by: '<S5>/1-D Lookup Table'
   */
  real_T uDLookupTable_tableData_c[261];

  /* Pooled Parameter (Expression: suspension.steering.theta_sweep)
   * Referenced by:
   *   '<S5>/1-D Lookup Table'
   *   '<S5>/1-D Lookup Table1'
   */
  real_T pooled8[261];

  /* Expression: suspension.steering.Aeq_right
   * Referenced by: '<S5>/1-D Lookup Table1'
   */
  real_T uDLookupTable1_tableData[261];

  /* Computed Parameter: uDLookupTable_maxIndex
   * Referenced by: '<S5>/2-D Lookup Table'
   */
  uint32_T uDLookupTable_maxIndex[2];
} ConstP;

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T T;                            /* '<Root>/T' */
  real_T phi;                          /* '<Root>/phi' */
  real_T gyro[3];                      /* '<Root>/ang_vel_s' */
  real_T vel[3];                       /* '<Root>/vel_NED' */
  real_T omega_m[4];                   /* '<Root>/omega_m' */
  real_T i_max[2];                     /* '<Root>/i_max' */
  real_T T_mc_RAW[2];                  /* '<Root>/T_mc_RAW' */
  real_T T_m_RAW[2];                   /* '<Root>/T_m_RAW' */
  real_T S;                            /* '<Root>/S' */
  real_T ID1[10];                      /* '<Root>/ID1' */
  real_T HV_ON;                        /* '<Root>/HV_ON' */
  real_T R2D;                          /* '<Root>/R2D' */
  real_T acc[3];                       /* '<Root>/accel_s' */
  real_T dphi;                         /* '<Root>/dphi' */
  real_T TVV_I;                        /* '<Root>/TVS_I' */
  real_T Vb;                           /* '<Root>/Vb' */
  real_T Ib;                           /* '<Root>/Ib' */
} ExtU;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T k[4];                         /* '<Root>/k' */
  real_T r[4];                         /* '<Root>/r' */
} ExtY;



/* Declare global externs for instrumentation */
extern void profileStart_controller(uint32_T);
extern void profileEnd_controller(uint32_T);
/* Code_Instrumentation_Declarations_Placeholder */

/* Real-time Model Data Structure */
struct tag_RTM {
  const char_T * volatile errorStatus;
  PrevZCX *prevZCSigState;
  DW *dwork;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    struct {
      uint8_T TID[2];
    } TaskCounters;
  } Timing;
};

extern const ConstB rtConstB;          /* constant block i/o */

/* Constant parameters (default storage) */
extern const ConstP rtConstP;

/* Model entry point functions */
extern void controller_initialize(RT_MODEL *const rtM);
extern void controller_step(RT_MODEL *const rtM, ExtU *rtU, ExtY *rtY);

/*-
 * These blocks were eliminated from the model due to optimizations:
 *
 * Block '<S3>/Product1' : Unused code path elimination
 * Block '<S3>/Unit Delay' : Unused code path elimination
 * Block '<S14>/Data Type Duplicate' : Unused code path elimination
 * Block '<S14>/Data Type Propagation' : Unused code path elimination
 */

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
 * hilite_system('controller_testing/controller')    - opens subsystem controller_testing/controller
 * hilite_system('controller_testing/controller/Kp') - opens and selects block Kp
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'controller_testing'
 * '<S1>'   : 'controller_testing/controller'
 * '<S2>'   : 'controller_testing/controller/State Estimation'
 * '<S3>'   : 'controller_testing/controller/State Machine S1'
 * '<S4>'   : 'controller_testing/controller/Throttle Map'
 * '<S5>'   : 'controller_testing/controller/Torque Vectoring'
 * '<S6>'   : 'controller_testing/controller/State Machine S1/Subsystem'
 * '<S7>'   : 'controller_testing/controller/State Machine S1/Subsystem3'
 * '<S8>'   : 'controller_testing/controller/State Machine S1/Subsystem3/Subsystem1'
 * '<S9>'   : 'controller_testing/controller/State Machine S1/Subsystem3/Subsystem2'
 * '<S10>'  : 'controller_testing/controller/State Machine S1/Subsystem3/ux'
 * '<S11>'  : 'controller_testing/controller/State Machine S1/Subsystem3/Subsystem1/Cross Product'
 * '<S12>'  : 'controller_testing/controller/State Machine S1/Subsystem3/Subsystem1/Normalize Vector'
 * '<S13>'  : 'controller_testing/controller/Torque Vectoring/MATLAB Function'
 * '<S14>'  : 'controller_testing/controller/Torque Vectoring/Saturation Dynamic'
 */
#endif                                 /* RTW_HEADER_controller_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
