#include "_coder_vcu_step_api.h"
#include "_coder_vcu_step_mex.h"

emlrtCTX emlrtRootTLSGlobal = NULL;

emlrtContext emlrtContextGlobal = {
    true,       false,
    131674U,    NULL,
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

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, xVCU_struct *y);

static void emlrtExitTimeCleanupDtorFcn(const void *r);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                             const char_T *identifier, pVCU_struct *y);

static const mxArray *emlrt_marshallOut(const yVCU_struct *u);

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               xVCU_struct *y);

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[4]);

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[3]);

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
                               real32_T ret[4]);

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[3]);

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[10]);

static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               pVCU_struct *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[28] = {"r",
                                         "ht",
                                         "wb",
                                         "gr",
                                         "IB_AVG_length",
                                         "MAX_TO_ABS_PO",
                                         "PB_derating_full_T",
                                         "PB_derating_half_T",
                                         "PB_derating_FR",
                                         "VB_derating_full_T",
                                         "VB_derating_zero_T",
                                         "IB_derating_full_T",
                                         "IB_derating_zero_T",
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
                                         "BT_derating_zero_T"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 28,
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
  thisId.fIdentifier = "IB_AVG_length";
  y->IB_AVG_length =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        4, "IB_AVG_length")),
                         &thisId);
  thisId.fIdentifier = "MAX_TO_ABS_PO";
  y->MAX_TO_ABS_PO =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        5, "MAX_TO_ABS_PO")),
                         &thisId);
  thisId.fIdentifier = "PB_derating_full_T";
  y->PB_derating_full_T =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtConstCTX)sp, u, 0, 6, "PB_derating_full_T")),
                         &thisId);
  thisId.fIdentifier = "PB_derating_half_T";
  y->PB_derating_half_T =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtConstCTX)sp, u, 0, 7, "PB_derating_half_T")),
                         &thisId);
  thisId.fIdentifier = "PB_derating_FR";
  y->PB_derating_FR =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        8, "PB_derating_FR")),
                         &thisId);
  thisId.fIdentifier = "VB_derating_full_T";
  y->VB_derating_full_T =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtConstCTX)sp, u, 0, 9, "VB_derating_full_T")),
                         &thisId);
  thisId.fIdentifier = "VB_derating_zero_T";
  y->VB_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 10,
                                     "VB_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "IB_derating_full_T";
  y->IB_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 11,
                                     "IB_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "IB_derating_zero_T";
  y->IB_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 12,
                                     "IB_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "MAX_TO_ABS_RG";
  y->MAX_TO_ABS_RG =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        13, "MAX_TO_ABS_RG")),
                         &thisId);
  thisId.fIdentifier = "VB_RG_derating_full_T";
  y->VB_RG_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 14,
                                     "VB_RG_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "VB_RG_derating_zero_T";
  y->VB_RG_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 15,
                                     "VB_RG_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "IB_RG_derating_full_T";
  y->IB_RG_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 16,
                                     "IB_RG_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "IB_RG_derating_zero_T";
  y->IB_RG_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 17,
                                     "IB_RG_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "GS_RG_derating_zero";
  y->GS_RG_derating_zero = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 18,
                                     "GS_RG_derating_zero")),
      &thisId);
  thisId.fIdentifier = "GS_RG_derating_full";
  y->GS_RG_derating_full = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 19,
                                     "GS_RG_derating_full")),
      &thisId);
  thisId.fIdentifier = "INV_T_derating_full_T";
  y->INV_T_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 20,
                                     "INV_T_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "INV_T_derating_zero_T";
  y->INV_T_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 21,
                                     "INV_T_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "IGBT_T_derating_full_T";
  y->IGBT_T_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 22,
                                     "IGBT_T_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "IGBT_T_derating_zero_T";
  y->IGBT_T_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 23,
                                     "IGBT_T_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "MT_derating_full_T";
  y->MT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 24,
                                     "MT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "MT_derating_zero_T";
  y->MT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 25,
                                     "MT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "BT_derating_full_T";
  y->BT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 26,
                                     "BT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "BT_derating_zero_T";
  y->BT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 27,
                                     "BT_derating_zero_T")),
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

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, xVCU_struct *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  f_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
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
  static const char_T *sv[24] = {"TH",
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
                                 "MC",
                                 "IC",
                                 "BT",
                                 "TO",
                                 "IB_AVG_buffer",
                                 "PB",
                                 "WT",
                                 "IB_AVG",
                                 "TO_BL_PO",
                                 "TO_BL_RG",
                                 "TORQUE_OUT",
                                 "SPEED_OUT"};
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
  const mxArray *m2;
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
  const mxArray *y;
  int32_T i;
  real32_T *b_pData;
  real32_T *pData;
  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 24, (const char_T **)&sv[0]));
  b_y = NULL;
  m = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m) = u->TH;
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "TH", b_y, 0);
  c_y = NULL;
  m1 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m1) = u->TH_PO;
  emlrtAssign(&c_y, m1);
  emlrtSetFieldR2017b(y, 0, "TH_PO", c_y, 1);
  d_y = NULL;
  m2 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m2) = u->TH_RG;
  emlrtAssign(&d_y, m2);
  emlrtSetFieldR2017b(y, 0, "TH_RG", d_y, 2);
  e_y = NULL;
  m3 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m3) = u->ST;
  emlrtAssign(&e_y, m3);
  emlrtSetFieldR2017b(y, 0, "ST", e_y, 3);
  f_y = NULL;
  m4 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m4) = u->VB;
  emlrtAssign(&f_y, m4);
  emlrtSetFieldR2017b(y, 0, "VB", f_y, 4);
  emlrtSetFieldR2017b(y, 0, "WM", b_emlrt_marshallOut(u->WM), 5);
  g_y = NULL;
  m5 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m5) = u->GS;
  emlrtAssign(&g_y, m5);
  emlrtSetFieldR2017b(y, 0, "GS", g_y, 6);
  h_y = NULL;
  m6 = emlrtCreateNumericArray(2, (const void *)&iv[0], mxSINGLE_CLASS, mxREAL);
  pData = (real32_T *)emlrtMxGetData(m6);
  pData[0] = u->AV[0];
  pData[1] = u->AV[1];
  pData[2] = u->AV[2];
  emlrtAssign(&h_y, m6);
  emlrtSetFieldR2017b(y, 0, "AV", h_y, 7);
  i_y = NULL;
  m7 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m7) = u->IB;
  emlrtAssign(&i_y, m7);
  emlrtSetFieldR2017b(y, 0, "IB", i_y, 8);
  j_y = NULL;
  m8 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m8) = u->MT;
  emlrtAssign(&j_y, m8);
  emlrtSetFieldR2017b(y, 0, "MT", j_y, 9);
  k_y = NULL;
  m9 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m9) = u->IGBT_T;
  emlrtAssign(&k_y, m9);
  emlrtSetFieldR2017b(y, 0, "IGBT_T", k_y, 10);
  l_y = NULL;
  m10 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m10) = u->INV_T;
  emlrtAssign(&l_y, m10);
  emlrtSetFieldR2017b(y, 0, "INV_T", l_y, 11);
  m_y = NULL;
  m11 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m11) = u->MC;
  emlrtAssign(&m_y, m11);
  emlrtSetFieldR2017b(y, 0, "MC", m_y, 12);
  n_y = NULL;
  m12 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m12) = u->IC;
  emlrtAssign(&n_y, m12);
  emlrtSetFieldR2017b(y, 0, "IC", n_y, 13);
  o_y = NULL;
  m13 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m13) = u->BT;
  emlrtAssign(&o_y, m13);
  emlrtSetFieldR2017b(y, 0, "BT", o_y, 14);
  emlrtSetFieldR2017b(y, 0, "TO", b_emlrt_marshallOut(u->TO), 15);
  p_y = NULL;
  m14 =
      emlrtCreateNumericArray(2, (const void *)&iv1[0], mxSINGLE_CLASS, mxREAL);
  b_pData = (real32_T *)emlrtMxGetData(m14);
  for (i = 0; i < 10; i++) {
    b_pData[i] = u->IB_AVG_buffer[i];
  }
  emlrtAssign(&p_y, m14);
  emlrtSetFieldR2017b(y, 0, "IB_AVG_buffer", p_y, 16);
  q_y = NULL;
  m15 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m15) = u->PB;
  emlrtAssign(&q_y, m15);
  emlrtSetFieldR2017b(y, 0, "PB", q_y, 17);
  emlrtSetFieldR2017b(y, 0, "WT", b_emlrt_marshallOut(u->WT), 18);
  r_y = NULL;
  m16 = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
  *(real32_T *)emlrtMxGetData(m16) = u->IB_AVG;
  emlrtAssign(&r_y, m16);
  emlrtSetFieldR2017b(y, 0, "IB_AVG", r_y, 19);
  emlrtSetFieldR2017b(y, 0, "TO_BL_PO", b_emlrt_marshallOut(u->TO_BL_PO), 20);
  emlrtSetFieldR2017b(y, 0, "TO_BL_RG", b_emlrt_marshallOut(u->TO_BL_RG), 21);
  emlrtSetFieldR2017b(y, 0, "TORQUE_OUT", b_emlrt_marshallOut(u->TORQUE_OUT),
                      22);
  emlrtSetFieldR2017b(y, 0, "SPEED_OUT", b_emlrt_marshallOut(u->SPEED_OUT), 23);
  return y;
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               xVCU_struct *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[14] = {
      "TH_RAW", "ST_RAW", "VB_RAW", "WM_RAW",     "GS_RAW",
      "AV_RAW", "IB_RAW", "MT_RAW", "IGBT_T_RAW", "INV_T_RAW",
      "MC_RAW", "IC_RAW", "BT_RAW", "TO_RAW"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 14,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "TH_RAW";
  y->TH_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 0, "TH_RAW")),
      &thisId);
  thisId.fIdentifier = "ST_RAW";
  y->ST_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1, "ST_RAW")),
      &thisId);
  thisId.fIdentifier = "VB_RAW";
  y->VB_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 2, "VB_RAW")),
      &thisId);
  thisId.fIdentifier = "WM_RAW";
  g_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 3, "WM_RAW")),
      &thisId, y->WM_RAW);
  thisId.fIdentifier = "GS_RAW";
  y->GS_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 4, "GS_RAW")),
      &thisId);
  thisId.fIdentifier = "AV_RAW";
  h_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 5, "AV_RAW")),
      &thisId, y->AV_RAW);
  thisId.fIdentifier = "IB_RAW";
  y->IB_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 6, "IB_RAW")),
      &thisId);
  thisId.fIdentifier = "MT_RAW";
  y->MT_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 7, "MT_RAW")),
      &thisId);
  thisId.fIdentifier = "IGBT_T_RAW";
  y->IGBT_T_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 8, "IGBT_T_RAW")),
      &thisId);
  thisId.fIdentifier = "INV_T_RAW";
  y->INV_T_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 9, "INV_T_RAW")),
      &thisId);
  thisId.fIdentifier = "MC_RAW";
  y->MC_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 10, "MC_RAW")),
      &thisId);
  thisId.fIdentifier = "IC_RAW";
  y->IC_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 11, "IC_RAW")),
      &thisId);
  thisId.fIdentifier = "BT_RAW";
  y->BT_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 12, "BT_RAW")),
      &thisId);
  thisId.fIdentifier = "TO_RAW";
  g_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 13, "TO_RAW")),
      &thisId, y->TO_RAW);
  emlrtDestroyArray(&u);
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[4])
{
  n_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[3])
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
  static const char_T *fieldNames[24] = {"TH",
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
                                         "MC",
                                         "IC",
                                         "BT",
                                         "TO",
                                         "IB_AVG_buffer",
                                         "PB",
                                         "WT",
                                         "IB_AVG",
                                         "TO_BL_PO",
                                         "TO_BL_RG",
                                         "TORQUE_OUT",
                                         "SPEED_OUT"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 24,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "TH";
  y->TH = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 0, "TH")),
      &thisId);
  thisId.fIdentifier = "TH_PO";
  y->TH_PO = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1, "TH_PO")),
      &thisId);
  thisId.fIdentifier = "TH_RG";
  y->TH_RG = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 2, "TH_RG")),
      &thisId);
  thisId.fIdentifier = "ST";
  y->ST = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 3, "ST")),
      &thisId);
  thisId.fIdentifier = "VB";
  y->VB = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 4, "VB")),
      &thisId);
  thisId.fIdentifier = "WM";
  g_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 5, "WM")),
      &thisId, y->WM);
  thisId.fIdentifier = "GS";
  y->GS = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 6, "GS")),
      &thisId);
  thisId.fIdentifier = "AV";
  h_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 7, "AV")),
      &thisId, y->AV);
  thisId.fIdentifier = "IB";
  y->IB = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 8, "IB")),
      &thisId);
  thisId.fIdentifier = "MT";
  y->MT = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 9, "MT")),
      &thisId);
  thisId.fIdentifier = "IGBT_T";
  y->IGBT_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 10, "IGBT_T")),
      &thisId);
  thisId.fIdentifier = "INV_T";
  y->INV_T = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 11, "INV_T")),
      &thisId);
  thisId.fIdentifier = "MC";
  y->MC = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 12, "MC")),
      &thisId);
  thisId.fIdentifier = "IC";
  y->IC = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 13, "IC")),
      &thisId);
  thisId.fIdentifier = "BT";
  y->BT = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 14, "BT")),
      &thisId);
  thisId.fIdentifier = "TO";
  g_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 15, "TO")),
      &thisId, y->TO);
  thisId.fIdentifier = "IB_AVG_buffer";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 16,
                                                    "IB_AVG_buffer")),
                     &thisId, y->IB_AVG_buffer);
  thisId.fIdentifier = "PB";
  y->PB = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 17, "PB")),
      &thisId);
  thisId.fIdentifier = "WT";
  g_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 18, "WT")),
      &thisId, y->WT);
  thisId.fIdentifier = "IB_AVG";
  y->IB_AVG = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 19, "IB_AVG")),
      &thisId);
  thisId.fIdentifier = "TO_BL_PO";
  g_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 20, "TO_BL_PO")),
      &thisId, y->TO_BL_PO);
  thisId.fIdentifier = "TO_BL_RG";
  g_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 21, "TO_BL_RG")),
      &thisId, y->TO_BL_RG);
  thisId.fIdentifier = "TORQUE_OUT";
  g_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 22,
                                                    "TORQUE_OUT")),
                     &thisId, y->TORQUE_OUT);
  thisId.fIdentifier = "SPEED_OUT";
  g_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 23, "SPEED_OUT")),
      &thisId, y->SPEED_OUT);
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
                               const emlrtMsgIdentifier *msgId, real32_T ret[4])
{
  static const int32_T dims[2] = {1, 4};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single|double", false,
                          2U, (const void *)&dims[0]);
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret[0], 4, false);
  emlrtDestroyArray(&src);
}

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real32_T ret[3])
{
  static const int32_T dims[2] = {1, 3};
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
  e_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "x", &x);
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
