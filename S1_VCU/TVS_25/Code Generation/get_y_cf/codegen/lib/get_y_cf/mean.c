/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: mean.c
 *
 * MATLAB Coder version            : 24.2
 * C/C++ source code generated on  : 01-Feb-2025 14:01:15
 */

/* Include Files */
#include "mean.h"
#include "rt_nonfinite.h"

/* Function Definitions */
/*
 * Arguments    : const double x[10]
 * Return Type  : double
 */
double mean(const double x[10])
{
  double y;
  int k;
  y = x[0];
  for (k = 0; k < 9; k++) {
    y += x[k + 1];
  }
  y /= 10.0;
  return y;
}

/*
 * File trailer for mean.c
 *
 * [EOF]
 */
