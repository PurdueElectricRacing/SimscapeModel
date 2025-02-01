/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: get_y_cf.c
 *
 * MATLAB Coder version            : 23.2
 * C/C++ source code generated on  : 01-Feb-2025 15:30:23
 */

/* Include Files */
#include "get_y_cf.h"
#include "get_y_cf_types.h"
#include <math.h>
#include <string.h>

/* Function Definitions */
/*
 * process individual data and distribute into individual fields
 *
 * Arguments    : const struct0_T *p
 *                const struct1_T *x
 *                struct2_T *y
 * Return Type  : void
 */
void get_y_cf(const struct0_T *p, const struct1_T *x, struct2_T *y)
{
  double varargin_1[506];
  double varargin_2[506];
  double minval_idx_1;
  double xi;
  double xtmp;
  int low_i;
  /*  throttle sensor: hardware filter & averaging across two independent
   * sensors is sufficient */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->TH_CF = fmax(fmin(x->TH_RAW, p->TH_ub), p->TH_lb);
  /*  steering angle sensor: the GMR sensor accuracy is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->ST_CF = fmax(fmin(x->ST_RAW, p->ST_ub), p->ST_lb);
  /*  battery voltage: the voltage sensor accuracy is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->VB_CF = fmax(fmin(x->VB_RAW, p->VB_ub), p->VB_lb);
  /*  tire wheel speed: the hall effect sensor accuracy is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->WT_CF[0] = fmax(fmin(x->WT_RAW[0], p->WT_ub[0]), p->WT_lb[0]);
  y->WT_CF[1] = fmax(fmin(x->WT_RAW[1], p->WT_ub[1]), p->WT_lb[1]);
  /*  chassis ground speed: GPS sensor accuracy is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->GS_CF = fmax(fmin(x->GS_RAW, p->GS_ub), p->GS_lb);
  /*  chassis angular velocity: the control scheme acts as a filter */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  xtmp = x->AV_RAW[0];
  xi = x->AV_RAW[1];
  minval_idx_1 = x->AV_RAW[2];
  for (low_i = 0; low_i < 3; low_i++) {
    y->AV_CF[low_i] = fmax(fmin((p->R[low_i] * xtmp + p->R[low_i + 3] * xi) +
                                    p->R[low_i + 6] * minval_idx_1,
                                p->AV_ub[low_i]),
                           p->AV_lb[low_i]);
  }
  /*  battery current: filtering is needed for the purpose of averaging */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  for (low_i = 0; low_i < 9; low_i++) {
    y->IB_CF_vec[low_i] = y->IB_CF_vec[low_i + 1];
  }
  y->IB_CF_vec[9] = fmax(fmin(x->IB_RAW, p->IB_ub), p->IB_lb);
  xtmp = y->IB_CF_vec[0];
  for (low_i = 0; low_i < 9; low_i++) {
    xtmp += y->IB_CF_vec[low_i + 1];
  }
  y->IB_CF = xtmp / 10.0;
  /*  max motor temperature: the thermocouple sensor accuracy is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->MT_CF = fmax(fmin(x->MT_RAW, p->MT_ub), p->MT_lb);
  /*  max inverter igbt temperature: the thermocouple sensor accuracy is good
   * enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->CT_CF = fmax(fmin(x->CT_RAW, p->CT_ub), p->CT_lb);
  /*  max inverter cold plate temperature: the thermocouple sensor accuracy is
   * good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->IT_CF = fmax(fmin(x->IT_RAW, p->IT_ub), p->IT_lb);
  /*  motor overload percentage: */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->MC_CF = fmax(fmin(x->MC_RAW, p->MC_ub), p->MC_lb);
  /*  inverter overload percentage:  */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->IC_CF = fmax(fmin(x->IC_RAW, p->IC_ub), p->IC_lb);
  /*  max battery cell temperature: the thermocouple sensor accuracy is good
   * enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->BT_CF = fmax(fmin(x->BT_RAW, p->BT_ub), p->BT_lb);
  /*  chassis acceleration: the sensor is bad, but this sensor is not used in
   * controller */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  xtmp = x->AG_RAW[0];
  xi = x->AG_RAW[1];
  minval_idx_1 = x->AG_RAW[2];
  for (low_i = 0; low_i < 3; low_i++) {
    y->AG_CF[low_i] = fmax(fmin((p->R[low_i] * xtmp + p->R[low_i + 3] * xi) +
                                    p->R[low_i + 6] * minval_idx_1,
                                p->AG_ub[low_i]),
                           p->AG_lb[low_i]);
  }
  /*  motor torque: the unfiltered values are desired */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->TO_CF[0] = fmax(fmin(x->TO_RAW[0], p->TO_ub[0]), p->TO_lb[0]);
  y->TO_CF[1] = fmax(fmin(x->TO_RAW[1], p->TO_ub[1]), p->TO_lb[1]);
  /*  steering deadband: the potentiometer sensor is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->DB_CF = fmax(fmin(x->DB_RAW, p->DB_ub), p->DB_lb);
  /*  torque vectoring intensity: the potentiometer sensor is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->PI_CF = fmax(fmin(x->PI_RAW, p->PI_ub), p->PI_lb);
  /*  torque vectoring proportional gain: the potentiometer sensor is good
   * enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  y->PP_CF = fmax(fmin(x->PP_RAW, p->PP_ub), p->PP_lb);
  /*  battery state of charge (SOC): */
  y->zero_current_counter =
      (y->zero_current_counter + 1.0) * (double)(y->IB_CF == 0.0);
  /*  if zero, reset counter, otherwise increment by one */
  if (y->zero_current_counter >= p->zero_currents_to_update_SOC) {
    double b_xi;
    signed char varargin_2_idx_0;
    signed char varargin_2_idx_1;
    /*  is above threshold, update VOC otherwise do nothing */
    memcpy(&varargin_1[0], &p->Batt_Voc_brk[0], 506U * sizeof(double));
    memcpy(&varargin_2[0], &p->Batt_As_Discharged_tbl[0],
           506U * sizeof(double));
    xi = y->VB_CF / p->Ns;
    if (p->Batt_Voc_brk[1] < p->Batt_Voc_brk[0]) {
      for (low_i = 0; low_i < 253; low_i++) {
        xtmp = varargin_1[low_i];
        varargin_1[low_i] = varargin_1[505 - low_i];
        varargin_1[505 - low_i] = xtmp;
        xtmp = varargin_2[low_i];
        varargin_2[low_i] = varargin_2[505 - low_i];
        varargin_2[505 - low_i] = xtmp;
      }
    }
    b_xi = 0.0;
    if ((xi <= varargin_1[505]) && (xi >= varargin_1[0])) {
      int high_i;
      int low_ip1;
      low_i = 1;
      low_ip1 = 2;
      high_i = 506;
      while (high_i > low_ip1) {
        int mid_i;
        mid_i = (low_i + high_i) >> 1;
        if (xi >= varargin_1[mid_i - 1]) {
          low_i = mid_i;
          low_ip1 = mid_i + 1;
        } else {
          high_i = mid_i;
        }
      }
      xtmp = varargin_1[low_i - 1];
      xtmp = (xi - xtmp) / (varargin_1[low_i] - xtmp);
      if (xtmp == 0.0) {
        b_xi = varargin_2[low_i - 1];
      } else if (xtmp == 1.0) {
        b_xi = varargin_2[low_i];
      } else {
        xi = varargin_2[low_i - 1];
        if (xi == varargin_2[low_i]) {
          b_xi = xi;
        } else {
          b_xi = (1.0 - xtmp) * xi + xtmp * varargin_2[low_i];
        }
      }
    }
    xtmp = p->Batt_cell_zero_SOC_capacity;
    minval_idx_1 = p->Batt_cell_full_SOC_capacity;
    varargin_2_idx_0 = 0;
    varargin_2_idx_1 = 1;
    if (p->Batt_cell_full_SOC_capacity < p->Batt_cell_zero_SOC_capacity) {
      xtmp = p->Batt_cell_full_SOC_capacity;
      minval_idx_1 = p->Batt_cell_zero_SOC_capacity;
      varargin_2_idx_0 = 1;
      varargin_2_idx_1 = 0;
    }
    xi = 0.0;
    if ((b_xi <= minval_idx_1) && (b_xi >= xtmp)) {
      xtmp = (b_xi - xtmp) / (minval_idx_1 - xtmp);
      if (xtmp == 0.0) {
        xi = varargin_2_idx_0;
      } else if (xtmp == 1.0) {
        xi = varargin_2_idx_1;
      } else if (varargin_2_idx_0 == varargin_2_idx_1) {
        xi = varargin_2_idx_0;
      } else {
        xi = (1.0 - xtmp) * (double)varargin_2_idx_0 +
             xtmp * (double)varargin_2_idx_1;
      }
    }
    /* SNIP code generation compatible version of 'clip()' */
    /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
    y->Batt_SOC = fmax(fmin(xi, 1.0), 0.0);
  }
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void get_y_cf_initialize(void)
{
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void get_y_cf_terminate(void)
{
}

/*
 * File trailer for get_y_cf.c
 *
 * [EOF]
 */
