/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Throttle.c
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

#include "Throttle.h"
#include <math.h>
#include "rtwtypes.h"
#include <stddef.h>
#define NumBitsPerChar                 8U

static uint32_T plook_evencag(real_T u, real_T bp0, real_T bpSpace, real_T
  *fraction);
static real_T intrp2d_la(const uint32_T bpIndex[], const real_T frac[], const
  real_T table[], const uint32_T stride, const uint32_T maxIndex[]);
static real_T rtGetNaN(void);
static real32_T rtGetNaNF(void);

#define NOT_USING_NONFINITE_LITERALS   1

extern real_T rtInf;
extern real_T rtMinusInf;
extern real_T rtNaN;
extern real32_T rtInfF;
extern real32_T rtMinusInfF;
extern real32_T rtNaNF;
static void rt_InitInfAndNaN(size_t realSize);
static boolean_T rtIsInf(real_T value);
static boolean_T rtIsInfF(real32_T value);
static boolean_T rtIsNaN(real_T value);
static boolean_T rtIsNaNF(real32_T value);
typedef struct {
  struct {
    uint32_T wordH;
    uint32_T wordL;
  } words;
} BigEndianIEEEDouble;

typedef struct {
  struct {
    uint32_T wordL;
    uint32_T wordH;
  } words;
} LittleEndianIEEEDouble;

typedef struct {
  union {
    real32_T wordLreal;
    uint32_T wordLuint;
  } wordL;
} IEEESingle;

real_T rtInf;
real_T rtMinusInf;
real_T rtNaN;
real32_T rtInfF;
real32_T rtMinusInfF;
real32_T rtNaNF;
static real_T rtGetInf(void);
static real32_T rtGetInfF(void);
static real_T rtGetMinusInf(void);
static real32_T rtGetMinusInfF(void);

/*
 * Initialize rtNaN needed by the generated code.
 * NaN is initialized as non-signaling. Assumes IEEE.
 */
static real_T rtGetNaN(void)
{
  size_t bitsPerReal = sizeof(real_T) * (NumBitsPerChar);
  real_T nan = 0.0;
  if (bitsPerReal == 32U) {
    nan = rtGetNaNF();
  } else {
    union {
      LittleEndianIEEEDouble bitVal;
      real_T fltVal;
    } tmpVal;

    tmpVal.bitVal.words.wordH = 0xFFF80000U;
    tmpVal.bitVal.words.wordL = 0x00000000U;
    nan = tmpVal.fltVal;
  }

  return nan;
}

/*
 * Initialize rtNaNF needed by the generated code.
 * NaN is initialized as non-signaling. Assumes IEEE.
 */
static real32_T rtGetNaNF(void)
{
  IEEESingle nanF = { { 0.0F } };

  nanF.wordL.wordLuint = 0xFFC00000U;
  return nanF.wordL.wordLreal;
}

/*
 * Initialize the rtInf, rtMinusInf, and rtNaN needed by the
 * generated code. NaN is initialized as non-signaling. Assumes IEEE.
 */
static void rt_InitInfAndNaN(size_t realSize)
{
  (void) (realSize);
  rtNaN = rtGetNaN();
  rtNaNF = rtGetNaNF();
  rtInf = rtGetInf();
  rtInfF = rtGetInfF();
  rtMinusInf = rtGetMinusInf();
  rtMinusInfF = rtGetMinusInfF();
}

/* Test if value is infinite */
static boolean_T rtIsInf(real_T value)
{
  return (boolean_T)((value==rtInf || value==rtMinusInf) ? 1U : 0U);
}

/* Test if single-precision value is infinite */
static boolean_T rtIsInfF(real32_T value)
{
  return (boolean_T)(((value)==rtInfF || (value)==rtMinusInfF) ? 1U : 0U);
}

