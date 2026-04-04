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
#include "vcu_step.h"
#include "vcu_step_types.h"

static void argInit_1x2_real_T(double result[2]);

static void argInit_1x3_real_T(double result[3]);

static void argInit_1x4_real_T(double result[4]);

static void argInit_pVCU_struc(pVCU_struc *result);

static double argInit_real_T(void);

static void argInit_xVCU_struc(xVCU_struc *result);

static void argInit_yVCU_struc(yVCU_struc *result);

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

static void argInit_1x4_real_T(double result[4])
{
  int idx1;

  for (idx1 = 0; idx1 < 4; idx1++) {

    result[idx1] = argInit_real_T();
  }
}

static void argInit_pVCU_struc(pVCU_struc *result)
{
  double result_tmp;

  result_tmp = argInit_real_T();
  result->r = result_tmp;
  argInit_1x2_real_T(result->ht);
  result->wb = result_tmp;
  result->gr = result_tmp;
  result->MAX_TO_ABS = result_tmp;
  result->PB_derating_full_T = result_tmp;
  result->PB_derating_half_T = result_tmp;
  result->PB_derating_FR = result_tmp;
  result->INV_T_derating_full_T = result_tmp;
  result->INV_derating_zero_T = result_tmp;
  result->IGBT_derating_full_T = result_tmp;
  result->IGBT_derating_zero_T = result_tmp;
  result->MT_derating_full_T = result_tmp;
  result->MT_derating_zero_T = result_tmp;
  result->BT_derating_full_T = result_tmp;
  result->BT_derating_zero_T = result_tmp;
  result->VB_derating_full_T = result_tmp;
  result->VB_derating_zero_T = result_tmp;
  result->IB_derating_full_T = result_tmp;
  result->IB_derating_zero_T = result_tmp;
}

static double argInit_real_T(void)
{
  return 0.0;
}

static void argInit_xVCU_struc(xVCU_struc *result)
{
  double result_tmp;

  result_tmp = argInit_real_T();
  argInit_1x4_real_T(result->WM_RAW);
  result->TH_RAW = result_tmp;
  result->ST_RAW = result_tmp;
  result->VB_RAW = result_tmp;
  result->GS_RAW = result_tmp;
  argInit_1x3_real_T(result->AV_RAW);
  result->IB_RAW = result_tmp;
  result->MT_RAW = result_tmp;
  result->IGBT_T_RAW = result_tmp;
  result->INV_T_RAW = result_tmp;
  result->MC_RAW = result_tmp;
  result->IC_RAW = result_tmp;
  result->BT_RAW = result_tmp;
  result->TO_RAW[0] = result->WM_RAW[0];
  result->TO_RAW[1] = result->WM_RAW[1];
  result->TO_RAW[2] = result->WM_RAW[2];
  result->TO_RAW[3] = result->WM_RAW[3];
}

static void argInit_yVCU_struc(yVCU_struc *result)
{
  double result_tmp;

  result_tmp = argInit_real_T();
  argInit_1x4_real_T(result->WM);
  result->TH = result_tmp;
  result->TH_PO = result_tmp;
  result->TH_RG = result_tmp;
  result->ST = result_tmp;
  result->VB = result_tmp;
  result->GS = result_tmp;
  argInit_1x3_real_T(result->AV);
  result->IB = result_tmp;
  result->MT = result_tmp;
  result->IGBT_T = result_tmp;
  result->INV_T = result_tmp;
  result->MC = result_tmp;
  result->IC = result_tmp;
  result->BT = result_tmp;
  result->PB = result_tmp;
  result->TO[0] = result->WM[0];
  result->TO_BL_PO[0] = result->WM[0];
  result->TORQUE_OUT[0] = result->WM[0];
  result->TO[1] = result->WM[1];
  result->TO_BL_PO[1] = result->WM[1];
  result->TORQUE_OUT[1] = result->WM[1];
  result->TO[2] = result->WM[2];
  result->TO_BL_PO[2] = result->WM[2];
  result->TORQUE_OUT[2] = result->WM[2];
  result->TO[3] = result->WM[3];
  result->TO_BL_PO[3] = result->WM[3];
  result->TORQUE_OUT[3] = result->WM[3];
}

int main(int argc, char **argv)
{
  (void)argc;
  (void)argv;

  main_vcu_step();
  return 0;
}

void main_vcu_step(void)
{
  pVCU_struc r;
  xVCU_struc r1;
  yVCU_struc y;

  argInit_yVCU_struc(&y);
  argInit_pVCU_struc(&r);
  argInit_xVCU_struc(&r1);
  vcu_step(&r, &r1, &y);
}
