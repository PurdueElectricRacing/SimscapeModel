/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: main.c
 *
 * MATLAB Coder version            : 23.2
 * C/C++ source code generated on  : 01-Feb-2025 15:30:23
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/

/* Include Files */
#include "main.h"
#include "get_y_cf.h"
#include "get_y_cf_types.h"

/* Function Declarations */
static void argInit_150x1_real_T(double result[150]);

static void argInit_1x10_real_T(double result[10]);

static void argInit_1x2_real_T(double result[2]);

static void argInit_1x3_real_T(double result[3]);

static void argInit_1x51_real_T(double result[51]);

static void argInit_1x53_real_T(double result[53]);

static void argInit_3x3_real_T(double result[9]);

static void argInit_506x1_real_T(double result[506]);

static void argInit_50x150_real_T(double result[7500]);

static void argInit_50x1_real_T(double result[50]);

static void argInit_51x53_real_T(double result[2703]);

static double argInit_real_T(void);

static void argInit_struct0_T(struct0_T *result);

static void argInit_struct1_T(struct1_T *result);

static void argInit_struct2_T(struct2_T *result);

/* Function Definitions */
/*
 * Arguments    : double result[150]
 * Return Type  : void
 */
static void argInit_150x1_real_T(double result[150])
{
  int idx0;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 150; idx0++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[10]
 * Return Type  : void
 */
static void argInit_1x10_real_T(double result[10])
{
  int idx1;
  /* Loop over the array to initialize each element. */
  for (idx1 = 0; idx1 < 10; idx1++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[idx1] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[2]
 * Return Type  : void
 */
static void argInit_1x2_real_T(double result[2])
{
  int idx1;
  /* Loop over the array to initialize each element. */
  for (idx1 = 0; idx1 < 2; idx1++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[idx1] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[3]
 * Return Type  : void
 */
static void argInit_1x3_real_T(double result[3])
{
  int idx1;
  /* Loop over the array to initialize each element. */
  for (idx1 = 0; idx1 < 3; idx1++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[idx1] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[51]
 * Return Type  : void
 */
static void argInit_1x51_real_T(double result[51])
{
  int idx1;
  /* Loop over the array to initialize each element. */
  for (idx1 = 0; idx1 < 51; idx1++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[idx1] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[53]
 * Return Type  : void
 */
static void argInit_1x53_real_T(double result[53])
{
  int idx1;
  /* Loop over the array to initialize each element. */
  for (idx1 = 0; idx1 < 53; idx1++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[idx1] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[9]
 * Return Type  : void
 */
static void argInit_3x3_real_T(double result[9])
{
  int i;
  /* Loop over the array to initialize each element. */
  for (i = 0; i < 9; i++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[i] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[506]
 * Return Type  : void
 */
static void argInit_506x1_real_T(double result[506])
{
  int idx0;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 506; idx0++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[7500]
 * Return Type  : void
 */
static void argInit_50x150_real_T(double result[7500])
{
  int i;
  /* Loop over the array to initialize each element. */
  for (i = 0; i < 7500; i++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[i] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[50]
 * Return Type  : void
 */
static void argInit_50x1_real_T(double result[50])
{
  int idx0;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 50; idx0++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

/*
 * Arguments    : double result[2703]
 * Return Type  : void
 */
static void argInit_51x53_real_T(double result[2703])
{
  int i;
  /* Loop over the array to initialize each element. */
  for (i = 0; i < 2703; i++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result[i] = argInit_real_T();
  }
}

/*
 * Arguments    : void
 * Return Type  : double
 */
static double argInit_real_T(void)
{
  return 0.0;
}

/*
 * Arguments    : struct0_T *result
 * Return Type  : void
 */
static void argInit_struct0_T(struct0_T *result)
{
  double result_tmp;
  /* Set the value of each structure field.
Change this value to the value that the application requires. */
  result_tmp = argInit_real_T();
  result->gr = result_tmp;
  result->Ns = result_tmp;
  result->CS_SFLAG_True = result_tmp;
  result->TB_SFLAG_True = result_tmp;
  result->SS_SFLAG_True = result_tmp;
  result->WT_SFLAG_True = result_tmp;
  result->IV_SFLAG_True = result_tmp;
  result->BT_SFLAG_True = result_tmp;
  result->MT_SFLAG_True = result_tmp;
  result->CT_SFLAG_True = result_tmp;
  result->MO_SFLAG_True = result_tmp;
  result->SS_FFLAG_True = result_tmp;
  result->AV_FFLAG_True = result_tmp;
  result->GS_FFLAG_True = result_tmp;
  result->VS_PFLAG_True = result_tmp;
  result->VT_PFLAG_True = result_tmp;
  result->TH_lb = result_tmp;
  result->ST_lb = result_tmp;
  result->VB_lb = result_tmp;
  argInit_1x2_real_T(result->ht);
  result->GS_lb = result_tmp;
  result->IB_lb = result_tmp;
  result->MT_lb = result_tmp;
  result->CT_lb = result_tmp;
  result->IT_lb = result_tmp;
  result->MC_lb = result_tmp;
  result->IC_lb = result_tmp;
  result->BT_lb = result_tmp;
  argInit_1x3_real_T(result->AV_lb);
  result->DB_lb = result_tmp;
  result->PI_lb = result_tmp;
  result->PP_lb = result_tmp;
  result->TH_ub = result_tmp;
  result->ST_ub = result_tmp;
  result->VB_ub = result_tmp;
  result->GS_ub = result_tmp;
  result->IB_ub = result_tmp;
  result->MT_ub = result_tmp;
  result->CT_ub = result_tmp;
  result->IT_ub = result_tmp;
  result->MC_ub = result_tmp;
  result->IC_ub = result_tmp;
  result->BT_ub = result_tmp;
  result->DB_ub = result_tmp;
  result->PI_ub = result_tmp;
  result->PP_ub = result_tmp;
  result->CF_IB_filter = result_tmp;
  result->zero_currents_to_update_SOC = result_tmp;
  result->Batt_cell_zero_SOC_voltage = result_tmp;
  result->Batt_cell_zero_SOC_capacity = result_tmp;
  result->Batt_cell_full_SOC_voltage = result_tmp;
  result->Batt_cell_full_SOC_capacity = result_tmp;
  result->MAX_TORQUE_NOM = result_tmp;
  result->mT_derating_full_T = result_tmp;
  result->mT_derating_zero_T = result_tmp;
  result->cT_derating_full_T = result_tmp;
  result->cT_derating_zero_T = result_tmp;
  result->bT_derating_full_T = result_tmp;
  result->bT_derating_zero_T = result_tmp;
  result->bI_derating_full_T = result_tmp;
  result->bI_derating_zero_T = result_tmp;
  result->Vb_derating_full_T = result_tmp;
  result->Vb_derating_zero_T = result_tmp;
  result->Ci_derating_full_T = result_tmp;
  result->Ci_derating_zero_T = result_tmp;
  result->Cm_derating_full_T = result_tmp;
  result->Cm_derating_zero_T = result_tmp;
  result->iT_derating_full_T = result_tmp;
  result->iT_derating_zero_T = result_tmp;
  result->dST_DB = result_tmp;
  result->r_power_sat = result_tmp;
  result->TC_eps = result_tmp;
  result->TC_sl_threshold = result_tmp;
  result->TC_throttle_mult = result_tmp;
  result->TC_highs_to_engage = result_tmp;
  result->TC_lows_to_disengage = result_tmp;
  result->r = result_tmp;
  argInit_3x3_real_T(result->R);
  argInit_506x1_real_T(result->Batt_Voc_brk);
  argInit_506x1_real_T(result->Batt_As_Discharged_tbl);
  argInit_150x1_real_T(result->PT_WM_brkpt);
  argInit_50x1_real_T(result->PT_VB_brkpt);
  argInit_50x150_real_T(result->PT_maxT_table);
  argInit_1x51_real_T(result->TV_vel_brkpt);
  argInit_1x53_real_T(result->TV_phi_brkpt);
  argInit_51x53_real_T(result->TV_yaw_table);
  result->WT_lb[0] = result->ht[0];
  result->WM_lb[0] = result->ht[0];
  result->WT_lb[1] = result->ht[1];
  result->WM_lb[1] = result->ht[1];
  result->AG_lb[0] = result->AV_lb[0];
  result->AG_lb[1] = result->AV_lb[1];
  result->AG_lb[2] = result->AV_lb[2];
  result->TO_lb[0] = result->ht[0];
  result->WT_ub[0] = result->ht[0];
  result->WM_ub[0] = result->ht[0];
  result->TO_lb[1] = result->ht[1];
  result->WT_ub[1] = result->ht[1];
  result->WM_ub[1] = result->ht[1];
  result->AV_ub[0] = result->AV_lb[0];
  result->AG_ub[0] = result->AV_lb[0];
  result->AV_ub[1] = result->AV_lb[1];
  result->AG_ub[1] = result->AV_lb[1];
  result->AV_ub[2] = result->AV_lb[2];
  result->AG_ub[2] = result->AV_lb[2];
  result->TO_ub[0] = result->ht[0];
  result->TO_ub[1] = result->ht[1];
}

/*
 * Arguments    : struct1_T *result
 * Return Type  : void
 */
static void argInit_struct1_T(struct1_T *result)
{
  double result_tmp;
  /* Set the value of each structure field.
Change this value to the value that the application requires. */
  result_tmp = argInit_real_T();
  result->ST_RAW = result_tmp;
  result->VB_RAW = result_tmp;
  argInit_1x2_real_T(result->WT_RAW);
  result->GS_RAW = result_tmp;
  result->IB_RAW = result_tmp;
  result->MT_RAW = result_tmp;
  result->CT_RAW = result_tmp;
  result->IT_RAW = result_tmp;
  result->MC_RAW = result_tmp;
  result->IC_RAW = result_tmp;
  result->BT_RAW = result_tmp;
  argInit_1x3_real_T(result->AV_RAW);
  result->DB_RAW = result_tmp;
  result->PI_RAW = result_tmp;
  result->PP_RAW = result_tmp;
  result->TH_RAW = result_tmp;
  result->WM_RAW[0] = result->WT_RAW[0];
  result->WM_RAW[1] = result->WT_RAW[1];
  result->AG_RAW[0] = result->AV_RAW[0];
  result->AG_RAW[1] = result->AV_RAW[1];
  result->AG_RAW[2] = result->AV_RAW[2];
  result->TO_RAW[0] = result->WT_RAW[0];
  result->TO_RAW[1] = result->WT_RAW[1];
}

/*
 * Arguments    : struct2_T *result
 * Return Type  : void
 */
static void argInit_struct2_T(struct2_T *result)
{
  double result_tmp;
  /* Set the value of each structure field.
Change this value to the value that the application requires. */
  result_tmp = argInit_real_T();
  result->TH_CF = result_tmp;
  result->ST_CF = result_tmp;
  result->VB_CF = result_tmp;
  argInit_1x2_real_T(result->WT_CF);
  result->GS_CF = result_tmp;
  result->IB_CF = result_tmp;
  result->MT_CF = result_tmp;
  result->CT_CF = result_tmp;
  result->IT_CF = result_tmp;
  result->MC_CF = result_tmp;
  result->IC_CF = result_tmp;
  result->BT_CF = result_tmp;
  argInit_1x3_real_T(result->AV_CF);
  result->DB_CF = result_tmp;
  result->PI_CF = result_tmp;
  result->PP_CF = result_tmp;
  result->Batt_SOC = result_tmp;
  result->zero_current_counter = result_tmp;
  result->VT_mode = result_tmp;
  result->TC_highs = result_tmp;
  result->TC_lows = result_tmp;
  result->VCU_mode = result_tmp;
  argInit_1x10_real_T(result->IB_CF_vec);
  result->WM_CF[0] = result->WT_CF[0];
  result->WM_CF[1] = result->WT_CF[1];
  result->AG_CF[0] = result->AV_CF[0];
  result->AG_CF[1] = result->AV_CF[1];
  result->AG_CF[2] = result->AV_CF[2];
  result->TO_CF[0] = result->WT_CF[0];
  result->TO_ET[0] = result->WT_CF[0];
  result->TO_AB_MX[0] = result->WT_CF[0];
  result->TO_DR_MX[0] = result->WT_CF[0];
  result->TO_PT[0] = result->WT_CF[0];
  result->TO_CF[1] = result->WT_CF[1];
  result->TO_ET[1] = result->WT_CF[1];
  result->TO_AB_MX[1] = result->WT_CF[1];
  result->TO_DR_MX[1] = result->WT_CF[1];
  result->TO_PT[1] = result->WT_CF[1];
}

/*
 * Arguments    : int argc
 *                char **argv
 * Return Type  : int
 */
int main(int argc, char **argv)
{
  (void)argc;
  (void)argv;
  /* The initialize function is being called automatically from your entry-point
   * function. So, a call to initialize is not included here. */
  /* Invoke the entry-point functions.
You can call entry-point functions multiple times. */
  main_get_y_cf();
  /* Terminate the application.
You do not need to do this more than one time. */
  get_y_cf_terminate();
  return 0;
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void main_get_y_cf(void)
{
  struct0_T r;
  struct1_T r1;
  struct2_T y;
  /* Initialize function 'get_y_cf' input arguments. */
  /* Initialize function input argument 'p'. */
  /* Initialize function input argument 'x'. */
  /* Initialize function input argument 'y'. */
  /* Call the entry-point 'get_y_cf'. */
  argInit_struct2_T(&y);
  argInit_struct0_T(&r);
  argInit_struct1_T(&r1);
  get_y_cf(&r, &r1, &y);
}

/*
 * File trailer for main.c
 *
 * [EOF]
 */
