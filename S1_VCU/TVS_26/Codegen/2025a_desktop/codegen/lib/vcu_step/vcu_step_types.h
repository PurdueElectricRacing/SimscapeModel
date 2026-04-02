/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: vcu_step_types.h
 *
 * MATLAB Coder version            : 25.1
 * C/C++ source code generated on  : 02-Apr-2026 17:56:15
 */

#ifndef VCU_STEP_TYPES_H
#define VCU_STEP_TYPES_H

/* Include Files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_pVCU_struct
#define typedef_pVCU_struct
typedef struct {
  double r;
  double ht[2];
  double wb;
  double gr;
  double MAX_TO_ABS;
  double PB_derating_full_T;
  double PB_derating_half_T;
  double PB_derating_FR;
  double INV_T_derating_full_T;
  double INV_derating_zero_T;
  double IGBT_derating_full_T;
  double IGBT_derating_zero_T;
  double MT_derating_full_T;
  double MT_derating_zero_T;
  double BT_derating_full_T;
  double BT_derating_zero_T;
  double VB_derating_full_T;
  double VB_derating_zero_T;
  double IB_derating_full_T;
  double IB_derating_zero_T;
} pVCU_struct;
#endif /* typedef_pVCU_struct */

#ifndef typedef_xVCU_struct
#define typedef_xVCU_struct
typedef struct {
  double TH_RAW;
  double ST_RAW;
  double VB_RAW;
  double WM_RAW[4];
  double GS_RAW;
  double AV_RAW[3];
  double IB_RAW;
  double MT_RAW;
  double IGBT_T_RAW;
  double INV_T_RAW;
  double MC_RAW;
  double IC_RAW;
  double BT_RAW;
  double TO_RAW[4];
} xVCU_struct;
#endif /* typedef_xVCU_struct */

#ifndef typedef_yVCU_struct
#define typedef_yVCU_struct
typedef struct {
  double TH;
  double TH_PO;
  double TH_RG;
  double ST;
  double VB;
  double WM[4];
  double GS;
  double AV[3];
  double IB;
  double MT;
  double IGBT_T;
  double INV_T;
  double MC;
  double IC;
  double BT;
  double TO[4];
  double PB;
  double TO_BL_PO[4];
  double TORQUE_OUT[4];
} yVCU_struct;
#endif /* typedef_yVCU_struct */

#endif
/*
 * File trailer for vcu_step_types.h
 *
 * [EOF]
 */
