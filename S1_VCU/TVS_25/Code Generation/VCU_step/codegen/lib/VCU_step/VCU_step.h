/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: VCU_step.h
 *
 * MATLAB Coder version            : 23.2
 * C/C++ source code generated on  : 01-Feb-2025 21:19:15
 */

#ifndef VCU_STEP_H
#define VCU_STEP_H

/* Include Files */
#include "VCU_step_types.h"
#include "rtwtypes.h"
#include <stddef.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Function Declarations */
extern void VCU_step(const struct0_T *p, const struct1_T *f, const struct2_T *x,
                     struct3_T *y);

extern void VCU_step_initialize(void);

extern void VCU_step_terminate(void);

#ifdef __cplusplus
}
#endif

#endif
/*
 * File trailer for VCU_step.h
 *
 * [EOF]
 */
