/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: vcu_step.c
 *
 * MATLAB Coder version            : 25.1
 * C/C++ source code generated on  : 02-Apr-2026 17:56:15
 */

/* Include Files */
#include "vcu_step.h"
#include "interp1.h"
#include "minOrMax.h"
#include "rt_nonfinite.h"
#include "vcu_step_types.h"
#include <emmintrin.h>
#include <math.h>

/* Function Definitions */
/*
 * clip and filter results
 *
 * Arguments    : const pVCU_struct *p
 *                const xVCU_struct *x
 *                yVCU_struct *y
 * Return Type  : void
 */
void vcu_step(const pVCU_struct *p, const xVCU_struct *x, yVCU_struct *y)
{
  double TO_DR_MAX[4];
  double b_p[2];
  double dv1[2];
  /*  Function Description */
  /*  vcu_step runs every loop on the TV board */
  /*  */
  /*  Inputs */
  /*    p   vehicle paramater struct. constant */
  /*    x   Raw sensor data struct. filled with data read from CAN */
  /*            in main.c */
  /*    y   Function input and output struct. contains all clipped and */
  /*            filtered variables, variable buffers, and output from */
  /*            this function. */
  /*  Outputs */
  /*    y   modified version of input y */
  /*  process raw inputs from x into y */
  /*  Function Description */
  /*  This function applies truncation and filtering to all signals that need */
  /*  it. In addition, it distributes signals from x to y. */
  /*  */
  /*  Input      :  p - struct of all constant controller parameters */
  /*                x - struct of all raw sensor measurements */
  /*                y - struct of CF processed controller data at time t-1 */
  /*   */
  /*  Return     :  y - struct of CF processed controller data at time t */
  /*  throttle */
  y->TH = x->TH_RAW;
  /*  power throttle */
  y->TH_PO = fmin(fmax(x->TH_RAW, 0.0), 1.0);
  /*  regen throttle */
  y->TH_RG = fabs(fmin(fmax(x->TH_RAW, -1.0), 0.0));
  /*  steering angle */
  y->ST = x->ST_RAW;
  /*  battery voltage */
  y->VB = x->VB_RAW;
  /*  motor shaft angular velocity */
  y->WM[0] = x->WM_RAW[0];
  y->WM[1] = x->WM_RAW[1];
  y->WM[2] = x->WM_RAW[2];
  y->WM[3] = x->WM_RAW[3];
  /*  groundspeed */
  y->GS = x->GS_RAW;
  /*  chasis angular velocity */
  y->AV[0] = x->AV_RAW[0];
  y->AV[1] = x->AV_RAW[1];
  y->AV[2] = x->AV_RAW[2];
  /*  battery current */
  y->IB = x->IB_RAW;
  /*  max motor temp */
  y->MT = x->MT_RAW;
  /*  max inverter IGBT temp */
  y->IGBT_T = x->IGBT_T_RAW;
  /*  max inverer cold plate temp */
  y->INV_T = x->INV_T_RAW;
  /*  motor overload percentage */
  y->MC = x->MC_RAW;
  /*  inverter overolad percentage */
  y->IC = x->IC_RAW;
  /*  max battery cell temperature */
  y->BT = x->BT_RAW;
  /*  motor torque */
  y->TO[0] = x->TO_RAW[0];
  y->TO[1] = x->TO_RAW[1];
  y->TO[2] = x->TO_RAW[2];
  y->TO[3] = x->TO_RAW[3];
  /*  determine VCU mode */
  /*  y = get_VCU_mode(p,f,x,y); */
  /*  switch between power and regen depending on throttle */
  if (x->TH_RAW >= 0.0) {
    __m128d r;
    __m128d r1;
    double b_PB_derate_front[28];
    double dv[2];
    double PB_derate_front;
    double PB_snipped;
    double b;
    double b_b;
    double c_b;
    double d_b;
    double e_b;
    double f_b;
    /*  baseline power torque */
    /*  torque limit after current, power, thermal derating */
    /*  max torque allowed by throttle position */
    /*  Function Description */
    /*  vcu_step runs every loop on the TV board */
    /*  */
    /*  Inputs */
    /*    p   vehicle paramater struct. constant */
    /*    x   Raw sensor data struct. filled with data read from CAN */
    /*            in main.c */
    /*    y   Function input and output struct. contains all clipped and */
    /*            filtered variables, variable buffers, and output from */
    /*            this function. */
    /*  Outputs */
    /*    y   modified version of input y */
    /*  80kW rules limit derating */
    /*  only derating to 50% total torque, F:R derating split can be changed */
    /* SNIP code generation compatible version of 'clip()' */
    /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
    PB_snipped =
        fmax(fmin(y->PB, p->PB_derating_half_T), p->PB_derating_full_T);
    b_p[0] = p->PB_derating_full_T;
    b_p[1] = p->PB_derating_half_T;
    dv[0] = 1.0;
    dv[1] = 1.0 - p->PB_derating_FR;
    PB_derate_front = interp1(b_p, dv, PB_snipped);
    b_p[0] = p->PB_derating_full_T;
    b_p[1] = p->PB_derating_half_T;
    dv[0] = 1.0;
    dv[1] = p->PB_derating_FR;
    PB_snipped = interp1(b_p, dv, PB_snipped);
    /*  Inverter temp safetey derating - derate all motors based on highest
     * inverter temp */
    /* SNIP code generation compatible version of 'clip()' */
    /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
    b_p[0] = p->INV_T_derating_full_T;
    b_p[1] = p->INV_derating_zero_T;
    b = b_interp1(b_p, fmax(fmin(x->INV_T_RAW, p->INV_derating_zero_T),
                            p->INV_T_derating_full_T));
    /*  IGBT temp safety derating - derate all motors based on highest IGBT temp
     */
    /* SNIP code generation compatible version of 'clip()' */
    /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
    b_p[0] = p->IGBT_derating_full_T;
    b_p[1] = p->IGBT_derating_zero_T;
    b_b = b_interp1(b_p, fmax(fmin(x->IGBT_T_RAW, p->IGBT_derating_zero_T),
                              p->IGBT_derating_full_T));
    /*  Motor temp safetey derating - derate all motors based on highest motor
     * temp */
    /* SNIP code generation compatible version of 'clip()' */
    /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
    b_p[0] = p->MT_derating_full_T;
    b_p[1] = p->MT_derating_zero_T;
    c_b = b_interp1(b_p, fmax(fmin(x->MT_RAW, p->MT_derating_zero_T),
                              p->MT_derating_full_T));
    /*  Battery temp safety derating - derate all motors based on highest cell
     * temp */
    /* SNIP code generation compatible version of 'clip()' */
    /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
    b_p[0] = p->BT_derating_full_T;
    b_p[1] = p->BT_derating_zero_T;
    d_b = b_interp1(b_p, fmax(fmin(x->BT_RAW, p->BT_derating_zero_T),
                              p->BT_derating_full_T));
    /*  Battery undervoltage safety derating */
    /* SNIP code generation compatible version of 'clip()' */
    /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
    b_p[0] = p->VB_derating_full_T;
    b_p[1] = p->VB_derating_zero_T;
    e_b = b_interp1(b_p, fmax(fmin(x->VB_RAW, p->VB_derating_zero_T),
                              p->VB_derating_full_T));
    /*  Battery current safety derating */
    /* SNIP code generation compatible version of 'clip()' */
    /*    clips 'value' to be between lower bound 'LB' and upper bound 'UB' */
    b_p[0] = p->IB_derating_full_T;
    b_p[1] = p->IB_derating_zero_T;
    f_b = b_interp1(b_p, fmax(fmin(x->IB_RAW, p->IB_derating_zero_T),
                              p->IB_derating_full_T));
    /*  combine derating, multiply by abs max torque to get maximum torque
     * allowed */
    b_PB_derate_front[0] = PB_derate_front;
    b_PB_derate_front[7] = PB_derate_front;
    b_PB_derate_front[14] = PB_snipped;
    b_PB_derate_front[21] = PB_snipped;
    b_PB_derate_front[1] = b;
    b_PB_derate_front[2] = b_b;
    b_PB_derate_front[3] = c_b;
    b_PB_derate_front[4] = d_b;
    b_PB_derate_front[5] = e_b;
    b_PB_derate_front[6] = f_b;
    b_PB_derate_front[8] = b;
    b_PB_derate_front[9] = b_b;
    b_PB_derate_front[10] = c_b;
    b_PB_derate_front[11] = d_b;
    b_PB_derate_front[12] = e_b;
    b_PB_derate_front[13] = f_b;
    b_PB_derate_front[15] = b;
    b_PB_derate_front[16] = b_b;
    b_PB_derate_front[17] = c_b;
    b_PB_derate_front[18] = d_b;
    b_PB_derate_front[19] = e_b;
    b_PB_derate_front[20] = f_b;
    b_PB_derate_front[22] = b;
    b_PB_derate_front[23] = b_b;
    b_PB_derate_front[24] = c_b;
    b_PB_derate_front[25] = d_b;
    b_PB_derate_front[26] = e_b;
    b_PB_derate_front[27] = f_b;
    minimum(b_PB_derate_front, TO_DR_MAX);
    /*  compute overall maximum torque */
    /*  set baseline to output torque */
    r = _mm_loadu_pd(&TO_DR_MAX[0]);
    r1 = _mm_set1_pd(p->MAX_TO_ABS);
    r = _mm_mul_pd(r1, r);
    _mm_storeu_pd(&TO_DR_MAX[0], r);
    PB_snipped = y->TH_PO * p->MAX_TO_ABS;
    _mm_storeu_pd(&dv1[0], r);
    b_p[0] = fmin(PB_snipped, dv1[0]);
    b_p[1] = fmin(PB_snipped, dv1[1]);
    r = _mm_loadu_pd(&b_p[0]);
    _mm_storeu_pd(&y->TO_BL_PO[0], r);
    _mm_storeu_pd(&y->TORQUE_OUT[0], r);
    r = _mm_loadu_pd(&TO_DR_MAX[2]);
    r = _mm_mul_pd(r1, r);
    _mm_storeu_pd(&TO_DR_MAX[2], r);
    PB_snipped = y->TH_PO * p->MAX_TO_ABS;
    _mm_storeu_pd(&dv1[0], r);
    b_p[0] = fmin(PB_snipped, dv1[0]);
    b_p[1] = fmin(PB_snipped, dv1[1]);
    r = _mm_loadu_pd(&b_p[0]);
    _mm_storeu_pd(&y->TO_BL_PO[2], r);
    _mm_storeu_pd(&y->TORQUE_OUT[2], r);
  } else if (x->TH_RAW < 0.0) {
    /*  baseline regen torque */
    /*  torque limit after speed, current, voltage, SOC, thermal derating */
    /*  y = get_BL_RG(p, x, y); */
    y->TORQUE_OUT[0] = 0.0;
    y->TORQUE_OUT[1] = 0.0;
    y->TORQUE_OUT[2] = 0.0;
    y->TORQUE_OUT[3] = 0.0;
  }
}

/*
 * File trailer for vcu_step.c
 *
 * [EOF]
 */
