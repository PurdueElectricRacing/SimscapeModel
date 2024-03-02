/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: throttle_map.c
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

#include "throttle_map.h"
#include <math.h>
#include "rtwtypes.h"

static uint32_T plook_evencag(real_T u, real_T bp0, real_T bpSpace, real_T
  *fraction);
static real_T intrp2d_la(const uint32_T bpIndex[], const real_T frac[], const
  real_T table[], const uint32_T stride, const uint32_T maxIndex[]);

/*===========*
 * Constants *
 *===========*/
#define RT_PI                          3.14159265358979323846
#define RT_PIF                         3.1415927F
#define RT_LN_10                       2.30258509299404568402
#define RT_LN_10F                      2.3025851F
#define RT_LOG10E                      0.43429448190325182765
#define RT_LOG10EF                     0.43429449F
#define RT_E                           2.7182818284590452354
#define RT_EF                          2.7182817F

/*
 * UNUSED_PARAMETER(x)
 *   Used to specify that a function parameter (argument) is required but not
 *   accessed by the function body.
 */
#ifndef UNUSED_PARAMETER
#if defined(__LCC__)
#define UNUSED_PARAMETER(x)                                      /* do nothing */
#else

/*
 * This is the semi-ANSI standard way of indicating that an
 * unused function parameter is required.
 */
#define UNUSED_PARAMETER(x)            (void) (x)
#endif
#endif

static uint32_T plook_evencag(real_T u, real_T bp0, real_T bpSpace, real_T
  *fraction)
{
  real_T invSpc;
  uint32_T bpIndex;

  /* Prelookup - Index and Fraction
     Index Search method: 'even'
     Use previous index: 'off'
     Use last breakpoint for index at or above upper limit: 'on'
     Remove protection against out-of-range input in generated code: 'on'
   */
  invSpc = 1.0 / bpSpace;
  bpIndex = (uint32_T)((u - bp0) * invSpc);
  *fraction = (u - ((real_T)(uint32_T)((u - bp0) * invSpc) * bpSpace + bp0)) *
    invSpc;
  return bpIndex;
}

static real_T intrp2d_la(const uint32_T bpIndex[], const real_T frac[], const
  real_T table[], const uint32_T stride, const uint32_T maxIndex[])
{
  real_T y;
  real_T yL_0d0;
  uint32_T offset_1d;

  /* Column-major Interpolation 2-D
     Interpolation method: 'Linear point-slope'
     Use last breakpoint for index at or above upper limit: 'on'
     Overflow mode: 'wrapping'
   */
  offset_1d = bpIndex[1U] * stride + bpIndex[0U];
  if (bpIndex[0U] == maxIndex[0U]) {
    y = table[offset_1d];
  } else {
    yL_0d0 = table[offset_1d];
    y = (table[offset_1d + 1U] - yL_0d0) * frac[0U] + yL_0d0;
  }

  if (bpIndex[1U] == maxIndex[1U]) {
  } else {
    offset_1d += stride;
    if (bpIndex[0U] == maxIndex[0U]) {
      yL_0d0 = table[offset_1d];
    } else {
      yL_0d0 = table[offset_1d];
      yL_0d0 += (table[offset_1d + 1U] - yL_0d0) * frac[0U];
    }

    y += (yL_0d0 - y) * frac[1U];
  }

  return y;
}

