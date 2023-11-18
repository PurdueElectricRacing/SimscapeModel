/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: controller.c
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

#include "controller.h"
#include <math.h>
#include "rtwtypes.h"
#include <string.h>
#include "zero_crossing_types.h"
#include <stddef.h>
#include "solver_zc.h"
#define NumBitsPerChar                 8U
#ifndef slZcHadEvent
#define slZcHadEvent(ev, zcsDir)       (((ev) & (zcsDir)) != 0x00 )
#endif

#ifndef slZcUnAliasEvents
#define slZcUnAliasEvents(evL, evR)    ((((slZcHadEvent((evL), (SL_ZCS_EVENT_N2Z)) && slZcHadEvent((evR), (SL_ZCS_EVENT_Z2P))) || (slZcHadEvent((evL), (SL_ZCS_EVENT_P2Z)) && slZcHadEvent((evR), (SL_ZCS_EVENT_Z2N)))) ? (SL_ZCS_EVENT_NUL) : (evR)))
#endif

static real_T look2_binlc(real_T u0, real_T u1, const real_T bp0[], const real_T
  bp1[], const real_T table[], const uint32_T maxIndex[], uint32_T stride);
static real_T look1_binlc(real_T u0, const real_T bp0[], const real_T table[],
  uint32_T maxIndex);
static uint32_T plook_evenca(real_T u, real_T bp0, real_T bpSpace, uint32_T
  maxIndex, real_T *fraction);
static real_T intrp1d_la(uint32_T bpIndex, real_T frac, const real_T table[],
  uint32_T maxIndex);
static uint32_T plook_evenc(real_T u, real_T bp0, real_T bpSpace, uint32_T
  maxIndex, real_T *fraction);
static real_T intrp1d_l(uint32_T bpIndex, real_T frac, const real_T table[]);
static real_T intrp2d_l(const uint32_T bpIndex[], const real_T frac[], const
  real_T table[], const uint32_T stride);

/* Forward declaration for local functions */
static void SystemCore_setup(dsp_simulink_MovingAverage *obj);
static void rate_scheduler(RT_MODEL *const rtM);
static real_T rtGetNaN(void);
static real32_T rtGetNaNF(void);
static ZCEventType rt_ZCFcn(ZCDirection zcDir, ZCSigState *prevZc, real_T
  currValue);

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

/* Detect zero crossings events. */
static ZCEventType rt_ZCFcn(ZCDirection zcDir, ZCSigState *prevZc, real_T
  currValue)
{
  slZcEventType zcsDir;
  slZcEventType tempEv;
  ZCEventType zcEvent = NO_ZCEVENT;    /* assume */

  /* zcEvent matrix */
  static const slZcEventType eventMatrix[4][4] = {
    /*          ZER              POS              NEG              UNK */
    { SL_ZCS_EVENT_NUL, SL_ZCS_EVENT_Z2P, SL_ZCS_EVENT_Z2N, SL_ZCS_EVENT_NUL },/* ZER */

    { SL_ZCS_EVENT_P2Z, SL_ZCS_EVENT_NUL, SL_ZCS_EVENT_P2N, SL_ZCS_EVENT_NUL },/* POS */

    { SL_ZCS_EVENT_N2Z, SL_ZCS_EVENT_N2P, SL_ZCS_EVENT_NUL, SL_ZCS_EVENT_NUL },/* NEG */

    { SL_ZCS_EVENT_NUL, SL_ZCS_EVENT_NUL, SL_ZCS_EVENT_NUL, SL_ZCS_EVENT_NUL }/* UNK */
  };

  /* get prevZcEvent and prevZcSign from prevZc */
  const slZcEventType prevEv = (slZcEventType)(((uint8_T)(*prevZc)) >> 2);
  const slZcSignalSignType prevSign = (slZcSignalSignType)(((uint8_T)(*prevZc))
    & (uint8_T)0x03);

  /* get current zcSignal sign from current zcSignal value */
  const slZcSignalSignType currSign = (slZcSignalSignType)((currValue) > 0.0 ?
    SL_ZCS_SIGN_POS :
    ((currValue) < 0.0 ? SL_ZCS_SIGN_NEG : SL_ZCS_SIGN_ZERO));

  /* get current zcEvent based on prev and current zcSignal value */
  slZcEventType currEv = eventMatrix[prevSign][currSign];

  /* get slZcEventType from ZCDirection */
  switch (zcDir) {
   case ANY_ZERO_CROSSING:
    zcsDir = SL_ZCS_EVENT_ALL;
    break;

   case FALLING_ZERO_CROSSING:
    zcsDir = SL_ZCS_EVENT_ALL_DN;
    break;

   case RISING_ZERO_CROSSING:
    zcsDir = SL_ZCS_EVENT_ALL_UP;
    break;

   default:
    zcsDir = SL_ZCS_EVENT_NUL;
    break;
  }

  /* had event, check if zc happened */
  if (slZcHadEvent(currEv, zcsDir)) {
    currEv = (slZcEventType)(slZcUnAliasEvents(prevEv, currEv));
  } else {
    currEv = SL_ZCS_EVENT_NUL;
  }

  /* Update prevZc */
  tempEv = (slZcEventType)(currEv << 2);/* shift left by 2 bits */
  *prevZc = (ZCSigState)((currSign) | (tempEv));
  if ((currEv & SL_ZCS_EVENT_ALL_DN) != 0) {
    zcEvent = FALLING_ZCEVENT;
  } else if ((currEv & SL_ZCS_EVENT_ALL_UP) != 0) {
    zcEvent = RISING_ZCEVENT;
  } else {
    zcEvent = NO_ZCEVENT;
  }

  return zcEvent;
}                                      /* rt_ZCFcn */

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

