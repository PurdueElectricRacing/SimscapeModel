/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: interp1.c
 *
 * MATLAB Coder version            : 24.2
 * C/C++ source code generated on  : 01-Feb-2025 14:01:15
 */

/* Include Files */
#include "interp1.h"
#include "rt_nonfinite.h"
#include "rt_nonfinite.h"
#include <string.h>

/* Function Definitions */
/*
 * Arguments    : const double varargin_1[2]
 *                double varargin_3
 * Return Type  : double
 */
double b_interp1(const double varargin_1[2], double varargin_3)
{
  double Vq;
  double r;
  double x_idx_1;
  signed char y_idx_0;
  signed char y_idx_1;
  r = varargin_1[0];
  y_idx_0 = 0;
  x_idx_1 = varargin_1[1];
  y_idx_1 = 1;
  if (varargin_1[1] < varargin_1[0]) {
    r = varargin_1[1];
    x_idx_1 = varargin_1[0];
    y_idx_0 = 1;
    y_idx_1 = 0;
  }
  Vq = rtNaN;
  if ((!rtIsNaN(varargin_3)) && (!(varargin_3 > x_idx_1)) &&
      (!(varargin_3 < r))) {
    r = (varargin_3 - r) / (x_idx_1 - r);
    if (r == 0.0) {
      Vq = y_idx_0;
    } else if (r == 1.0) {
      Vq = y_idx_1;
    } else if (y_idx_0 == y_idx_1) {
      Vq = y_idx_0;
    } else {
      Vq = (1.0 - r) * (double)y_idx_0 + r * (double)y_idx_1;
    }
  }
  return Vq;
}

/*
 * Arguments    : const double varargin_1[506]
 *                const double varargin_2[506]
 *                double varargin_3
 * Return Type  : double
 */
double interp1(const double varargin_1[506], const double varargin_2[506],
               double varargin_3)
{
  double x[506];
  double y[506];
  double Vq;
  double xtmp;
  int high_i;
  int low_i;
  int low_ip1;
  int mid_i;
  memcpy(&y[0], &varargin_2[0], 506U * sizeof(double));
  memcpy(&x[0], &varargin_1[0], 506U * sizeof(double));
  if (varargin_1[1] < varargin_1[0]) {
    for (low_i = 0; low_i < 253; low_i++) {
      xtmp = x[low_i];
      x[low_i] = x[505 - low_i];
      x[505 - low_i] = xtmp;
      xtmp = y[low_i];
      y[low_i] = y[505 - low_i];
      y[505 - low_i] = xtmp;
    }
  }
  Vq = rtNaN;
  if ((!rtIsNaN(varargin_3)) && (!(varargin_3 > x[505])) &&
      (!(varargin_3 < x[0]))) {
    low_i = 1;
    low_ip1 = 2;
    high_i = 506;
    while (high_i > low_ip1) {
      mid_i = (low_i + high_i) >> 1;
      if (varargin_3 >= x[mid_i - 1]) {
        low_i = mid_i;
        low_ip1 = mid_i + 1;
      } else {
        high_i = mid_i;
      }
    }
    xtmp = x[low_i - 1];
    xtmp = (varargin_3 - xtmp) / (x[low_i] - xtmp);
    if (xtmp == 0.0) {
      Vq = y[low_i - 1];
    } else if (xtmp == 1.0) {
      Vq = y[low_i];
    } else {
      Vq = y[low_i - 1];
      if (!(Vq == y[low_i])) {
        Vq = (1.0 - xtmp) * Vq + xtmp * y[low_i];
      }
    }
  }
  return Vq;
}

/*
 * File trailer for interp1.c
 *
 * [EOF]
 */
