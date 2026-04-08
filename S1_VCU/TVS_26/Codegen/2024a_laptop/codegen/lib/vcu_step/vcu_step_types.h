#ifndef VCU_STEP_TYPES_H
#define VCU_STEP_TYPES_H

#include "rtwtypes.h"

#ifndef typedef_struct0_T
#define typedef_struct0_T
typedef struct {
  float r;
  float ht[2];
  float wb;
  float gr;
  float MAX_TO_ABS_PO;
  float MAX_TO_ABS_RG;
  float PB_derating_full_T;
  float PB_derating_half_T;
  float PB_derating_FR;
  float INV_T_derating_full_T;
  float INV_T_derating_zero_T;
  float IGBT_T_derating_full_T;
  float IGBT_T_derating_zero_T;
  float MT_derating_full_T;
  float MT_derating_zero_T;
  float BT_derating_full_T;
  float BT_derating_zero_T;
  float VB_derating_full_T;
  float VB_derating_zero_T;
  float IB_derating_full_T;
  float IB_derating_zero_T;
  float VB_RG_derating_full_T;
  float VB_RG_derating_zero_T;
  float IB_RG_derating_full_T;
  float IB_RG_derating_zero_T;
  float GS_RG_derating_zero;
  float GS_RG_derating_full;
} struct0_T;
#endif

#ifndef typedef_struct1_T
#define typedef_struct1_T
typedef struct {
  float TH_RAW;
  float ST_RAW;
  float VB_RAW;
  float WM_RAW[4];
  float GS_RAW;
  float AV_RAW[3];
  float IB_RAW;
  float MT_RAW;
  float IGBT_T_RAW;
  float INV_T_RAW;
  float MC_RAW;
  float IC_RAW;
  float BT_RAW;
  float TO_RAW[4];
} struct1_T;
#endif

#ifndef typedef_struct2_T
#define typedef_struct2_T
typedef struct {
  float TH;
  float TH_PO;
  float TH_RG;
  float ST;
  float VB;
  float WM[4];
  float GS;
  float AV[3];
  float IB;
  float MT;
  float IGBT_T;
  float INV_T;
  float MC;
  float IC;
  float BT;
  float TO[4];
  float PB;
  float TO_BL_PO[4];
  float TO_BL_RG[4];
  float TORQUE_OUT[4];
} struct2_T;
#endif

#endif