static real_T look2_binlc(real_T u0, real_T u1, const real_T bp0[], const real_T
  bp1[], const real_T table[], const uint32_T maxIndex[], uint32_T stride)
{
  real_T fractions[2];
  real_T frac;
  real_T yL_0d0;
  real_T yL_0d1;
  uint32_T bpIndices[2];
  uint32_T bpIdx;
  uint32_T iLeft;
  uint32_T iRght;

  /* Column-major Lookup 2-D
     Search method: 'binary'
     Use previous index: 'off'
     Interpolation method: 'Linear point-slope'
     Extrapolation method: 'Clip'
     Use last breakpoint for index at or above upper limit: 'off'
     Remove protection against out-of-range input in generated code: 'off'
   */
  /* Prelookup - Index and Fraction
     Index Search method: 'binary'
     Extrapolation method: 'Clip'
     Use previous index: 'off'
     Use last breakpoint for index at or above upper limit: 'off'
     Remove protection against out-of-range input in generated code: 'off'
   */
  if (u0 <= bp0[0U]) {
    iLeft = 0U;
    frac = 0.0;
  } else if (u0 < bp0[maxIndex[0U]]) {
    /* Binary Search */
    bpIdx = maxIndex[0U] >> 1U;
    iLeft = 0U;
    iRght = maxIndex[0U];
    while (iRght - iLeft > 1U) {
      if (u0 < bp0[bpIdx]) {
        iRght = bpIdx;
      } else {
        iLeft = bpIdx;
      }

      bpIdx = (iRght + iLeft) >> 1U;
    }

    frac = (u0 - bp0[iLeft]) / (bp0[iLeft + 1U] - bp0[iLeft]);
  } else {
    iLeft = maxIndex[0U] - 1U;
    frac = 1.0;
  }

  fractions[0U] = frac;
  bpIndices[0U] = iLeft;

  /* Prelookup - Index and Fraction
     Index Search method: 'binary'
     Extrapolation method: 'Clip'
     Use previous index: 'off'
     Use last breakpoint for index at or above upper limit: 'off'
     Remove protection against out-of-range input in generated code: 'off'
   */
  if (u1 <= bp1[0U]) {
    iLeft = 0U;
    frac = 0.0;
  } else if (u1 < bp1[maxIndex[1U]]) {
    /* Binary Search */
    bpIdx = maxIndex[1U] >> 1U;
    iLeft = 0U;
    iRght = maxIndex[1U];
    while (iRght - iLeft > 1U) {
      if (u1 < bp1[bpIdx]) {
        iRght = bpIdx;
      } else {
        iLeft = bpIdx;
      }

      bpIdx = (iRght + iLeft) >> 1U;
    }

    frac = (u1 - bp1[iLeft]) / (bp1[iLeft + 1U] - bp1[iLeft]);
  } else {
    iLeft = maxIndex[1U] - 1U;
    frac = 1.0;
  }

  /* Column-major Interpolation 2-D
     Interpolation method: 'Linear point-slope'
     Use last breakpoint for index at or above upper limit: 'off'
     Overflow mode: 'wrapping'
   */
  bpIdx = iLeft * stride + bpIndices[0U];
  yL_0d0 = table[bpIdx];
  yL_0d0 += (table[bpIdx + 1U] - yL_0d0) * fractions[0U];
  bpIdx += stride;
  yL_0d1 = table[bpIdx];
  return (((table[bpIdx + 1U] - yL_0d1) * fractions[0U] + yL_0d1) - yL_0d0) *
    frac + yL_0d0;
}

static real_T look1_binlc(real_T u0, const real_T bp0[], const real_T table[],
  uint32_T maxIndex)
{
  real_T frac;
  real_T yL_0d0;
  uint32_T iLeft;

  /* Column-major Lookup 1-D
     Search method: 'binary'
     Use previous index: 'off'
     Interpolation method: 'Linear point-slope'
     Extrapolation method: 'Clip'
     Use last breakpoint for index at or above upper limit: 'off'
     Remove protection against out-of-range input in generated code: 'off'
   */
  /* Prelookup - Index and Fraction
     Index Search method: 'binary'
     Extrapolation method: 'Clip'
     Use previous index: 'off'
     Use last breakpoint for index at or above upper limit: 'off'
     Remove protection against out-of-range input in generated code: 'off'
   */
  if (u0 <= bp0[0U]) {
    iLeft = 0U;
    frac = 0.0;
  } else if (u0 < bp0[maxIndex]) {
    uint32_T bpIdx;
    uint32_T iRght;

    /* Binary Search */
    bpIdx = maxIndex >> 1U;
    iLeft = 0U;
    iRght = maxIndex;
    while (iRght - iLeft > 1U) {
      if (u0 < bp0[bpIdx]) {
        iRght = bpIdx;
      } else {
        iLeft = bpIdx;
      }

      bpIdx = (iRght + iLeft) >> 1U;
    }

    frac = (u0 - bp0[iLeft]) / (bp0[iLeft + 1U] - bp0[iLeft]);
  } else {
    iLeft = maxIndex - 1U;
    frac = 1.0;
  }

  /* Column-major Interpolation 1-D
     Interpolation method: 'Linear point-slope'
     Use last breakpoint for index at or above upper limit: 'off'
     Overflow mode: 'wrapping'
   */
  yL_0d0 = table[iLeft];
  return (table[iLeft + 1U] - yL_0d0) * frac + yL_0d0;
}

static uint32_T plook_evenca(real_T u, real_T bp0, real_T bpSpace, uint32_T
  maxIndex, real_T *fraction)
{
  uint32_T bpIndex;

  /* Prelookup - Index and Fraction
     Index Search method: 'even'
     Extrapolation method: 'Clip'
     Use previous index: 'off'
     Use last breakpoint for index at or above upper limit: 'on'
     Remove protection against out-of-range input in generated code: 'off'
   */
  if (u <= bp0) {
    bpIndex = 0U;
    *fraction = 0.0;
  } else {
    real_T fbpIndex;
    real_T invSpc;
    invSpc = 1.0 / bpSpace;
    fbpIndex = (u - bp0) * invSpc;
    if (fbpIndex < maxIndex) {
      bpIndex = (uint32_T)fbpIndex;
      *fraction = (u - ((real_T)(uint32_T)fbpIndex * bpSpace + bp0)) * invSpc;
    } else {
      bpIndex = maxIndex;
      *fraction = 0.0;
    }
  }

  return bpIndex;
}

static real_T intrp1d_la(uint32_T bpIndex, real_T frac, const real_T table[],
  uint32_T maxIndex)
{
  real_T y;

  /* Column-major Interpolation 1-D
     Interpolation method: 'Linear point-slope'
     Use last breakpoint for index at or above upper limit: 'on'
     Overflow mode: 'wrapping'
   */
  if (bpIndex == maxIndex) {
    y = table[bpIndex];
  } else {
    real_T yL_0d0;
    yL_0d0 = table[bpIndex];
    y = (table[bpIndex + 1U] - yL_0d0) * frac + yL_0d0;
  }

  return y;
}

static uint32_T plook_evenc(real_T u, real_T bp0, real_T bpSpace, uint32_T
  maxIndex, real_T *fraction)
{
  uint32_T bpIndex;

  /* Prelookup - Index and Fraction
     Index Search method: 'even'
     Extrapolation method: 'Clip'
     Use previous index: 'off'
     Use last breakpoint for index at or above upper limit: 'off'
     Remove protection against out-of-range input in generated code: 'off'
   */
  if (u <= bp0) {
    bpIndex = 0U;
    *fraction = 0.0;
  } else {
    real_T fbpIndex;
    real_T invSpc;
    invSpc = 1.0 / bpSpace;
    fbpIndex = (u - bp0) * invSpc;
    if (fbpIndex < maxIndex) {
      bpIndex = (uint32_T)fbpIndex;
      *fraction = (u - ((real_T)(uint32_T)fbpIndex * bpSpace + bp0)) * invSpc;
    } else {
      bpIndex = maxIndex - 1U;
      *fraction = 1.0;
    }
  }

  return bpIndex;
}

