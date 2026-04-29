#include "_coder_vcu_step_api.h"
#include "_coder_vcu_step_mex.h"

emlrtCTX emlrtRootTLSGlobal = NULL;

emlrtContext emlrtContextGlobal = {
    true,       false,
    131643U,    NULL,
    "vcu_step", NULL,
    false,      {2045744189U, 2170104910U, 2743257031U, 4284093946U},
    NULL};

static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               pVCU_struct *y);

static const mxArray *b_emlrt_marshallOut(const real32_T u[4]);

static real32_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId);

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[2]);

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[3]);

static void emlrtExitTimeCleanupDtorFcn(const void *r);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                             const char_T *identifier, pVCU_struct *y);

static const mxArray *emlrt_marshallOut(const yVCU_struct *u);

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, xVCU_struct *y);

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               xVCU_struct *y);

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[4]);

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, yVCU_struct *y);

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               yVCU_struct *y);

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[10]);

static real32_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId);

static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[2]);

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[3]);

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[4]);

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[10]);

static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               pVCU_struct *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[45] = {"r",
                                         "ht",
                                         "wb",
                                         "gr",
                                         "MAX_ABS_WM",
                                         "IB_AVG_length",
                                         "MAX_TO_ABS_PO",
                                         "PB_derating_full_T",
                                         "PB_derating_half_T",
                                         "PB_derating_FR",
                                         "VB_derating_full_T",
                                         "VB_derating_zero_T",
                                         "IB_derating_full_T",
                                         "IB_derating_zero_T",
                                         "OV_MOT_derating_full_T",
                                         "OV_MOT_derating_zero_T",
                                         "OV_INV_derating_full_T",
                                         "OV_INV_derating_zero_T",
                                         "MAX_TO_ABS_RG",
                                         "VB_RG_derating_full_T",
                                         "VB_RG_derating_zero_T",
                                         "IB_RG_derating_full_T",
                                         "IB_RG_derating_zero_T",
                                         "GS_RG_derating_zero",
                                         "GS_RG_derating_full",
                                         "INV_T_derating_full_T",
                                         "INV_T_derating_zero_T",
                                         "IGBT_T_derating_full_T",
                                         "IGBT_T_derating_zero_T",
                                         "MT_derating_full_T",
                                         "MT_derating_zero_T",
                                         "BT_derating_full_T",
                                         "BT_derating_zero_T",
                                         "AC_speed_brkpt",
                                         "AC_speed_table",
                                         "AC_brkpt_lb",
                                         "AC_brkpt_ub",
                                         "SK_YAW_des",
                                         "SK_LR_split_des",
                                         "SK_ST_ZERO_TV",
                                         "SK_ST_FULL_TV",
                                         "AX_YAW_des",
                                         "AX_ST_ZERO_TV",
                                         "AX_ST_FULL_TV",
                                         "AX_LR_split_des"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 45,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "r";
  y->r = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 0, "r")),
      &thisId);
  thisId.fIdentifier = "ht";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1, "ht")),
      &thisId, y->ht);
  thisId.fIdentifier = "wb";
  y->wb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 2, "wb")),
      &thisId);
  thisId.fIdentifier = "gr";
  y->gr = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 3, "gr")),
      &thisId);
  thisId.fIdentifier = "MAX_ABS_WM";
  y->MAX_ABS_WM = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 4, "MAX_ABS_WM")),
      &thisId);
  thisId.fIdentifier = "IB_AVG_length";
  y->IB_AVG_length =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        5, "IB_AVG_length")),
                         &thisId);
  thisId.fIdentifier = "MAX_TO_ABS_PO";
  y->MAX_TO_ABS_PO =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        6, "MAX_TO_ABS_PO")),
                         &thisId);
  thisId.fIdentifier = "PB_derating_full_T";
  y->PB_derating_full_T =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtConstCTX)sp, u, 0, 7, "PB_derating_full_T")),
                         &thisId);
  thisId.fIdentifier = "PB_derating_half_T";
  y->PB_derating_half_T =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtConstCTX)sp, u, 0, 8, "PB_derating_half_T")),
                         &thisId);
  thisId.fIdentifier = "PB_derating_FR";
  y->PB_derating_FR =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        9, "PB_derating_FR")),
                         &thisId);
  thisId.fIdentifier = "VB_derating_full_T";
  y->VB_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 10,
                                     "VB_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "VB_derating_zero_T";
  y->VB_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 11,
                                     "VB_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "IB_derating_full_T";
  y->IB_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 12,
                                     "IB_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "IB_derating_zero_T";
  y->IB_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 13,
                                     "IB_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "OV_MOT_derating_full_T";
  y->OV_MOT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 14,
                                     "OV_MOT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "OV_MOT_derating_zero_T";
  y->OV_MOT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 15,
                                     "OV_MOT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "OV_INV_derating_full_T";
  y->OV_INV_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 16,
                                     "OV_INV_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "OV_INV_derating_zero_T";
  y->OV_INV_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 17,
                                     "OV_INV_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "MAX_TO_ABS_RG";
  y->MAX_TO_ABS_RG =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        18, "MAX_TO_ABS_RG")),
                         &thisId);
  thisId.fIdentifier = "VB_RG_derating_full_T";
  y->VB_RG_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 19,
                                     "VB_RG_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "VB_RG_derating_zero_T";
  y->VB_RG_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 20,
                                     "VB_RG_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "IB_RG_derating_full_T";
  y->IB_RG_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 21,
                                     "IB_RG_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "IB_RG_derating_zero_T";
  y->IB_RG_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 22,
                                     "IB_RG_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "GS_RG_derating_zero";
  y->GS_RG_derating_zero = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 23,
                                     "GS_RG_derating_zero")),
      &thisId);
  thisId.fIdentifier = "GS_RG_derating_full";
  y->GS_RG_derating_full = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 24,
                                     "GS_RG_derating_full")),
      &thisId);
  thisId.fIdentifier = "INV_T_derating_full_T";
  y->INV_T_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 25,
                                     "INV_T_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "INV_T_derating_zero_T";
  y->INV_T_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 26,
                                     "INV_T_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "IGBT_T_derating_full_T";
  y->IGBT_T_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 27,
                                     "IGBT_T_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "IGBT_T_derating_zero_T";
  y->IGBT_T_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 28,
                                     "IGBT_T_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "MT_derating_full_T";
  y->MT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 29,
                                     "MT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "MT_derating_zero_T";
  y->MT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 30,
                                     "MT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "BT_derating_full_T";
  y->BT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 31,
                                     "BT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "BT_derating_zero_T";
  y->BT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 32,
                                     "BT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "AC_speed_brkpt";
  e_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 33,
                                                    "AC_speed_brkpt")),
                     &thisId, y->AC_speed_brkpt);
  thisId.fIdentifier = "AC_speed_table";
  e_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 34,
                                                    "AC_speed_table")),
                     &thisId, y->AC_speed_table);
  thisId.fIdentifier = "AC_brkpt_lb";
  y->AC_brkpt_lb =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        35, "AC_brkpt_lb")),
                         &thisId);
  thisId.fIdentifier = "AC_brkpt_ub";
  y->AC_brkpt_ub =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        36, "AC_brkpt_ub")),
                         &thisId);
  thisId.fIdentifier = "SK_YAW_des";
  y->SK_YAW_des =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        37, "SK_YAW_des")),
                         &thisId);
  thisId.fIdentifier = "SK_LR_split_des";
  y->SK_LR_split_des =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        38, "SK_LR_split_des")),
                         &thisId);
  thisId.fIdentifier = "SK_ST_ZERO_TV";
  y->SK_ST_ZERO_TV =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        39, "SK_ST_ZERO_TV")),
                         &thisId);
  thisId.fIdentifier = "SK_ST_FULL_TV";
  y->SK_ST_FULL_TV =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        40, "SK_ST_FULL_TV")),
                         &thisId);
  thisId.fIdentifier = "AX_YAW_des";
  y->AX_YAW_des =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        41, "AX_YAW_des")),
                         &thisId);
  thisId.fIdentifier = "AX_ST_ZERO_TV";
  y->AX_ST_ZERO_TV =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        42, "AX_ST_ZERO_TV")),
                         &thisId);
  thisId.fIdentifier = "AX_ST_FULL_TV";
  y->AX_ST_FULL_TV =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        43, "AX_ST_FULL_TV")),
                         &thisId);
  thisId.fIdentifier = "AX_LR_split_des";
  y->AX_LR_split_des =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        44, "AX_LR_split_des")),
                         &thisId);
  emlrtDestroyArray(&u);
}

