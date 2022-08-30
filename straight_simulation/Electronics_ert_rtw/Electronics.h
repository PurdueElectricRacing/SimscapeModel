/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Electronics.h
 *
 * Code generated for Simulink model 'Electronics'.
 *
 * Model version                  : 2.156
 * Simulink Coder version         : 9.7 (R2022a) 13-Nov-2021
 * C/C++ source code generated on : Tue Aug 30 12:14:21 2022
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex-M
 * Code generation objectives:
 *    1. Execution efficiency
 *    2. RAM efficiency
 * Validation result: Not run
 */

#ifndef RTW_HEADER_Electronics_h_
#define RTW_HEADER_Electronics_h_
#ifndef Electronics_COMMON_INCLUDES_
#define Electronics_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "bigM_v2_func.h"
#endif                                 /* Electronics_COMMON_INCLUDES_ */

/* Model Code Variants */

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

/* Forward declaration for rtModel */
typedef struct tag_RTM RT_MODEL;

/* Block signals and states (default storage) for system '<Root>' */
typedef struct {
  real_T UnitDelay2_DSTATE[4];         /* '<S2>/Unit Delay2' */
  real_T UnitDelay2_DSTATE_a[2];       /* '<S3>/Unit Delay2' */
  real_T UnitDelay4_DSTATE;            /* '<S3>/Unit Delay4' */
  real_T UnitDelay_DSTATE;             /* '<S3>/Unit Delay' */
  real_T DiscreteTimeIntegrator_DSTATE;/* '<S8>/Discrete-Time Integrator' */
  real_T UnitDelay1_DSTATE;            /* '<S3>/Unit Delay1' */
  real_T DiscreteTimeIntegrator2_DSTATE;/* '<S8>/Discrete-Time Integrator2' */
  real_T UnitDelay3_DSTATE;            /* '<S3>/Unit Delay3' */
  int8_T DiscreteTimeIntegrator_PrevRese;/* '<S8>/Discrete-Time Integrator' */
  int8_T DiscreteTimeIntegrator2_PrevRes;/* '<S8>/Discrete-Time Integrator2' */
} DW;

/* Constant parameters (default storage) */
typedef struct {
  /* Expression: gr
   * Referenced by: '<S3>/Constraint Generation'
   */
  real_T ConstraintGeneration_gr[4];

  /* Expression: max_rpm
   * Referenced by: '<S3>/Constraint Generation'
   */
  real_T ConstraintGeneration_max_rpm[68];

  /* Expression: max_torque
   * Referenced by: '<S3>/Constraint Generation'
   */
  real_T ConstraintGeneration_max_torque[68];

  /* Expression: power_loss_grid
   * Referenced by: '<S3>/Constraint Generation'
   */
  real_T ConstraintGeneration_power_loss[26857];

  /* Expression: power_loss_limit
   * Referenced by: '<S3>/Constraint Generation'
   */
  real_T ConstraintGeneration_power_lo_g[4];

  /* Expression: rpm_sweep
   * Referenced by: '<S3>/Constraint Generation'
   */
  real_T ConstraintGeneration_rpm_sweep[107];

  /* Expression: torque_sweep
   * Referenced by: '<S3>/Constraint Generation'
   */
  real_T ConstraintGeneration_torque_swe[251];
} ConstP;

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T driver_input;                 /* '<Root>/driver_input' */
  real_T steering_angle[2];            /* '<Root>/steering_angle' */
  real_T brake_pressure[4];            /* '<Root>/brake_pressure' */
  real_T omega[4];                     /* '<Root>/omega' */
  real_T Vg[2];                        /* '<Root>/Vg' */
  real_T yaw;                          /* '<Root>/yaw' */
  real_T FZ[4];                        /* '<Root>/FZ' */
  real_T shock_velocity[4];            /* '<Root>/shock_velocity' */
  real_T shock_displacement[4];        /* '<Root>/shock_displacement' */
  real_T power_limits[2];              /* '<Root>/power_limits' */
  real_T Ag[2];                        /* '<Root>/Ag' */
  real_T rdot;                         /* '<Root>/rdot' */
  real_T motor_temp[4];                /* '<Root>/motor_temp' */
} ExtU;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T Tx[4];                        /* '<Root>/Tx' */
} ExtY;

/* Real-time Model Data Structure */
struct tag_RTM {
  const char_T * volatile errorStatus;
};

/* Block signals and states (default storage) */
extern DW rtDW;

/* External inputs (root inport signals with default storage) */
extern ExtU rtU;

/* External outputs (root outports fed by signals with default storage) */
extern ExtY rtY;

/* Constant parameters (default storage) */
extern const ConstP rtConstP;

/* Model entry point functions */
extern void Electronics_initialize(void);
extern void Electronics_step(void);

/* Real-time Model object */
extern RT_MODEL *const rtM;

/*-
 * These blocks were eliminated from the model due to optimizations:
 *
 * Block '<S8>/P' : Eliminated nontunable gain of 1
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
 * hilite_system('complete_plant/Electronics')    - opens subsystem complete_plant/Electronics
 * hilite_system('complete_plant/Electronics/Kp') - opens and selects block Kp
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'complete_plant'
 * '<S1>'   : 'complete_plant/Electronics'
 * '<S2>'   : 'complete_plant/Electronics/Torque Vectoring FPGA'
 * '<S3>'   : 'complete_plant/Electronics/Torque Vectoring Micro Controller'
 * '<S4>'   : 'complete_plant/Electronics/Torque Vectoring FPGA/Optimization '
 * '<S5>'   : 'complete_plant/Electronics/Torque Vectoring Micro Controller/Brake Model'
 * '<S6>'   : 'complete_plant/Electronics/Torque Vectoring Micro Controller/Constraint Generation'
 * '<S7>'   : 'complete_plant/Electronics/Torque Vectoring Micro Controller/Normal Force Model'
 * '<S8>'   : 'complete_plant/Electronics/Torque Vectoring Micro Controller/PIT Controller'
 * '<S9>'   : 'complete_plant/Electronics/Torque Vectoring Micro Controller/Reference Generation'
 * '<S10>'  : 'complete_plant/Electronics/Torque Vectoring Micro Controller/Steering Model'
 * '<S11>'  : 'complete_plant/Electronics/Torque Vectoring Micro Controller/Tire Model'
 */
#endif                                 /* RTW_HEADER_Electronics_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
