/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: get_y_cf.c
 *
 * MATLAB Coder version            : 24.2
 * C/C++ source code generated on  : 01-Feb-2025 14:01:15
 */

/* Include Files */
#include "get_y_cf.h"
#include "get_y_cf_data.h"
#include "get_y_cf_initialize.h"
#include "get_y_cf_types.h"
#include "interp1.h"
#include "mean.h"
#include "rt_nonfinite.h"
#include "rt_nonfinite.h"

/* Function Definitions */
/*
 * process individual data and distribute into individual fields
 *
 * Arguments    : const struct0_T *p
 *                const struct2_T *x
 *                struct3_T *y
 * Return Type  : void
 */
void get_y_cf(const struct0_T *p, const struct2_T *x, struct3_T *y)
{
  double minval[2];
  double d;
  double d1;
  double d2;
  double u0;
  int k;
  if (!isInitialized_get_y_cf) {
    get_y_cf_initialize();
  }
  /*  throttle sensor: hardware filter & averaging across two independent
   * sensors is sufficient */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->TH_RAW <= p->TH_ub) || rtIsNaN(p->TH_ub)) {
    u0 = x->TH_RAW;
  } else {
    u0 = p->TH_ub;
  }
  if ((u0 >= p->TH_lb) || rtIsNaN(p->TH_lb)) {
    y->TH_CF = u0;
  } else {
    y->TH_CF = p->TH_lb;
  }
  /*  steering angle sensor: the GMR sensor accuracy is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->ST_RAW <= p->ST_ub) || rtIsNaN(p->ST_ub)) {
    u0 = x->ST_RAW;
  } else {
    u0 = p->ST_ub;
  }
  if ((u0 >= p->ST_lb) || rtIsNaN(p->ST_lb)) {
    y->ST_CF = u0;
  } else {
    y->ST_CF = p->ST_lb;
  }
  /*  battery voltage: the voltage sensor accuracy is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->VB_RAW <= p->VB_ub) || rtIsNaN(p->VB_ub)) {
    u0 = x->VB_RAW;
  } else {
    u0 = p->VB_ub;
  }
  if ((u0 >= p->VB_lb) || rtIsNaN(p->VB_lb)) {
    y->VB_CF = u0;
  } else {
    y->VB_CF = p->VB_lb;
  }
  /*  tire wheel speed: the hall effect sensor accuracy is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->WT_RAW[0] <= p->WT_ub[0]) || rtIsNaN(p->WT_ub[0])) {
    u0 = x->WT_RAW[0];
  } else {
    u0 = p->WT_ub[0];
  }
  if ((u0 >= p->WT_lb[0]) || rtIsNaN(p->WT_lb[0])) {
    y->WT_CF[0] = u0;
  } else {
    y->WT_CF[0] = p->WT_lb[0];
  }
  if ((x->WT_RAW[1] <= p->WT_ub[1]) || rtIsNaN(p->WT_ub[1])) {
    u0 = x->WT_RAW[1];
  } else {
    u0 = p->WT_ub[1];
  }
  if ((u0 >= p->WT_lb[1]) || rtIsNaN(p->WT_lb[1])) {
    y->WT_CF[1] = u0;
  } else {
    y->WT_CF[1] = p->WT_lb[1];
  }
  /*  chassis ground speed: GPS sensor accuracy is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->GS_RAW <= p->GS_ub) || rtIsNaN(p->GS_ub)) {
    u0 = x->GS_RAW;
  } else {
    u0 = p->GS_ub;
  }
  if ((u0 >= p->GS_lb) || rtIsNaN(p->GS_lb)) {
    y->GS_CF = u0;
  } else {
    y->GS_CF = p->GS_lb;
  }
  /*  chassis angular velocity: the control scheme acts as a filter */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  u0 = x->AV_RAW[0];
  d = x->AV_RAW[1];
  d1 = x->AV_RAW[2];
  for (k = 0; k < 3; k++) {
    d2 = (p->R[k] * u0 + p->R[k + 3] * d) + p->R[k + 6] * d1;
    if ((!(d2 <= p->AV_ub[k])) && (!rtIsNaN(p->AV_ub[k]))) {
      d2 = p->AV_ub[k];
    }
    if ((d2 >= p->AV_lb[k]) || rtIsNaN(p->AV_lb[k])) {
      y->AV_CF[k] = d2;
    } else {
      y->AV_CF[k] = p->AV_lb[k];
    }
  }
  /*  battery current: filtering is needed for the purpose of averaging */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->IB_RAW <= p->IB_ub) || rtIsNaN(p->IB_ub)) {
    u0 = x->IB_RAW;
  } else {
    u0 = p->IB_ub;
  }
  for (k = 0; k < 9; k++) {
    y->IB_CF_vec[k] = y->IB_CF_vec[k + 1];
  }
  if ((u0 >= p->IB_lb) || rtIsNaN(p->IB_lb)) {
    y->IB_CF_vec[9] = u0;
  } else {
    y->IB_CF_vec[9] = p->IB_lb;
  }
  y->IB_CF = mean(y->IB_CF_vec);
  /*  max motor temperature: the thermocouple sensor accuracy is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->MT_RAW <= p->MT_ub) || rtIsNaN(p->MT_ub)) {
    u0 = x->MT_RAW;
  } else {
    u0 = p->MT_ub;
  }
  if ((u0 >= p->MT_lb) || rtIsNaN(p->MT_lb)) {
    y->MT_CF = u0;
  } else {
    y->MT_CF = p->MT_lb;
  }
  /*  max inverter igbt temperature: the thermocouple sensor accuracy is good
   * enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->CT_RAW <= p->CT_ub) || rtIsNaN(p->CT_ub)) {
    u0 = x->CT_RAW;
  } else {
    u0 = p->CT_ub;
  }
  if ((u0 >= p->CT_lb) || rtIsNaN(p->CT_lb)) {
    y->CT_CF = u0;
  } else {
    y->CT_CF = p->CT_lb;
  }
  /*  max inverter cold plate temperature: the thermocouple sensor accuracy is
   * good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->IT_RAW <= p->IT_ub) || rtIsNaN(p->IT_ub)) {
    u0 = x->IT_RAW;
  } else {
    u0 = p->IT_ub;
  }
  if ((u0 >= p->IT_lb) || rtIsNaN(p->IT_lb)) {
    y->IT_CF = u0;
  } else {
    y->IT_CF = p->IT_lb;
  }
  /*  motor overload percentage: */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->MC_RAW <= p->MC_ub) || rtIsNaN(p->MC_ub)) {
    u0 = x->MC_RAW;
  } else {
    u0 = p->MC_ub;
  }
  if ((u0 >= p->MC_lb) || rtIsNaN(p->MC_lb)) {
    y->MC_CF = u0;
  } else {
    y->MC_CF = p->MC_lb;
  }
  /*  inverter overload percentage:  */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->IC_RAW <= p->IC_ub) || rtIsNaN(p->IC_ub)) {
    u0 = x->IC_RAW;
  } else {
    u0 = p->IC_ub;
  }
  if ((u0 >= p->IC_lb) || rtIsNaN(p->IC_lb)) {
    y->IC_CF = u0;
  } else {
    y->IC_CF = p->IC_lb;
  }
  /*  max battery cell temperature: the thermocouple sensor accuracy is good
   * enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->BT_RAW <= p->BT_ub) || rtIsNaN(p->BT_ub)) {
    u0 = x->BT_RAW;
  } else {
    u0 = p->BT_ub;
  }
  if ((u0 >= p->BT_lb) || rtIsNaN(p->BT_lb)) {
    y->BT_CF = u0;
  } else {
    y->BT_CF = p->BT_lb;
  }
  /*  chassis acceleration: the sensor is bad, but this sensor is not used in
   * controller */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  u0 = x->AG_RAW[0];
  d = x->AG_RAW[1];
  d1 = x->AG_RAW[2];
  for (k = 0; k < 3; k++) {
    d2 = (p->R[k] * u0 + p->R[k + 3] * d) + p->R[k + 6] * d1;
    if ((!(d2 <= p->AG_ub[k])) && (!rtIsNaN(p->AG_ub[k]))) {
      d2 = p->AG_ub[k];
    }
    if ((d2 >= p->AG_lb[k]) || rtIsNaN(p->AG_lb[k])) {
      y->AG_CF[k] = d2;
    } else {
      y->AG_CF[k] = p->AG_lb[k];
    }
  }
  /*  motor torque: the unfiltered values are desired */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->TO_RAW[0] <= p->TO_ub[0]) || rtIsNaN(p->TO_ub[0])) {
    u0 = x->TO_RAW[0];
  } else {
    u0 = p->TO_ub[0];
  }
  if ((u0 >= p->TO_lb[0]) || rtIsNaN(p->TO_lb[0])) {
    y->TO_CF[0] = u0;
  } else {
    y->TO_CF[0] = p->TO_lb[0];
  }
  if ((x->TO_RAW[1] <= p->TO_ub[1]) || rtIsNaN(p->TO_ub[1])) {
    u0 = x->TO_RAW[1];
  } else {
    u0 = p->TO_ub[1];
  }
  if ((u0 >= p->TO_lb[1]) || rtIsNaN(p->TO_lb[1])) {
    y->TO_CF[1] = u0;
  } else {
    y->TO_CF[1] = p->TO_lb[1];
  }
  /*  steering deadband: the potentiometer sensor is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->DB_RAW <= p->DB_ub) || rtIsNaN(p->DB_ub)) {
    u0 = x->DB_RAW;
  } else {
    u0 = p->DB_ub;
  }
  if ((u0 >= p->DB_lb) || rtIsNaN(p->DB_lb)) {
    y->DB_CF = u0;
  } else {
    y->DB_CF = p->DB_lb;
  }
  /*  torque vectoring intensity: the potentiometer sensor is good enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->PI_RAW <= p->PI_ub) || rtIsNaN(p->PI_ub)) {
    u0 = x->PI_RAW;
  } else {
    u0 = p->PI_ub;
  }
  if ((u0 >= p->PI_lb) || rtIsNaN(p->PI_lb)) {
    y->PI_CF = u0;
  } else {
    y->PI_CF = p->PI_lb;
  }
  /*  torque vectoring proportional gain: the potentiometer sensor is good
   * enough */
  /* SNIP code generation compatible version of 'clip()' */
  /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
  if ((x->PP_RAW <= p->PP_ub) || rtIsNaN(p->PP_ub)) {
    u0 = x->PP_RAW;
  } else {
    u0 = p->PP_ub;
  }
  if ((u0 >= p->PP_lb) || rtIsNaN(p->PP_lb)) {
    y->PP_CF = u0;
  } else {
    y->PP_CF = p->PP_lb;
  }
  /*  battery state of charge (SOC): */
  y->zero_current_counter =
      (y->zero_current_counter + 1.0) * (double)(y->IB_CF == 0.0);
  /*  if zero, reset counter, otherwise increment by one */
  if (y->zero_current_counter >= p->zero_currents_to_update_SOC) {
    /*  is above threshold, update VOC otherwise do nothing */
    minval[0] = p->Batt_cell_zero_SOC_capacity;
    minval[1] = p->Batt_cell_full_SOC_capacity;
    u0 = b_interp1(minval, interp1(p->Batt_Voc_brk, p->Batt_As_Discharged_tbl,
                                   y->VB_CF / p->series));
    /* SNIP code generation compatible version of 'clip()' */
    /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
    if (!(u0 <= 1.0)) {
      u0 = 1.0;
    }
    if (u0 >= 0.0) {
      y->Batt_SOC = u0;
    } else {
      y->Batt_SOC = 0.0;
    }
  }
}

/*
 * File trailer for get_y_cf.c
 *
 * [EOF]
 */
