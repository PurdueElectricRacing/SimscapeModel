/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Electronics.c
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

#include "Electronics.h"
#include "rtwtypes.h"
#include <math.h>
#include <stddef.h>

/* Named constants for MATLAB Function: '<S3>/Reference Generation' */
#define Ku                             (0.024464831804281342)

/* Named constants for MATLAB Function: '<S3>/Steering Model' */
#define S1                             (7.0E-5)
#define S2                             (-0.0038)
#define S3                             (0.6535)
#define S4                             (0.1061)
#define deg2rad                        (0.01745329)

/* Named constants for MATLAB Function: '<S3>/Tire Model' */
#define A1                             (39.8344)
#define A2                             (813.078)
#define B1                             (1.287E-6)
#define B2                             (-0.002325)
#define B3                             (3.797)
#define C1                             (-2.541E-9)
#define C2                             (5.279E-6)
#define C3                             (-0.003943)
#define C4                             (3.634)
#define RE                             (0.2228169203)
#define a                              (1.14)
#define c                              (-1.14)
#define d                              (-1.027)
#define NumBitsPerChar                 8U

/* Block signals and states (default storage) */
DW rtDW;

/* External inputs (root inport signals with default storage) */
ExtU rtU;

/* External outputs (root outports fed by signals with default storage) */
ExtY rtY;

/* Real-time model */
static RT_MODEL rtM_;
RT_MODEL *const rtM = &rtM_;
extern real_T rt_powd_snf(real_T u0, real_T u1);
extern real_T rt_atan2d_snf(real_T u0, real_T u1);

/* Forward declaration for local functions */
static void pchip_j(const real_T xx[4], real_T v[4]);
static void power(const real_T b_a[4], real_T y[4]);
static real_T pchip(const real_T x[68], const real_T y[68], real_T xx);
static void minimum(const real_T x[251], real_T *ex, int32_T *idx);
static void minimum_l(const real_T x[8], real_T ex[4]);
static real_T sum(const real_T x[4]);
static real_T norm(const real_T x[2]);
static real_T rtGetInf(void);
static real32_T rtGetInfF(void);
static real_T rtGetMinusInf(void);
static real32_T rtGetMinusInfF(void);
static real_T rtGetNaN(void);
static real32_T rtGetNaNF(void);

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

real_T rt_powd_snf(real_T u0, real_T u1)
{
  real_T y;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = (rtNaN);
  } else {
    real_T tmp;
    real_T tmp_0;
    tmp = fabs(u0);
    tmp_0 = fabs(u1);
    if (rtIsInf(u1)) {
      if (tmp == 1.0) {
        y = 1.0;
      } else if (tmp > 1.0) {
        if (u1 > 0.0) {
          y = (rtInf);
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = (rtInf);
      }
    } else if (tmp_0 == 0.0) {
      y = 1.0;
    } else if (tmp_0 == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > floor(u1))) {
      y = (rtNaN);
    } else {
      y = pow(u0, u1);
    }
  }

  return y;
}

real_T rt_atan2d_snf(real_T u0, real_T u1)
{
  real_T y;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = (rtNaN);
  } else if (rtIsInf(u0) && rtIsInf(u1)) {
    int32_T u0_0;
    int32_T u1_0;
    if (u0 > 0.0) {
      u0_0 = 1;
    } else {
      u0_0 = -1;
    }

    if (u1 > 0.0) {
      u1_0 = 1;
    } else {
      u1_0 = -1;
    }

    y = atan2(u0_0, u1_0);
  } else if (u1 == 0.0) {
    if (u0 > 0.0) {
      y = RT_PI / 2.0;
    } else if (u0 < 0.0) {
      y = -(RT_PI / 2.0);
    } else {
      y = 0.0;
    }
  } else {
    y = atan2(u0, u1);
  }

  return y;
}

/* Function for MATLAB Function: '<S3>/Tire Model' */
static void pchip_j(const real_T xx[4], real_T v[4])
{
  real_T pp_coefs[24];
  real_T d_s[7];
  real_T del[6];
  real_T h[6];
  real_T dzzdx;
  real_T h_0;
  real_T hs;
  int32_T b_k;
  static const real_T e[7] = { 0.0, 204.13, 427.04, 668.1, 895.72, 1124.4,
    1324.4 };

  static const real_T f[7] = { 0.0, 13757.41, 21278.97, 26666.02, 30253.47,
    30313.18, 30313.18 };

  for (b_k = 0; b_k < 6; b_k++) {
    h_0 = e[b_k + 1] - e[b_k];
    del[b_k] = (f[b_k + 1] - f[b_k]) / h_0;
    h[b_k] = h_0;
  }

  for (b_k = 0; b_k < 5; b_k++) {
    real_T hs3;
    h_0 = h[b_k + 1];
    hs = h_0 + h[b_k];
    hs3 = 3.0 * hs;
    dzzdx = (h[b_k] + hs) / hs3;
    hs = (h_0 + hs) / hs3;
    d_s[b_k + 1] = 0.0;
    if (del[b_k] < 0.0) {
      h_0 = del[b_k + 1];
      if (h_0 <= del[b_k]) {
        d_s[b_k + 1] = del[b_k] / (del[b_k] / h_0 * dzzdx + hs);
      } else if (h_0 < 0.0) {
        d_s[b_k + 1] = h_0 / (h_0 / del[b_k] * hs + dzzdx);
      }
    } else if (del[b_k] > 0.0) {
      h_0 = del[b_k + 1];
      if (h_0 >= del[b_k]) {
        d_s[b_k + 1] = del[b_k] / (del[b_k] / h_0 * dzzdx + hs);
      } else if (h_0 > 0.0) {
        d_s[b_k + 1] = h_0 / (h_0 / del[b_k] * hs + dzzdx);
      }
    }
  }

  dzzdx = ((2.0 * h[0] + h[1]) * del[0] - h[0] * del[1]) / (h[0] + h[1]);
  if (rtIsNaN(del[0])) {
    hs = del[0];
  } else if (del[0] < 0.0) {
    hs = -1.0;
  } else {
    hs = (del[0] > 0.0);
  }

  if (rtIsNaN(dzzdx)) {
    h_0 = dzzdx;
  } else if (dzzdx < 0.0) {
    h_0 = -1.0;
  } else {
    h_0 = (dzzdx > 0.0);
  }

  if (h_0 != hs) {
    dzzdx = 0.0;
  } else {
    if (rtIsNaN(del[1])) {
      h_0 = del[1];
    } else if (del[1] < 0.0) {
      h_0 = -1.0;
    } else {
      h_0 = (del[1] > 0.0);
    }

    if ((hs != h_0) && (fabs(dzzdx) > fabs(3.0 * del[0]))) {
      dzzdx = 3.0 * del[0];
    }
  }

  d_s[0] = dzzdx;
  dzzdx = ((2.0 * h[5] + h[4]) * del[5] - del[4] * h[5]) / (h[4] + h[5]);
  if (rtIsNaN(del[5])) {
    hs = del[5];
  } else if (del[5] < 0.0) {
    hs = -1.0;
  } else {
    hs = (del[5] > 0.0);
  }

  if (rtIsNaN(dzzdx)) {
    h_0 = dzzdx;
  } else if (dzzdx < 0.0) {
    h_0 = -1.0;
  } else {
    h_0 = (dzzdx > 0.0);
  }

  if (h_0 != hs) {
    dzzdx = 0.0;
  } else {
    if (rtIsNaN(del[4])) {
      h_0 = del[4];
    } else if (del[4] < 0.0) {
      h_0 = -1.0;
    } else {
      h_0 = (del[4] > 0.0);
    }

    if ((hs != h_0) && (fabs(dzzdx) > fabs(3.0 * del[5]))) {
      dzzdx = 3.0 * del[5];
    }
  }

  d_s[6] = dzzdx;
  for (b_k = 0; b_k < 6; b_k++) {
    h_0 = h[b_k];
    hs = del[b_k];
    dzzdx = (hs - d_s[b_k]) / h_0;
    hs = (d_s[b_k + 1] - hs) / h_0;
    pp_coefs[b_k] = (hs - dzzdx) / h_0;
    pp_coefs[b_k + 6] = 2.0 * dzzdx - hs;
    pp_coefs[b_k + 12] = d_s[b_k];
    pp_coefs[b_k + 18] = f[b_k];
  }

  for (b_k = 0; b_k < 4; b_k++) {
    if (rtIsNaN(xx[b_k])) {
      v[b_k] = xx[b_k];
    } else {
      int32_T high_i;
      int32_T low_i;
      int32_T low_ip1;
      high_i = 7;
      low_i = 0;
      low_ip1 = 2;
      while (high_i > low_ip1) {
        int32_T mid_i;
        mid_i = ((low_i + high_i) + 1) >> 1;
        if (xx[b_k] >= e[mid_i - 1]) {
          low_i = mid_i - 1;
          low_ip1 = mid_i + 1;
        } else {
          high_i = mid_i;
        }
      }

      dzzdx = xx[b_k] - e[low_i];
      v[b_k] = ((dzzdx * pp_coefs[low_i] + pp_coefs[low_i + 6]) * dzzdx +
                pp_coefs[low_i + 12]) * dzzdx + pp_coefs[low_i + 18];
    }
  }
}

/* Function for MATLAB Function: '<S3>/Tire Model' */
static void power(const real_T b_a[4], real_T y[4])
{
  y[0] = b_a[0] * b_a[0];
  y[1] = b_a[1] * b_a[1];
  y[2] = b_a[2] * b_a[2];
  y[3] = b_a[3] * b_a[3];
}

