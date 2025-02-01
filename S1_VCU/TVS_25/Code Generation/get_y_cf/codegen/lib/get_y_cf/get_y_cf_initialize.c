/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: get_y_cf_initialize.c
 *
 * MATLAB Coder version            : 24.2
 * C/C++ source code generated on  : 01-Feb-2025 14:01:15
 */

/* Include Files */
#include "get_y_cf_initialize.h"
#include "get_y_cf_data.h"
#include "rt_nonfinite.h"

/* Function Definitions */
/*
 * Arguments    : void
 * Return Type  : void
 */
void get_y_cf_initialize(void)
{
  rt_InitInfAndNaN();
  isInitialized_get_y_cf = true;
}

/*
 * File trailer for get_y_cf_initialize.c
 *
 * [EOF]
 */