/* Test if value is not a number */
static boolean_T rtIsNaN(real_T value)
{
  boolean_T result = (boolean_T) 0;
  size_t bitsPerReal = sizeof(real_T) * (NumBitsPerChar);
  if (bitsPerReal == 32U) {
    result = rtIsNaNF((real32_T)value);
  } else {
    union {
      LittleEndianIEEEDouble bitVal;
      real_T fltVal;
    } tmpVal;

    tmpVal.fltVal = value;
    result = (boolean_T)((tmpVal.bitVal.words.wordH & 0x7FF00000) == 0x7FF00000 &&
                         ( (tmpVal.bitVal.words.wordH & 0x000FFFFF) != 0 ||
                          (tmpVal.bitVal.words.wordL != 0) ));
  }

  return result;
}

/* Test if single-precision value is not a number */
static boolean_T rtIsNaNF(real32_T value)
{
  IEEESingle tmp;
  tmp.wordL.wordLreal = value;
  return (boolean_T)( (tmp.wordL.wordLuint & 0x7F800000) == 0x7F800000 &&
                     (tmp.wordL.wordLuint & 0x007FFFFF) != 0 );
}

/*
 * Initialize rtInf needed by the generated code.
 * Inf is initialized as non-signaling. Assumes IEEE.
 */
static real_T rtGetInf(void)
{
  size_t bitsPerReal = sizeof(real_T) * (NumBitsPerChar);
  real_T inf = 0.0;
  if (bitsPerReal == 32U) {
    inf = rtGetInfF();
  } else {
    union {
      LittleEndianIEEEDouble bitVal;
      real_T fltVal;
    } tmpVal;

    tmpVal.bitVal.words.wordH = 0x7FF00000U;
    tmpVal.bitVal.words.wordL = 0x00000000U;
    inf = tmpVal.fltVal;
  }

  return inf;
}

/*
 * Initialize rtInfF needed by the generated code.
 * Inf is initialized as non-signaling. Assumes IEEE.
 */
static real32_T rtGetInfF(void)
{
  IEEESingle infF;
  infF.wordL.wordLuint = 0x7F800000U;
  return infF.wordL.wordLreal;
}

/*
 * Initialize rtMinusInf needed by the generated code.
 * Inf is initialized as non-signaling. Assumes IEEE.
 */
static real_T rtGetMinusInf(void)
{
  size_t bitsPerReal = sizeof(real_T) * (NumBitsPerChar);
  real_T minf = 0.0;
  if (bitsPerReal == 32U) {
    minf = rtGetMinusInfF();
  } else {
    union {
      LittleEndianIEEEDouble bitVal;
      real_T fltVal;
    } tmpVal;

    tmpVal.bitVal.words.wordH = 0xFFF00000U;
    tmpVal.bitVal.words.wordL = 0x00000000U;
    minf = tmpVal.fltVal;
  }

  return minf;
}

/*
 * Initialize rtMinusInfF needed by the generated code.
 * Inf is initialized as non-signaling. Assumes IEEE.
 */
