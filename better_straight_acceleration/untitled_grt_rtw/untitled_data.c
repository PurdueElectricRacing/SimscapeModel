/*
 * untitled_data.c
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

#include "untitled.h"
#include "untitled_private.h"

/* Block parameters (default storage) */
P_untitled_T untitled_P = {
  /* Variable: A1
   * Referenced by: '<S1>/Tire Model'
   */
  39.8344,

  /* Variable: A2
   * Referenced by: '<S1>/Tire Model'
   */
  813.078,

  /* Variable: B1
   * Referenced by: '<S1>/Tire Model'
   */
  1.287E-6,

  /* Variable: B2
   * Referenced by: '<S1>/Tire Model'
   */
  -0.002325,

  /* Variable: B3
   * Referenced by: '<S1>/Tire Model'
   */
  3.797,

  /* Variable: C1
   * Referenced by: '<S1>/Tire Model'
   */
  -2.541E-9,

  /* Variable: C2
   * Referenced by: '<S1>/Tire Model'
   */
  5.279E-6,

  /* Variable: C3
   * Referenced by: '<S1>/Tire Model'
   */
  -0.003943,

  /* Variable: C4
   * Referenced by: '<S1>/Tire Model'
   */
  3.634,

  /* Variable: C_param
   * Referenced by: '<S1>/Tire Model'
   */
  { 0.0, 13757.41, 21278.97, 26666.02, 30253.47, 30313.18, 30313.18 },

  /* Variable: FZ_C
   * Referenced by: '<S1>/Tire Model'
   */
  { 0.0, 204.13, 427.04, 668.1, 895.72, 1124.4, 1324.4 },

  /* Variable: I
   * Referenced by: '<S5>/I'
   */
  1.0,

  /* Variable: J_z
   * Referenced by: '<S1>/Constraint Generation'
   */
  75.0,

  /* Variable: Ku
   * Referenced by: '<S1>/Reference Generation'
   */
  0.024464831804281342,

  /* Variable: P
   * Referenced by: '<S5>/P'
   */
  10.0,

  /* Variable: RE
   * Referenced by:
   *   '<S1>/Constraint Generation'
   *   '<S1>/Tire Model'
   */
  0.2228169203,

  /* Variable: S1
   * Referenced by: '<S1>/Steering Model'
   */
  7.0E-5,

  /* Variable: S2
   * Referenced by: '<S1>/Steering Model'
   */
  -0.0038,

  /* Variable: S3
   * Referenced by: '<S1>/Steering Model'
   */
  0.6535,

  /* Variable: S4
   * Referenced by: '<S1>/Steering Model'
   */
  0.1061,

  /* Variable: T
   * Referenced by: '<S5>/T'
   */
  0.15,

  /* Variable: V_target
   * Referenced by: '<S1>/Reference Generation'
   */
  { 0.0, 3.0, 6.0, 9.0, 12.0, 15.0, 18.0, 21.0, 25.0, 31.0 },

  /* Variable: a
   * Referenced by: '<S1>/Tire Model'
   */
  1.14,

  /* Variable: b
   * Referenced by: '<S1>/Tire Model'
   */
  -0.03291,

  /* Variable: c
   * Referenced by: '<S1>/Tire Model'
   */
  -1.14,

  /* Variable: d
   * Referenced by: '<S1>/Tire Model'
   */
  -1.027,

  /* Variable: deg2rad
   * Referenced by: '<S1>/Steering Model'
   */
  0.01745329,

  /* Variable: gr
   * Referenced by: '<S1>/Constraint Generation'
   */
  { 6.63043, 6.63043, 7.95652, 7.95652 },

  /* Variable: inch2mm
   * Referenced by: '<S1>/Steering Model'
   */
  25.4,

  /* Variable: k_limit
   * Referenced by: '<S1>/Tire Model'
   */
  3.461,

  /* Variable: l
   * Referenced by:
   *   '<S1>/Constraint Generation'
   *   '<S1>/Reference Generation'
   *   '<S1>/Tire Model'
   */
  { 0.7922471, 0.7828529 },

  /* Variable: max_yaw_field
   * Referenced by: '<S1>/Reference Generation'
   */
  { 1.34, 1.34, 1.34, 1.66, 1.14, 1.24, 0.754, 0.849, 0.85, 0.85 },

  /* Variable: min_speed_regen
   * Referenced by: '<S1>/Constraint Generation'
   */
  85.0,

  /* Variable: motor_efficiency
   * Referenced by: '<S1>/Constraint Generation'
   */
  { 0.85, 0.85, 0.85, 0.85 },

  /* Variable: motor_limit_power
   * Referenced by: '<S1>/Constraint Generation'
   */
  { 15000.0, 15000.0, 15000.0, 15000.0 },

  /* Variable: motor_limit_torque
   * Referenced by: '<S1>/Constraint Generation'
   */
  { -25.0, 25.0 },

  /* Variable: mu_factor
   * Referenced by: '<S1>/Tire Model'
   */
  0.66666666666666663,

  /* Variable: s
   * Referenced by:
   *   '<S1>/Constraint Generation'
   *   '<S1>/Tire Model'
   */
  { 0.647895, 0.62102 },

  /* Variable: steer_slope
   * Referenced by: '<S1>/Steering Model'
   */
  0.0111,

  /* Variable: t
   * Referenced by: '<S1>/Constraint Generation'
   */
  0.015,

  /* Variable: tau
   * Referenced by: '<S1>/Constraint Generation'
   */
  0.0,

  /* Variable: T2F
   * Referenced by: '<S1>/Constraint Generation'
   */
  { 29.0F, 29.0F, 35.0F, 35.0F },

  /* Expression: 1
   * Referenced by: '<Root>/Constant'
   */
  1.0,

  /* Expression: [200 200 200 200]
   * Referenced by: '<Root>/Constant1'
   */
  { 200.0, 200.0, 200.0, 200.0 },

  /* Expression: 0
   * Referenced by: '<S1>/Unit Delay4'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/Unit Delay'
   */
  0.0,

  /* Computed Parameter: DiscreteTimeIntegrator_gainval
   * Referenced by: '<S5>/Discrete-Time Integrator'
   */
  0.015,

  /* Expression: 0
   * Referenced by: '<S5>/Discrete-Time Integrator'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/Unit Delay1'
   */
  0.0,

  /* Computed Parameter: DiscreteTimeIntegrator2_gainval
   * Referenced by: '<S5>/Discrete-Time Integrator2'
   */
  0.015,

  /* Expression: 0
   * Referenced by: '<S5>/Discrete-Time Integrator2'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/Unit Delay3'
   */
  0.0
};