static real_T intrp1d_l(uint32_T bpIndex, real_T frac, const real_T table[])
{
  real_T yL_0d0;

  /* Column-major Interpolation 1-D
     Interpolation method: 'Linear point-slope'
     Use last breakpoint for index at or above upper limit: 'off'
     Overflow mode: 'wrapping'
   */
  yL_0d0 = table[bpIndex];
  return (table[bpIndex + 1U] - yL_0d0) * frac + yL_0d0;
}

static real_T intrp2d_l(const uint32_T bpIndex[], const real_T frac[], const
  real_T table[], const uint32_T stride)
{
  real_T yL_0d0;
  real_T yL_0d1;
  uint32_T offset_1d;

  /* Column-major Interpolation 2-D
     Interpolation method: 'Linear point-slope'
     Use last breakpoint for index at or above upper limit: 'off'
     Overflow mode: 'wrapping'
   */
  offset_1d = bpIndex[1U] * stride + bpIndex[0U];
  yL_0d0 = table[offset_1d];
  yL_0d0 += (table[offset_1d + 1U] - yL_0d0) * frac[0U];
  offset_1d += stride;
  yL_0d1 = table[offset_1d];
  return (((table[offset_1d + 1U] - yL_0d1) * frac[0U] + yL_0d1) - yL_0d0) *
    frac[1U] + yL_0d0;
}

/*
 *         This function updates active task flag for each subrate.
 *         The function is called at model base rate, hence the
 *         generated code self-manages all its subrates.
 */
static void rate_scheduler(RT_MODEL *const rtM)
{
  /* Compute which subrates run during the next base time step.  Subrates
   * are an integer multiple of the base rate counter.  Therefore, the subtask
   * counter is reset when it reaches its limit (zero means run).
   */
  (rtM->Timing.TaskCounters.TID[1])++;
  if ((rtM->Timing.TaskCounters.TID[1]) > 1) {/* Sample time: [0.02s, 0.0s] */
    rtM->Timing.TaskCounters.TID[1] = 0;
  }
}

static void SystemCore_setup(dsp_simulink_MovingAverage *obj)
{
  boolean_T flag;
  obj->isSetupComplete = false;
  obj->isInitialized = 1;

  /* Start for MATLABSystem: '<S6>/Moving Average3' */
  obj->NumChannels = 1;
  obj->FrameLength = 3;
  obj->_pobj0.isInitialized = 0;
  obj->_pobj0.isInitialized = 0;
  flag = (obj->_pobj0.isInitialized == 1);
  if (flag) {
    /* Start for MATLABSystem: '<S6>/Moving Average3' */
    obj->_pobj0.TunablePropsChanged = true;
  }

  /* Start for MATLABSystem: '<S6>/Moving Average3' */
  obj->_pobj0.ForgettingFactor = 1.0;
  obj->pStatistic = &obj->_pobj0;
  obj->isSetupComplete = true;
  obj->TunablePropsChanged = false;
}

