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

#include "main.h"
#include "get_ET.h"
#include "get_ET_types.h"

static void argInit_150x1_real_T(double result[150]);

static void argInit_1x10_real_T(double result[10]);

static void argInit_1x2_real_T(double result[2]);

static void argInit_1x3_real_T(double result[3]);

static void argInit_1x51_real_T(double result[51]);

static void argInit_1x53_real_T(double result[53]);

static void argInit_1x5_real_T(double result[5]);

static void argInit_3x3_real_T(double result[9]);

static void argInit_506x1_real_T(double result[506]);

static void argInit_50x150_real_T(double result[7500]);

static void argInit_50x1_real_T(double result[50]);

static void argInit_51x53_real_T(double result[2703]);

static double argInit_real_T(void);

static void argInit_struct0_T(struct0_T *result);

static void argInit_struct1_T(struct1_T *result);

static void argInit_150x1_real_T(double result[150])
{
  int idx0;

  for (idx0 = 0; idx0 < 150; idx0++) {

    result[idx0] = argInit_real_T();
  }
}

static void argInit_1x10_real_T(double result[10])
{
  int idx1;

  for (idx1 = 0; idx1 < 10; idx1++) {

    result[idx1] = argInit_real_T();
  }
}

static void argInit_1x2_real_T(double result[2])
{
  int idx1;

  for (idx1 = 0; idx1 < 2; idx1++) {

    result[idx1] = argInit_real_T();
  }
}

static void argInit_1x3_real_T(double result[3])
{
  int idx1;

  for (idx1 = 0; idx1 < 3; idx1++) {

    result[idx1] = argInit_real_T();
  }
}

static void argInit_1x51_real_T(double result[51])
{
  int idx1;

  for (idx1 = 0; idx1 < 51; idx1++) {

    result[idx1] = argInit_real_T();
  }
}

static void argInit_1x53_real_T(double result[53])
{
  int idx1;

  for (idx1 = 0; idx1 < 53; idx1++) {

    result[idx1] = argInit_real_T();
  }
}

static void argInit_1x5_real_T(double result[5])
{
  int idx1;

  for (idx1 = 0; idx1 < 5; idx1++) {

    result[idx1] = argInit_real_T();
  }
}

static void argInit_3x3_real_T(double result[9])
{
  int i;

  for (i = 0; i < 9; i++) {

    result[i] = argInit_real_T();
  }
}

static void argInit_506x1_real_T(double result[506])
{
  int idx0;

  for (idx0 = 0; idx0 < 506; idx0++) {

    result[idx0] = argInit_real_T();
  }
}

static void argInit_50x150_real_T(double result[7500])
{
  int i;

  for (i = 0; i < 7500; i++) {

    result[i] = argInit_real_T();
  }
}

static void argInit_50x1_real_T(double result[50])
{
  int idx0;

  for (idx0 = 0; idx0 < 50; idx0++) {

    result[idx0] = argInit_real_T();
  }
}

static void argInit_51x53_real_T(double result[2703])
{
  int i;

  for (i = 0; i < 2703; i++) {

    result[i] = argInit_real_T();
  }
}

static double argInit_real_T(void)
{
  return 0.0;
}