/* Function for MATLAB Function: '<S3>/Constraint Generation' */
static real_T pchip(const real_T x[68], const real_T y[68], real_T xx)
{
  real_T pp_coefs[268];
  real_T d_s[68];
  real_T del[67];
  real_T h[67];
  real_T dzzdx;
  real_T h_0;
  real_T hs;
  real_T v;
  int32_T low_i;
  for (low_i = 0; low_i < 67; low_i++) {
    h_0 = x[low_i + 1] - x[low_i];
    del[low_i] = (y[low_i + 1] - y[low_i]) / h_0;
    h[low_i] = h_0;
  }

  for (low_i = 0; low_i < 66; low_i++) {
    real_T hs3;
    h_0 = h[low_i + 1];
    hs = h_0 + h[low_i];
    hs3 = 3.0 * hs;
    dzzdx = (h[low_i] + hs) / hs3;
    hs = (h_0 + hs) / hs3;
    d_s[low_i + 1] = 0.0;
    if (del[low_i] < 0.0) {
      h_0 = del[low_i + 1];
      if (h_0 <= del[low_i]) {
        d_s[low_i + 1] = del[low_i] / (del[low_i] / h_0 * dzzdx + hs);
      } else if (h_0 < 0.0) {
        d_s[low_i + 1] = h_0 / (h_0 / del[low_i] * hs + dzzdx);
      }
    } else if (del[low_i] > 0.0) {
      h_0 = del[low_i + 1];
      if (h_0 >= del[low_i]) {
        d_s[low_i + 1] = del[low_i] / (del[low_i] / h_0 * dzzdx + hs);
      } else if (h_0 > 0.0) {
        d_s[low_i + 1] = h_0 / (h_0 / del[low_i] * hs + dzzdx);
      }
    }
  }

  dzzdx = ((2.0 * h[0] + h[1]) * del[0] - h[0] * del[1]) / (h[0] + h[1]);
  if (rtIsNaN(del[0])) {
    hs = del[0];
  } else if (del[0] < 0.0) {
    hs = -1.0;
  } else {
    hs = (del[0] > 0.0);
  }

  if (rtIsNaN(dzzdx)) {
    h_0 = dzzdx;
  } else if (dzzdx < 0.0) {
    h_0 = -1.0;
  } else {
    h_0 = (dzzdx > 0.0);
  }

  if (h_0 != hs) {
    dzzdx = 0.0;
  } else {
    if (rtIsNaN(del[1])) {
      h_0 = del[1];
    } else if (del[1] < 0.0) {
      h_0 = -1.0;
    } else {
      h_0 = (del[1] > 0.0);
    }

    if ((hs != h_0) && (fabs(dzzdx) > fabs(3.0 * del[0]))) {
      dzzdx = 3.0 * del[0];
    }
  }

  d_s[0] = dzzdx;
  dzzdx = ((2.0 * h[66] + h[65]) * del[66] - del[65] * h[66]) / (h[65] + h[66]);
  if (rtIsNaN(del[66])) {
    hs = del[66];
  } else if (del[66] < 0.0) {
    hs = -1.0;
  } else {
    hs = (del[66] > 0.0);
  }

  if (rtIsNaN(dzzdx)) {
    h_0 = dzzdx;
  } else if (dzzdx < 0.0) {
    h_0 = -1.0;
  } else {
    h_0 = (dzzdx > 0.0);
  }

  if (h_0 != hs) {
    dzzdx = 0.0;
  } else {
    if (rtIsNaN(del[65])) {
      h_0 = del[65];
    } else if (del[65] < 0.0) {
      h_0 = -1.0;
    } else {
      h_0 = (del[65] > 0.0);
    }

    if ((hs != h_0) && (fabs(dzzdx) > fabs(3.0 * del[66]))) {
      dzzdx = 3.0 * del[66];
    }
  }

  d_s[67] = dzzdx;
  for (low_i = 0; low_i < 67; low_i++) {
    h_0 = h[low_i];
    hs = del[low_i];
    dzzdx = (hs - d_s[low_i]) / h_0;
    hs = (d_s[low_i + 1] - hs) / h_0;
    pp_coefs[low_i] = (hs - dzzdx) / h_0;
    pp_coefs[low_i + 67] = 2.0 * dzzdx - hs;
    pp_coefs[low_i + 134] = d_s[low_i];
    pp_coefs[low_i + 201] = y[low_i];
  }

  if (rtIsNaN(xx)) {
    v = xx;
  } else {
    int32_T high_i;
    int32_T low_ip1;
    high_i = 68;
    low_i = 0;
    low_ip1 = 2;
    while (high_i > low_ip1) {
      int32_T mid_i;
      mid_i = ((low_i + high_i) + 1) >> 1;
      if (xx >= x[mid_i - 1]) {
        low_i = mid_i - 1;
        low_ip1 = mid_i + 1;
      } else {
        high_i = mid_i;
      }
    }

    dzzdx = xx - x[low_i];
    v = ((dzzdx * pp_coefs[low_i] + pp_coefs[low_i + 67]) * dzzdx +
         pp_coefs[low_i + 134]) * dzzdx + pp_coefs[low_i + 201];
  }

  return v;
}

/* Function for MATLAB Function: '<S3>/Constraint Generation' */
static void minimum(const real_T x[251], real_T *ex, int32_T *idx)
{
  int32_T b_k;
  if (!rtIsNaN(x[0])) {
    *idx = 1;
  } else {
    boolean_T exitg1;
    *idx = 0;
    b_k = 2;
    exitg1 = false;
    while ((!exitg1) && (b_k < 252)) {
      if (!rtIsNaN(x[b_k - 1])) {
        *idx = b_k;
        exitg1 = true;
      } else {
        b_k++;
      }
    }
  }

  if (*idx == 0) {
    *ex = x[0];
    *idx = 1;
  } else {
    *ex = x[*idx - 1];
    for (b_k = *idx; b_k < 251; b_k++) {
      if (*ex > x[b_k]) {
        *ex = x[b_k];
        *idx = b_k + 1;
      }
    }
  }
}

/* Function for MATLAB Function: '<S3>/Constraint Generation' */
static void minimum_l(const real_T x[8], real_T ex[4])
{
  boolean_T tmp;
  ex[0] = x[0];
  if (rtIsNaN(x[1])) {
    tmp = false;
  } else if (rtIsNaN(x[0])) {
    tmp = true;
  } else {
    tmp = (x[0] > x[1]);
  }

  if (tmp) {
    ex[0] = x[1];
  }

  ex[1] = x[2];
  if (rtIsNaN(x[3])) {
    tmp = false;
  } else if (rtIsNaN(x[2])) {
    tmp = true;
  } else {
    tmp = (x[2] > x[3]);
  }

  if (tmp) {
    ex[1] = x[3];
  }

  ex[2] = x[4];
  if (rtIsNaN(x[5])) {
    tmp = false;
  } else if (rtIsNaN(x[4])) {
    tmp = true;
  } else {
    tmp = (x[4] > x[5]);
  }

  if (tmp) {
    ex[2] = x[5];
  }

  ex[3] = x[6];
  if (rtIsNaN(x[7])) {
    tmp = false;
  } else if (rtIsNaN(x[6])) {
    tmp = true;
  } else {
    tmp = (x[6] > x[7]);
  }

  if (tmp) {
    ex[3] = x[7];
  }
}

/* Function for MATLAB Function: '<S3>/Constraint Generation' */
static real_T sum(const real_T x[4])
{
  return ((x[0] + x[1]) + x[2]) + x[3];
}

/* Function for MATLAB Function: '<S3>/Constraint Generation' */
static real_T norm(const real_T x[2])
{
  real_T absxk;
  real_T b_t;
  real_T scale;
  real_T y;
  scale = 3.3121686421112381E-170;
  absxk = fabs(x[0]);
  if (absxk > 3.3121686421112381E-170) {
    y = 1.0;
    scale = absxk;
  } else {
    b_t = absxk / 3.3121686421112381E-170;
    y = b_t * b_t;
  }

  absxk = fabs(x[1]);
  if (absxk > scale) {
    b_t = scale / absxk;
    y = y * b_t * b_t + 1.0;
    scale = absxk;
  } else {
    b_t = absxk / scale;
    y += b_t * b_t;
  }

  return scale * sqrt(y);
}

