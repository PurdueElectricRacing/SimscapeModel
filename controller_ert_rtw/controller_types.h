/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: controller_types.h
 *
 * Code generated for Simulink model 'controller'.
 *
 * Model version                  : 1.32
 * Simulink Coder version         : 23.2 (R2023b) 01-Aug-2023
 * C/C++ source code generated on : Sat Nov 18 11:46:47 2023
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex-M
 * Code generation objectives:
 *    1. Execution efficiency
 *    2. RAM efficiency
 * Validation result: Not run
 */

#ifndef RTW_HEADER_controller_types_h_
#define RTW_HEADER_controller_types_h_
#include "rtwtypes.h"
#ifndef DEFINED_TYPEDEF_FOR_struct_PBJ0pLktwRVsA3CRzAh4JG_
#define DEFINED_TYPEDEF_FOR_struct_PBJ0pLktwRVsA3CRzAh4JG_

typedef struct {
  real_T max_v_bp[43];
  real_T max_s_bp[27];
  real_T max_yaw_table_ref[918];
  real_T dy;
  real_T torque_sat_const;
  real_T dB;
  real_T ang_acc_hystersesis;
  real_T yaw_filter;
  real_T deadband_angle;
  real_T TVS_Intensity;
  real_T P;
  real_T I;
} struct_PBJ0pLktwRVsA3CRzAh4JG;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_70qMdc9n3PJKUXCCz5qw0D_
#define DEFINED_TYPEDEF_FOR_struct_70qMdc9n3PJKUXCCz5qw0D_

typedef struct {
  real_T dTx;
  real_T min_velocity_regen;
  real_T ABS_MIN_TORQUE[4];
  real_T ABS_MAX_TORQUE[4];
  real_T ABS_MAX_TRQ_CMD;
  real_T ABS_MIN_TRQ_CMD;
  real_T ABS_MAX_I_FLOW;
  real_T motor_controller_t_bp[2];
  real_T motor_controller_I_table[2];
  real_T motor_t_bp[2];
  real_T motor_I_table[2];
} struct_70qMdc9n3PJKUXCCz5qw0D;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_PVx48YGixNBxeoa9Bin6KF_
#define DEFINED_TYPEDEF_FOR_struct_PVx48YGixNBxeoa9Bin6KF_

typedef struct {
  real_T Vth;
  real_T low_V_SA;
} struct_PVx48YGixNBxeoa9Bin6KF;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_QcJxbVRZfO5j0hod9mEtZB_
#define DEFINED_TYPEDEF_FOR_struct_QcJxbVRZfO5j0hod9mEtZB_

typedef struct {
  real_T omega_bp[3];
  real_T k_actual[69];
  real_T k_linear_bp[23];
} struct_QcJxbVRZfO5j0hod9mEtZB;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_KYILtMQMPnewnVi9ev8EBB_
#define DEFINED_TYPEDEF_FOR_struct_KYILtMQMPnewnVi9ev8EBB_

typedef struct {
  struct_PBJ0pLktwRVsA3CRzAh4JG yaw_control;
  struct_70qMdc9n3PJKUXCCz5qw0D power_control;
  struct_PVx48YGixNBxeoa9Bin6KF traction_control;
  struct_QcJxbVRZfO5j0hod9mEtZB torque_control;
} struct_KYILtMQMPnewnVi9ev8EBB;

#endif

#ifndef struct_tag_xm5q3dGCROLmOPhUk992jB
#define struct_tag_xm5q3dGCROLmOPhUk992jB

struct tag_xm5q3dGCROLmOPhUk992jB
{
  int32_T isInitialized;
  boolean_T isSetupComplete;
  boolean_T TunablePropsChanged;
  real_T ForgettingFactor;
  real_T pwN;
  real_T pmN;
  real_T plambda;
};

#endif                                 /* struct_tag_xm5q3dGCROLmOPhUk992jB */

#ifndef typedef_h_dsp_internal_ExponentialMovin
#define typedef_h_dsp_internal_ExponentialMovin

typedef struct tag_xm5q3dGCROLmOPhUk992jB h_dsp_internal_ExponentialMovin;

#endif                             /* typedef_h_dsp_internal_ExponentialMovin */

#ifndef struct_tag_BlgwLpgj2bjudmbmVKWwDE
#define struct_tag_BlgwLpgj2bjudmbmVKWwDE

struct tag_BlgwLpgj2bjudmbmVKWwDE
{
  uint32_T f1[8];
};

#endif                                 /* struct_tag_BlgwLpgj2bjudmbmVKWwDE */

#ifndef typedef_cell_wrap
#define typedef_cell_wrap

typedef struct tag_BlgwLpgj2bjudmbmVKWwDE cell_wrap;

#endif                                 /* typedef_cell_wrap */

#ifndef struct_tag_RION7Slzecs2S2sy9qoHvG
#define struct_tag_RION7Slzecs2S2sy9qoHvG

struct tag_RION7Slzecs2S2sy9qoHvG
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  boolean_T TunablePropsChanged;
  cell_wrap inputVarSize;
  h_dsp_internal_ExponentialMovin *pStatistic;
  int32_T NumChannels;
  int32_T FrameLength;
  h_dsp_internal_ExponentialMovin _pobj0;
};

#endif                                 /* struct_tag_RION7Slzecs2S2sy9qoHvG */

#ifndef typedef_dsp_simulink_MovingAverage
#define typedef_dsp_simulink_MovingAverage

typedef struct tag_RION7Slzecs2S2sy9qoHvG dsp_simulink_MovingAverage;

#endif                                 /* typedef_dsp_simulink_MovingAverage */

/* Forward declaration for rtModel */
typedef struct tag_RTM RT_MODEL;

#endif                                 /* RTW_HEADER_controller_types_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
