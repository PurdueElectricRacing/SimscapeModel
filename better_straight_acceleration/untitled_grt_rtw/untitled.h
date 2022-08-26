/*
 * untitled.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "untitled".
 *
 * Model version              : 1.0
 * Simulink Coder version : 9.6 (R2021b) 14-May-2021
 * C source code generated on : Tue Aug 16 12:47:27 2022
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_untitled_h_
#define RTW_HEADER_untitled_h_
#include <emmintrin.h>
#include <math.h>
#include <float.h>
#include <string.h>
#include <stddef.h>
#ifndef untitled_COMMON_INCLUDES_
#define untitled_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "rt_logging.h"
#endif                                 /* untitled_COMMON_INCLUDES_ */

#include "untitled_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_nonfinite.h"
#include "rt_defines.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetFinalTime
#define rtmGetFinalTime(rtm)           ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWLogInfo
#define rtmGetRTWLogInfo(rtm)          ((rtm)->rtwLogInfo)
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
#define rtmGetT(rtm)                   ((rtm)->Timing.taskTime0)
#endif

#ifndef rtmGetTFinal
#define rtmGetTFinal(rtm)              ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                (&(rtm)->Timing.taskTime0)
#endif

/* Block states (default storage) for system '<Root>' */
typedef struct {
  real_T UnitDelay4_DSTATE;            /* '<S1>/Unit Delay4' */
  real_T UnitDelay_DSTATE;             /* '<S1>/Unit Delay' */
  real_T DiscreteTimeIntegrator_DSTATE;/* '<S5>/Discrete-Time Integrator' */
  real_T UnitDelay1_DSTATE;            /* '<S1>/Unit Delay1' */
  real_T DiscreteTimeIntegrator2_DSTATE;/* '<S5>/Discrete-Time Integrator2' */
  real_T UnitDelay3_DSTATE;            /* '<S1>/Unit Delay3' */
  int8_T DiscreteTimeIntegrator_PrevRese;/* '<S5>/Discrete-Time Integrator' */
  int8_T DiscreteTimeIntegrator2_PrevRes;/* '<S5>/Discrete-Time Integrator2' */
} DW_untitled_T;