/* Model step function */
void throttle_map_step(RT_MODEL_throttle_map_T *const throttle_map_M,
  ExtU_throttle_map_T *throttle_map_U, ExtY_throttle_map_T *throttle_map_Y)
{
  DW_throttle_map_T *throttle_map_DW = throttle_map_M->dwork;
  real_T fractions[2];
  real_T rtb_UnitDelay[2];
  real_T frac;
  real_T low_dif;
  real_T rtb_dk_idx_0;
  real_T rtb_k_min_idx_0;
  real_T rtb_k_min_idx_1;
  uint32_T bpIndices[2];
  uint32_T bpIndices_0[2];
  rtb_dk_idx_0 = throttle_map_P.V[1] - throttle_map_P.V[0];
  bpIndices[1U] = plook_evencag(throttle_map_U->V, throttle_map_P.V[0],
    rtb_dk_idx_0, &frac);
  rtb_UnitDelay[1U] = frac;
  low_dif = throttle_map_P.w[1] - throttle_map_P.w[0];
  bpIndices[0U] = plook_evencag(throttle_map_U->w[0], throttle_map_P.w[0],
    low_dif, &frac);
  rtb_UnitDelay[0U] = frac;
  rtb_k_min_idx_0 = intrp2d_la(bpIndices, rtb_UnitDelay, throttle_map_P.k_min,
    107U, throttle_map_ConstP.pooled1);
  bpIndices[0U] = plook_evencag(throttle_map_U->w[1], throttle_map_P.w[0],
    low_dif, &frac);
  rtb_UnitDelay[0U] = frac;
  rtb_k_min_idx_1 = intrp2d_la(bpIndices, rtb_UnitDelay, throttle_map_P.k_min,
    107U, throttle_map_ConstP.pooled1);
  bpIndices_0[1U] = plook_evencag(throttle_map_U->V, throttle_map_P.V[0],
    rtb_dk_idx_0, &frac);
  fractions[1U] = frac;
  bpIndices_0[0U] = plook_evencag(throttle_map_U->w[0], throttle_map_P.w[0],
    low_dif, &frac);
  fractions[0U] = frac;
  rtb_dk_idx_0 = intrp2d_la(bpIndices_0, fractions, throttle_map_P.dk, 107U,
    throttle_map_ConstP.pooled1);
  bpIndices_0[0U] = plook_evencag(throttle_map_U->w[1], throttle_map_P.w[0],
    low_dif, &frac);
  fractions[0U] = frac;
  frac = throttle_map_DW->UnitDelay2_DSTATE;
  rtb_UnitDelay[0] = throttle_map_DW->UnitDelay_DSTATE[0];
  if (throttle_map_U->TVS_STATE != 0.0) {
    rtb_k_min_idx_0 += rtb_dk_idx_0 * throttle_map_U->rTVS[0];
    rtb_k_min_idx_1 += intrp2d_la(bpIndices_0, fractions, throttle_map_P.dk,
      107U, throttle_map_ConstP.pooled1) * throttle_map_U->rTVS[1];
  } else {
    rtb_k_min_idx_0 = throttle_map_U->rEQUAL[0];
    rtb_k_min_idx_1 = throttle_map_U->rEQUAL[1];
  }

  rtb_UnitDelay[1] = throttle_map_DW->UnitDelay_DSTATE[1];
  if (throttle_map_U->TVS_STATE != throttle_map_DW->UnitDelay1_DSTATE) {
    frac = 0.0;
  }

  if (rtb_UnitDelay[0] > rtb_UnitDelay[1]) {
    if (rtb_k_min_idx_0 > rtb_k_min_idx_1) {
      low_dif = rtb_k_min_idx_1;
    } else {
      low_dif = rtb_k_min_idx_0;
    }

    low_dif -= rtb_UnitDelay[1];
    if (fabs(low_dif) < throttle_map_P.dk_thresh) {
      frac = 1.0;
    }

    if (frac == 0.0) {
      rtb_dk_idx_0 = throttle_map_P.alpha * low_dif + rtb_UnitDelay[1];
      if (rtb_k_min_idx_0 < rtb_k_min_idx_1) {
        low_dif = rtb_k_min_idx_1;
      } else {
        low_dif = rtb_k_min_idx_0;
      }
    } else {
      low_dif = rtb_k_min_idx_0;
      rtb_dk_idx_0 = rtb_k_min_idx_1;
    }
  } else {
    if (rtb_k_min_idx_0 > rtb_k_min_idx_1) {
      low_dif = rtb_k_min_idx_1;
    } else {
      low_dif = rtb_k_min_idx_0;
    }

    low_dif -= rtb_UnitDelay[0];
    if (fabs(low_dif) < throttle_map_P.dk_thresh) {
      frac = 1.0;
    }

    if (frac == 0.0) {
      low_dif = throttle_map_P.alpha * low_dif + rtb_UnitDelay[0];
      if (rtb_k_min_idx_0 < rtb_k_min_idx_1) {
        rtb_dk_idx_0 = rtb_k_min_idx_1;
      } else {
        rtb_dk_idx_0 = rtb_k_min_idx_0;
      }
    } else {
      low_dif = rtb_k_min_idx_0;
      rtb_dk_idx_0 = rtb_k_min_idx_1;
    }
  }

  throttle_map_Y->TVS_PERMIT = ((frac == 0.0) || (throttle_map_U->TVS_STATE !=
    0.0));
  throttle_map_DW->UnitDelay1_DSTATE = throttle_map_U->TVS_STATE;
  throttle_map_DW->UnitDelay2_DSTATE = frac;
  throttle_map_Y->k[0] = low_dif;
  throttle_map_DW->UnitDelay_DSTATE[0] = low_dif;
  throttle_map_Y->k[1] = rtb_dk_idx_0;
  throttle_map_DW->UnitDelay_DSTATE[1] = rtb_dk_idx_0;
}

/* Model initialize function */
void throttle_map_initialize(RT_MODEL_throttle_map_T *const throttle_map_M)
{
  DW_throttle_map_T *throttle_map_DW = throttle_map_M->dwork;
  throttle_map_DW->UnitDelay1_DSTATE = throttle_map_P.LAST_TVS_PERMIT_IC;
  throttle_map_DW->UnitDelay2_DSTATE = throttle_map_P.FINISHED_SMOOTHENING_IC;
  throttle_map_DW->UnitDelay_DSTATE[0] = throttle_map_P.k_IC[0];
  throttle_map_DW->UnitDelay_DSTATE[1] = throttle_map_P.k_IC[1];
}

/* Model terminate function */
void throttle_map_terminate(RT_MODEL_throttle_map_T *const throttle_map_M)
{
  /* (no terminate code required) */
  UNUSED_PARAMETER(throttle_map_M);
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
