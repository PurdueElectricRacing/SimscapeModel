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
                               pVCU_struc *y);

static const mxArray *b_emlrt_marshallOut(const real_T u[4]);

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[2]);

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, xVCU_struc *y);

static void emlrtExitTimeCleanupDtorFcn(const void *r);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                             const char_T *identifier, pVCU_struc *y);

static const mxArray *emlrt_marshallOut(const yVCU_struc *u);

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               xVCU_struc *y);

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[4]);

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[3]);

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, yVCU_struc *y);

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               yVCU_struc *y);

static real_T k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId);

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[2]);

static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[4]);

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[3]);

static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               pVCU_struc *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[20] = {"r",
                                         "ht",
                                         "wb",
                                         "gr",
                                         "MAX_TO_ABS",
                                         "PB_derating_full_T",
                                         "PB_derating_half_T",
                                         "PB_derating_FR",
                                         "INV_T_derating_full_T",
                                         "INV_derating_zero_T",
                                         "IGBT_derating_full_T",
                                         "IGBT_derating_zero_T",
                                         "MT_derating_full_T",
                                         "MT_derating_zero_T",
                                         "BT_derating_full_T",
                                         "BT_derating_zero_T",
                                         "VB_derating_full_T",
                                         "VB_derating_zero_T",
                                         "IB_derating_full_T",
                                         "IB_derating_zero_T"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 20,
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
  thisId.fIdentifier = "MAX_TO_ABS";
  y->MAX_TO_ABS = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 4, "MAX_TO_ABS")),
      &thisId);
  thisId.fIdentifier = "PB_derating_full_T";
  y->PB_derating_full_T =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtConstCTX)sp, u, 0, 5, "PB_derating_full_T")),
                         &thisId);
  thisId.fIdentifier = "PB_derating_half_T";
  y->PB_derating_half_T =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtConstCTX)sp, u, 0, 6, "PB_derating_half_T")),
                         &thisId);
  thisId.fIdentifier = "PB_derating_FR";
  y->PB_derating_FR =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        7, "PB_derating_FR")),
                         &thisId);
  thisId.fIdentifier = "INV_T_derating_full_T";
  y->INV_T_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 8,
                                     "INV_T_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "INV_derating_zero_T";
  y->INV_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 9,
                                     "INV_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "IGBT_derating_full_T";
  y->IGBT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 10,
                                     "IGBT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "IGBT_derating_zero_T";
  y->IGBT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 11,
                                     "IGBT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "MT_derating_full_T";
  y->MT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 12,
                                     "MT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "MT_derating_zero_T";
  y->MT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 13,
                                     "MT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "BT_derating_full_T";
  y->BT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 14,
                                     "BT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "BT_derating_zero_T";
  y->BT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 15,
                                     "BT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "VB_derating_full_T";
  y->VB_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 16,
                                     "VB_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "VB_derating_zero_T";
  y->VB_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 17,
                                     "VB_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "IB_derating_full_T";
  y->IB_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 18,
                                     "IB_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "IB_derating_zero_T";
  y->IB_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 19,
                                     "IB_derating_zero_T")),
      &thisId);
  emlrtDestroyArray(&u);
}

