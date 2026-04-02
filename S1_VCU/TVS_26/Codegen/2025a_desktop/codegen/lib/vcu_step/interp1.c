/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: interp1.c
 *
 * MATLAB Coder version            : 25.1
 * C/C++ source code generated on  : 02-Apr-2026 17:56:15
 */

/* Include Files */
#include "interp1.h"
#include "rt_nonfinite.h"
#include "rt_nonfinite.h"

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
  y_idx_0 = 1;
  x_idx_1 = varargin_1[1];
  y_idx_1 = 0;
  if (varargin_1[1] < varargin_1[0]) {
    r = varargin_1[1];
    x_idx_1 = varargin_1[0];
    y_idx_0 = 0;
    y_idx_1 = 1;
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
 * Arguments    : const double varargin_1[2]
 *                const double varargin_2[2]
 *                double varargin_3
 * Return Type  : double
 */
double interp1(const double varargin_1[2], const double varargin_2[2],
               double varargin_3)
{
  double Vq;
  double r;
  double x_idx_1;
  double y_idx_0;
  double y_idx_1;
  y_idx_0 = varargin_2[0];
  r = varargin_1[0];
  y_idx_1 = varargin_2[1];
  x_idx_1 = varargin_1[1];
  if (varargin_1[1] < varargin_1[0]) {
    r = varargin_1[1];
    x_idx_1 = varargin_1[0];
    y_idx_0 = varargin_2[1];
    y_idx_1 = 1.0;
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
      Vq = (1.0 - r) * y_idx_0 + r * y_idx_1;
    }
  }
  return Vq;
}

/*
 * File trailer for interp1.c
 *
 * [EOF]
 */