static const mxArray *b_emlrt_marshallOut(const real32_T u[4])
{
  static const int32_T iv[2] = {1, 4};
  const mxArray *m;
  const mxArray *y;
  real32_T *pData;
  y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxSINGLE_CLASS, mxREAL);
  pData = (real32_T *)emlrtMxGetData(m);
  pData[0] = u[0];
  pData[1] = u[1];
  pData[2] = u[2];
  pData[3] = u[3];
  emlrtAssign(&y, m);
  return y;
}

static real32_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId)
{
  real32_T y;
  y = l_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[2])
{
  m_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[3])
{
  n_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrtExitTimeCleanupDtorFcn(const void *r)
{
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                             const char_T *identifier, pVCU_struct *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static const mxArray *emlrt_marshallOut(const yVCU_struct *u)
{
  static const int32_T iv[2] = {1, 3};
  static const int32_T iv1[2] = {1, 10};
  static const char_T *sv[35] = {"VCU_MODE",
                                 "TH",
                                 "TH_PO",
                                 "TH_RG",
                                 "ST",
                                 "VB",
                                 "WM",
                                 "GS",
                                 "AV",
                                 "IB",
                                 "MT",
                                 "IGBT_T",
                                 "INV_T",
                                 "OV_MOT",
                                 "OV_INV",
                                 "BT",
                                 "TO",
                                 "IB_AVG_buffer",
                                 "PB",
                                 "WW",
                                 "IB_AVG",
                                 "TO_BL_PO",
                                 "RG_split_FR",
                                 "TO_BL_RG",
                                 "AC_MW",
                                 "SK_TO",
                                 "SK_FR_split",
                                 "SK_LR_gain",
                                 "AX_TO",
                                 "AX_FR_split",
                                 "AX_LR_gain",
                                 "TORQUE_LIM_NEG",
                                 "TORQUE_LIM_POS",
                                 "SPEED_OUT",
                                 "TORQUE_OUT"};
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *f_y;
  const mxArray *g_y;
  const mxArray *h_y;
  const mxArray *i_y;
  const mxArray *j_y;
  const mxArray *k_y;
  const mxArray *l_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m10;
  const mxArray *m11;
  const mxArray *m12;
  const mxArray *m13;
  const mxArray *m14;
  const mxArray *m15;
  const mxArray *m16;
  const mxArray *m17;
  const mxArray *m18;
  const mxArray *m19;
  const mxArray *m2;
  const mxArray *m20;
  const mxArray *m3;
  const mxArray *m4;
  const mxArray *m5;
  const mxArray *m6;
  const mxArray *m7;
  const mxArray *m8;
  const mxArray *m9;
  const mxArray *m_y;
  const mxArray *n_y;
  const mxArray *o_y;
  const mxArray *p_y;
  const mxArray *q_y;
  const mxArray *r_y;
  const mxArray *s_y;
  const mxArray *t_y;
  const mxArray *u_y;
  const mxArray *v_y;
  const mxArray *y;
  int32_T i;
  real32_T *b_pData;
  real32_T *pData;
  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 35, (const char_T **)&sv[0]));
  b_y = NULL;
  m = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m) = u->VCU_MODE;
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "VCU_MODE", b_y, 0);
  c_y = NULL;
  m1 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m1) = u->TH;
  emlrtAssign(&c_y, m1);
  emlrtSetFieldR2017b(y, 0, "TH", c_y, 1);
  d_y = NULL;
  m2 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m2) = u->TH_PO;
  emlrtAssign(&d_y, m2);
  emlrtSetFieldR2017b(y, 0, "TH_PO", d_y, 2);
  e_y = NULL;
  m3 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m3) = u->TH_RG;
  emlrtAssign(&e_y, m3);
  emlrtSetFieldR2017b(y, 0, "TH_RG", e_y, 3);
  f_y = NULL;
  m4 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m4) = u->ST;
  emlrtAssign(&f_y, m4);
  emlrtSetFieldR2017b(y, 0, "ST", f_y, 4);
  g_y = NULL;
  m5 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m5) = u->VB;
  emlrtAssign(&g_y, m5);
  emlrtSetFieldR2017b(y, 0, "VB", g_y, 5);
  emlrtSetFieldR2017b(y, 0, "WM", b_emlrt_marshallOut(u->WM), 6);
  h_y = NULL;
  m6 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m6) = u->GS;
  emlrtAssign(&h_y, m6);
  emlrtSetFieldR2017b(y, 0, "GS", h_y, 7);
  i_y = NULL;
  m7 = emlrtCreateNumericArray(2, (const void *)&iv[0], mxSINGLE_CLASS, mxREAL);
  pData = (real32_T *)emlrtMxGetData(m7);
  pData[0] = u->AV[0];
  pData[1] = u->AV[1];
  pData[2] = u->AV[2];
  emlrtAssign(&i_y, m7);
  emlrtSetFieldR2017b(y, 0, "AV", i_y, 8);
  j_y = NULL;
  m8 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m8) = u->IB;
  emlrtAssign(&j_y, m8);
  emlrtSetFieldR2017b(y, 0, "IB", j_y, 9);
  k_y = NULL;
  m9 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m9) = u->MT;
  emlrtAssign(&k_y, m9);
  emlrtSetFieldR2017b(y, 0, "MT", k_y, 10);
  l_y = NULL;
  m10 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m10) = u->IGBT_T;
  emlrtAssign(&l_y, m10);
  emlrtSetFieldR2017b(y, 0, "IGBT_T", l_y, 11);
  m_y = NULL;
  m11 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m11) = u->INV_T;
  emlrtAssign(&m_y, m11);
  emlrtSetFieldR2017b(y, 0, "INV_T", m_y, 12);
  emlrtSetFieldR2017b(y, 0, "OV_MOT", b_emlrt_marshallOut(u->OV_MOT), 13);
  emlrtSetFieldR2017b(y, 0, "OV_INV", b_emlrt_marshallOut(u->OV_INV), 14);
  n_y = NULL;
  m12 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m12) = u->BT;
  emlrtAssign(&n_y, m12);
  emlrtSetFieldR2017b(y, 0, "BT", n_y, 15);
  emlrtSetFieldR2017b(y, 0, "TO", b_emlrt_marshallOut(u->TO), 16);
  o_y = NULL;
  m13 =
      emlrtCreateNumericArray(2, (const void *)&iv1[0], mxSINGLE_CLASS, mxREAL);
  b_pData = (real32_T *)emlrtMxGetData(m13);
  for (i = 0; i < 10; i++) {
    b_pData[i] = u->IB_AVG_buffer[i];
  }
  emlrtAssign(&o_y, m13);
  emlrtSetFieldR2017b(y, 0, "IB_AVG_buffer", o_y, 17);
  p_y = NULL;
  m14 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m14) = u->PB;
  emlrtAssign(&p_y, m14);
  emlrtSetFieldR2017b(y, 0, "PB", p_y, 18);
  emlrtSetFieldR2017b(y, 0, "WW", b_emlrt_marshallOut(u->WW), 19);
  q_y = NULL;
  m15 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m15) = u->IB_AVG;
  emlrtAssign(&q_y, m15);
  emlrtSetFieldR2017b(y, 0, "IB_AVG", q_y, 20);
  emlrtSetFieldR2017b(y, 0, "TO_BL_PO", b_emlrt_marshallOut(u->TO_BL_PO), 21);
  r_y = NULL;
  m16 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m16) = u->RG_split_FR;
  emlrtAssign(&r_y, m16);
  emlrtSetFieldR2017b(y, 0, "RG_split_FR", r_y, 22);
  emlrtSetFieldR2017b(y, 0, "TO_BL_RG", b_emlrt_marshallOut(u->TO_BL_RG), 23);
  emlrtSetFieldR2017b(y, 0, "AC_MW", b_emlrt_marshallOut(u->AC_MW), 24);
  emlrtSetFieldR2017b(y, 0, "SK_TO", b_emlrt_marshallOut(u->SK_TO), 25);
  s_y = NULL;
  m17 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m17) = u->SK_FR_split;
  emlrtAssign(&s_y, m17);
  emlrtSetFieldR2017b(y, 0, "SK_FR_split", s_y, 26);
  t_y = NULL;
  m18 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m18) = u->SK_LR_gain;
  emlrtAssign(&t_y, m18);
  emlrtSetFieldR2017b(y, 0, "SK_LR_gain", t_y, 27);
  emlrtSetFieldR2017b(y, 0, "AX_TO", b_emlrt_marshallOut(u->AX_TO), 28);
  u_y = NULL;
  m19 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m19) = u->AX_FR_split;
  emlrtAssign(&u_y, m19);
  emlrtSetFieldR2017b(y, 0, "AX_FR_split", u_y, 29);
  v_y = NULL;
  m20 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m20) = u->AX_LR_gain;
  emlrtAssign(&v_y, m20);
  emlrtSetFieldR2017b(y, 0, "AX_LR_gain", v_y, 30);
  emlrtSetFieldR2017b(y, 0, "TORQUE_LIM_NEG",
                      b_emlrt_marshallOut(u->TORQUE_LIM_NEG), 31);
  emlrtSetFieldR2017b(y, 0, "TORQUE_LIM_POS",
                      b_emlrt_marshallOut(u->TORQUE_LIM_POS), 32);
  emlrtSetFieldR2017b(y, 0, "SPEED_OUT", b_emlrt_marshallOut(u->SPEED_OUT), 33);
  emlrtSetFieldR2017b(y, 0, "TORQUE_OUT", b_emlrt_marshallOut(u->TORQUE_OUT),
                      34);
  return y;
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, xVCU_struct *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  g_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               xVCU_struct *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[21] = {
      "VCU_MODE_REQ",    "THROT_RAW",       "BRAKE_RAW",      "ST_RAW",
      "VB_RAW",          "WM_RAW",          "GS_RAW",         "AV_RAW",
      "IB_RAW",          "MT_RAW",          "IGBT_T_RAW",     "INV_T_RAW",
      "MC_RAW",          "IC_RAW",          "BT_RAW",         "TO_RAW",
      "RG_split_FR_RAW", "SK_FR_split_RAW", "SK_LR_gain_RAW", "AX_FR_split_RAW",
      "AX_LR_gain_RAW"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 21,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "VCU_MODE_REQ";
  y->VCU_MODE_REQ =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        0, "VCU_MODE_REQ")),
                         &thisId);
  thisId.fIdentifier = "THROT_RAW";
  y->THROT_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1, "THROT_RAW")),
      &thisId);
  thisId.fIdentifier = "BRAKE_RAW";
  y->BRAKE_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 2, "BRAKE_RAW")),
      &thisId);
  thisId.fIdentifier = "ST_RAW";
  y->ST_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 3, "ST_RAW")),
      &thisId);
  thisId.fIdentifier = "VB_RAW";
  y->VB_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 4, "VB_RAW")),
      &thisId);
  thisId.fIdentifier = "WM_RAW";
  h_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 5, "WM_RAW")),
      &thisId, y->WM_RAW);
  thisId.fIdentifier = "GS_RAW";
  y->GS_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 6, "GS_RAW")),
      &thisId);
  thisId.fIdentifier = "AV_RAW";
  e_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 7, "AV_RAW")),
      &thisId, y->AV_RAW);
  thisId.fIdentifier = "IB_RAW";
  y->IB_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 8, "IB_RAW")),
      &thisId);
  thisId.fIdentifier = "MT_RAW";
  y->MT_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 9, "MT_RAW")),
      &thisId);
  thisId.fIdentifier = "IGBT_T_RAW";
  y->IGBT_T_RAW =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        10, "IGBT_T_RAW")),
                         &thisId);
  thisId.fIdentifier = "INV_T_RAW";
  y->INV_T_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 11, "INV_T_RAW")),
      &thisId);
  thisId.fIdentifier = "MC_RAW";
  h_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 12, "MC_RAW")),
      &thisId, y->MC_RAW);
  thisId.fIdentifier = "IC_RAW";
  h_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 13, "IC_RAW")),
      &thisId, y->IC_RAW);
  thisId.fIdentifier = "BT_RAW";
  y->BT_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 14, "BT_RAW")),
      &thisId);
  thisId.fIdentifier = "TO_RAW";
  h_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 15, "TO_RAW")),
      &thisId, y->TO_RAW);
  thisId.fIdentifier = "RG_split_FR_RAW";
  y->RG_split_FR_RAW =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        16, "RG_split_FR_RAW")),
                         &thisId);
  thisId.fIdentifier = "SK_FR_split_RAW";
  y->SK_FR_split_RAW =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        17, "SK_FR_split_RAW")),
                         &thisId);
  thisId.fIdentifier = "SK_LR_gain_RAW";
  y->SK_LR_gain_RAW =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        18, "SK_LR_gain_RAW")),
                         &thisId);
  thisId.fIdentifier = "AX_FR_split_RAW";
  y->AX_FR_split_RAW =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        19, "AX_FR_split_RAW")),
                         &thisId);
  thisId.fIdentifier = "AX_LR_gain_RAW";
  y->AX_LR_gain_RAW =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        20, "AX_LR_gain_RAW")),
                         &thisId);
  emlrtDestroyArray(&u);
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[4])
{
  o_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, yVCU_struct *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  j_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               yVCU_struct *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[35] = {"VCU_MODE",
                                         "TH",
                                         "TH_PO",
                                         "TH_RG",
                                         "ST",
                                         "VB",
                                         "WM",
                                         "GS",
                                         "AV",
                                         "IB",
                                         "MT",
                                         "IGBT_T",
                                         "INV_T",
                                         "OV_MOT",
                                         "OV_INV",
                                         "BT",
                                         "TO",
                                         "IB_AVG_buffer",
                                         "PB",
                                         "WW",
                                         "IB_AVG",
                                         "TO_BL_PO",
                                         "RG_split_FR",
                                         "TO_BL_RG",
                                         "AC_MW",
                                         "SK_TO",
                                         "SK_FR_split",
                                         "SK_LR_gain",
                                         "AX_TO",
                                         "AX_FR_split",
                                         "AX_LR_gain",
                                         "TORQUE_LIM_NEG",
                                         "TORQUE_LIM_POS",
                                         "SPEED_OUT",
                                         "TORQUE_OUT"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 35,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "VCU_MODE";
  y->VCU_MODE = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 0, "VCU_MODE")),
      &thisId);
  thisId.fIdentifier = "TH";
  y->TH = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1, "TH")),
      &thisId);
  thisId.fIdentifier = "TH_PO";
  y->TH_PO = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 2, "TH_PO")),
      &thisId);
  thisId.fIdentifier = "TH_RG";
  y->TH_RG = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 3, "TH_RG")),
      &thisId);
  thisId.fIdentifier = "ST";
  y->ST = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 4, "ST")),
      &thisId);
  thisId.fIdentifier = "VB";
  y->VB = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 5, "VB")),
      &thisId);
  thisId.fIdentifier = "WM";
  h_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 6, "WM")),
      &thisId, y->WM);
  thisId.fIdentifier = "GS";
  y->GS = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 7, "GS")),
      &thisId);
  thisId.fIdentifier = "AV";
  e_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 8, "AV")),
      &thisId, y->AV);
  thisId.fIdentifier = "IB";
  y->IB = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 9, "IB")),
      &thisId);
  thisId.fIdentifier = "MT";
  y->MT = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 10, "MT")),
      &thisId);
  thisId.fIdentifier = "IGBT_T";
  y->IGBT_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 11, "IGBT_T")),
      &thisId);
  thisId.fIdentifier = "INV_T";
  y->INV_T = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 12, "INV_T")),
      &thisId);
  thisId.fIdentifier = "OV_MOT";
  h_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 13, "OV_MOT")),
      &thisId, y->OV_MOT);
  thisId.fIdentifier = "OV_INV";
  h_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 14, "OV_INV")),
      &thisId, y->OV_INV);
  thisId.fIdentifier = "BT";
  y->BT = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 15, "BT")),
      &thisId);
  thisId.fIdentifier = "TO";
  h_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 16, "TO")),
      &thisId, y->TO);
  thisId.fIdentifier = "IB_AVG_buffer";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 17,
                                                    "IB_AVG_buffer")),
                     &thisId, y->IB_AVG_buffer);
  thisId.fIdentifier = "PB";
  y->PB = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 18, "PB")),
      &thisId);
  thisId.fIdentifier = "WW";
  h_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 19, "WW")),
      &thisId, y->WW);
  thisId.fIdentifier = "IB_AVG";
  y->IB_AVG = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 20, "IB_AVG")),
      &thisId);
  thisId.fIdentifier = "TO_BL_PO";
  h_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 21, "TO_BL_PO")),
      &thisId, y->TO_BL_PO);
  thisId.fIdentifier = "RG_split_FR";
  y->RG_split_FR =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        22, "RG_split_FR")),
                         &thisId);
  thisId.fIdentifier = "TO_BL_RG";
  h_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 23, "TO_BL_RG")),
      &thisId, y->TO_BL_RG);
  thisId.fIdentifier = "AC_MW";
  h_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 24, "AC_MW")),
      &thisId, y->AC_MW);
  thisId.fIdentifier = "SK_TO";
  h_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 25, "SK_TO")),
      &thisId, y->SK_TO);
  thisId.fIdentifier = "SK_FR_split";
  y->SK_FR_split =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        26, "SK_FR_split")),
                         &thisId);
  thisId.fIdentifier = "SK_LR_gain";
  y->SK_LR_gain =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        27, "SK_LR_gain")),
                         &thisId);
  thisId.fIdentifier = "AX_TO";
  h_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 28, "AX_TO")),
      &thisId, y->AX_TO);
  thisId.fIdentifier = "AX_FR_split";
  y->AX_FR_split =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        29, "AX_FR_split")),
                         &thisId);
  thisId.fIdentifier = "AX_LR_gain";
  y->AX_LR_gain =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        30, "AX_LR_gain")),
                         &thisId);
  thisId.fIdentifier = "TORQUE_LIM_NEG";
  h_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 31,
                                                    "TORQUE_LIM_NEG")),
                     &thisId, y->TORQUE_LIM_NEG);
  thisId.fIdentifier = "TORQUE_LIM_POS";
  h_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 32,
                                                    "TORQUE_LIM_POS")),
                     &thisId, y->TORQUE_LIM_POS);
  thisId.fIdentifier = "SPEED_OUT";
  h_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 33, "SPEED_OUT")),
      &thisId, y->SPEED_OUT);
  thisId.fIdentifier = "TORQUE_OUT";
  h_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 34,
                                                    "TORQUE_OUT")),
                     &thisId, y->TORQUE_OUT);
  emlrtDestroyArray(&u);
}

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[10])
{
  p_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real32_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  real32_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single|double", false,
                          0U, (const void *)&dims);
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret, 4, false);
  emlrtDestroyArray(&src);
  return ret;
}