/* Model step function */
void controller_step(RT_MODEL *const rtM, ExtU *rtU, ExtY *rtY)
{
  DW *rtDW = rtM->dwork;
  PrevZCX *rtPrevZCX = rtM->prevZCSigState;
  h_dsp_internal_ExponentialMovin *obj;
  real_T rtb_Product_a[9];
  real_T tmp[9];
  real_T rtb_Product_e[3];
  real_T fractions[2];
  real_T fractions_0[2];
  real_T rtb_AllMomentArmsFLFRRLRRabou_0;
  real_T rtb_AllMomentArmsFLFRRLRRabou_1;
  real_T rtb_AllMomentArmsFLFRRLRRabou_2;
  real_T rtb_Bias;
  real_T rtb_ElementProduct_idx_0;
  real_T rtb_ElementProduct_idx_4;
  real_T rtb_FRMomentArm;
  real_T rtb_MathFunction_idx_1;
  real_T rtb_MaxIndividualMotorTorqueN_0;
  real_T rtb_MaxIndividualMotorTorqueNm_;
  real_T rtb_Sin;
  real_T rtb_Tx_guess_idx_3;
  int32_T rtb_exitflag;
  uint32_T bpIndices[2];
  uint32_T bpIndices_0[2];
  uint32_T bpIdx;
  boolean_T rtb_Equal;
  ZCEventType zcEvent;
  if (rtM->Timing.TaskCounters.TID[1] == 0) {
    /* Outputs for Atomic SubSystem: '<Root>/controller' */
    /* Outputs for Enabled SubSystem: '<S3>/Subsystem' incorporates:
     *  EnablePort: '<S6>/Enable'
     */
    /* Logic: '<S3>/AND' incorporates:
     *  Logic: '<S3>/NOT'
     */
    if ((!(rtU->FlagIndicatingReadytoDrive01 != 0.0)) &&
        (rtU->FlagIndicatingHVON01 != 0.0)) {
      /* MATLABSystem: '<S6>/Moving Average3' incorporates:
       *  Inport: '<Root>/accel_s'
       */
      if (rtDW->obj.TunablePropsChanged) {
        rtDW->obj.TunablePropsChanged = false;
      }

      obj = rtDW->obj.pStatistic;
      if (rtDW->obj.pStatistic->isInitialized != 1) {
        rtDW->obj.pStatistic->isSetupComplete = false;
        rtDW->obj.pStatistic->isInitialized = 1;
        obj->pwN = 1.0;
        obj->pmN = 0.0;
        obj->plambda = obj->ForgettingFactor;
        obj->isSetupComplete = true;
        obj->TunablePropsChanged = false;
        obj->pwN = 1.0;
        obj->pmN = 0.0;
      }

      if (obj->TunablePropsChanged) {
        obj->TunablePropsChanged = false;
        obj->plambda = obj->ForgettingFactor;
      }

      rtb_ElementProduct_idx_4 = obj->pwN;
      rtb_Bias = obj->pmN;
      rtb_Tx_guess_idx_3 = obj->plambda;
      rtb_Bias = (1.0 - 1.0 / rtb_ElementProduct_idx_4) * rtb_Bias + 1.0 /
        rtb_ElementProduct_idx_4 * rtU->acc[0];
      rtb_ElementProduct_idx_4 = rtb_Tx_guess_idx_3 * rtb_ElementProduct_idx_4 +
        1.0;

      /* MATLABSystem: '<S6>/Moving Average3' */
      rtDW->ma_x[0] = rtb_Bias;

      /* MATLABSystem: '<S6>/Moving Average3' incorporates:
       *  Inport: '<Root>/accel_s'
       */
      rtb_Bias = (1.0 - 1.0 / rtb_ElementProduct_idx_4) * rtb_Bias + 1.0 /
        rtb_ElementProduct_idx_4 * rtU->acc[1];
      rtb_ElementProduct_idx_4 = rtb_Tx_guess_idx_3 * rtb_ElementProduct_idx_4 +
        1.0;

      /* MATLABSystem: '<S6>/Moving Average3' */
      rtDW->ma_x[1] = rtb_Bias;

      /* MATLABSystem: '<S6>/Moving Average3' incorporates:
       *  Inport: '<Root>/accel_s'
       */
      rtb_Bias = (1.0 - 1.0 / rtb_ElementProduct_idx_4) * rtb_Bias + 1.0 /
        rtb_ElementProduct_idx_4 * rtU->acc[2];
      rtb_ElementProduct_idx_4 = rtb_Tx_guess_idx_3 * rtb_ElementProduct_idx_4 +
        1.0;

      /* MATLABSystem: '<S6>/Moving Average3' */
      rtDW->ma_x[2] = rtb_Bias;

      /* MATLABSystem: '<S6>/Moving Average3' */
      obj->pwN = rtb_ElementProduct_idx_4;
      obj->pmN = rtb_Bias;
    }

    /* End of Logic: '<S3>/AND' */
    /* End of Outputs for SubSystem: '<S3>/Subsystem' */

    /* Outputs for Triggered SubSystem: '<S3>/Subsystem3' incorporates:
     *  TriggerPort: '<S7>/Trigger'
     */
    zcEvent = rt_ZCFcn(RISING_ZERO_CROSSING,&rtPrevZCX->Subsystem3_Trig_ZCE,
                       (rtU->FlagIndicatingReadytoDrive01));
    if (zcEvent != NO_ZCEVENT) {
      /* DotProduct: '<S8>/Dot Product' incorporates:
       *  MATLABSystem: '<S6>/Moving Average3'
       */
      rtb_Tx_guess_idx_3 = (rtDW->ma_x[0] * rtDW->ma_x[0] + rtDW->ma_x[1] *
                            rtDW->ma_x[1]) + rtDW->ma_x[2] * rtDW->ma_x[2];

      /* Sqrt: '<S8>/Sqrt' */
      rtb_ElementProduct_idx_4 = sqrt(rtb_Tx_guess_idx_3);

      /* SignalConversion generated from: '<S8>/Dot Product1' */
      rtb_Product_e[2] = rtb_ElementProduct_idx_4;

      /* Bias: '<S8>/Bias' */
      rtb_Bias = rtb_Tx_guess_idx_3 + 0.0001;

      /* Product: '<S11>/Element Product' */
      rtb_ElementProduct_idx_0 = rtDW->ma_x[1] * rtb_ElementProduct_idx_4;
      rtb_ElementProduct_idx_4 *= rtDW->ma_x[0];

      /* Sum: '<S11>/Sum' incorporates:
       *  Constant: '<S8>/Zero1'
       *  Product: '<S11>/Element Product'
       */
      rtb_AllMomentArmsFLFRRLRRabou_2 = rtb_ElementProduct_idx_0 - rtDW->ma_x[2]
        * 0.0;
      rtb_Product_e[0] = rtb_AllMomentArmsFLFRRLRRabou_2;

      /* Math: '<S12>/Math Function' incorporates:
       *  Sum: '<S11>/Sum'
       */
      rtb_ElementProduct_idx_0 = rtb_AllMomentArmsFLFRRLRRabou_2 *
        rtb_AllMomentArmsFLFRRLRRabou_2;

      /* Sum: '<S11>/Sum' incorporates:
       *  Constant: '<S8>/Zero1'
       *  Product: '<S11>/Element Product'
       */
      rtb_AllMomentArmsFLFRRLRRabou_2 = rtDW->ma_x[2] * 0.0 -
        rtb_ElementProduct_idx_4;
      rtb_Product_e[1] = rtb_AllMomentArmsFLFRRLRRabou_2;

      /* Math: '<S12>/Math Function' incorporates:
       *  Sum: '<S11>/Sum'
       */
      rtb_MathFunction_idx_1 = rtb_AllMomentArmsFLFRRLRRabou_2 *
        rtb_AllMomentArmsFLFRRLRRabou_2;

      /* Sum: '<S11>/Sum' incorporates:
       *  Constant: '<S8>/Zero1'
       *  Product: '<S11>/Element Product'
       */
      rtb_AllMomentArmsFLFRRLRRabou_2 = rtDW->ma_x[0] * 0.0 - rtDW->ma_x[1] *
        0.0;

      /* Product: '<S8>/Divide' incorporates:
       *  DotProduct: '<S8>/Dot Product1'
       *  MATLABSystem: '<S6>/Moving Average3'
       */
      rtb_ElementProduct_idx_4 = ((0.0 * rtDW->ma_x[0] + 0.0 * rtDW->ma_x[1]) +
        rtb_Product_e[2] * rtDW->ma_x[2]) / rtb_Bias;

      /* Trigonometry: '<S8>/Acos' */
      if (rtb_ElementProduct_idx_4 > 1.0) {
        rtb_ElementProduct_idx_4 = 1.0;
      } else if (rtb_ElementProduct_idx_4 < -1.0) {
        rtb_ElementProduct_idx_4 = -1.0;
      }

      rtb_Tx_guess_idx_3 = acos(rtb_ElementProduct_idx_4);

      /* End of Trigonometry: '<S8>/Acos' */

      /* Trigonometry: '<S9>/Cos' incorporates:
       *  Trigonometry: '<S9>/Cos1'
       */
      rtb_MaxIndividualMotorTorqueN_0 = cos(rtb_Tx_guess_idx_3);
      rtb_Bias = rtb_MaxIndividualMotorTorqueN_0;

      /* Trigonometry: '<S9>/Sin' */
      rtb_Sin = sin(rtb_Tx_guess_idx_3);

      /* Sum: '<S12>/Sum of Elements' incorporates:
       *  Math: '<S12>/Math Function'
       *  Sum: '<S11>/Sum'
       */
      rtb_ElementProduct_idx_4 = -0.0;
      rtb_ElementProduct_idx_4 += rtb_ElementProduct_idx_0;
      rtb_ElementProduct_idx_4 += rtb_MathFunction_idx_1;
      rtb_ElementProduct_idx_4 += rtb_AllMomentArmsFLFRRLRRabou_2 *
        rtb_AllMomentArmsFLFRRLRRabou_2;

      /* Math: '<S12>/Math Function1'
       *
       * About '<S12>/Math Function1':
       *  Operator: sqrt
       */
      if (rtb_ElementProduct_idx_4 < 0.0) {
        rtb_ElementProduct_idx_4 = -sqrt(fabs(rtb_ElementProduct_idx_4));
      } else {
        rtb_ElementProduct_idx_4 = sqrt(rtb_ElementProduct_idx_4);
      }

      /* End of Math: '<S12>/Math Function1' */

      /* Switch: '<S12>/Switch' incorporates:
       *  Constant: '<S12>/Constant'
       *  Product: '<S12>/Product'
       *  Sum: '<S11>/Sum'
       *  UnitDelay: '<S4>/Unit Delay'
       */
      if (rtb_ElementProduct_idx_4 > 0.0) {
        rtb_AllMomentArmsFLFRRLRRabou_0 = rtb_Product_e[0];
        rtb_AllMomentArmsFLFRRLRRabou_1 = rtb_Product_e[1];
      } else {
        rtb_AllMomentArmsFLFRRLRRabou_0 = rtb_Product_e[0] * 0.0;
        rtb_AllMomentArmsFLFRRLRRabou_1 = rtb_Product_e[1] * 0.0;
        rtb_AllMomentArmsFLFRRLRRabou_2 *= 0.0;
        rtb_ElementProduct_idx_4 = 1.0;
      }

      /* End of Switch: '<S12>/Switch' */

      /* Product: '<S12>/Divide' */
      rtb_Product_e[0] = rtb_AllMomentArmsFLFRRLRRabou_0 /
        rtb_ElementProduct_idx_4;
      rtb_Product_e[1] = rtb_AllMomentArmsFLFRRLRRabou_1 /
        rtb_ElementProduct_idx_4;
      rtb_Product_e[2] = rtb_AllMomentArmsFLFRRLRRabou_2 /
        rtb_ElementProduct_idx_4;

      /* Trigonometry: '<S9>/Cos1' */
      rtb_ElementProduct_idx_4 = rtb_MaxIndividualMotorTorqueN_0;

      /* Sum: '<S9>/Subtract' incorporates:
       *  Constant: '<S9>/One1'
       */
      rtb_ElementProduct_idx_4 = 1.0 - rtb_ElementProduct_idx_4;

      /* MATLAB Function: '<S7>/ux' incorporates:
       *  Product: '<S12>/Divide'
       *  Product: '<S9>/Product1'
       */
      tmp[0] = 0.0 * rtb_Sin;
      tmp[3] = -rtb_Product_e[2] * rtb_Sin;
      tmp[6] = rtb_Product_e[1] * rtb_Sin;
      tmp[1] = rtb_Product_e[2] * rtb_Sin;
      tmp[4] = 0.0 * rtb_Sin;
      tmp[7] = -rtb_Product_e[0] * rtb_Sin;
      tmp[2] = -rtb_Product_e[1] * rtb_Sin;
      tmp[5] = rtb_Product_e[0] * rtb_Sin;
      tmp[8] = 0.0 * rtb_Sin;

      /* Product: '<S9>/Product3' incorporates:
       *  Math: '<S9>/Transpose'
       *  Product: '<S12>/Divide'
       */
      for (rtb_exitflag = 0; rtb_exitflag < 3; rtb_exitflag++) {
        rtb_Product_a[3 * rtb_exitflag] = rtb_Product_e[0] *
          rtb_Product_e[rtb_exitflag];
        rtb_Product_a[3 * rtb_exitflag + 1] = rtb_Product_e[1] *
          rtb_Product_e[rtb_exitflag];
        rtb_Product_a[3 * rtb_exitflag + 2] = rtb_Product_e[2] *
          rtb_Product_e[rtb_exitflag];
      }

      /* End of Product: '<S9>/Product3' */
      for (rtb_exitflag = 0; rtb_exitflag < 9; rtb_exitflag++) {
        /* Sum: '<S9>/Add' incorporates:
         *  IdentityMatrix: '<S9>/IdentityMatrix'
         *  Product: '<S9>/Product'
         *  Product: '<S9>/Product2'
         */
        rtDW->R[rtb_exitflag] = (rtb_Bias * rtDW->IdentityMatrix[rtb_exitflag] +
          tmp[rtb_exitflag]) + rtb_ElementProduct_idx_4 *
          rtb_Product_a[rtb_exitflag];
      }
    }

    /* End of Outputs for SubSystem: '<S3>/Subsystem3' */

    /* Gain: '<S5>/Tx_equal_gain' */
    rtb_AllMomentArmsFLFRRLRRabou_2 = 0.0 * rtU->driver_input;

    /* Saturate: '<S5>/Max Torque' incorporates:
     *  Gain: '<S5>/Tx_equal_gain'
     */
    if (rtb_AllMomentArmsFLFRRLRRabou_2 < 0.02) {
      rtb_ElementProduct_idx_0 = 0.02;
      rtb_MaxIndividualMotorTorqueN_0 = 0.02;
    } else {
      rtb_ElementProduct_idx_0 = (rtNaN);
      rtb_MaxIndividualMotorTorqueN_0 = (rtNaN);
    }

    /* Gain: '<S5>/Tx_equal_gain' */
    rtb_Tx_guess_idx_3 = 25.0 * rtU->driver_input;

    /* Saturate: '<S5>/Max Torque' incorporates:
     *  Gain: '<S5>/Tx_equal_gain'
     */
    if (rtb_Tx_guess_idx_3 > 25.0) {
      rtb_MathFunction_idx_1 = 25.0;
    } else if (rtb_Tx_guess_idx_3 < 0.02) {
      rtb_MathFunction_idx_1 = 0.02;
    } else {
      rtb_MathFunction_idx_1 = rtb_Tx_guess_idx_3;
    }

    if (rtb_Tx_guess_idx_3 > 25.0) {
      rtb_MaxIndividualMotorTorqueNm_ = 25.0;
    } else if (rtb_Tx_guess_idx_3 < 0.02) {
      rtb_MaxIndividualMotorTorqueNm_ = 0.02;
    } else {
      rtb_MaxIndividualMotorTorqueNm_ = rtb_Tx_guess_idx_3;
    }

    /* MinMax: '<S5>/Max' */
    rtb_Sin = rtU->MotorTemeprature0100degC14[0];
    rtb_Sin = fmax(rtb_Sin, rtU->MotorTemeprature0100degC14[1]);

    /* Lookup_n-D: '<S5>/Temperature to Motor Current Limit Map' incorporates:
     *  CCaller: '<S5>/C Caller'
     */
    bpIdx = plook_evenca(rtb_Sin, 75.0, 25.0, 1U, &rtb_ElementProduct_idx_4);
    rtb_Sin = intrp1d_la(bpIdx, rtb_ElementProduct_idx_4, rtConstP.pooled6, 1U);

    /* MinMax: '<S5>/Max1' */
    rtb_Bias = rtU->MotorControlerTemeprature075deg[0];
    rtb_Bias = fmax(rtb_Bias, rtU->MotorControlerTemeprature075deg[1]);

    /* Lookup_n-D: '<S5>/Temperature to MC Current Limit Map' incorporates:
     *  CCaller: '<S5>/C Caller'
     */
    bpIdx = plook_evenca(rtb_Bias, 50.0, 25.0, 1U, &rtb_ElementProduct_idx_4);
    rtb_Bias = intrp1d_la(bpIdx, rtb_ElementProduct_idx_4, rtConstP.pooled6, 1U);

    /* Lookup_n-D: '<S5>/1-D Lookup Table2' incorporates:
     *  Sum: '<S5>/Sum4'
     */
    bpIdx = plook_evenc(rtU->MaxDischargeChargeCurrent0150A1[0] -
                        rtU->BatteryCurrent0150A11, 0.0, 5.0, 1U,
                        &rtb_ElementProduct_idx_4);

    /* MinMax: '<S5>/Minimum' incorporates:
     *  Gain: '<S5>/Tx_equal_gain'
     *  Lookup_n-D: '<S5>/1-D Lookup Table2'
     *  Sum: '<S5>/Sum2'
     */
    rtb_AllMomentArmsFLFRRLRRabou_2 = fmin(((rtb_AllMomentArmsFLFRRLRRabou_2 +
      rtb_AllMomentArmsFLFRRLRRabou_2) + rtb_Tx_guess_idx_3) +
      rtb_Tx_guess_idx_3, rtb_Sin);
    rtb_AllMomentArmsFLFRRLRRabou_2 = fmin(rtb_AllMomentArmsFLFRRLRRabou_2,
      rtb_Bias);
    rtb_AllMomentArmsFLFRRLRRabou_2 = fmin(rtb_AllMomentArmsFLFRRLRRabou_2,
      intrp1d_l(bpIdx, rtb_ElementProduct_idx_4,
                rtConstP.uDLookupTable2_tableData));

    /* Gain: '<S5>/Gain4' */
    rtb_ElementProduct_idx_4 = 0.5 * rtb_AllMomentArmsFLFRRLRRabou_2;

    /* Abs: '<S5>/Abs1' */
    rtb_Bias = fabs(rtU->steering_angle_deg);

    /* RelationalOperator: '<S5>/GreaterThan' */
    rtb_Equal = (rtb_Bias > rtU->deadbandonthetadeg11);

    /* Product: '<S5>/Product3' */
    rtb_Bias = rtU->steering_angle_deg * (real_T)rtb_Equal;

    /* Lookup_n-D: '<S5>/2-D Lookup Table' incorporates:
     *  CCaller: '<S5>/C Caller'
     *  DotProduct: '<S2>/Dot Product'
     *  Sqrt: '<S2>/Sqrt'
     */
    rtb_Bias = look2_binlc(sqrt(rtU->vel[0] * rtU->vel[0] + rtU->vel[1] *
      rtU->vel[1]), rtb_Bias, rtConstP.uDLookupTable_bp01Data,
      rtConstP.uDLookupTable_bp02Data, rtConstP.uDLookupTable_tableData,
      rtConstP.uDLookupTable_maxIndex, 34U);

    /* Product: '<S2>/Product' incorporates:
     *  Inport: '<Root>/ang_vel_s'
     *  Sum: '<S9>/Add'
     */
    rtb_Sin = rtU->gyro[1];
    rtb_Tx_guess_idx_3 = rtU->gyro[0];
    rtb_AllMomentArmsFLFRRLRRabou_1 = rtU->gyro[2];
    for (rtb_exitflag = 0; rtb_exitflag < 3; rtb_exitflag++) {
      rtb_Product_e[rtb_exitflag] = (rtDW->R[rtb_exitflag + 3] * rtb_Sin +
        rtDW->R[rtb_exitflag] * rtb_Tx_guess_idx_3) + rtDW->R[rtb_exitflag + 6] *
        rtb_AllMomentArmsFLFRRLRRabou_1;
    }

    /* Gain: '<S5>/P_gain' incorporates:
     *  Product: '<S2>/Product'
     *  Product: '<S5>/Product'
     *  Sum: '<S5>/Sum1'
     */
    rtb_Bias = (rtb_Product_e[2] - rtU->intensityfactoronyawratereferen *
                rtb_Bias) * 20.0;

    /* Switch: '<S14>/Switch2' incorporates:
     *  RelationalOperator: '<S14>/LowerRelop1'
     */
    if (!(rtb_Bias > rtb_ElementProduct_idx_4)) {
      /* Gain: '<S5>/Gain2' */
      rtb_ElementProduct_idx_4 = -rtb_ElementProduct_idx_4;

      /* Switch: '<S14>/Switch' incorporates:
       *  RelationalOperator: '<S14>/UpperRelop'
       */
      if (!(rtb_Bias < rtb_ElementProduct_idx_4)) {
        rtb_ElementProduct_idx_4 = rtb_Bias;
      }

      /* End of Switch: '<S14>/Switch' */
    }

    /* End of Switch: '<S14>/Switch2' */

    /* Switch: '<S5>/Switch' incorporates:
     *  Saturate: '<S5>/Saturation2'
     */
    if (rtb_ElementProduct_idx_4 > 0.0) {
      /* Saturate: '<S5>/Saturation1' */
      if (rtb_ElementProduct_idx_4 <= 0.001) {
        rtb_AllMomentArmsFLFRRLRRabou_1 = 0.001;
      } else {
        rtb_AllMomentArmsFLFRRLRRabou_1 = rtb_ElementProduct_idx_4;
      }

      /* End of Saturate: '<S5>/Saturation1' */
    } else if (rtb_ElementProduct_idx_4 >= -0.001) {
      /* Saturate: '<S5>/Saturation2' */
      rtb_AllMomentArmsFLFRRLRRabou_1 = -0.001;
    } else {
      rtb_AllMomentArmsFLFRRLRRabou_1 = rtb_ElementProduct_idx_4;
    }

    /* End of Switch: '<S5>/Switch' */

    /* Lookup_n-D: '<S5>/1-D Lookup Table' */
    rtb_AllMomentArmsFLFRRLRRabou_0 = look1_binlc(rtU->steering_angle_deg,
      rtConstP.pooled8, rtConstP.uDLookupTable_tableData_c, 260U);

    /* Lookup_n-D: '<S5>/1-D Lookup Table1' */
    rtb_FRMomentArm = look1_binlc(rtU->steering_angle_deg, rtConstP.pooled8,
      rtConstP.uDLookupTable1_tableData, 260U);

    /* MATLAB Function: '<S5>/MATLAB Function' */
    if (rtb_AllMomentArmsFLFRRLRRabou_1 > 0.0) {
      rtb_ElementProduct_idx_4 = rtb_MathFunction_idx_1 + 25.0;
      rtb_Tx_guess_idx_3 = (rtb_MaxIndividualMotorTorqueNm_ -
                            rtb_AllMomentArmsFLFRRLRRabou_1 / 0.621) + 25.0;
    } else {
      rtb_ElementProduct_idx_4 = (rtb_MathFunction_idx_1 - fabs
        (rtb_AllMomentArmsFLFRRLRRabou_1 / 0.621)) + 25.0;
      rtb_Tx_guess_idx_3 = rtb_MaxIndividualMotorTorqueNm_ + 25.0;
    }

    /* End of MATLAB Function: '<S5>/MATLAB Function' */

    /* CCaller: '<S5>/C Caller' incorporates:
     *  Bias: '<S5>/ub_offset'
     *  Constant: '<S5>/Constant'
     *  Constant: '<S5>/Constant3'
     *  Constant: '<S5>/Constant4'
     *  Constant: '<S5>/Constant5'
     *  Constant: '<S5>/optimization_offset_Aeq'
     *  Constant: '<S5>/yaw_error_limit'
     *  DotProduct: '<S5>/Aeq Dot'
     *  SignalConversion generated from: '<S5>/Aeq Dot'
     *  Sum: '<S5>/b Add'
     *  Sum: '<S5>/beq Add'
     */
    rtb_Bias = 25.0;
    rtb_Sin = 25.0;
    rtb_exitflag = bigM_func(39.2280863132881, 39.2280863132881,
      39.2280863132881, 39.2280863132881, rtb_AllMomentArmsFLFRRLRRabou_2 +
      100.0, 1.0, 1.0, 1.0, 1.0, (((25.0 * rtb_AllMomentArmsFLFRRLRRabou_0 +
      25.0 * rtb_FRMomentArm) + 15.525) - 15.525) +
      rtb_AllMomentArmsFLFRRLRRabou_1, rtb_AllMomentArmsFLFRRLRRabou_0,
      rtb_FRMomentArm, 0.621, -0.621, rtConstB.lb_offset[0], rtConstB.lb_offset
      [1], rtConstB.lb_offset[2], rtConstB.lb_offset[3],
      rtb_ElementProduct_idx_0 + 25.0, rtb_MaxIndividualMotorTorqueN_0 + 25.0,
      rtb_MathFunction_idx_1 + 25.0, rtb_MaxIndividualMotorTorqueNm_ + 25.0,
      &rtb_Bias, &rtb_Sin, &rtb_ElementProduct_idx_4, &rtb_Tx_guess_idx_3,
      0.020000000000000004);

    /* Bias: '<S5>/Tx_reverse_offset' */
    rtb_AllMomentArmsFLFRRLRRabou_0 = rtb_Bias - 25.0;
    rtb_AllMomentArmsFLFRRLRRabou_1 = rtb_Sin - 25.0;
    rtb_AllMomentArmsFLFRRLRRabou_2 = rtb_ElementProduct_idx_4 - 25.0;
    rtb_ElementProduct_idx_4 = rtb_Tx_guess_idx_3 - 25.0;

    /* Gain: '<S5>/Gain' */
    rtb_ElementProduct_idx_0 = 0.04 * rtb_AllMomentArmsFLFRRLRRabou_0;
    rtb_MaxIndividualMotorTorqueN_0 = 0.04 * rtb_AllMomentArmsFLFRRLRRabou_1;
    rtb_MathFunction_idx_1 = 0.04 * rtb_AllMomentArmsFLFRRLRRabou_2;
    rtb_MaxIndividualMotorTorqueNm_ = 0.04 * rtb_ElementProduct_idx_4;

    /* Switch: '<S4>/Switch' incorporates:
     *  Lookup_n-D: '<S4>/dk'
     *  Lookup_n-D: '<S4>/k_min'
     *  Product: '<S4>/Product'
     *  RelationalOperator: '<S4>/Equal'
     *  Sum: '<S4>/Sum1'
     *  UnitDelay: '<S4>/Unit Delay'
     */
    if (rtb_exitflag == 3) {
      /* Lookup_n-D: '<S4>/dk' incorporates:
       *  Inport: '<Root>/omega_m'
       *  Lookup_n-D: '<S4>/k_min'
       */
      bpIndices[1U] = plook_evenc(rtU->BatteryTerminalVoltage0340V11, 60.0,
        11.200000000000003, 25U, &rtb_ElementProduct_idx_4);
      fractions[1U] = rtb_ElementProduct_idx_4;
      bpIndices[0U] = plook_evenc(rtU->omega_m[0], 0.0, 10.404006451471698, 106U,
        &rtb_ElementProduct_idx_4);
      fractions[0U] = rtb_ElementProduct_idx_4;
      rtb_Bias = intrp2d_l(bpIndices, fractions, rtConstP.dk_tableData, 107U);
      bpIndices[0U] = plook_evenc(rtU->omega_m[1], 0.0, 10.404006451471698, 106U,
        &rtb_ElementProduct_idx_4);
      fractions[0U] = rtb_ElementProduct_idx_4;
      rtb_Sin = intrp2d_l(bpIndices, fractions, rtConstP.dk_tableData, 107U);
      bpIndices[0U] = plook_evenc(rtU->omega_m[2], 0.0, 10.404006451471698, 106U,
        &rtb_ElementProduct_idx_4);
      fractions[0U] = rtb_ElementProduct_idx_4;
      rtb_Tx_guess_idx_3 = intrp2d_l(bpIndices, fractions, rtConstP.dk_tableData,
        107U);
      bpIndices[0U] = plook_evenc(rtU->omega_m[3], 0.0, 10.404006451471698, 106U,
        &rtb_ElementProduct_idx_4);
      fractions[0U] = rtb_ElementProduct_idx_4;

      /* Product: '<S4>/Product' incorporates:
       *  Lookup_n-D: '<S4>/k_min'
       */
      rtb_AllMomentArmsFLFRRLRRabou_0 = rtb_Bias * rtb_ElementProduct_idx_0;
      rtb_AllMomentArmsFLFRRLRRabou_1 = rtb_Sin *
        rtb_MaxIndividualMotorTorqueN_0;
      rtb_AllMomentArmsFLFRRLRRabou_2 = rtb_Tx_guess_idx_3 *
        rtb_MathFunction_idx_1;

      /* Lookup_n-D: '<S4>/k_min' incorporates:
       *  Inport: '<Root>/omega_m'
       */
      bpIndices_0[1U] = plook_evenc(rtU->BatteryTerminalVoltage0340V11, 60.0,
        11.200000000000003, 25U, &rtb_ElementProduct_idx_4);
      fractions_0[1U] = rtb_ElementProduct_idx_4;
      bpIndices_0[0U] = plook_evenc(rtU->omega_m[0], 0.0, 10.404006451471698,
        106U, &rtb_ElementProduct_idx_4);
      fractions_0[0U] = rtb_ElementProduct_idx_4;
      rtb_Bias = intrp2d_l(bpIndices_0, fractions_0, rtConstP.k_min_tableData,
                           107U);
      bpIndices_0[0U] = plook_evenc(rtU->omega_m[1], 0.0, 10.404006451471698,
        106U, &rtb_ElementProduct_idx_4);
      fractions_0[0U] = rtb_ElementProduct_idx_4;
      rtb_Sin = intrp2d_l(bpIndices_0, fractions_0, rtConstP.k_min_tableData,
                          107U);
      bpIndices_0[0U] = plook_evenc(rtU->omega_m[2], 0.0, 10.404006451471698,
        106U, &rtb_ElementProduct_idx_4);
      fractions_0[0U] = rtb_ElementProduct_idx_4;
      rtb_Tx_guess_idx_3 = intrp2d_l(bpIndices_0, fractions_0,
        rtConstP.k_min_tableData, 107U);
      bpIndices_0[0U] = plook_evenc(rtU->omega_m[3], 0.0, 10.404006451471698,
        106U, &rtb_ElementProduct_idx_4);
      fractions_0[0U] = rtb_ElementProduct_idx_4;
      rtb_AllMomentArmsFLFRRLRRabou_0 += rtb_Bias;
      rtb_AllMomentArmsFLFRRLRRabou_1 += rtb_Sin;
      rtb_AllMomentArmsFLFRRLRRabou_2 += rtb_Tx_guess_idx_3;
      rtb_ElementProduct_idx_4 = intrp2d_l(bpIndices, fractions,
        rtConstP.dk_tableData, 107U) * rtb_MaxIndividualMotorTorqueNm_ +
        intrp2d_l(bpIndices_0, fractions_0, rtConstP.k_min_tableData, 107U);
    } else {
      rtb_AllMomentArmsFLFRRLRRabou_0 = rtU->driver_input;
      rtb_AllMomentArmsFLFRRLRRabou_1 = rtU->driver_input;
      rtb_AllMomentArmsFLFRRLRRabou_2 = rtU->driver_input;
      rtb_ElementProduct_idx_4 = rtU->driver_input;
    }

    /* End of Switch: '<S4>/Switch' */

    /* Sum: '<S4>/Sum' incorporates:
     *  Gain: '<S4>/Gain'
     *  Gain: '<S4>/Gain1'
     *  UnitDelay: '<S4>/Unit Delay'
     */
    rtb_Bias = 0.5 * rtb_AllMomentArmsFLFRRLRRabou_0 + 0.5 *
      rtDW->UnitDelay_DSTATE[0];

    /* Update for UnitDelay: '<S4>/Unit Delay' incorporates:
     *  Sum: '<S4>/Sum'
     */
    rtDW->UnitDelay_DSTATE[0] = rtb_Bias;

    /* Outport: '<Root>/k' incorporates:
     *  Gain: '<S4>/Gain2'
     *  Sum: '<S4>/Sum'
     */
    rtY->k[0] = 0.0 * rtb_Bias;

    /* Outport: '<Root>/r' incorporates:
     *  Gain: '<S1>/Gain2'
     */
    rtY->r[0] = 0.0 * rtb_ElementProduct_idx_0;

    /* Sum: '<S4>/Sum' incorporates:
     *  Gain: '<S4>/Gain'
     *  Gain: '<S4>/Gain1'
     *  UnitDelay: '<S4>/Unit Delay'
     */
    rtb_Bias = 0.5 * rtb_AllMomentArmsFLFRRLRRabou_1 + 0.5 *
      rtDW->UnitDelay_DSTATE[1];

    /* Update for UnitDelay: '<S4>/Unit Delay' incorporates:
     *  Sum: '<S4>/Sum'
     */
    rtDW->UnitDelay_DSTATE[1] = rtb_Bias;

    /* Outport: '<Root>/k' incorporates:
     *  Gain: '<S4>/Gain2'
     *  Sum: '<S4>/Sum'
     */
    rtY->k[1] = 0.0 * rtb_Bias;

    /* Outport: '<Root>/r' incorporates:
     *  Gain: '<S1>/Gain2'
     */
    rtY->r[1] = 0.0 * rtb_MaxIndividualMotorTorqueN_0;

    /* Sum: '<S4>/Sum' incorporates:
     *  Gain: '<S4>/Gain'
     *  Gain: '<S4>/Gain1'
     *  UnitDelay: '<S4>/Unit Delay'
     */
    rtb_Bias = 0.5 * rtb_AllMomentArmsFLFRRLRRabou_2 + 0.5 *
      rtDW->UnitDelay_DSTATE[2];

    /* Update for UnitDelay: '<S4>/Unit Delay' incorporates:
     *  Sum: '<S4>/Sum'
     */
    rtDW->UnitDelay_DSTATE[2] = rtb_Bias;

    /* Outport: '<Root>/k' incorporates:
     *  Gain: '<S4>/Gain2'
     *  Sum: '<S4>/Sum'
     */
    rtY->k[2] = rtb_Bias;

    /* Outport: '<Root>/r' incorporates:
     *  Gain: '<S1>/Gain2'
     */
    rtY->r[2] = rtb_MathFunction_idx_1;

    /* Sum: '<S4>/Sum' incorporates:
     *  Gain: '<S4>/Gain'
     *  Gain: '<S4>/Gain1'
     *  UnitDelay: '<S4>/Unit Delay'
     */
    rtb_Bias = 0.5 * rtb_ElementProduct_idx_4 + 0.5 * rtDW->UnitDelay_DSTATE[3];

    /* Update for UnitDelay: '<S4>/Unit Delay' incorporates:
     *  Sum: '<S4>/Sum'
     */
    rtDW->UnitDelay_DSTATE[3] = rtb_Bias;

    /* Outport: '<Root>/k' incorporates:
     *  Gain: '<S4>/Gain2'
     *  Sum: '<S4>/Sum'
     */
    rtY->k[3] = rtb_Bias;

    /* Outport: '<Root>/r' incorporates:
     *  Gain: '<S1>/Gain2'
     */
    rtY->r[3] = rtb_MaxIndividualMotorTorqueNm_;

    /* End of Outputs for SubSystem: '<Root>/controller' */
  }

  rate_scheduler(rtM);
}

