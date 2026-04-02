/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: minOrMax.c
 *
 * MATLAB Coder version            : 25.1
 * C/C++ source code generated on  : 02-Apr-2026 17:56:15
 */

/* Include Files */
#include "minOrMax.h"
#include "rt_nonfinite.h"
#include "rt_nonfinite.h"

/* Function Definitions */
/*
 * Arguments    : const double x[28]
 *                double ex[4]
 * Return Type  : void
 */
void minimum(const double x[28], double ex[4])
{
  int i;
  int j;
  for (j = 0; j < 4; j++) {
    ex[j] = x[7 * j];
    for (i = 0; i < 6; i++) {
      double d;
      boolean_T p;
      d = x[(i + 7 * j) + 1];
      if (rtIsNaN(d)) {
        p = false;
      } else {
        double d1;
        d1 = ex[j];
        if (rtIsNaN(d1)) {
          p = true;
        } else {
          p = (d1 > d);
        }
      }
      if (p) {
        ex[j] = d;
      }
    }
  }
}

/*
 * File trailer for minOrMax.c
 *
 * [EOF]
 */