static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real32_T ret[2])
{
  static const int32_T dims[2] = {1, 2};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single|double", false,
                          2U, (const void *)&dims[0]);
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret[0], 4, false);
  emlrtDestroyArray(&src);
}

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real32_T ret[3])
{
  static const int32_T dims[2] = {1, 3};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single|double", false,
                          2U, (const void *)&dims[0]);
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret[0], 4, false);
  emlrtDestroyArray(&src);
}

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real32_T ret[4])
{
  static const int32_T dims[2] = {1, 4};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single|double", false,
                          2U, (const void *)&dims[0]);
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret[0], 4, false);
  emlrtDestroyArray(&src);
}

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[10])
{
  static const int32_T dims[2] = {1, 10};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single|double", false,
                          2U, (const void *)&dims[0]);
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret[0], 4, false);
  emlrtDestroyArray(&src);
}

void vcu_step_api(const mxArray *const prhs[3], const mxArray **plhs)
{
  emlrtStack st = {NULL, NULL, NULL};
  pVCU_struct p;
  xVCU_struct x;
  yVCU_struct y;
  st.tls = emlrtRootTLSGlobal;

  emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "p", &p);
  f_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "x", &x);
  i_emlrt_marshallIn(&st, emlrtAliasP(prhs[2]), "y", &y);

  vcu_step(&p, &x, &y);

  *plhs = emlrt_marshallOut(&y);
}

void vcu_step_atexit(void)
{
  emlrtStack st = {NULL, NULL, NULL};
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtPushHeapReferenceStackR2021a(
      &st, false, NULL, (void *)&emlrtExitTimeCleanupDtorFcn, NULL, NULL, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  vcu_step_xil_terminate();
  vcu_step_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void vcu_step_initialize(void)
{
  emlrtStack st = {NULL, NULL, NULL};
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

void vcu_step_terminate(void)
{
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}