/* Model initialize function */
void controller_initialize(RT_MODEL *const rtM)
{
  DW *rtDW = rtM->dwork;
  PrevZCX *rtPrevZCX = rtM->prevZCSigState;

  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  {
    h_dsp_internal_ExponentialMovin *obj;
    rtPrevZCX->Subsystem3_Trig_ZCE = UNINITIALIZED_ZCSIG;

    /* SystemInitialize for Atomic SubSystem: '<Root>/controller' */
    /* SystemInitialize for Enabled SubSystem: '<S3>/Subsystem' */
    /* Start for MATLABSystem: '<S6>/Moving Average3' */
    rtDW->obj.isInitialized = 0;
    rtDW->obj.NumChannels = -1;
    rtDW->obj.FrameLength = -1;
    rtDW->obj.matlabCodegenIsDeleted = false;
    SystemCore_setup(&rtDW->obj);

    /* InitializeConditions for MATLABSystem: '<S6>/Moving Average3' */
    obj = rtDW->obj.pStatistic;
    if (obj->isInitialized == 1) {
      obj->pwN = 1.0;
      obj->pmN = 0.0;
    }

    /* End of InitializeConditions for MATLABSystem: '<S6>/Moving Average3' */
    /* End of SystemInitialize for SubSystem: '<S3>/Subsystem' */

    /* SystemInitialize for Triggered SubSystem: '<S3>/Subsystem3' */
    /* Start for IdentityMatrix: '<S9>/IdentityMatrix' */
    memcpy(&rtDW->IdentityMatrix[0], &rtConstP.IdentityMatrix_IDMatrixData[0],
           9U * sizeof(real_T));

    /* End of SystemInitialize for SubSystem: '<S3>/Subsystem3' */
    /* End of SystemInitialize for SubSystem: '<Root>/controller' */
  }
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