/* Parameters (default storage) */
struct P_untitled_T_ {
  real_T A1;                           /* Variable: A1
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T A2;                           /* Variable: A2
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T B1;                           /* Variable: B1
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T B2;                           /* Variable: B2
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T B3;                           /* Variable: B3
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T C1;                           /* Variable: C1
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T C2;                           /* Variable: C2
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T C3;                           /* Variable: C3
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T C4;                           /* Variable: C4
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T C_param[7];                   /* Variable: C_param
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T FZ_C[7];                      /* Variable: FZ_C
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T I;                            /* Variable: I
                                        * Referenced by: '<S5>/I'
                                        */
  real_T J_z;                          /* Variable: J_z
                                        * Referenced by: '<S1>/Constraint Generation'
                                        */
  real_T Ku;                           /* Variable: Ku
                                        * Referenced by: '<S1>/Reference Generation'
                                        */
  real_T P;                            /* Variable: P
                                        * Referenced by: '<S5>/P'
                                        */
  real_T RE;                           /* Variable: RE
                                        * Referenced by:
                                        *   '<S1>/Constraint Generation'
                                        *   '<S1>/Tire Model'
                                        */
  real_T S1;                           /* Variable: S1
                                        * Referenced by: '<S1>/Steering Model'
                                        */
  real_T S2;                           /* Variable: S2
                                        * Referenced by: '<S1>/Steering Model'
                                        */
  real_T S3;                           /* Variable: S3
                                        * Referenced by: '<S1>/Steering Model'
                                        */
  real_T S4;                           /* Variable: S4
                                        * Referenced by: '<S1>/Steering Model'
                                        */
  real_T T;                            /* Variable: T
                                        * Referenced by: '<S5>/T'
                                        */
  real_T V_target[10];                 /* Variable: V_target
                                        * Referenced by: '<S1>/Reference Generation'
                                        */
  real_T a;                            /* Variable: a
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T b;                            /* Variable: b
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T c;                            /* Variable: c
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T d;                            /* Variable: d
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T deg2rad;                      /* Variable: deg2rad
                                        * Referenced by: '<S1>/Steering Model'
                                        */
  real_T gr[4];                        /* Variable: gr
                                        * Referenced by: '<S1>/Constraint Generation'
                                        */
  real_T inch2mm;                      /* Variable: inch2mm
                                        * Referenced by: '<S1>/Steering Model'
                                        */
  real_T k_limit;                      /* Variable: k_limit
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T l[2];                         /* Variable: l
                                        * Referenced by:
                                        *   '<S1>/Constraint Generation'
                                        *   '<S1>/Reference Generation'
                                        *   '<S1>/Tire Model'
                                        */
  real_T max_yaw_field[10];            /* Variable: max_yaw_field
                                        * Referenced by: '<S1>/Reference Generation'
                                        */
  real_T min_speed_regen;              /* Variable: min_speed_regen
                                        * Referenced by: '<S1>/Constraint Generation'
                                        */
  real_T motor_efficiency[4];          /* Variable: motor_efficiency
                                        * Referenced by: '<S1>/Constraint Generation'
                                        */
  real_T motor_limit_power[4];         /* Variable: motor_limit_power
                                        * Referenced by: '<S1>/Constraint Generation'
                                        */
  real_T motor_limit_torque[2];        /* Variable: motor_limit_torque
                                        * Referenced by: '<S1>/Constraint Generation'
                                        */
  real_T mu_factor;                    /* Variable: mu_factor
                                        * Referenced by: '<S1>/Tire Model'
                                        */
  real_T s[2];                         /* Variable: s
                                        * Referenced by:
                                        *   '<S1>/Constraint Generation'
                                        *   '<S1>/Tire Model'
                                        */
  real_T steer_slope;                  /* Variable: steer_slope
                                        * Referenced by: '<S1>/Steering Model'
                                        */
  real_T t;                            /* Variable: t
                                        * Referenced by: '<S1>/Constraint Generation'
                                        */
  real_T tau;                          /* Variable: tau
                                        * Referenced by: '<S1>/Constraint Generation'
                                        */
  real32_T T2F[4];                     /* Variable: T2F
                                        * Referenced by: '<S1>/Constraint Generation'
                                        */
  real_T Constant_Value;               /* Expression: 1
                                        * Referenced by: '<Root>/Constant'
                                        */
  real_T Constant1_Value[4];           /* Expression: [200 200 200 200]
                                        * Referenced by: '<Root>/Constant1'
                                        */
  real_T UnitDelay4_InitialCondition;  /* Expression: 0
                                        * Referenced by: '<S1>/Unit Delay4'
                                        */
  real_T UnitDelay_InitialCondition;   /* Expression: 0
                                        * Referenced by: '<S1>/Unit Delay'
                                        */
  real_T DiscreteTimeIntegrator_gainval;
                           /* Computed Parameter: DiscreteTimeIntegrator_gainval
                            * Referenced by: '<S5>/Discrete-Time Integrator'
                            */
  real_T DiscreteTimeIntegrator_IC;    /* Expression: 0
                                        * Referenced by: '<S5>/Discrete-Time Integrator'
                                        */
  real_T UnitDelay1_InitialCondition;  /* Expression: 0
                                        * Referenced by: '<S1>/Unit Delay1'
                                        */
  real_T DiscreteTimeIntegrator2_gainval;
                          /* Computed Parameter: DiscreteTimeIntegrator2_gainval
                           * Referenced by: '<S5>/Discrete-Time Integrator2'
                           */
  real_T DiscreteTimeIntegrator2_IC;   /* Expression: 0
                                        * Referenced by: '<S5>/Discrete-Time Integrator2'
                                        */
  real_T UnitDelay3_InitialCondition;  /* Expression: 0
                                        * Referenced by: '<S1>/Unit Delay3'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_untitled_T {
  const char_T *errorStatus;
  RTWLogInfo *rtwLogInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block parameters (default storage) */
extern P_untitled_T untitled_P;

/* Block states (default storage) */
extern DW_untitled_T untitled_DW;

/* Model entry point functions */
extern void untitled_initialize(void);
extern void untitled_step(void);
extern void untitled_terminate(void);

/* Real-time Model object */
extern RT_MODEL_untitled_T *const untitled_M;

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
 * '<Root>' : 'untitled'
 * '<S1>'   : 'untitled/Torque Vectoring Micro Controller'
 * '<S2>'   : 'untitled/Torque Vectoring Micro Controller/Brake Model'
 * '<S3>'   : 'untitled/Torque Vectoring Micro Controller/Constraint Generation'
 * '<S4>'   : 'untitled/Torque Vectoring Micro Controller/Normal Force Model'
 * '<S5>'   : 'untitled/Torque Vectoring Micro Controller/PIT Controller'
 * '<S6>'   : 'untitled/Torque Vectoring Micro Controller/Reference Generation'
 * '<S7>'   : 'untitled/Torque Vectoring Micro Controller/Steering Model'
 * '<S8>'   : 'untitled/Torque Vectoring Micro Controller/Tire Model'
 */
#endif                                 /* RTW_HEADER_untitled_h_ */