/* Model step function */
void Electronics_step(void)
{
  real_T c_x[251];
  real_T varargin_1[251];
  real_T pp_coefs[36];
  real_T c_s[10];
  real_T del[9];
  real_T t_0[8];
  real_T C[4];
  real_T R[4];
  real_T SA[4];
  real_T SL[4];
  real_T a_bar[4];
  real_T b_k[4];
  real_T kx[4];
  real_T mu_x[4];
  real_T n_max[4];
  real_T rtb_FY[4];
  real_T tmp[4];
  real_T rtb_steering[3];
  real_T SA_fr;
  real_T SA_rl;
  real_T SA_rr;
  real_T V_fl_idx_1;
  real_T V_fl_idx_1_tmp;
  real_T V_rr_idx_0;
  real_T a_bar_tmp;
  real_T a_bar_tmp_0;
  real_T a_bar_tmp_1;
  real_T absxk;
  real_T absxk_tmp;
  real_T b_V_fl_tmp;
  real_T dzzdx;
  real_T kx_idx_0;
  real_T kx_idx_2;
  real_T kx_idx_3;
  real_T lb_adjust_idx_0;
  real_T lb_adjust_idx_2;
  real_T mu_x_0;
  real_T mu_y_idx_0;
  real_T mu_y_idx_1;
  real_T mu_y_idx_2;
  real_T rtb_Fx_max_idx_0;
  real_T rtb_Fx_max_idx_1;
  real_T rtb_Fx_max_idx_2;
  real_T rtb_Fx_max_idx_3;
  real_T rtb_Sum1;
  real_T scale;
  real_T signd1;
  real_T t;
  real_T v_cog;
  int32_T b_idx;
  int32_T hs;
  int32_T hs3;
  int32_T low_ip1;
  int32_T mid_i;
  real32_T T2F_aug_idx_0;
  real32_T T2F_aug_idx_1;
  real32_T T2F_aug_idx_2;
  real32_T T2F_aug_idx_3;
  real32_T Tx_idx_0;
  real32_T Tx_idx_1;
  real32_T Tx_idx_2;
  real32_T Tx_idx_3;
  real32_T lb_f;
  real32_T lb_f_idx_0;
  real32_T lb_f_idx_1;
  real32_T lb_f_idx_2;
  real32_T rtb_A_idx_0;
  real32_T rtb_A_idx_1;
  real32_T rtb_A_idx_2;
  real32_T rtb_A_idx_3;
  real32_T rtb_b;
  real32_T rtb_lb;
  real32_T rtb_lb_idx_0;
  real32_T rtb_lb_idx_1;
  real32_T rtb_lb_idx_2;
  real32_T rtb_lb_idx_3;
  real32_T rtb_ub;
  real32_T rtb_ub_idx_0;
  real32_T rtb_ub_idx_1;
  real32_T rtb_ub_idx_2;
  real32_T rtb_ub_idx_3;
  real32_T rtb_ub_neg_idx_0;
  real32_T rtb_ub_neg_idx_1;
  real32_T rtb_ub_neg_idx_2;
  real32_T signs_idx_0;
  real32_T signs_idx_1;
  real32_T signs_idx_2;
  real32_T signs_use_idx_0;
  real32_T signs_use_idx_1;
  real32_T signs_use_idx_2;
  real32_T signs_use_idx_3;
  real32_T ub_f_idx_0;
  real32_T ub_f_idx_1;
  real32_T z;
  int8_T h[9];
  int8_T h_0;
  boolean_T b_x[4];
  static const int8_T c_0[10] = { 0, 3, 6, 9, 12, 15, 18, 21, 25, 31 };

  static const real_T d_0[10] = { 1.34, 1.34, 1.34, 1.66, 1.14, 1.24, 0.754,
    0.849, 0.85, 0.85 };

  real_T V_fl_idx_1_tmp_0;
  boolean_T exitg1;

  /* MATLAB Function: '<S3>/Reference Generation' incorporates:
   *  Inport: '<Root>/Vg'
   *  Inport: '<Root>/steering_angle'
   *  MATLAB Function: '<S2>/Optimization '
   *  MATLAB Function: '<S3>/Tire Model'
   */
  scale = 3.3121686421112381E-170;
  lb_adjust_idx_2 = fabs(rtU.Vg[0]);
  if (lb_adjust_idx_2 > 3.3121686421112381E-170) {
    v_cog = 1.0;
    scale = lb_adjust_idx_2;
  } else {
    t = lb_adjust_idx_2 / 3.3121686421112381E-170;
    v_cog = t * t;
  }

  absxk_tmp = fabs(rtU.Vg[1]);
  if (absxk_tmp > scale) {
    t = scale / absxk_tmp;
    v_cog = v_cog * t * t + 1.0;
    scale = absxk_tmp;
  } else {
    t = absxk_tmp / scale;
    v_cog += t * t;
  }

  v_cog = scale * sqrt(v_cog);
  for (hs3 = 0; hs3 < 9; hs3++) {
    h_0 = (int8_T)(c_0[hs3 + 1] - c_0[hs3]);
    del[hs3] = (d_0[hs3 + 1] - d_0[hs3]) / (real_T)h_0;
    h[hs3] = h_0;
  }

  for (b_idx = 0; b_idx < 8; b_idx++) {
    low_ip1 = h[b_idx + 1];
    hs = low_ip1 + h[b_idx];
    hs3 = 3 * hs;
    dzzdx = (real_T)(h[b_idx] + hs) / (real_T)hs3;
    signd1 = (real_T)(low_ip1 + hs) / (real_T)hs3;
    c_s[b_idx + 1] = 0.0;
    if (del[b_idx] < 0.0) {
      SA_fr = del[b_idx + 1];
      if (SA_fr <= del[b_idx]) {
        c_s[b_idx + 1] = del[b_idx] / (del[b_idx] / SA_fr * dzzdx + signd1);
      } else if (SA_fr < 0.0) {
        c_s[b_idx + 1] = SA_fr / (SA_fr / del[b_idx] * signd1 + dzzdx);
      }
    } else if (del[b_idx] > 0.0) {
      scale = del[b_idx + 1];
      if (scale >= del[b_idx]) {
        c_s[b_idx + 1] = del[b_idx] / (del[b_idx] / scale * dzzdx + signd1);
      } else if (scale > 0.0) {
        c_s[b_idx + 1] = scale / (scale / del[b_idx] * signd1 + dzzdx);
      }
    }
  }

  dzzdx = ((real_T)((h[0] << 1) + h[1]) * del[0] - (real_T)h[0] * del[1]) /
    (real_T)(h[0] + h[1]);
  if (rtIsNaN(del[0])) {
    signd1 = del[0];
  } else if (del[0] < 0.0) {
    signd1 = -1.0;
  } else {
    signd1 = (del[0] > 0.0);
  }

  if (rtIsNaN(dzzdx)) {
    SA_fr = dzzdx;
  } else if (dzzdx < 0.0) {
    SA_fr = -1.0;
  } else {
    SA_fr = (dzzdx > 0.0);
  }

  if (SA_fr != signd1) {
    dzzdx = 0.0;
  } else {
    if (rtIsNaN(del[1])) {
      SA_fr = del[1];
    } else if (del[1] < 0.0) {
      SA_fr = -1.0;
    } else {
      SA_fr = (del[1] > 0.0);
    }

    if ((signd1 != SA_fr) && (fabs(dzzdx) > fabs(3.0 * del[0]))) {
      dzzdx = 3.0 * del[0];
    }
  }

  c_s[0] = dzzdx;
  dzzdx = ((real_T)((h[8] << 1) + h[7]) * del[8] - del[7] * (real_T)h[8]) /
    (real_T)(h[7] + h[8]);
  if (rtIsNaN(del[8])) {
    signd1 = del[8];
  } else if (del[8] < 0.0) {
    signd1 = -1.0;
  } else {
    signd1 = (del[8] > 0.0);
  }

  if (rtIsNaN(dzzdx)) {
    SA_fr = dzzdx;
  } else if (dzzdx < 0.0) {
    SA_fr = -1.0;
  } else {
    SA_fr = (dzzdx > 0.0);
  }

  if (SA_fr != signd1) {
    dzzdx = 0.0;
  } else {
    if (rtIsNaN(del[7])) {
      SA_fr = del[7];
    } else if (del[7] < 0.0) {
      SA_fr = -1.0;
    } else {
      SA_fr = (del[7] > 0.0);
    }

    if ((signd1 != SA_fr) && (fabs(dzzdx) > fabs(3.0 * del[8]))) {
      dzzdx = 3.0 * del[8];
    }
  }

  c_s[9] = dzzdx;
  for (b_idx = 0; b_idx < 9; b_idx++) {
    h_0 = h[b_idx];
    signd1 = del[b_idx];
    dzzdx = (signd1 - c_s[b_idx]) / (real_T)h_0;
    signd1 = (c_s[b_idx + 1] - signd1) / (real_T)h_0;
    pp_coefs[b_idx] = (signd1 - dzzdx) / (real_T)h_0;
    pp_coefs[b_idx + 9] = 2.0 * dzzdx - signd1;
    pp_coefs[b_idx + 18] = c_s[b_idx];
    pp_coefs[b_idx + 27] = d_0[b_idx];
  }

  if (rtIsNaN(v_cog)) {
    dzzdx = v_cog;
  } else {
    hs3 = 10;
    hs = 0;
    low_ip1 = 2;
    while (hs3 > low_ip1) {
      mid_i = ((hs + hs3) + 1) >> 1;
      if (v_cog >= c_0[mid_i - 1]) {
        hs = mid_i - 1;
        low_ip1 = mid_i + 1;
      } else {
        hs3 = mid_i;
      }
    }

    signd1 = v_cog - (real_T)c_0[hs];
    dzzdx = ((signd1 * pp_coefs[hs] + pp_coefs[hs + 9]) * signd1 + pp_coefs[hs +
             18]) * signd1 + pp_coefs[hs + 27];
  }

  v_cog = v_cog * rtU.steering_angle[0] / (v_cog * v_cog * Ku + 1.5751);
  if (v_cog == 0.0) {
    scale = 0.0;
  } else {
    signd1 = fabs(v_cog);
    V_fl_idx_1 = fabs(dzzdx);
    if (!rtIsNaN(v_cog)) {
      if (v_cog < 0.0) {
        v_cog = -1.0;
      } else {
        v_cog = (v_cog > 0.0);
      }
    }

    if (signd1 > V_fl_idx_1) {
      signd1 = V_fl_idx_1;
    } else if (rtIsNaN(signd1) && (!rtIsNaN(V_fl_idx_1))) {
      signd1 = V_fl_idx_1;
    }

    scale = v_cog * signd1;
  }

  /* End of MATLAB Function: '<S3>/Reference Generation' */

  /* MATLAB Function: '<S3>/Steering Model' incorporates:
   *  Inport: '<Root>/steering_angle'
   */
  dzzdx = 0.28194 * rtU.steering_angle[0];
  lb_adjust_idx_0 = (((dzzdx * dzzdx * S2 + S1 * rt_powd_snf(dzzdx, 3.0)) + S3 *
                      dzzdx) + S4) * deg2rad;
  rtb_steering[1] = -(((-dzzdx * -dzzdx * S2 + S1 * rt_powd_snf(-dzzdx, 3.0)) +
                       S3 * -dzzdx) + S4) * deg2rad;

  /* Sum: '<S8>/Sum1' incorporates:
   *  Inport: '<Root>/yaw'
   */
  rtb_Sum1 = scale - rtU.yaw;

  /* UnitDelay: '<S3>/Unit Delay4' */
  v_cog = rtDW.UnitDelay4_DSTATE;

  /* DiscreteIntegrator: '<S8>/Discrete-Time Integrator' incorporates:
   *  UnitDelay: '<S3>/Unit Delay4'
   */
  if ((rtDW.UnitDelay4_DSTATE <= 0.0) && (rtDW.DiscreteTimeIntegrator_PrevRese ==
       1)) {
    rtDW.DiscreteTimeIntegrator_DSTATE = 0.0;
  }

  /* DiscreteIntegrator: '<S8>/Discrete-Time Integrator' incorporates:
   *  Gain: '<S8>/I'
   *  Product: '<S8>/Product'
   *  UnitDelay: '<S3>/Unit Delay'
   */
  dzzdx = 15.0 * rtb_Sum1 * rtDW.UnitDelay_DSTATE * 0.015 +
    rtDW.DiscreteTimeIntegrator_DSTATE;

  /* DiscreteIntegrator: '<S8>/Discrete-Time Integrator2' incorporates:
   *  UnitDelay: '<S3>/Unit Delay4'
   */
  if ((rtDW.UnitDelay4_DSTATE <= 0.0) && (rtDW.DiscreteTimeIntegrator2_PrevRes ==
       1)) {
    rtDW.DiscreteTimeIntegrator2_DSTATE = 0.0;
  }

  /* DiscreteIntegrator: '<S8>/Discrete-Time Integrator2' incorporates:
   *  Gain: '<S8>/T'
   *  Inport: '<Root>/rdot'
   *  Product: '<S8>/Product1'
   *  Sum: '<S8>/Sum5'
   *  UnitDelay: '<S3>/Unit Delay'
   *  UnitDelay: '<S3>/Unit Delay1'
   */
  signd1 = (rtDW.UnitDelay1_DSTATE - rtU.rdot) * 0.0 * rtDW.UnitDelay_DSTATE *
    0.015 + rtDW.DiscreteTimeIntegrator2_DSTATE;

  /* Sum: '<S8>/Sum7' incorporates:
   *  Product: '<S8>/Product2'
   *  Sum: '<S8>/Sum'
   *  UnitDelay: '<S3>/Unit Delay4'
   */
  rtb_Sum1 = (rtb_Sum1 * rtDW.UnitDelay4_DSTATE + dzzdx) + signd1;

  /* MATLAB Function: '<S3>/Tire Model' incorporates:
   *  Inport: '<Root>/FZ'
   *  Inport: '<Root>/Vg'
   *  Inport: '<Root>/omega'
   *  Inport: '<Root>/yaw'
   *  MATLAB Function: '<S3>/Constraint Generation'
   *  MATLAB Function: '<S3>/Normal Force Model'
   *  MATLAB Function: '<S3>/Steering Model'
   */
  kx_idx_0 = rtU.yaw * 0.62102 + rtU.Vg[0];
  V_rr_idx_0 = rtU.yaw * -0.62102 + rtU.Vg[0];
  SA_rr = rtU.yaw * 0.7922471 + rtU.Vg[1];
  SA_rl = rtU.yaw * 0.647895 + rtU.Vg[0];
  absxk = sin(rtb_steering[1]);
  b_V_fl_tmp = cos(rtb_steering[1]);
  kx_idx_2 = SA_rr * -absxk + SA_rl * b_V_fl_tmp;
  V_fl_idx_1_tmp = sin(lb_adjust_idx_0);
  V_fl_idx_1_tmp_0 = cos(lb_adjust_idx_0);
  V_fl_idx_1 = (rtU.yaw * -0.647895 + rtU.Vg[0]) * V_fl_idx_1_tmp_0 + SA_rr *
    -V_fl_idx_1_tmp;
  if (lb_adjust_idx_2 > 2.0) {
    t = -rt_atan2d_snf(SA_rr, SA_rl) + rtb_steering[1];
    SA_fr = -rt_atan2d_snf(SA_rr, rtU.Vg[0] - 0.647895 * rtU.yaw) +
      lb_adjust_idx_0;
    SA_rr = rtU.Vg[1] - 0.7828529 * rtU.yaw;
    SA_rl = -rt_atan2d_snf(SA_rr, kx_idx_0);
    SA_rr = -rt_atan2d_snf(SA_rr, rtU.Vg[0] - 0.62102 * rtU.yaw);
  } else {
    t = 0.0;
    SA_fr = 0.0;
    SA_rl = 0.0;
    SA_rr = 0.0;
  }

  SA[0] = t;
  SA[1] = SA_fr;
  SA[2] = SA_rl;
  SA[3] = SA_rr;
  if (rtU.Vg[0] > 2.0) {
    t = RE * rtU.omega[0] / (kx_idx_2 * cos(t)) - 1.0;
    SA_fr = RE * rtU.omega[1] / (V_fl_idx_1 * cos(SA_fr)) - 1.0;
    SA_rl = RE * rtU.omega[2] / (kx_idx_0 * cos(SA_rl)) - 1.0;
    SA_rr = RE * rtU.omega[3] / (V_rr_idx_0 * cos(SA_rr)) - 1.0;
  } else {
    t = (RE * rtU.omega[0] - kx_idx_2) / (kx_idx_2 * kx_idx_2 / 2.0 + 2.0);
    SA_fr = (RE * rtU.omega[1] - V_fl_idx_1) / (V_fl_idx_1 * V_fl_idx_1 / 2.0 +
      2.0);
    SA_rl = (RE * rtU.omega[2] - kx_idx_0) / (kx_idx_0 * kx_idx_0 / 2.0 + 2.0);
    SA_rr = (RE * rtU.omega[3] - V_rr_idx_0) / (V_rr_idx_0 * V_rr_idx_0 / 2.0 +
      2.0);
  }

  SL[0] = t;
  SL[1] = SA_fr;
  SL[2] = SA_rl;
  SL[3] = SA_rr;
  kx_idx_0 = A1 * rtU.FZ[0] + A2;
  n_max[0] = fabs(rtU.FZ[0]);
  V_rr_idx_0 = A1 * rtU.FZ[1] + A2;
  n_max[1] = fabs(rtU.FZ[1]);
  kx_idx_2 = A1 * rtU.FZ[2] + A2;
  n_max[2] = fabs(rtU.FZ[2]);
  kx_idx_3 = A1 * rtU.FZ[3] + A2;
  n_max[3] = fabs(rtU.FZ[3]);
  pchip_j(n_max, C);
  power(rtU.FZ, n_max);
  mu_x_0 = (B1 * n_max[0] + B2 * rtU.FZ[0]) + B3;
  rtb_Fx_max_idx_3 = ((C1 * rt_powd_snf(rtU.FZ[0], 3.0) + C2 * n_max[0]) + C3 *
                      rtU.FZ[0]) + C4;
  V_fl_idx_1 = mu_x_0 * rtU.FZ[0];
  kx[0] = kx_idx_0 * t / V_fl_idx_1;
  mu_x[0] = mu_x_0;
  mu_y_idx_0 = rtb_Fx_max_idx_3;
  rtb_Fx_max_idx_0 = V_fl_idx_1;
  a_bar_tmp = tan(SA[0]);
  a_bar[0] = C[0] * a_bar_tmp / (rtb_Fx_max_idx_3 * rtU.FZ[0]);
  C[0] = C[0] * mu_x_0 / (kx_idx_0 * rtb_Fx_max_idx_3);
  mu_x_0 = (B1 * n_max[1] + B2 * rtU.FZ[1]) + B3;
  rtb_Fx_max_idx_3 = ((C1 * rt_powd_snf(rtU.FZ[1], 3.0) + C2 * n_max[1]) + C3 *
                      rtU.FZ[1]) + C4;
  V_fl_idx_1 = mu_x_0 * rtU.FZ[1];
  kx[1] = V_rr_idx_0 * SA_fr / V_fl_idx_1;
  mu_x[1] = mu_x_0;
  mu_y_idx_1 = rtb_Fx_max_idx_3;
  rtb_Fx_max_idx_1 = V_fl_idx_1;
  a_bar_tmp_0 = tan(SA[1]);
  a_bar[1] = C[1] * a_bar_tmp_0 / (rtb_Fx_max_idx_3 * rtU.FZ[1]);
  C[1] = C[1] * mu_x_0 / (V_rr_idx_0 * rtb_Fx_max_idx_3);
  mu_x_0 = (B1 * n_max[2] + B2 * rtU.FZ[2]) + B3;
  rtb_Fx_max_idx_3 = ((C1 * rt_powd_snf(rtU.FZ[2], 3.0) + C2 * n_max[2]) + C3 *
                      rtU.FZ[2]) + C4;
  V_fl_idx_1 = mu_x_0 * rtU.FZ[2];
  kx[2] = kx_idx_2 * SA_rl / V_fl_idx_1;
  mu_x[2] = mu_x_0;
  mu_y_idx_2 = rtb_Fx_max_idx_3;
  rtb_Fx_max_idx_2 = V_fl_idx_1;
  lb_adjust_idx_0 = tan(SA[2]);
  a_bar[2] = C[2] * lb_adjust_idx_0 / (rtb_Fx_max_idx_3 * rtU.FZ[2]);
  C[2] = C[2] * mu_x_0 / (kx_idx_2 * rtb_Fx_max_idx_3);
  mu_x_0 = (B1 * n_max[3] + B2 * rtU.FZ[3]) + B3;
  rtb_Fx_max_idx_3 = ((C1 * rt_powd_snf(rtU.FZ[3], 3.0) + C2 * n_max[3]) + C3 *
                      rtU.FZ[3]) + C4;
  V_fl_idx_1 = mu_x_0 * rtU.FZ[3];
  kx[3] = kx_idx_3 * SA_rr / V_fl_idx_1;
  a_bar_tmp_1 = tan(SA[3]);
  a_bar[3] = C[3] * a_bar_tmp_1 / (rtb_Fx_max_idx_3 * rtU.FZ[3]);
  C[3] = C[3] * mu_x_0 / (kx_idx_3 * rtb_Fx_max_idx_3);
  power(kx, tmp);
  power(a_bar, kx);
  rtb_FY[0] = 1.0;
  b_k[0] = sqrt(tmp[0] + kx[0]);
  rtb_FY[1] = 1.0;
  b_k[1] = sqrt(tmp[1] + kx[1]);
  rtb_FY[2] = 1.0;
  b_k[2] = sqrt(tmp[2] + kx[2]);
  rtb_FY[3] = 1.0;
  b_k[3] = sqrt(tmp[3] + kx[3]);
  b_idx = 0;
  for (hs = 0; hs < 4; hs++) {
    b_idx = hs;
    if (fabs(b_k[hs]) <= 6.2831853071795862) {
      rtb_FY[0] = (C[0] + 1.0) * 0.5 - cos(b_k[0] / 2.0) * 0.5 * (1.0 - C[0]);
      rtb_FY[1] = (C[1] + 1.0) * 0.5 - cos(b_k[1] / 2.0) * 0.5 * (1.0 - C[1]);
      rtb_FY[2] = (C[2] + 1.0) * 0.5 - cos(b_k[2] / 2.0) * 0.5 * (1.0 - C[2]);
      rtb_FY[3] = (C[3] + 1.0) * 0.5 - cos(b_k[3] / 2.0) * 0.5 * (1.0 - C[3]);
    }

    b_x[hs] = (SL[hs] == 0.0);
    R[hs] = exp(-0.03291 * b_k[hs]) * a + exp(d * b_k[hs]) * c;
  }

  hs = ((b_x[0] + b_x[1]) + b_x[2]) + b_x[3];
  if (((((SA[0] == 0.0) + (SA[1] == 0.0)) + (SA[2] == 0.0)) + (SA[3] == 0.0)) +
      hs == 8) {
    rtb_FY[0] = 0.0;
    rtb_FY[1] = 0.0;
    rtb_FY[2] = 0.0;
    rtb_FY[3] = 0.0;
  } else {
    n_max[0] = a_bar_tmp;
    n_max[1] = a_bar_tmp_0;
    n_max[2] = lb_adjust_idx_0;
    n_max[3] = a_bar_tmp_1;
    power(SL, tmp);
    power(rtb_FY, kx);
    power(n_max, SL);
    rtb_FY[0] = rtb_FY[0] * R[0] * a_bar_tmp * mu_y_idx_0 * rtU.FZ[0] / sqrt(kx
      [0] * SL[0] + tmp[0]);
    rtb_FY[1] = rtb_FY[1] * R[1] * a_bar_tmp_0 * mu_y_idx_1 * rtU.FZ[1] / sqrt
      (kx[1] * SL[1] + tmp[1]);
    rtb_FY[2] = rtb_FY[2] * R[2] * lb_adjust_idx_0 * mu_y_idx_2 * rtU.FZ[2] /
      sqrt(kx[2] * SL[2] + tmp[2]);
    rtb_FY[3] = rtb_FY[3] * R[3] * a_bar_tmp_1 * rtb_Fx_max_idx_3 * rtU.FZ[3] /
      sqrt(kx[3] * SL[3] + tmp[3]);
  }

  n_max[0] = 1.0;
  n_max[1] = 1.0;
  n_max[2] = 1.0;
  n_max[3] = 1.0;
  if (fabs(b_k[b_idx]) <= 6.2831853071795862) {
    n_max[0] = (C[0] + 1.0) * 0.5 - (1.0 - C[0]) * -0.07951282886348926;
    n_max[1] = (C[1] + 1.0) * 0.5 - (1.0 - C[1]) * -0.07951282886348926;
    n_max[2] = (C[2] + 1.0) * 0.5 - (1.0 - C[2]) * -0.07951282886348926;
    n_max[3] = (C[3] + 1.0) * 0.5 - (1.0 - C[3]) * -0.07951282886348926;
  }

  rtb_Fx_max_idx_3 = 0.0;
  if (fabs(a_bar[0]) < 3.461) {
    rtb_Fx_max_idx_3 = sqrt(11.978520999999999 - a_bar[0] * a_bar[0]);
  }

  R[0] = rtb_Fx_max_idx_3 * mu_x[0] * rtU.FZ[0] / kx_idx_0;
  SA[0] = a_bar_tmp;
  rtb_Fx_max_idx_3 = 0.0;
  if (fabs(a_bar[1]) < 3.461) {
    rtb_Fx_max_idx_3 = sqrt(11.978520999999999 - a_bar[1] * a_bar[1]);
  }

  R[1] = rtb_Fx_max_idx_3 * mu_x[1] * rtU.FZ[1] / V_rr_idx_0;
  SA[1] = tan(SA[1]);
  rtb_Fx_max_idx_3 = 0.0;
  if (fabs(a_bar[2]) < 3.461) {
    rtb_Fx_max_idx_3 = sqrt(11.978520999999999 - a_bar[2] * a_bar[2]);
  }

  R[2] = rtb_Fx_max_idx_3 * mu_x[2] * rtU.FZ[2] / kx_idx_2;
  SA[2] = tan(SA[2]);
  rtb_Fx_max_idx_3 = 0.0;
  if (fabs(a_bar[3]) < 3.461) {
    rtb_Fx_max_idx_3 = sqrt(11.978520999999999 - a_bar[3] * a_bar[3]);
  }

  R[3] = rtb_Fx_max_idx_3 * mu_x_0 * rtU.FZ[3] / kx_idx_3;
  SA[3] = tan(SA[3]);
  power(R, tmp);
  power(n_max, kx);
  power(SA, SL);
  rtb_Fx_max_idx_0 = rtb_Fx_max_idx_0 * 0.98467346545576384 * R[0] / sqrt(kx[0] *
    SL[0] + tmp[0]);
  rtb_Fx_max_idx_1 = rtb_Fx_max_idx_1 * 0.98467346545576384 * R[1] / sqrt(kx[1] *
    SL[1] + tmp[1]);
  rtb_Fx_max_idx_2 = rtb_Fx_max_idx_2 * 0.98467346545576384 * R[2] / sqrt(kx[2] *
    SL[2] + tmp[2]);
  rtb_Fx_max_idx_3 = V_fl_idx_1 * 0.98467346545576384 * R[3] / sqrt(kx[3] * SL[3]
    + tmp[3]);
  if ((fabs(SA_rl) > 0.3) + (fabs(SA_rr) > 0.3) > 0) {
    rtb_Fx_max_idx_2 = 500.0;
    rtb_Fx_max_idx_3 = 500.0;
  }

  if ((fabs(t) > 0.3) + (fabs(SA_fr) > 0.3) > 0) {
    rtb_Fx_max_idx_0 = 500.0;
    rtb_Fx_max_idx_1 = 500.0;
  }

  mu_x_0 = rtb_FY[0] * 0.7;

  /* MATLAB Function: '<S3>/Brake Model' */
  SA[0] = 0.0;

  /* MATLAB Function: '<S3>/Tire Model' */
  a_bar_tmp = rtb_FY[1] * 0.7;

  /* MATLAB Function: '<S3>/Brake Model' */
  SA[1] = 0.0;

  /* MATLAB Function: '<S3>/Tire Model' */
  mu_y_idx_0 = rtb_FY[2] * 0.7;

  /* MATLAB Function: '<S3>/Brake Model' */
  SA[2] = 0.0;

  /* MATLAB Function: '<S3>/Tire Model' */
  a_bar_tmp_0 = rtb_FY[3] * 0.7;

  /* MATLAB Function: '<S3>/Brake Model' incorporates:
   *  Inport: '<Root>/Vg'
   *  Inport: '<Root>/brake_pressure'
   */
  SA[3] = 0.0;
  if (lb_adjust_idx_2 > 5.0) {
    if (rtIsNaN(rtU.Vg[0])) {
      SA_rr = rtU.Vg[0];
    } else if (rtU.Vg[0] < 0.0) {
      SA_rr = -1.0;
    } else {
      SA_rr = (rtU.Vg[0] > 0.0);
    }

    SA[0] = 61.327819610128337 * SA_rr * rtU.brake_pressure[0];
    SA[1] = 61.327819610128337 * SA_rr * rtU.brake_pressure[1];
    SA[2] = 40.536598327799823 * SA_rr * rtU.brake_pressure[2];
    SA[3] = 40.536598327799823 * SA_rr * rtU.brake_pressure[3];
  }

  /* MATLAB Function: '<S3>/Constraint Generation' incorporates:
   *  Inport: '<Root>/Vg'
   *  Inport: '<Root>/driver_input'
   *  Inport: '<Root>/omega'
   *  Inport: '<Root>/power_limits'
   *  MATLAB Function: '<S3>/Tire Model'
   *  UnitDelay: '<S2>/Unit Delay2'
   *  UnitDelay: '<S3>/Unit Delay2'
   *  UnitDelay: '<S3>/Unit Delay3'
   */
  lb_adjust_idx_0 = 0.647895 * b_V_fl_tmp + 0.7922471 * absxk;
  kx_idx_3 = -0.647895 * V_fl_idx_1_tmp_0 + 0.7922471 * V_fl_idx_1_tmp;
  SL[0] = -0.647895 * absxk + 0.7922471 * b_V_fl_tmp;
  SL[1] = 0.647895 * V_fl_idx_1_tmp + 0.7922471 * V_fl_idx_1_tmp_0;
  if (rtU.driver_input <= 0.0) {
    if (rtU.power_limits[1] != 0.0) {
      SA_rr = -60000.0;
    } else {
      SA_rr = -1.0;
    }
  } else if (rtU.power_limits[0] < 75000.0) {
    SA_rr = rtU.power_limits[0];
  } else {
    SA_rr = 75000.0;
  }

  V_fl_idx_1 = rtb_Fx_max_idx_0 * 0.7 * 0.2228169203 / 6.63043;
  SA_rl = SA[0] / 6.63043;
  kx_idx_0 = V_fl_idx_1 - SA_rl;
  b_V_fl_tmp = -V_fl_idx_1 - SA_rl;
  V_fl_idx_1 = rtb_Fx_max_idx_1 * 0.7 * 0.2228169203 / 6.63043;
  SA_rl = SA[1] / 6.63043;
  V_rr_idx_0 = V_fl_idx_1 - SA_rl;
  V_fl_idx_1_tmp = -V_fl_idx_1 - SA_rl;
  V_fl_idx_1 = rtb_Fx_max_idx_2 * 0.7 * 0.2228169203 / 8.0;
  SA_rl = SA[2] / 8.0;
  kx_idx_2 = V_fl_idx_1 - SA_rl;
  rtb_Fx_max_idx_2 = -V_fl_idx_1 - SA_rl;
  V_fl_idx_1 = rtb_Fx_max_idx_3 * 0.7 * 0.2228169203 / 8.0;
  SA_rl = SA[3] / 8.0;
  rtb_Fx_max_idx_1 = V_fl_idx_1 - SA_rl;
  V_fl_idx_1 = -V_fl_idx_1 - SA_rl;
  for (b_idx = 0; b_idx < 4; b_idx++) {
    C[b_idx] = rtU.omega[b_idx] * rtConstP.ConstraintGeneration_gr[b_idx];
    SA[b_idx] = C[b_idx] / 10.4719755;
    SA[b_idx] = ceil(SA[b_idx]);
    SA[b_idx]++;
    absxk = pchip(rtConstP.ConstraintGeneration_max_rpm,
                  rtConstP.ConstraintGeneration_max_torque, C[b_idx]);
    if (C[b_idx] >= 0.0) {
      if (C[b_idx] <= 1110.029403) {
        if (absxk >= 0.0) {
          if (absxk <= 25.0) {
            hs3 = 107;
            hs = 0;
            low_ip1 = 2;
            while (hs3 > low_ip1) {
              mid_i = ((hs + hs3) + 1) >> 1;
              if (C[b_idx] >= rtConstP.ConstraintGeneration_rpm_sweep[mid_i - 1])
              {
                hs = mid_i - 1;
                low_ip1 = mid_i + 1;
              } else {
                hs3 = mid_i;
              }
            }

            hs3 = 251;
            low_ip1 = 1;
            mid_i = 2;
            while (hs3 > mid_i) {
              int32_T b_mid_i;
              b_mid_i = (low_ip1 + hs3) >> 1;
              if (absxk >= rtConstP.ConstraintGeneration_torque_swe[b_mid_i - 1])
              {
                low_ip1 = b_mid_i;
                mid_i = b_mid_i + 1;
              } else {
                hs3 = b_mid_i;
              }
            }

            if (C[b_idx] == rtConstP.ConstraintGeneration_rpm_sweep[hs]) {
              hs3 = 251 * hs + low_ip1;
              t = rtConstP.ConstraintGeneration_power_loss[hs3 - 1];
              SA_rl = rtConstP.ConstraintGeneration_power_loss[hs3];
            } else {
              SA_fr = rtConstP.ConstraintGeneration_rpm_sweep[hs + 1];
              if (SA_fr == C[b_idx]) {
                hs3 = (hs + 1) * 251 + low_ip1;
                t = rtConstP.ConstraintGeneration_power_loss[hs3 - 1];
                SA_rl = rtConstP.ConstraintGeneration_power_loss[hs3];
              } else {
                SA_rl = (C[b_idx] - rtConstP.ConstraintGeneration_rpm_sweep[hs])
                  / (SA_fr - rtConstP.ConstraintGeneration_rpm_sweep[hs]);
                SA_fr = rtConstP.ConstraintGeneration_power_loss[((hs + 1) * 251
                  + low_ip1) - 1];
                hs3 = (251 * hs + low_ip1) - 1;
                t = rtConstP.ConstraintGeneration_power_loss[hs3];
                if (SA_fr == t) {
                  t = rtConstP.ConstraintGeneration_power_loss[hs3];
                } else {
                  t = (1.0 - SA_rl) * t + SA_fr * SA_rl;
                }

                hs3 = (hs + 1) * 251 + low_ip1;
                hs = 251 * hs + low_ip1;
                if (rtConstP.ConstraintGeneration_power_loss[hs3] ==
                    rtConstP.ConstraintGeneration_power_loss[hs]) {
                  SA_rl = rtConstP.ConstraintGeneration_power_loss[hs];
                } else {
                  SA_rl = (1.0 - SA_rl) *
                    rtConstP.ConstraintGeneration_power_loss[hs] +
                    rtConstP.ConstraintGeneration_power_loss[hs3] * SA_rl;
                }
              }
            }

            SA_fr = rtConstP.ConstraintGeneration_torque_swe[low_ip1 - 1];
            if (SA_fr == absxk) {
              SA_rl = t;
            } else if (t == SA_rl) {
              SA_rl = t;
            } else if (!(absxk ==
                         rtConstP.ConstraintGeneration_torque_swe[low_ip1])) {
              SA_fr = (absxk - SA_fr) /
                (rtConstP.ConstraintGeneration_torque_swe[low_ip1] - SA_fr);
              SA_rl = (1.0 - SA_fr) * t + SA_fr * SA_rl;
            }
          } else {
            SA_rl = (rtNaN);
          }
        } else {
          SA_rl = (rtNaN);
        }
      } else {
        SA_rl = (rtNaN);
      }
    } else {
      SA_rl = (rtNaN);
    }

    if ((0.95 * SA_rl > rtConstP.ConstraintGeneration_power_lo_g[b_idx]) ||
        (SA_rr < 0.0)) {
      low_ip1 = (int32_T)SA[b_idx];
      SA_fr = rtConstP.ConstraintGeneration_power_lo_g[b_idx];
      hs = (int32_T)(SA[b_idx] + 1.0);
      t = rtConstP.ConstraintGeneration_power_lo_g[b_idx];
      for (hs3 = 0; hs3 < 251; hs3++) {
        varargin_1[hs3] = fabs(rtConstP.ConstraintGeneration_power_loss[(low_ip1
          - 1) * 251 + hs3] - SA_fr);
        c_x[hs3] = rtConstP.ConstraintGeneration_power_loss[(hs - 1) * 251 + hs3]
          - t;
      }

      minimum(varargin_1, &absxk, &hs);
      for (hs3 = 0; hs3 < 251; hs3++) {
        varargin_1[hs3] = fabs(c_x[hs3]);
      }

      minimum(varargin_1, &absxk, &hs3);
      mu_x[b_idx] = (rtConstP.ConstraintGeneration_torque_swe[hs - 1] +
                     rtConstP.ConstraintGeneration_torque_swe[hs3 - 1]) / 2.0;
    } else {
      mu_x[b_idx] = absxk;
    }
  }

  SA_rl = rtDW.UnitDelay2_DSTATE[0] * 0.0;
  rtb_steering[2] = SA_rl + 25.0;
  if (rtIsNaN(SA_rl + 0.01) || (!rtIsNaN(SA_rl + 25.0))) {
  } else {
    rtb_steering[2] = SA_rl + 0.01;
  }

  SA[0] = SA_rl;
  SA_rl = rtDW.UnitDelay2_DSTATE[1] * 0.0;
  mu_y_idx_1 = SA_rl + 25.0;
  if (rtIsNaN(SA_rl + 0.01) || (!rtIsNaN(SA_rl + 25.0))) {
  } else {
    mu_y_idx_1 = SA_rl + 0.01;
  }

  SA[1] = SA_rl;
  SA_rl = rtDW.UnitDelay2_DSTATE[2] * 0.0;
  mu_y_idx_2 = SA_rl + 25.0;
  if (rtIsNaN(SA_rl + 0.01) || (!rtIsNaN(SA_rl + 25.0))) {
  } else {
    mu_y_idx_2 = SA_rl + 0.01;
  }

  SA[2] = SA_rl;
  SA_rl = rtDW.UnitDelay2_DSTATE[3] * 0.0;
  rtb_Fx_max_idx_3 = SA_rl + 25.0;
  if (rtIsNaN(SA_rl + 0.01) || (!rtIsNaN(SA_rl + 25.0))) {
  } else {
    rtb_Fx_max_idx_3 = SA_rl + 0.01;
  }

  t_0[0] = SA[0] + -25.0;
  t_0[1] = SA[0] - 0.01;
  t_0[2] = SA[1] + -25.0;
  t_0[3] = SA[1] - 0.01;
  t_0[4] = SA[2] + -25.0;
  t_0[5] = SA[2] - 0.01;
  t_0[6] = SA_rl + -25.0;
  t_0[7] = SA_rl - 0.01;
  minimum_l(t_0, SA);
  rtb_steering[0] = kx_idx_0;
  rtb_steering[1] = mu_x[0];
  if (!rtIsNaN(kx_idx_0)) {
    hs3 = 1;
  } else {
    hs3 = 0;
    b_idx = 2;
    exitg1 = false;
    while ((!exitg1) && (b_idx < 4)) {
      if (!rtIsNaN(rtb_steering[b_idx - 1])) {
        hs3 = b_idx;
        exitg1 = true;
      } else {
        b_idx++;
      }
    }
  }

  if (hs3 == 0) {
    absxk = kx_idx_0;
  } else {
    absxk = rtb_steering[hs3 - 1];
    while (hs3 + 1 <= 3) {
      if (absxk > rtb_steering[hs3]) {
        absxk = rtb_steering[hs3];
      }

      hs3++;
    }
  }

  rtb_ub_idx_0 = (real32_T)absxk;
  rtb_steering[0] = b_V_fl_tmp;
  rtb_steering[1] = -mu_x[0];
  rtb_steering[2] = SA[0];
  if (!rtIsNaN(b_V_fl_tmp)) {
    b_idx = 1;
  } else {
    b_idx = 0;
    hs3 = 2;
    exitg1 = false;
    while ((!exitg1) && (hs3 < 4)) {
      if (!rtIsNaN(rtb_steering[hs3 - 1])) {
        b_idx = hs3;
        exitg1 = true;
      } else {
        hs3++;
      }
    }
  }

  if (b_idx == 0) {
    absxk = b_V_fl_tmp;
  } else {
    absxk = rtb_steering[b_idx - 1];
    while (b_idx + 1 <= 3) {
      if (absxk < rtb_steering[b_idx]) {
        absxk = rtb_steering[b_idx];
      }

      b_idx++;
    }
  }

  rtb_lb_idx_0 = (real32_T)absxk;
  if ((real32_T)absxk > 0.0F) {
    rtb_lb_idx_0 = -0.1F;
  } else if ((real32_T)absxk < -25.0F) {
    rtb_lb_idx_0 = -25.0F;
  }

  if (rtb_ub_idx_0 < 0.0F) {
    rtb_ub_idx_0 = 0.1F;
  } else if (rtb_ub_idx_0 > 25.0F) {
    rtb_ub_idx_0 = 25.0F;
  }

  rtb_steering[0] = V_rr_idx_0;
  rtb_steering[1] = mu_x[1];
  rtb_steering[2] = mu_y_idx_1;
  if (!rtIsNaN(V_rr_idx_0)) {
    hs3 = 1;
  } else {
    hs3 = 0;
    b_idx = 2;
    exitg1 = false;
    while ((!exitg1) && (b_idx < 4)) {
      if (!rtIsNaN(rtb_steering[b_idx - 1])) {
        hs3 = b_idx;
        exitg1 = true;
      } else {
        b_idx++;
      }
    }
  }

  if (hs3 == 0) {
    absxk = V_rr_idx_0;
  } else {
    absxk = rtb_steering[hs3 - 1];
    while (hs3 + 1 <= 3) {
      if (absxk > rtb_steering[hs3]) {
        absxk = rtb_steering[hs3];
      }

      hs3++;
    }
  }

  rtb_ub_idx_1 = (real32_T)absxk;
  rtb_steering[0] = V_fl_idx_1_tmp;
  rtb_steering[1] = -mu_x[1];
  rtb_steering[2] = SA[1];
  if (!rtIsNaN(V_fl_idx_1_tmp)) {
    b_idx = 1;
  } else {
    b_idx = 0;
    hs3 = 2;
    exitg1 = false;
    while ((!exitg1) && (hs3 < 4)) {
      if (!rtIsNaN(rtb_steering[hs3 - 1])) {
        b_idx = hs3;
        exitg1 = true;
      } else {
        hs3++;
      }
    }
  }

  if (b_idx == 0) {
    absxk = V_fl_idx_1_tmp;
  } else {
    absxk = rtb_steering[b_idx - 1];
    while (b_idx + 1 <= 3) {
      if (absxk < rtb_steering[b_idx]) {
        absxk = rtb_steering[b_idx];
      }

      b_idx++;
    }
  }

  rtb_lb_idx_1 = (real32_T)absxk;
  if ((real32_T)absxk > 0.0F) {
    rtb_lb_idx_1 = -0.1F;
  } else if ((real32_T)absxk < -25.0F) {
    rtb_lb_idx_1 = -25.0F;
  }

  if (rtb_ub_idx_1 < 0.0F) {
    rtb_ub_idx_1 = 0.1F;
  } else if (rtb_ub_idx_1 > 25.0F) {
    rtb_ub_idx_1 = 25.0F;
  }

  rtb_steering[0] = kx_idx_2;
  rtb_steering[1] = mu_x[2];
  rtb_steering[2] = mu_y_idx_2;
  if (!rtIsNaN(kx_idx_2)) {
    hs3 = 1;
  } else {
    hs3 = 0;
    b_idx = 2;
    exitg1 = false;
    while ((!exitg1) && (b_idx < 4)) {
      if (!rtIsNaN(rtb_steering[b_idx - 1])) {
        hs3 = b_idx;
        exitg1 = true;
      } else {
        b_idx++;
      }
    }
  }

  if (hs3 == 0) {
    absxk = kx_idx_2;
  } else {
    absxk = rtb_steering[hs3 - 1];
    while (hs3 + 1 <= 3) {
      if (absxk > rtb_steering[hs3]) {
        absxk = rtb_steering[hs3];
      }

      hs3++;
    }
  }

  rtb_ub_idx_2 = (real32_T)absxk;
  rtb_steering[0] = rtb_Fx_max_idx_2;
  rtb_steering[1] = -mu_x[2];
  rtb_steering[2] = SA[2];
  if (!rtIsNaN(rtb_Fx_max_idx_2)) {
    b_idx = 1;
  } else {
    b_idx = 0;
    hs3 = 2;
    exitg1 = false;
    while ((!exitg1) && (hs3 < 4)) {
      if (!rtIsNaN(rtb_steering[hs3 - 1])) {
        b_idx = hs3;
        exitg1 = true;
      } else {
        hs3++;
      }
    }
  }

  if (b_idx == 0) {
    absxk = rtb_Fx_max_idx_2;
  } else {
    absxk = rtb_steering[b_idx - 1];
    while (b_idx + 1 <= 3) {
      if (absxk < rtb_steering[b_idx]) {
        absxk = rtb_steering[b_idx];
      }

      b_idx++;
    }
  }

  rtb_lb_idx_2 = (real32_T)absxk;
  if ((real32_T)absxk > 0.0F) {
    rtb_lb_idx_2 = -0.1F;
  } else if ((real32_T)absxk < -25.0F) {
    rtb_lb_idx_2 = -25.0F;
  }

  if (rtb_ub_idx_2 < 0.0F) {
    rtb_ub_idx_2 = 0.1F;
  } else if (rtb_ub_idx_2 > 25.0F) {
    rtb_ub_idx_2 = 25.0F;
  }

  rtb_steering[0] = rtb_Fx_max_idx_1;
  rtb_steering[1] = mu_x[3];
  rtb_steering[2] = rtb_Fx_max_idx_3;
  if (!rtIsNaN(rtb_Fx_max_idx_1)) {
    hs3 = 1;
  } else {
    hs3 = 0;
    b_idx = 2;
    exitg1 = false;
    while ((!exitg1) && (b_idx < 4)) {
      if (!rtIsNaN(rtb_steering[b_idx - 1])) {
        hs3 = b_idx;
        exitg1 = true;
      } else {
        b_idx++;
      }
    }
  }

  if (hs3 == 0) {
    absxk = rtb_Fx_max_idx_1;
  } else {
    absxk = rtb_steering[hs3 - 1];
    while (hs3 + 1 <= 3) {
      if (absxk > rtb_steering[hs3]) {
        absxk = rtb_steering[hs3];
      }

      hs3++;
    }
  }

  rtb_ub_idx_3 = (real32_T)absxk;
  rtb_steering[0] = V_fl_idx_1;
  rtb_steering[1] = -mu_x[3];
  rtb_steering[2] = SA[3];
  if (!rtIsNaN(V_fl_idx_1)) {
    b_idx = 1;
  } else {
    b_idx = 0;
    hs3 = 2;
    exitg1 = false;
    while ((!exitg1) && (hs3 < 4)) {
      if (!rtIsNaN(rtb_steering[hs3 - 1])) {
        b_idx = hs3;
        exitg1 = true;
      } else {
        hs3++;
      }
    }
  }

  if (b_idx == 0) {
    absxk = V_fl_idx_1;
  } else {
    absxk = rtb_steering[b_idx - 1];
    while (b_idx + 1 <= 3) {
      if (absxk < rtb_steering[b_idx]) {
        absxk = rtb_steering[b_idx];
      }

      b_idx++;
    }
  }

  rtb_lb_idx_3 = (real32_T)absxk;
  if ((real32_T)absxk > 0.0F) {
    rtb_lb_idx_3 = -0.1F;
  } else if ((real32_T)absxk < -25.0F) {
    rtb_lb_idx_3 = -25.0F;
  }

  if (rtb_ub_idx_3 < 0.0F) {
    rtb_ub_idx_3 = 0.1F;
  } else if (rtb_ub_idx_3 > 25.0F) {
    rtb_ub_idx_3 = 25.0F;
  }

  if (rtU.Vg[0] < 1.4) {
    rtb_lb_idx_0 = 0.001F;
    rtb_lb_idx_1 = 0.001F;
    rtb_lb_idx_2 = 0.001F;
    rtb_lb_idx_3 = 0.001F;
  }

  rtb_b = (real32_T)(rtU.driver_input * SA_rr);
  rtb_A_idx_0 = (real32_T)(C[0] / 0.9);
  SA_rl = SL[0] * mu_x_0;
  SA[0] = SA_rl;
  rtb_A_idx_1 = (real32_T)(C[1] / 0.9);
  t = SL[1] * a_bar_tmp;
  SA[1] = t;
  rtb_A_idx_2 = (real32_T)(C[2] / 0.9);
  SA[2] = -0.7828529 * mu_y_idx_0;
  rtb_A_idx_3 = (real32_T)(C[3] / 0.9);
  SA[3] = -0.7828529 * a_bar_tmp_0;
  absxk = sum(SA);
  z = ((((rtb_ub_idx_0 * 4.385F * 6.63043F * (real32_T)lb_adjust_idx_0 +
          rtb_ub_idx_2 * 4.385F * 8.0F * 0.62102F) + rtb_lb_idx_1 * 4.385F *
         6.63043F * (real32_T)kx_idx_3) + rtb_lb_idx_3 * 4.385F * 8.0F *
        -0.62102F) + (real32_T)absxk) / 75.0F;
  SA[0] = SA_rl;
  SA[1] = t;
  SA[2] = -0.7828529 * mu_y_idx_0;
  SA[3] = -0.7828529 * a_bar_tmp_0;
  Tx_idx_0 = ((((rtb_ub_idx_1 * 4.385F * 6.63043F * (real32_T)kx_idx_3 +
                 rtb_ub_idx_3 * 4.385F * 8.0F * -0.62102F) + rtb_lb_idx_0 *
                4.385F * 6.63043F * (real32_T)lb_adjust_idx_0) + rtb_lb_idx_2 *
               4.385F * 8.0F * 0.62102F) + (real32_T)sum(SA)) / 75.0F;
  if (rtb_Sum1 >= z) {
    rtb_Sum1 = z;

    /* Update for UnitDelay: '<S3>/Unit Delay' */
    rtDW.UnitDelay_DSTATE = 0.0;
  } else if (rtb_Sum1 <= Tx_idx_0) {
    rtb_Sum1 = Tx_idx_0;

    /* Update for UnitDelay: '<S3>/Unit Delay' */
    rtDW.UnitDelay_DSTATE = 0.0;
  } else {
    /* Update for UnitDelay: '<S3>/Unit Delay' */
    rtDW.UnitDelay_DSTATE = 1.0;
  }

  if (norm(rtU.Vg) < 0.5) {
    rtb_Sum1 = absxk / 75.0;
  } else if (scale == 0.0) {
    rtb_Sum1 = absxk / 75.0;
  }

  ub_f_idx_0 = (real32_T)(0.013333333333333334 * lb_adjust_idx_0) * 4.385F *
    6.63043F;
  C[0] = 0.013333333333333334 * SL[0] * mu_x_0;
  ub_f_idx_1 = (real32_T)(0.013333333333333334 * kx_idx_3) * 4.385F * 6.63043F;
  C[1] = 0.013333333333333334 * SL[1] * a_bar_tmp;
  C[2] = -0.010438038666666666 * mu_y_idx_0;
  C[3] = -0.010438038666666666 * a_bar_tmp_0;
  z = (real32_T)(rtb_Sum1 - sum(C));
  if (fabsf(z) < 0.0001) {
    z = 1.0E-7F;
  }

  if (rtIsNaN(rtDW.UnitDelay3_DSTATE)) {
    SA_fr = rtDW.UnitDelay3_DSTATE;
  } else if (rtDW.UnitDelay3_DSTATE < 0.0) {
    SA_fr = -1.0;
  } else {
    SA_fr = (rtDW.UnitDelay3_DSTATE > 0.0);
  }

  if (rtIsNaN(SA_rr)) {
    t = SA_rr;
  } else if (SA_rr < 0.0) {
    t = -1.0;
  } else {
    t = (SA_rr > 0.0);
  }

  if (SA_fr != t) {
    /* Update for UnitDelay: '<S3>/Unit Delay4' */
    rtDW.UnitDelay4_DSTATE = 0.0;
  } else if (rtDW.UnitDelay2_DSTATE_a[0] < 0.5) {
    /* Update for UnitDelay: '<S3>/Unit Delay4' */
    rtDW.UnitDelay4_DSTATE = !(rtU.Vg[0] >= 0.5);
  } else {
    /* Update for UnitDelay: '<S3>/Unit Delay4' */
    rtDW.UnitDelay4_DSTATE = 1.0;
  }

  /* MATLAB Function: '<S2>/Optimization ' incorporates:
   *  UnitDelay: '<S2>/Unit Delay2'
   */
  scale = 3.3121686421112381E-170;
  if (lb_adjust_idx_2 > 3.3121686421112381E-170) {
    SA_rl = 1.0;
    scale = lb_adjust_idx_2;
  } else {
    t = lb_adjust_idx_2 / 3.3121686421112381E-170;
    SA_rl = t * t;
  }

  if (absxk_tmp > scale) {
    t = scale / absxk_tmp;
    SA_rl = SA_rl * t * t + 1.0;
    scale = absxk_tmp;
  } else {
    t = absxk_tmp / scale;
    SA_rl += t * t;
  }

  SA_rl = scale * sqrt(SA_rl);
  hs = 0;
  rtb_ub = rtb_ub_idx_0;
  rtb_lb = rtb_lb_idx_0;
  lb_f = rtb_lb_idx_0;
  rtb_ub_neg_idx_0 = rtb_ub_idx_0;
  rtb_Fx_max_idx_0 = 0.0;
  if ((rtb_lb_idx_0 < 0.0F) && (rtb_ub_idx_0 > 0.0F)) {
    hs = 1;
    rtb_Fx_max_idx_0 = 1.0;
    if (rtIsNaN(rtDW.UnitDelay2_DSTATE[0])) {
      absxk = rtDW.UnitDelay2_DSTATE[0];
    } else if (rtDW.UnitDelay2_DSTATE[0] < 0.0) {
      absxk = -1.0;
    } else {
      absxk = (rtDW.UnitDelay2_DSTATE[0] > 0.0);
    }

    if (absxk > 0.0) {
      lb_f = 0.001F;
    } else if (absxk < 0.0) {
      rtb_ub_neg_idx_0 = -0.001F;
    }
  } else if (fabsf(rtb_ub_idx_0 - rtb_lb_idx_0) < 0.5F) {
    rtb_ub_neg_idx_0 = -0.001F;
    lb_f = -10.0F;
    rtb_lb = -0.002F;
    rtb_ub = 0.002F;
  }

  Tx_idx_0 = 0.0F;
  rtb_lb_idx_0 = rtb_lb;
  lb_f_idx_0 = lb_f;

  /* MATLAB Function: '<S2>/Optimization ' incorporates:
   *  UnitDelay: '<S2>/Unit Delay2'
   */
  rtb_ub_idx_0 = rtb_ub;
  if (rtIsNaNF(lb_f)) {
    signs_idx_0 = lb_f;
  } else if (lb_f < 0.0F) {
    signs_idx_0 = -1.0F;
  } else {
    signs_idx_0 = (real32_T)(lb_f > 0.0F);
  }

  rtb_ub = rtb_ub_idx_1;
  rtb_lb = rtb_lb_idx_1;
  lb_f = rtb_lb_idx_1;
  rtb_ub_neg_idx_1 = rtb_ub_idx_1;
  rtb_Fx_max_idx_1 = 0.0;
  if ((rtb_lb_idx_1 < 0.0F) && (rtb_ub_idx_1 > 0.0F)) {
    hs = 1;
    rtb_Fx_max_idx_1 = 2.0;
    if (rtIsNaN(rtDW.UnitDelay2_DSTATE[1])) {
      absxk = rtDW.UnitDelay2_DSTATE[1];
    } else if (rtDW.UnitDelay2_DSTATE[1] < 0.0) {
      absxk = -1.0;
    } else {
      absxk = (rtDW.UnitDelay2_DSTATE[1] > 0.0);
    }

    if (absxk > 0.0) {
      lb_f = 0.001F;
    } else if (absxk < 0.0) {
      rtb_ub_neg_idx_1 = -0.001F;
    }
  } else if (fabsf(rtb_ub_idx_1 - rtb_lb_idx_1) < 0.5F) {
    rtb_ub_neg_idx_1 = -0.001F;
    lb_f = -10.0F;
    rtb_lb = -0.002F;
    rtb_ub = 0.002F;
  }

  Tx_idx_1 = 0.0F;
  rtb_lb_idx_1 = rtb_lb;
  lb_f_idx_1 = lb_f;

  /* MATLAB Function: '<S2>/Optimization ' incorporates:
   *  UnitDelay: '<S2>/Unit Delay2'
   */
  rtb_ub_idx_1 = rtb_ub;
  if (rtIsNaNF(lb_f)) {
    signs_idx_1 = lb_f;
  } else if (lb_f < 0.0F) {
    signs_idx_1 = -1.0F;
  } else {
    signs_idx_1 = (real32_T)(lb_f > 0.0F);
  }

  rtb_ub = rtb_ub_idx_2;
  rtb_lb = rtb_lb_idx_2;
  lb_f = rtb_lb_idx_2;
  rtb_ub_neg_idx_2 = rtb_ub_idx_2;
  rtb_Fx_max_idx_2 = 0.0;
  if ((rtb_lb_idx_2 < 0.0F) && (rtb_ub_idx_2 > 0.0F)) {
    hs = 1;
    rtb_Fx_max_idx_2 = 3.0;
    if (rtIsNaN(rtDW.UnitDelay2_DSTATE[2])) {
      absxk = rtDW.UnitDelay2_DSTATE[2];
    } else if (rtDW.UnitDelay2_DSTATE[2] < 0.0) {
      absxk = -1.0;
    } else {
      absxk = (rtDW.UnitDelay2_DSTATE[2] > 0.0);
    }

    if (absxk > 0.0) {
      lb_f = 0.001F;
    } else if (absxk < 0.0) {
      rtb_ub_neg_idx_2 = -0.001F;
    }
  } else if (fabsf(rtb_ub_idx_2 - rtb_lb_idx_2) < 0.5F) {
    rtb_ub_neg_idx_2 = -0.001F;
    lb_f = -10.0F;
    rtb_lb = -0.002F;
    rtb_ub = 0.002F;
  }

  Tx_idx_2 = 0.0F;
  rtb_lb_idx_2 = rtb_lb;
  lb_f_idx_2 = lb_f;

  /* MATLAB Function: '<S2>/Optimization ' incorporates:
   *  Inport: '<Root>/Vg'
   *  Inport: '<Root>/driver_input'
   *  MATLAB Function: '<S3>/Constraint Generation'
   *  UnitDelay: '<S2>/Unit Delay2'
   */
  rtb_ub_idx_2 = rtb_ub;
  if (rtIsNaNF(lb_f)) {
    signs_idx_2 = lb_f;
  } else if (lb_f < 0.0F) {
    signs_idx_2 = -1.0F;
  } else {
    signs_idx_2 = (real32_T)(lb_f > 0.0F);
  }

  rtb_ub = rtb_ub_idx_3;
  rtb_lb = rtb_lb_idx_3;
  lb_f = rtb_lb_idx_3;
  rtb_Fx_max_idx_3 = 0.0;
  if ((rtb_lb_idx_3 < 0.0F) && (rtb_ub_idx_3 > 0.0F)) {
    hs = 1;
    rtb_Fx_max_idx_3 = 4.0;
    if (rtIsNaN(rtDW.UnitDelay2_DSTATE[3])) {
      absxk = rtDW.UnitDelay2_DSTATE[3];
    } else if (rtDW.UnitDelay2_DSTATE[3] < 0.0) {
      absxk = -1.0;
    } else {
      absxk = (rtDW.UnitDelay2_DSTATE[3] > 0.0);
    }

    if (absxk > 0.0) {
      lb_f = 0.001F;
    } else if (absxk < 0.0) {
      rtb_ub_idx_3 = -0.001F;
    }
  } else if (fabsf(rtb_ub_idx_3 - rtb_lb_idx_3) < 0.5F) {
    rtb_ub_idx_3 = -0.001F;
    lb_f = -10.0F;
    rtb_lb = -0.002F;
    rtb_ub = 0.002F;
  }

  if (rtIsNaNF(lb_f)) {
    rtb_lb_idx_3 = lb_f;
  } else if (lb_f < 0.0F) {
    rtb_lb_idx_3 = -1.0F;
  } else {
    rtb_lb_idx_3 = (real32_T)(lb_f > 0.0F);
  }

  Tx_idx_3 = 0.0F;
  if (rtU.driver_input < 0.0) {
    T2F_aug_idx_0 = -29.0744381F;
    rtb_A_idx_0 = -rtb_A_idx_0;
    T2F_aug_idx_1 = -29.0744381F;
    rtb_A_idx_1 = -rtb_A_idx_1;
    T2F_aug_idx_2 = -35.08F;
    rtb_A_idx_2 = -rtb_A_idx_2;
    T2F_aug_idx_3 = -35.08F;
    rtb_A_idx_3 = -rtb_A_idx_3;
  } else {
    T2F_aug_idx_0 = 29.0744381F;
    T2F_aug_idx_1 = 29.0744381F;
    T2F_aug_idx_2 = 35.08F;
    T2F_aug_idx_3 = 35.08F;
  }

  if (SA_rl < 1.4) {
    signs_use_idx_0 = fabsf(signs_idx_0);
    signs_use_idx_1 = fabsf(signs_idx_1);
    signs_use_idx_2 = fabsf(signs_idx_2);
    signs_use_idx_3 = fabsf(rtb_lb_idx_3);
  } else if (35.0 - rtU.Vg[0] < 1.0) {
    signs_use_idx_0 = fabsf(signs_idx_0);
    signs_use_idx_1 = fabsf(signs_idx_1);
    signs_use_idx_2 = fabsf(signs_idx_2);
    signs_use_idx_3 = fabsf(rtb_lb_idx_3);
  } else {
    signs_use_idx_0 = signs_idx_0;
    signs_use_idx_1 = signs_idx_1;
    signs_use_idx_2 = signs_idx_2;
    signs_use_idx_3 = rtb_lb_idx_3;
  }

  if ((!(SA_rl < 1.4)) || (!(rtU.driver_input < 0.0))) {
    if ((hs == 1) && (SA_rl > 0.3)) {
      Tx_idx_0 = 0.0F;
      Tx_idx_1 = 0.0F;
      Tx_idx_2 = 0.0F;
      Tx_idx_3 = 0.0F;
      bigM_func(T2F_aug_idx_0, T2F_aug_idx_1, T2F_aug_idx_2, T2F_aug_idx_3,
                rtb_b, rtb_A_idx_0, rtb_A_idx_1, rtb_A_idx_2, rtb_A_idx_3, z,
                ub_f_idx_0, ub_f_idx_1, 0.290471792F, -0.290471792F, lb_f_idx_0,
                lb_f_idx_1, lb_f_idx_2, lb_f, rtb_ub_neg_idx_0, rtb_ub_neg_idx_1,
                rtb_ub_neg_idx_2, rtb_ub_idx_3, &Tx_idx_0, &Tx_idx_1, &Tx_idx_2,
                &Tx_idx_3, signs_use_idx_0, signs_use_idx_1, signs_use_idx_2,
                signs_use_idx_3, 0.2);
      absxk = fabs(Tx_idx_0);
      if ((absxk < 0.002) && (absxk >= 0.001) && (rtb_Fx_max_idx_0 > 0.0)) {
        if (signs_idx_0 > 0.0F) {
          absxk_tmp = rtb_lb_idx_0;
          SA[0] = -lb_f_idx_0;
        } else {
          absxk_tmp = -rtb_ub_neg_idx_0;
          SA[0] = rtb_ub_idx_0;
        }
      } else if (rtb_Fx_max_idx_0 > 0.0) {
        absxk_tmp = lb_f_idx_0;
        SA[0] = rtb_ub_neg_idx_0;
      } else {
        absxk_tmp = rtb_lb_idx_0;
        SA[0] = rtb_ub_idx_0;
      }

      if (rtIsNaN(absxk_tmp)) {
        rtb_Fx_max_idx_0 = absxk_tmp;
      } else if (absxk_tmp < 0.0) {
        rtb_Fx_max_idx_0 = -1.0;
      } else {
        rtb_Fx_max_idx_0 = (absxk_tmp > 0.0);
      }

      lb_adjust_idx_0 = absxk_tmp;
      absxk = fabs(Tx_idx_1);
      if ((absxk < 0.002) && (absxk >= 0.001) && (rtb_Fx_max_idx_1 > 0.0)) {
        if (signs_idx_1 > 0.0F) {
          absxk_tmp = rtb_lb_idx_1;
          SA[1] = -lb_f_idx_1;
        } else {
          absxk_tmp = -rtb_ub_neg_idx_1;
          SA[1] = rtb_ub_idx_1;
        }
      } else if (rtb_Fx_max_idx_1 > 0.0) {
        absxk_tmp = lb_f_idx_1;
        SA[1] = rtb_ub_neg_idx_1;
      } else {
        absxk_tmp = rtb_lb_idx_1;
        SA[1] = rtb_ub_idx_1;
      }

      if (rtIsNaN(absxk_tmp)) {
        rtb_Fx_max_idx_1 = absxk_tmp;
      } else if (absxk_tmp < 0.0) {
        rtb_Fx_max_idx_1 = -1.0;
      } else {
        rtb_Fx_max_idx_1 = (absxk_tmp > 0.0);
      }

      kx_idx_3 = absxk_tmp;
      absxk = fabs(Tx_idx_2);
      if ((absxk < 0.002) && (absxk >= 0.001) && (rtb_Fx_max_idx_2 > 0.0)) {
        if (signs_idx_2 > 0.0F) {
          absxk_tmp = rtb_lb_idx_2;
          SA[2] = -lb_f_idx_2;
        } else {
          absxk_tmp = -rtb_ub_neg_idx_2;
          SA[2] = rtb_ub_idx_2;
        }
      } else if (rtb_Fx_max_idx_2 > 0.0) {
        absxk_tmp = lb_f_idx_2;
        SA[2] = rtb_ub_neg_idx_2;
      } else {
        absxk_tmp = rtb_lb_idx_2;
        SA[2] = rtb_ub_idx_2;
      }

      if (rtIsNaN(absxk_tmp)) {
        rtb_Fx_max_idx_2 = absxk_tmp;
      } else if (absxk_tmp < 0.0) {
        rtb_Fx_max_idx_2 = -1.0;
      } else {
        rtb_Fx_max_idx_2 = (absxk_tmp > 0.0);
      }

      lb_adjust_idx_2 = absxk_tmp;
      absxk = fabs(Tx_idx_3);
      if ((absxk < 0.002) && (absxk >= 0.001) && (rtb_Fx_max_idx_3 > 0.0)) {
        if (rtb_lb_idx_3 > 0.0F) {
          absxk_tmp = rtb_lb;
          SA[3] = -lb_f;
        } else {
          absxk_tmp = -rtb_ub_idx_3;
          SA[3] = rtb_ub;
        }
      } else if (rtb_Fx_max_idx_3 > 0.0) {
        absxk_tmp = lb_f;
        SA[3] = rtb_ub_idx_3;
      } else {
        absxk_tmp = rtb_lb;
        SA[3] = rtb_ub;
      }

      if (rtIsNaN(absxk_tmp)) {
        V_fl_idx_1 = absxk_tmp;
      } else if (absxk_tmp < 0.0) {
        V_fl_idx_1 = -1.0;
      } else {
        V_fl_idx_1 = (absxk_tmp > 0.0);
      }

      if (SA_rl < 1.4) {
        rtb_FY[0] = fabs(rtb_Fx_max_idx_0);
        rtb_FY[1] = fabs(rtb_Fx_max_idx_1);
        rtb_FY[2] = fabs(rtb_Fx_max_idx_2);
        rtb_FY[3] = fabs(V_fl_idx_1);
      } else if (35.0 - rtU.Vg[0] < 1.0) {
        rtb_FY[0] = fabs(rtb_Fx_max_idx_0);
        rtb_FY[1] = fabs(rtb_Fx_max_idx_1);
        rtb_FY[2] = fabs(rtb_Fx_max_idx_2);
        rtb_FY[3] = fabs(V_fl_idx_1);
      } else {
        rtb_FY[0] = rtb_Fx_max_idx_0;
        rtb_FY[1] = rtb_Fx_max_idx_1;
        rtb_FY[2] = rtb_Fx_max_idx_2;
        rtb_FY[3] = V_fl_idx_1;
      }

      Tx_idx_0 = 0.0F;
      Tx_idx_1 = 0.0F;
      Tx_idx_2 = 0.0F;
      Tx_idx_3 = 0.0F;
      b_idx = bigM_func(T2F_aug_idx_0, T2F_aug_idx_1, T2F_aug_idx_2,
                        T2F_aug_idx_3, rtb_b, rtb_A_idx_0, rtb_A_idx_1,
                        rtb_A_idx_2, rtb_A_idx_3, z, ub_f_idx_0, ub_f_idx_1,
                        0.290471792F, -0.290471792F, lb_adjust_idx_0, kx_idx_3,
                        lb_adjust_idx_2, absxk_tmp, SA[0], SA[1], SA[2], SA[3],
                        &Tx_idx_0, &Tx_idx_1, &Tx_idx_2, &Tx_idx_3, rtb_FY[0],
                        rtb_FY[1], rtb_FY[2], rtb_FY[3], 0.2);
      if ((b_idx != 1) && (b_idx != 3)) {
        Tx_idx_0 = (real32_T)rtDW.UnitDelay2_DSTATE[0];
        Tx_idx_1 = (real32_T)rtDW.UnitDelay2_DSTATE[1];
        Tx_idx_2 = (real32_T)rtDW.UnitDelay2_DSTATE[2];
        Tx_idx_3 = (real32_T)rtDW.UnitDelay2_DSTATE[3];
      }
    } else {
      Tx_idx_0 = 0.0F;
      Tx_idx_1 = 0.0F;
      Tx_idx_2 = 0.0F;
      Tx_idx_3 = 0.0F;
      b_idx = bigM_func(T2F_aug_idx_0, T2F_aug_idx_1, T2F_aug_idx_2,
                        T2F_aug_idx_3, rtb_b, rtb_A_idx_0, rtb_A_idx_1,
                        rtb_A_idx_2, rtb_A_idx_3, z, ub_f_idx_0, ub_f_idx_1,
                        0.290471792F, -0.290471792F, rtb_lb_idx_0, rtb_lb_idx_1,
                        rtb_lb_idx_2, rtb_lb, rtb_ub_idx_0, rtb_ub_idx_1,
                        rtb_ub_idx_2, rtb_ub, &Tx_idx_0, &Tx_idx_1, &Tx_idx_2,
                        &Tx_idx_3, signs_idx_0, signs_idx_1, signs_idx_2,
                        rtb_lb_idx_3, 0.05);
      if ((b_idx != 3) && (b_idx != 1)) {
        Tx_idx_0 = (real32_T)rtDW.UnitDelay2_DSTATE[0];
        Tx_idx_1 = (real32_T)rtDW.UnitDelay2_DSTATE[1];
        Tx_idx_2 = (real32_T)rtDW.UnitDelay2_DSTATE[2];
        Tx_idx_3 = (real32_T)rtDW.UnitDelay2_DSTATE[3];
      }
    }
  }

  /* Outport: '<Root>/Tx' incorporates:
   *  MATLAB Function: '<S2>/Optimization '
   */
  rtY.Tx[0] = Tx_idx_0;

  /* Update for UnitDelay: '<S2>/Unit Delay2' incorporates:
   *  MATLAB Function: '<S2>/Optimization '
   */
  rtDW.UnitDelay2_DSTATE[0] = Tx_idx_0;

  /* Outport: '<Root>/Tx' incorporates:
   *  MATLAB Function: '<S2>/Optimization '
   */
  rtY.Tx[1] = Tx_idx_1;

  /* Update for UnitDelay: '<S2>/Unit Delay2' incorporates:
   *  MATLAB Function: '<S2>/Optimization '
   */
  rtDW.UnitDelay2_DSTATE[1] = Tx_idx_1;

  /* Outport: '<Root>/Tx' incorporates:
   *  MATLAB Function: '<S2>/Optimization '
   */
  rtY.Tx[2] = Tx_idx_2;

  /* Update for UnitDelay: '<S2>/Unit Delay2' incorporates:
   *  MATLAB Function: '<S2>/Optimization '
   */
  rtDW.UnitDelay2_DSTATE[2] = Tx_idx_2;

  /* Outport: '<Root>/Tx' incorporates:
   *  MATLAB Function: '<S2>/Optimization '
   */
  rtY.Tx[3] = Tx_idx_3;

  /* Update for UnitDelay: '<S2>/Unit Delay2' incorporates:
   *  MATLAB Function: '<S2>/Optimization '
   */
  rtDW.UnitDelay2_DSTATE[3] = Tx_idx_3;

  /* Update for UnitDelay: '<S3>/Unit Delay2' incorporates:
   *  Inport: '<Root>/Vg'
   */
  rtDW.UnitDelay2_DSTATE_a[0] = rtU.Vg[0];
  rtDW.UnitDelay2_DSTATE_a[1] = rtU.Vg[1];

  /* Update for DiscreteIntegrator: '<S8>/Discrete-Time Integrator' incorporates:
   *  DiscreteIntegrator: '<S8>/Discrete-Time Integrator2'
   */
  rtDW.DiscreteTimeIntegrator_DSTATE = dzzdx;
  if (v_cog > 0.0) {
    rtDW.DiscreteTimeIntegrator_PrevRese = 1;
    rtDW.DiscreteTimeIntegrator2_PrevRes = 1;
  } else {
    if (v_cog < 0.0) {
      rtDW.DiscreteTimeIntegrator_PrevRese = -1;
    } else if (v_cog == 0.0) {
      rtDW.DiscreteTimeIntegrator_PrevRese = 0;
    } else {
      rtDW.DiscreteTimeIntegrator_PrevRese = 2;
    }

    if (v_cog < 0.0) {
      rtDW.DiscreteTimeIntegrator2_PrevRes = -1;
    } else if (v_cog == 0.0) {
      rtDW.DiscreteTimeIntegrator2_PrevRes = 0;
    } else {
      rtDW.DiscreteTimeIntegrator2_PrevRes = 2;
    }
  }

  /* End of Update for DiscreteIntegrator: '<S8>/Discrete-Time Integrator' */

  /* Update for UnitDelay: '<S3>/Unit Delay1' incorporates:
   *  MATLAB Function: '<S3>/Constraint Generation'
   */
  rtDW.UnitDelay1_DSTATE = rtb_Sum1;

  /* Update for DiscreteIntegrator: '<S8>/Discrete-Time Integrator2' */
  rtDW.DiscreteTimeIntegrator2_DSTATE = signd1;

  /* Update for UnitDelay: '<S3>/Unit Delay3' incorporates:
   *  MATLAB Function: '<S3>/Constraint Generation'
   */
  rtDW.UnitDelay3_DSTATE = SA_rr;
}

/* Model initialize function */
void Electronics_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* InitializeConditions for UnitDelay: '<S2>/Unit Delay2' */
  rtDW.UnitDelay2_DSTATE[0] = 0.0001;
  rtDW.UnitDelay2_DSTATE[1] = 0.0001;
  rtDW.UnitDelay2_DSTATE[2] = 0.0001;
  rtDW.UnitDelay2_DSTATE[3] = 0.0001;

  /* InitializeConditions for DiscreteIntegrator: '<S8>/Discrete-Time Integrator' */
  rtDW.DiscreteTimeIntegrator_PrevRese = 2;

  /* InitializeConditions for DiscreteIntegrator: '<S8>/Discrete-Time Integrator2' */
  rtDW.DiscreteTimeIntegrator2_PrevRes = 2;
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