static void argInit_struct0_T(struct0_T *result)
{
  double result_tmp;

  result_tmp = argInit_real_T();
  result->gr = result_tmp;
  result->Ns = result_tmp;
  result->ET_permit_N = result_tmp;
  result->PT_permit_N = result_tmp;
  result->VS_permit_N = result_tmp;
  result->VT_permit_N = result_tmp;
  result->CS_SFLAG_True = result_tmp;
  result->TB_SFLAG_True = result_tmp;
  result->SS_SFLAG_True = result_tmp;
  result->WT_SFLAG_True = result_tmp;
  result->IV_SFLAG_True = result_tmp;
  result->BT_SFLAG_True = result_tmp;
  result->MT_SFLAG_True = result_tmp;
  result->CO_SFLAG_True = result_tmp;
  result->MO_SFLAG_True = result_tmp;
  result->SS_FFLAG_True = result_tmp;
  result->AV_FFLAG_True = result_tmp;
  result->GS_FFLAG_True = result_tmp;
  result->VCU_PFLAG_VS = result_tmp;
  result->VCU_PFLAG_VT = result_tmp;
  result->TH_lb = result_tmp;
  result->ST_lb = result_tmp;
  result->VB_lb = result_tmp;
  argInit_1x2_real_T(result->WT_lb);
  result->GS_lb = result_tmp;
  result->IB_lb = result_tmp;
  result->MT_lb = result_tmp;
  result->CT_lb = result_tmp;
  result->IT_lb = result_tmp;
  result->MC_lb = result_tmp;
  result->IC_lb = result_tmp;
  result->BT_lb = result_tmp;
  argInit_1x3_real_T(result->AG_lb);
  result->DB_lb = result_tmp;
  result->PI_lb = result_tmp;
  result->PP_lb = result_tmp;
  result->TH_ub = result_tmp;
  result->ST_ub = result_tmp;
  result->VB_ub = result_tmp;
  result->WM_lb[0] = result->WT_lb[0];
  result->TO_lb[0] = result->WT_lb[0];
  result->WT_ub[0] = result->WT_lb[0];
  result->WM_ub[0] = result->WT_lb[0];
  result->WM_lb[1] = result->WT_lb[1];
  result->TO_lb[1] = result->WT_lb[1];
  result->WT_ub[1] = result->WT_lb[1];
  result->WM_ub[1] = result->WT_lb[1];
  result->GS_ub = result_tmp;
  result->IB_ub = result_tmp;
  result->MT_ub = result_tmp;
  result->CT_ub = result_tmp;
  result->IT_ub = result_tmp;
  result->MC_ub = result_tmp;
  result->IC_ub = result_tmp;
  result->BT_ub = result_tmp;
  result->AV_ub[0] = result->AG_lb[0];
  result->AG_ub[0] = result->AG_lb[0];
  result->AV_ub[1] = result->AG_lb[1];
  result->AG_ub[1] = result->AG_lb[1];
  result->AV_ub[2] = result->AG_lb[2];
  result->AG_ub[2] = result->AG_lb[2];
  result->DB_ub = result_tmp;
  result->PI_ub = result_tmp;
  result->PP_ub = result_tmp;
  result->CF_IB_filter_N = result_tmp;
  result->zero_currents_to_update_SOC = result_tmp;
  result->Batt_cell_zero_SOC_voltage = result_tmp;
  result->Batt_cell_zero_SOC_capacity = result_tmp;
  result->Batt_cell_full_SOC_voltage = result_tmp;
  result->Batt_cell_full_SOC_capacity = result_tmp;
  result->MAX_TORQUE_NOM = result_tmp;
  result->PT_WM_lb = result_tmp;
  result->PT_WM_ub = result_tmp;
  result->PT_VB_lb = result_tmp;
  result->PT_VB_ub = result_tmp;
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
  result->TV_ST_lb = result_tmp;
  result->TV_ST_ub = result_tmp;
  result->TV_GS_lb = result_tmp;
  result->TV_GS_ub = result_tmp;
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
  argInit_50x150_real_T(result->PT_TO_table);
  argInit_1x51_real_T(result->TV_GS_brkpt);
  argInit_1x53_real_T(result->TV_ST_brkpt);
  argInit_51x53_real_T(result->TV_AV_table);
  result->TO_ub[0] = result->WT_lb[0];
  result->ht[0] = result->WT_lb[0];
  result->TO_ub[1] = result->WT_lb[1];
  result->ht[1] = result->WT_lb[1];
  result->AV_lb[0] = result->AG_lb[0];
  result->AV_lb[1] = result->AG_lb[1];
  result->AV_lb[2] = result->AG_lb[2];
}

static void argInit_struct1_T(struct1_T *result)
{
  double result_tmp;
  int i;

  argInit_1x5_real_T(result->PT_permit_buffer);
  result_tmp = argInit_real_T();
  result->TH_CF = result_tmp;
  result->ST_CF = result_tmp;
  result->VB_CF = result_tmp;
  argInit_1x2_real_T(result->WM_CF);
  result->GS_CF = result_tmp;
  result->IB_CF = result_tmp;
  result->MT_CF = result_tmp;
  result->CT_CF = result_tmp;
  result->IT_CF = result_tmp;
  result->MC_CF = result_tmp;
  result->IC_CF = result_tmp;
  result->BT_CF = result_tmp;
  argInit_1x3_real_T(result->AG_CF);
  result->DB_CF = result_tmp;
  result->PI_CF = result_tmp;
  result->PP_CF = result_tmp;
  result->Batt_SOC = result_tmp;
  result->zero_current_counter = result_tmp;
  result->TO_AB_MX = result_tmp;
  result->TO_DR_MX = result_tmp;
  result->VT_mode = result_tmp;
  result->TO_CF[0] = result->WM_CF[0];
  result->TO_ET[0] = result->WM_CF[0];
  result->TO_PT[0] = result->WM_CF[0];
  result->WM_VS[0] = result->WM_CF[0];
  result->TO_VT[0] = result->WM_CF[0];
  result->TO_CF[1] = result->WM_CF[1];
  result->TO_ET[1] = result->WM_CF[1];
  result->TO_PT[1] = result->WM_CF[1];
  result->WM_VS[1] = result->WM_CF[1];
  result->TO_VT[1] = result->WM_CF[1];
  result->TV_AV_ref = result_tmp;
  result->TV_delta_torque = result_tmp;
  result->TC_highs = result_tmp;
  result->TC_lows = result_tmp;
  result->sl = result_tmp;
  result->VCU_mode = result_tmp;
  argInit_1x10_real_T(result->IB_CF_buffer);
  for (i = 0; i < 5; i++) {
    result->VS_permit_buffer[i] = result->PT_permit_buffer[i];
    result->VT_permit_buffer[i] = result->PT_permit_buffer[i];
    result->ET_permit_buffer[i] = result->PT_permit_buffer[i];
  }
  result->WT_CF[0] = result->WM_CF[0];
  result->WT_CF[1] = result->WM_CF[1];
  result->AV_CF[0] = result->AG_CF[0];
  result->AV_CF[1] = result->AG_CF[1];
  result->AV_CF[2] = result->AG_CF[2];
}

int main(int argc, char **argv)
{
  (void)argc;
  (void)argv;

  main_get_ET();
  return 0;
}

void main_get_ET(void)
{
  struct0_T r;
  struct1_T y;

  argInit_struct1_T(&y);
  argInit_struct0_T(&r);
  get_ET(&r, &y);
}