static real32_T rtGetMinusInfF(void)
{
  IEEESingle minfF;
  minfF.wordL.wordLuint = 0xFF800000U;
  return minfF.wordL.wordLreal;
}

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
void Throttle_step(RT_MODEL *const rtM, ExtU *rtU, ExtY *rtY)
{
  DW *rtDW = rtM->dwork;
  real_T fractions[2];
  real_T rtb_UnitDelay[2];
  real_T frac;
  real_T rtb_dk_idx_0;
  real_T rtb_k_min_idx_0;
  real_T rtb_k_min_idx_1;
  real_T rtb_smoothed_command_idx_1;
  uint32_T bpIndices[2];
  uint32_T bpIndices_0[2];

  /* Outputs for Atomic SubSystem: '<Root>/Throttle Map' */
  /* Lookup_n-D: '<S1>/k_min' */
  bpIndices[1U] = plook_evencag(rtU->BatteryVoltage0340V11, 60.0,
    11.200000000000003, &frac);
  rtb_UnitDelay[1U] = frac;
  bpIndices[0U] = plook_evencag(rtU->MotorShaftVelocity01200rads12[0], 0.0,
    10.404006451471698, &frac);
  rtb_UnitDelay[0U] = frac;
  rtb_k_min_idx_0 = intrp2d_la(bpIndices, rtb_UnitDelay,
    rtConstP.k_min_tableData, 107U, rtConstP.pooled3);
  bpIndices[0U] = plook_evencag(rtU->MotorShaftVelocity01200rads12[1], 0.0,
    10.404006451471698, &frac);
  rtb_UnitDelay[0U] = frac;
  rtb_k_min_idx_1 = intrp2d_la(bpIndices, rtb_UnitDelay,
    rtConstP.k_min_tableData, 107U, rtConstP.pooled3);

  /* Lookup_n-D: '<S1>/dk' */
  bpIndices_0[1U] = plook_evencag(rtU->BatteryVoltage0340V11, 60.0,
    11.200000000000003, &frac);
  fractions[1U] = frac;
  bpIndices_0[0U] = plook_evencag(rtU->MotorShaftVelocity01200rads12[0], 0.0,
    10.404006451471698, &frac);
  fractions[0U] = frac;
  rtb_dk_idx_0 = intrp2d_la(bpIndices_0, fractions, rtConstP.dk_tableData, 107U,
    rtConstP.pooled3);
  bpIndices_0[0U] = plook_evencag(rtU->MotorShaftVelocity01200rads12[1], 0.0,
    10.404006451471698, &frac);
  fractions[0U] = frac;

  /* UnitDelay: '<S1>/Unit Delay' */
  rtb_UnitDelay[0] = rtDW->UnitDelay_DSTATE[0];
  rtb_UnitDelay[1] = rtDW->UnitDelay_DSTATE[1];

  /* MATLAB Function: '<S1>/MATLAB Function' incorporates:
   *  Inport: '<Root>/rTVS'
   *  Inport: '<Root>/r_EQUAL'
   *  Lookup_n-D: '<S1>/dk'
   *  Lookup_n-D: '<S1>/k_min'
   *  Product: '<S1>/Product'
   *  Sum: '<S1>/Sum1'
   *  UnitDelay: '<S1>/Unit Delay'
   *  UnitDelay: '<S1>/Unit Delay1'
   *  UnitDelay: '<S1>/Unit Delay2'
   */
  frac = rtDW->UnitDelay2_DSTATE;
  if (rtU->FlagIndicatingControllerEnable0 != 0.0) {
    rtb_k_min_idx_0 += rtb_dk_idx_0 * rtU->TVSPowerRatio11AA12[0];
    rtb_k_min_idx_1 += intrp2d_la(bpIndices_0, fractions, rtConstP.dk_tableData,
      107U, rtConstP.pooled3) * rtU->TVSPowerRatio11AA12[1];
  } else {
    rtb_k_min_idx_0 = rtU->EqualPowerRatio11AA12[0];
    rtb_k_min_idx_1 = rtU->EqualPowerRatio11AA12[1];
  }

  if (rtU->FlagIndicatingControllerEnable0 != rtDW->UnitDelay1_DSTATE) {
    frac = 0.0;
  }

  if (rtb_UnitDelay[0] > rtb_UnitDelay[1]) {
    if (rtb_k_min_idx_0 > rtb_k_min_idx_1) {
      rtb_dk_idx_0 = rtb_k_min_idx_1;
    } else if (rtIsNaN(rtb_k_min_idx_0)) {
      if (!rtIsNaN(rtb_k_min_idx_1)) {
        rtb_dk_idx_0 = rtb_k_min_idx_1;
      } else {
        rtb_dk_idx_0 = (rtNaN);
      }
    } else {
      rtb_dk_idx_0 = rtb_k_min_idx_0;
    }

    rtb_dk_idx_0 -= rtb_UnitDelay[1];
    if (fabs(rtb_dk_idx_0) < 0.05) {
      frac = 1.0;
    }

    if (frac == 0.0) {
      rtb_smoothed_command_idx_1 = 0.1 * rtb_dk_idx_0 + rtb_UnitDelay[1];
      if (rtb_k_min_idx_0 < rtb_k_min_idx_1) {
        rtb_dk_idx_0 = rtb_k_min_idx_1;
      } else if (rtIsNaN(rtb_k_min_idx_0)) {
        if (!rtIsNaN(rtb_k_min_idx_1)) {
          rtb_dk_idx_0 = rtb_k_min_idx_1;
        } else {
          rtb_dk_idx_0 = (rtNaN);
        }
      } else {
        rtb_dk_idx_0 = rtb_k_min_idx_0;
      }
    } else {
      rtb_dk_idx_0 = rtb_k_min_idx_0;
      rtb_smoothed_command_idx_1 = rtb_k_min_idx_1;
    }
  } else {
    if (rtb_k_min_idx_0 > rtb_k_min_idx_1) {
      rtb_dk_idx_0 = rtb_k_min_idx_1;
    } else if (rtIsNaN(rtb_k_min_idx_0)) {
      if (!rtIsNaN(rtb_k_min_idx_1)) {
        rtb_dk_idx_0 = rtb_k_min_idx_1;
      } else {
        rtb_dk_idx_0 = (rtNaN);
      }
    } else {
      rtb_dk_idx_0 = rtb_k_min_idx_0;
    }

    rtb_dk_idx_0 -= rtb_UnitDelay[0];
    if (fabs(rtb_dk_idx_0) < 0.05) {
      frac = 1.0;
    }

    if (frac == 0.0) {
      rtb_dk_idx_0 = 0.1 * rtb_dk_idx_0 + rtb_UnitDelay[0];
      if (rtb_k_min_idx_0 < rtb_k_min_idx_1) {
        rtb_smoothed_command_idx_1 = rtb_k_min_idx_1;
      } else if (rtIsNaN(rtb_k_min_idx_0)) {
        if (!rtIsNaN(rtb_k_min_idx_1)) {
          rtb_smoothed_command_idx_1 = rtb_k_min_idx_1;
        } else {
          rtb_smoothed_command_idx_1 = (rtNaN);
        }
      } else {
        rtb_smoothed_command_idx_1 = rtb_k_min_idx_0;
      }
    } else {
      rtb_dk_idx_0 = rtb_k_min_idx_0;
      rtb_smoothed_command_idx_1 = rtb_k_min_idx_1;
    }
  }

  /* Update for UnitDelay: '<S1>/Unit Delay1' */
  rtDW->UnitDelay1_DSTATE = rtU->FlagIndicatingControllerEnable0;

  /* Update for UnitDelay: '<S1>/Unit Delay2' incorporates:
   *  MATLAB Function: '<S1>/MATLAB Function'
   */
  rtDW->UnitDelay2_DSTATE = frac;

  /* Update for UnitDelay: '<S1>/Unit Delay' */
  rtDW->UnitDelay_DSTATE[0] = rtb_dk_idx_0;

  /* End of Outputs for SubSystem: '<Root>/Throttle Map' */

  /* Outport: '<Root>/k' */
  rtY->k[0] = rtb_dk_idx_0;

  /* Outputs for Atomic SubSystem: '<Root>/Throttle Map' */
  /* Update for UnitDelay: '<S1>/Unit Delay' */
  rtDW->UnitDelay_DSTATE[1] = rtb_smoothed_command_idx_1;

  /* End of Outputs for SubSystem: '<Root>/Throttle Map' */

  /* Outport: '<Root>/k' */
  rtY->k[1] = rtb_smoothed_command_idx_1;

  /* Outputs for Atomic SubSystem: '<Root>/Throttle Map' */
  /* Outport: '<Root>/finish_smooth' incorporates:
   *  MATLAB Function: '<S1>/MATLAB Function'
   */
  rtY->finish_smooth = frac;

  /* End of Outputs for SubSystem: '<Root>/Throttle Map' */
}

/* Model initialize function */
void Throttle_initialize(RT_MODEL *const rtM)
{
  DW *rtDW = rtM->dwork;

  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* SystemInitialize for Atomic SubSystem: '<Root>/Throttle Map' */
  /* InitializeConditions for UnitDelay: '<S1>/Unit Delay2' */
  rtDW->UnitDelay2_DSTATE = 1.0;

  /* End of SystemInitialize for SubSystem: '<Root>/Throttle Map' */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
