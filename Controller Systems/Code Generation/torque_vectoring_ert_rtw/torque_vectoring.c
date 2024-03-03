/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: torque_vectoring.c
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

#include "torque_vectoring.h"
#include <math.h>
#include "rtwtypes.h"

/* Block signals and states (default storage) */
DW_torque_vectoring_T torque_vectoring_DW;

/* External inputs (root inport signals with default storage) */
ExtU_torque_vectoring_T torque_vectoring_U;

/* External outputs (root outports fed by signals with default storage) */
ExtY_torque_vectoring_T torque_vectoring_Y;
extern real_T rt_roundd(real_T u);
static uint32_T plook_evencag(real_T u, real_T bp0, real_T bpSpace, real_T
  *fraction);
static real_T intrp1d_la(uint32_T bpIndex, real_T frac, const real_T table[],
  uint32_T maxIndex);
static real_T intrp2d_la(const uint32_T bpIndex[], const real_T frac[], const
  real_T table[], const uint32_T stride, const uint32_T maxIndex[]);

/* Forward declaration for local functions */
static void torque_vectori_SystemCore_setup(dsp_simulink_MovingAverage_to_T *obj);
static void torque_vecto_SystemCore_setup_h(dsp_simulink_MovingAverage_h_T *obj);
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

real_T rt_roundd(real_T u)
{
  real_T y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

static void torque_vectori_SystemCore_setup(dsp_simulink_MovingAverage_to_T *obj)
{
  obj->isSetupComplete = false;
  obj->isInitialized = 1;
  obj->NumChannels = 1;
  obj->FrameLength = 1;
  obj->_pobj0.isInitialized = 0;
  obj->_pobj0.isInitialized = 0;
  obj->pStatistic = &obj->_pobj0;
  obj->isSetupComplete = true;
  obj->TunablePropsChanged = false;
}

static void torque_vecto_SystemCore_setup_h(dsp_simulink_MovingAverage_h_T *obj)
{
  obj->isSetupComplete = false;
  obj->isInitialized = 1;
  obj->NumChannels = 1;
  obj->FrameLength = 1;
  obj->_pobj0.isInitialized = 0;
  obj->_pobj0.isInitialized = 0;
  obj->pStatistic = &obj->_pobj0;
  obj->isSetupComplete = true;
  obj->TunablePropsChanged = false;
}

/* Model step function */
void torque_vectoring_step(void)
{
  h_dsp_internal_SlidingWindo_h_T *obj_0;
  h_dsp_internal_SlidingWindowA_T *obj;
  real_T csumrev[19];
  real_T rtb_Saturation[19];
  real_T csumrev_0[5];
  real_T rtb_Product_p[3];
  real_T tmp[3];
  real_T fractions[2];
  real_T csum;
  real_T cumRevIndex;
  real_T modValueRev;
  real_T rtb_Gain4;
  real_T z;
  int32_T i;
  int32_T localProduct;
  uint32_T bpIndices[2];
  uint32_T bpIdx;
  uint32_T bpIdx_0;
  uint32_T bpIdx_1;
  boolean_T rtb_MatrixConcatenate[51];
  for (i = 0; i < 19; i++) {
    rtb_Gain4 = torque_vectoring_U.D_raw[i];
    cumRevIndex = torque_vectoring_ConstP.pooled1[i];
    csum = torque_vectoring_P.ub[i];
    if (rtb_Gain4 > csum) {
      rtb_Gain4 = csum;
      rtb_Saturation[i] = csum;
    } else if (rtb_Gain4 < cumRevIndex) {
      rtb_Gain4 = cumRevIndex;
      rtb_Saturation[i] = cumRevIndex;
    } else {
      rtb_Saturation[i] = rtb_Gain4;
    }

    torque_vectoring_Y.sig_trunc[i] = rtb_Gain4;
  }

  torque_vectoring_Y.w[0] = rtb_Saturation[3];
  torque_vectoring_Y.w[1] = rtb_Saturation[4];
  torque_vectoring_Y.V = rtb_Saturation[2];
  if (torque_vectoring_DW.obj.TunablePropsChanged) {
    torque_vectoring_DW.obj.TunablePropsChanged = false;
  }

  obj = torque_vectoring_DW.obj.pStatistic;
  if (torque_vectoring_DW.obj.pStatistic->isInitialized != 1) {
    torque_vectoring_DW.obj.pStatistic->isSetupComplete = false;
    torque_vectoring_DW.obj.pStatistic->isInitialized = 1;
    obj->pCumSum = 0.0;
    obj->pCumRevIndex = 1.0;
    obj->pModValueRev = 0.0;
    obj->isSetupComplete = true;
    obj->pCumSum = 0.0;
    for (i = 0; i < 19; i++) {
      obj->pCumSumRev[i] = 0.0;
      obj->pCumSumRev[i] = 0.0;
    }

    obj->pCumRevIndex = 1.0;
    obj->pModValueRev = 0.0;
  }

  cumRevIndex = obj->pCumRevIndex;
  csum = obj->pCumSum;
  for (i = 0; i < 19; i++) {
    csumrev[i] = obj->pCumSumRev[i];
  }

  modValueRev = obj->pModValueRev;
  z = 0.0;
  rtb_Gain4 = 0.0;
  csum += rtb_Saturation[11];
  if (modValueRev == 0.0) {
    z = csumrev[(int32_T)cumRevIndex - 1] + csum;
  }

  csumrev[(int32_T)cumRevIndex - 1] = rtb_Saturation[11];
  if (cumRevIndex != 19.0) {
    cumRevIndex++;
  } else {
    cumRevIndex = 1.0;
    csum = 0.0;
    for (i = 17; i >= 0; i--) {
      csumrev[i] += csumrev[i + 1];
    }
  }

  if (modValueRev == 0.0) {
    rtb_Gain4 = z / 20.0;
  }

  obj->pCumSum = csum;
  for (i = 0; i < 19; i++) {
    obj->pCumSumRev[i] = csumrev[i];
  }

  obj->pCumRevIndex = cumRevIndex;
  if (modValueRev > 0.0) {
    obj->pModValueRev = modValueRev - 1.0;
  } else {
    obj->pModValueRev = 0.0;
  }

  cumRevIndex = 0.0;
  for (i = 0; i < 3; i++) {
    csum = rtb_Saturation[i + 5];
    cumRevIndex += csum * csum;
    csum = torque_vectoring_U.R[i];
    modValueRev = csum * rtb_Saturation[8];
    z = csum * rtb_Saturation[16];
    csum = torque_vectoring_U.R[i + 3];
    modValueRev += csum * rtb_Saturation[9];
    z += csum * rtb_Saturation[17];
    csum = torque_vectoring_U.R[i + 6];
    tmp[i] = csum * rtb_Saturation[18] + z;
    rtb_Product_p[i] = csum * rtb_Saturation[10] + modValueRev;
  }

  cumRevIndex = sqrt(cumRevIndex);
  torque_vectoring_Y.sig_filt[0] = rtb_Saturation[0];
  torque_vectoring_Y.sig_filt[1] = rtb_Saturation[0];
  torque_vectoring_Y.sig_filt[2] = rtb_Saturation[1];
  torque_vectoring_Y.sig_filt[3] = rtb_Saturation[2];
  torque_vectoring_Y.sig_filt[4] = rtb_Saturation[3];
  torque_vectoring_Y.sig_filt[5] = rtb_Saturation[4];
  torque_vectoring_Y.sig_filt[6] = cumRevIndex;
  torque_vectoring_Y.sig_filt[7] = rtb_Product_p[0];
  torque_vectoring_Y.sig_filt[8] = rtb_Product_p[1];
  torque_vectoring_Y.sig_filt[9] = rtb_Product_p[2];
  torque_vectoring_Y.sig_filt[10] = rtb_Gain4;
  torque_vectoring_Y.sig_filt[11] = rtb_Saturation[12];
  torque_vectoring_Y.sig_filt[12] = rtb_Saturation[13];
  torque_vectoring_Y.sig_filt[13] = rtb_Saturation[14];
  torque_vectoring_Y.sig_filt[14] = rtb_Saturation[15];
  torque_vectoring_Y.sig_filt[15] = tmp[0];
  torque_vectoring_Y.sig_filt[16] = tmp[1];
  torque_vectoring_Y.sig_filt[17] = tmp[2];
  torque_vectoring_Y.rEQUAL[0] = rtb_Saturation[0];
  torque_vectoring_Y.rEQUAL[1] = rtb_Saturation[0];
  bpIdx = plook_evencag(fmax(rtb_Saturation[14], rtb_Saturation[15]),
                        torque_vectoring_P.Tmo[0], torque_vectoring_P.Tmo[1] -
                        torque_vectoring_P.Tmo[0], &csum);
  z = fmax(rtb_Saturation[12], rtb_Saturation[13]);
  bpIdx_0 = plook_evencag(z, torque_vectoring_P.Tmc[0], torque_vectoring_P.Tmc[1]
    - torque_vectoring_P.Tmc[0], &modValueRev);
  bpIdx_1 = plook_evencag(rtb_Gain4 - torque_vectoring_P.I_FUSE,
    torque_vectoring_P.dIb[0], torque_vectoring_P.dIb[1] -
    torque_vectoring_P.dIb[0], &z);
  rtb_Gain4 = torque_vectoring_P.r_power_sat / torque_vectoring_P.PLb * fmin
    (fmin(fmin(rtb_Saturation[0] + rtb_Saturation[0], intrp1d_la(bpIdx, csum,
        torque_vectoring_P.k_TL, 1U)), intrp1d_la(bpIdx_0, modValueRev,
       torque_vectoring_P.k_TL, 1U)), intrp1d_la(bpIdx_1, z,
      torque_vectoring_P.k_TL, 1U));
  bpIndices[0U] = plook_evencag(cumRevIndex, torque_vectoring_P.v[0],
    torque_vectoring_P.v[1] - torque_vectoring_P.v[0], &csum);
  fractions[0U] = csum;
  bpIndices[1U] = plook_evencag(fabs(rtb_Saturation[1]) >
    torque_vectoring_U.dphi ? rtb_Saturation[1] : 0.0, torque_vectoring_P.s[0],
    torque_vectoring_P.s[1] - torque_vectoring_P.s[0], &csum);
  fractions[1U] = csum;
  cumRevIndex = (torque_vectoring_U.TVS_I * intrp2d_la(bpIndices, fractions,
    torque_vectoring_P.yaw_table, 51U,
    torque_vectoring_ConstP.uDLookupTable_maxIndex) - rtb_Product_p[2]) *
    torque_vectoring_U.TVS_P * torque_vectoring_P.half_track[1];
  if (cumRevIndex <= rtb_Gain4) {
    rtb_Gain4 = -rtb_Gain4;
    if (cumRevIndex >= rtb_Gain4) {
      rtb_Gain4 = cumRevIndex;
    }
  }

  if (rtb_Gain4 > 0.0) {
    torque_vectoring_Y.rTVS[0] = rtb_Saturation[0];
    torque_vectoring_Y.rTVS[1] = rtb_Saturation[0] - rtb_Gain4;
  } else {
    torque_vectoring_Y.rTVS[0] = rtb_Saturation[0] - fabs(rtb_Gain4);
    torque_vectoring_Y.rTVS[1] = rtb_Saturation[0];
  }

  for (i = 0; i < 19; i++) {
    rtb_Gain4 = torque_vectoring_U.D_raw[i];
    rtb_MatrixConcatenate[i + 32] = (torque_vectoring_ConstP.pooled1[i] <=
      rtb_Gain4);
    rtb_MatrixConcatenate[i + 13] = (torque_vectoring_P.ub[i] >= rtb_Gain4);
  }

  for (i = 0; i < 13; i++) {
    rtb_MatrixConcatenate[i] = torque_vectoring_U.F_raw[i];
  }

  localProduct = rtb_MatrixConcatenate[0] ? (int32_T)rtb_MatrixConcatenate[1] :
    0;
  for (i = 0; i < 49; i++) {
    localProduct = rtb_MatrixConcatenate[i + 2] ? localProduct : 0;
  }

  if (torque_vectoring_DW.obj_m.TunablePropsChanged) {
    torque_vectoring_DW.obj_m.TunablePropsChanged = false;
  }

  obj_0 = torque_vectoring_DW.obj_m.pStatistic;
  if (torque_vectoring_DW.obj_m.pStatistic->isInitialized != 1) {
    torque_vectoring_DW.obj_m.pStatistic->isSetupComplete = false;
    torque_vectoring_DW.obj_m.pStatistic->isInitialized = 1;
    obj_0->pCumSum = 0.0;
    obj_0->pCumRevIndex = 1.0;
    obj_0->pModValueRev = 0.0;
    obj_0->isSetupComplete = true;
    obj_0->pCumSum = 0.0;
    for (i = 0; i < 5; i++) {
      obj_0->pCumSumRev[i] = 0.0;
      obj_0->pCumSumRev[i] = 0.0;
    }

    obj_0->pCumRevIndex = 1.0;
    obj_0->pModValueRev = 0.0;
  }

  cumRevIndex = obj_0->pCumRevIndex;
  csum = obj_0->pCumSum;
  for (i = 0; i < 5; i++) {
    csumrev_0[i] = obj_0->pCumSumRev[i];
  }

  modValueRev = obj_0->pModValueRev;
  z = 0.0;
  rtb_Gain4 = 0.0;
  csum += (real_T)localProduct;
  if (modValueRev == 0.0) {
    z = csumrev_0[(int32_T)cumRevIndex - 1] + csum;
  }

  csumrev_0[(int32_T)cumRevIndex - 1] = localProduct;
  if (cumRevIndex != 5.0) {
    cumRevIndex++;
  } else {
    cumRevIndex = 1.0;
    csum = 0.0;
    csumrev_0[3] += csumrev_0[4];
    csumrev_0[2] += csumrev_0[3];
    csumrev_0[1] += csumrev_0[2];
    csumrev_0[0] += csumrev_0[1];
  }

  if (modValueRev == 0.0) {
    rtb_Gain4 = z / 6.0;
  }

  obj_0->pCumSum = csum;
  for (i = 0; i < 5; i++) {
    obj_0->pCumSumRev[i] = csumrev_0[i];
  }

  obj_0->pCumRevIndex = cumRevIndex;
  if (modValueRev > 0.0) {
    obj_0->pModValueRev = modValueRev - 1.0;
  } else {
    obj_0->pModValueRev = 0.0;
  }

  torque_vectoring_Y.TVS_STATE = rt_roundd(rtb_Gain4);
  for (i = 0; i < 51; i++) {
    torque_vectoring_Y.F_TVS[i] = rtb_MatrixConcatenate[i];
  }
}

/* Model initialize function */
void torque_vectoring_initialize(void)
{
  {
    h_dsp_internal_SlidingWindo_h_T *obj_0;
    h_dsp_internal_SlidingWindowA_T *obj;
    int32_T i;
    torque_vectoring_DW.obj.isInitialized = 0;
    torque_vectoring_DW.obj.NumChannels = -1;
    torque_vectoring_DW.obj.FrameLength = -1;
    torque_vectoring_DW.obj.matlabCodegenIsDeleted = false;
    torque_vectori_SystemCore_setup(&torque_vectoring_DW.obj);
    obj = torque_vectoring_DW.obj.pStatistic;
    if (obj->isInitialized == 1) {
      obj->pCumSum = 0.0;
      for (i = 0; i < 19; i++) {
        obj->pCumSumRev[i] = 0.0;
      }

      obj->pCumRevIndex = 1.0;
      obj->pModValueRev = 0.0;
    }

    torque_vectoring_DW.obj_m.isInitialized = 0;
    torque_vectoring_DW.obj_m.NumChannels = -1;
    torque_vectoring_DW.obj_m.FrameLength = -1;
    torque_vectoring_DW.obj_m.matlabCodegenIsDeleted = false;
    torque_vecto_SystemCore_setup_h(&torque_vectoring_DW.obj_m);
    obj_0 = torque_vectoring_DW.obj_m.pStatistic;
    if (obj_0->isInitialized == 1) {
      obj_0->pCumSum = 0.0;
      for (i = 0; i < 5; i++) {
        obj_0->pCumSumRev[i] = 0.0;
      }

      obj_0->pCumRevIndex = 1.0;
      obj_0->pModValueRev = 0.0;
    }
  }
}

/* Model terminate function */
void torque_vectoring_terminate(void)
{
  h_dsp_internal_SlidingWindo_h_T *obj_0;
  h_dsp_internal_SlidingWindowA_T *obj;
  if (!torque_vectoring_DW.obj.matlabCodegenIsDeleted) {
    torque_vectoring_DW.obj.matlabCodegenIsDeleted = true;
    if ((torque_vectoring_DW.obj.isInitialized == 1) &&
        torque_vectoring_DW.obj.isSetupComplete) {
      obj = torque_vectoring_DW.obj.pStatistic;
      if (obj->isInitialized == 1) {
        obj->isInitialized = 2;
      }

      torque_vectoring_DW.obj.NumChannels = -1;
      torque_vectoring_DW.obj.FrameLength = -1;
    }
  }

  if (!torque_vectoring_DW.obj_m.matlabCodegenIsDeleted) {
    torque_vectoring_DW.obj_m.matlabCodegenIsDeleted = true;
    if ((torque_vectoring_DW.obj_m.isInitialized == 1) &&
        torque_vectoring_DW.obj_m.isSetupComplete) {
      obj_0 = torque_vectoring_DW.obj_m.pStatistic;
      if (obj_0->isInitialized == 1) {
        obj_0->isInitialized = 2;
      }

      torque_vectoring_DW.obj_m.NumChannels = -1;
      torque_vectoring_DW.obj_m.FrameLength = -1;
    }
  }
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