static const mxArray *b_emlrt_marshallOut(const real_T u[4])
{
  static const int32_T iv[2] = {1, 4};
  const mxArray *m;
  const mxArray *y;
  real_T *pData;
  y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m);
  pData[0] = u[0];
  pData[1] = u[1];
  pData[2] = u[2];
  pData[3] = u[3];
  emlrtAssign(&y, m);
  return y;
}

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = k_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[2])
{
  l_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, xVCU_struc *y)
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
                             const char_T *identifier, pVCU_struc *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static const mxArray *emlrt_marshallOut(const yVCU_struc *u)
{
  static const int32_T iv[2] = {1, 3};
  static const char_T *sv[19] = {
      "TH", "TH_PO", "TH_RG", "ST",       "VB",        "WM", "GS",
      "AV", "IB",    "MT",    "IGBT_T",   "INV_T",     "MC", "IC",
      "BT", "TO",    "PB",    "TO_BL_PO", "TORQUE_OUT"};
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
  const mxArray *y;
  real_T *pData;
  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 19, (const char_T **)&sv[0]));
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->TH);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "TH", b_y, 0);
  c_y = NULL;
  m1 = emlrtCreateDoubleScalar(u->TH_PO);
  emlrtAssign(&c_y, m1);
  emlrtSetFieldR2017b(y, 0, "TH_PO", c_y, 1);
  d_y = NULL;
  m2 = emlrtCreateDoubleScalar(u->TH_RG);
  emlrtAssign(&d_y, m2);
  emlrtSetFieldR2017b(y, 0, "TH_RG", d_y, 2);
  e_y = NULL;
  m3 = emlrtCreateDoubleScalar(u->ST);
  emlrtAssign(&e_y, m3);
  emlrtSetFieldR2017b(y, 0, "ST", e_y, 3);
  f_y = NULL;
  m4 = emlrtCreateDoubleScalar(u->VB);
  emlrtAssign(&f_y, m4);
  emlrtSetFieldR2017b(y, 0, "VB", f_y, 4);
  emlrtSetFieldR2017b(y, 0, "WM", b_emlrt_marshallOut(u->WM), 5);
  g_y = NULL;
  m5 = emlrtCreateDoubleScalar(u->GS);
  emlrtAssign(&g_y, m5);
  emlrtSetFieldR2017b(y, 0, "GS", g_y, 6);
  h_y = NULL;
  m6 = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m6);
  pData[0] = u->AV[0];
  pData[1] = u->AV[1];
  pData[2] = u->AV[2];
  emlrtAssign(&h_y, m6);
  emlrtSetFieldR2017b(y, 0, "AV", h_y, 7);
  i_y = NULL;
  m7 = emlrtCreateDoubleScalar(u->IB);
  emlrtAssign(&i_y, m7);
  emlrtSetFieldR2017b(y, 0, "IB", i_y, 8);
  j_y = NULL;
  m8 = emlrtCreateDoubleScalar(u->MT);
  emlrtAssign(&j_y, m8);
  emlrtSetFieldR2017b(y, 0, "MT", j_y, 9);
  k_y = NULL;
  m9 = emlrtCreateDoubleScalar(u->IGBT_T);
  emlrtAssign(&k_y, m9);
  emlrtSetFieldR2017b(y, 0, "IGBT_T", k_y, 10);
  l_y = NULL;
  m10 = emlrtCreateDoubleScalar(u->INV_T);
  emlrtAssign(&l_y, m10);
  emlrtSetFieldR2017b(y, 0, "INV_T", l_y, 11);
  m_y = NULL;
  m11 = emlrtCreateDoubleScalar(u->MC);
  emlrtAssign(&m_y, m11);
  emlrtSetFieldR2017b(y, 0, "MC", m_y, 12);
  n_y = NULL;
  m12 = emlrtCreateDoubleScalar(u->IC);
  emlrtAssign(&n_y, m12);
  emlrtSetFieldR2017b(y, 0, "IC", n_y, 13);
  o_y = NULL;
  m13 = emlrtCreateDoubleScalar(u->BT);
  emlrtAssign(&o_y, m13);
  emlrtSetFieldR2017b(y, 0, "BT", o_y, 14);
  emlrtSetFieldR2017b(y, 0, "TO", b_emlrt_marshallOut(u->TO), 15);
  p_y = NULL;
  m14 = emlrtCreateDoubleScalar(u->PB);
  emlrtAssign(&p_y, m14);
  emlrtSetFieldR2017b(y, 0, "PB", p_y, 16);
  emlrtSetFieldR2017b(y, 0, "TO_BL_PO", b_emlrt_marshallOut(u->TO_BL_PO), 17);
  emlrtSetFieldR2017b(y, 0, "TORQUE_OUT", b_emlrt_marshallOut(u->TORQUE_OUT),
                      18);
  return y;
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               xVCU_struc *y)
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
                               const emlrtMsgIdentifier *parentId, real_T y[4])
{
  m_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[3])
{
  n_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, yVCU_struc *y)
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
                               yVCU_struc *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[19] = {
      "TH", "TH_PO", "TH_RG", "ST",       "VB",        "WM", "GS",
      "AV", "IB",    "MT",    "IGBT_T",   "INV_T",     "MC", "IC",
      "BT", "TO",    "PB",    "TO_BL_PO", "TORQUE_OUT"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 19,
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
  thisId.fIdentifier = "PB";
  y->PB = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 16, "PB")),
      &thisId);
  thisId.fIdentifier = "TO_BL_PO";
  g_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 17, "TO_BL_PO")),
      &thisId, y->TO_BL_PO);
  thisId.fIdentifier = "TORQUE_OUT";
  g_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 18,
                                                    "TORQUE_OUT")),
                     &thisId, y->TORQUE_OUT);
  emlrtDestroyArray(&u);
}

static real_T k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  real_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 0U,
                          (const void *)&dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[2])
{
  static const int32_T dims[2] = {1, 2};
  real_T(*r)[2];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[2])emlrtMxGetData(src);
  ret[0] = (*r)[0];
  ret[1] = (*r)[1];
  emlrtDestroyArray(&src);
}

static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[4])
{
  static const int32_T dims[2] = {1, 4};
  real_T(*r)[4];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[4])emlrtMxGetData(src);
  ret[0] = (*r)[0];
  ret[1] = (*r)[1];
  ret[2] = (*r)[2];
  ret[3] = (*r)[3];
  emlrtDestroyArray(&src);
}

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[3])
{
  static const int32_T dims[2] = {1, 3};
  real_T(*r)[3];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[3])emlrtMxGetData(src);
  ret[0] = (*r)[0];
  ret[1] = (*r)[1];
  ret[2] = (*r)[2];
  emlrtDestroyArray(&src);
}

void vcu_step_api(const mxArray *const prhs[3], const mxArray **plhs)
{
  emlrtStack st = {NULL, NULL, NULL};
  pVCU_struc p;
  xVCU_struc x;
  yVCU_struc y;
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
