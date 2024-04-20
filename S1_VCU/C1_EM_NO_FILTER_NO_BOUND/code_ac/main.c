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
#include "ac_compute_R.h"
#include "ac_compute_R_terminate.h"

static void argInit_1x151_real32_T(float result[151]);

static float argInit_real32_T(void);

static void argInit_1x151_real32_T(float result[151])
{
  int idx1;

  for (idx1 = 0; idx1 < 151; idx1++) {

    result[idx1] = argInit_real32_T();
  }
}

static float argInit_real32_T(void)
{
  return 0.0F;
}

int main(int argc, char **argv)
{
  (void)argc;
  (void)argv;

  main_ac_compute_R();

  ac_compute_R_terminate();
  return 0;
}

void main_ac_compute_R(void)
{
  float ax_tmp[151];
  float R[9];

  argInit_1x151_real32_T(ax_tmp);

  ac_compute_R(ax_tmp, ax_tmp, ax_tmp, R);
}
