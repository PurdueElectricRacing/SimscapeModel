#include "_coder_get_ET_api.h"
#include "_coder_get_ET_mex.h"

emlrtCTX emlrtRootTLSGlobal = NULL;

emlrtContext emlrtContextGlobal = {
    true,     false,
    131643U,  NULL,
    "get_ET", NULL,
    false,    {2045744189U, 2170104910U, 2743257031U, 4284093946U},
    NULL};

static void ab_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[50]);

static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               struct0_T *y);

static const mxArray *b_emlrt_marshallOut(const real_T u[5]);

static void bb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[7500]);

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static const mxArray *c_emlrt_marshallOut(const real_T u[2]);

static void cb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[51]);

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[2]);

static const mxArray *d_emlrt_marshallOut(const real_T u[3]);

static void db_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[53]);

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[3]);

static void eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[2703]);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                             const char_T *identifier, struct0_T *y);

static const mxArray *emlrt_marshallOut(const struct1_T *u);

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[9]);

static void fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[5]);

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[506]);

static void gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[10]);

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[506]);

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[150]);

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[50]);

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[7500]);

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[51]);

static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[53]);

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[2703]);

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, struct1_T *y);

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               struct1_T *y);

static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[5]);

static void r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[10]);

static real_T s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId);

static void t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[2]);

static void u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[3]);

static void v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[9]);

static void w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real_T ret[506]);

static void x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real_T ret[506]);

static void y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real_T ret[150]);

static void ab_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[50])
{
  static const int32_T dims = 50;
  real_T(*r)[50];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 1U,
                          (const void *)&dims);
  r = (real_T(*)[50])emlrtMxGetData(src);
  for (i = 0; i < 50; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, struct0_T *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[107] = {"r",
                                          "ht",
                                          "gr",
                                          "Ns",
                                          "ET_permit_N",
                                          "PT_permit_N",
                                          "VS_permit_N",
                                          "VT_permit_N",
                                          "CS_SFLAG_True",
                                          "TB_SFLAG_True",
                                          "SS_SFLAG_True",
                                          "WT_SFLAG_True",
                                          "IV_SFLAG_True",
                                          "BT_SFLAG_True",
                                          "MT_SFLAG_True",
                                          "CO_SFLAG_True",
                                          "MO_SFLAG_True",
                                          "SS_FFLAG_True",
                                          "AV_FFLAG_True",
                                          "GS_FFLAG_True",
                                          "VCU_PFLAG_VS",
                                          "VCU_PFLAG_VT",
                                          "TH_lb",
                                          "ST_lb",
                                          "VB_lb",
                                          "WT_lb",
                                          "WM_lb",
                                          "GS_lb",
                                          "AV_lb",
                                          "IB_lb",
                                          "MT_lb",
                                          "CT_lb",
                                          "IT_lb",
                                          "MC_lb",
                                          "IC_lb",
                                          "BT_lb",
                                          "AG_lb",
                                          "TO_lb",
                                          "DB_lb",
                                          "PI_lb",
                                          "PP_lb",
                                          "TH_ub",
                                          "ST_ub",
                                          "VB_ub",
                                          "WT_ub",
                                          "WM_ub",
                                          "GS_ub",
                                          "AV_ub",
                                          "IB_ub",
                                          "MT_ub",
                                          "CT_ub",
                                          "IT_ub",
                                          "MC_ub",
                                          "IC_ub",
                                          "BT_ub",
                                          "AG_ub",
                                          "TO_ub",
                                          "DB_ub",
                                          "PI_ub",
                                          "PP_ub",
                                          "CF_IB_filter_N",
                                          "R",
                                          "Batt_Voc_brk",
                                          "Batt_As_Discharged_tbl",
                                          "zero_currents_to_update_SOC",
                                          "Batt_cell_zero_SOC_voltage",
                                          "Batt_cell_zero_SOC_capacity",
                                          "Batt_cell_full_SOC_voltage",
                                          "Batt_cell_full_SOC_capacity",
                                          "MAX_TORQUE_NOM",
                                          "PT_WM_brkpt",
                                          "PT_VB_brkpt",
                                          "PT_TO_table",
                                          "PT_WM_lb",
                                          "PT_WM_ub",
                                          "PT_VB_lb",
                                          "PT_VB_ub",
                                          "mT_derating_full_T",
                                          "mT_derating_zero_T",
                                          "cT_derating_full_T",
                                          "cT_derating_zero_T",
                                          "bT_derating_full_T",
                                          "bT_derating_zero_T",
                                          "bI_derating_full_T",
                                          "bI_derating_zero_T",
                                          "Vb_derating_full_T",
                                          "Vb_derating_zero_T",
                                          "Ci_derating_full_T",
                                          "Ci_derating_zero_T",
                                          "Cm_derating_full_T",
                                          "Cm_derating_zero_T",
                                          "iT_derating_full_T",
                                          "iT_derating_zero_T",
                                          "dST_DB",
                                          "r_power_sat",
                                          "TV_GS_brkpt",
                                          "TV_ST_brkpt",
                                          "TV_AV_table",
                                          "TV_ST_lb",
                                          "TV_ST_ub",
                                          "TV_GS_lb",
                                          "TV_GS_ub",
                                          "TC_eps",
                                          "TC_sl_threshold",
                                          "TC_throttle_mult",
                                          "TC_highs_to_engage",
                                          "TC_lows_to_disengage"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 107,
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
  thisId.fIdentifier = "gr";
  y->gr = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 2, "gr")),
      &thisId);
  thisId.fIdentifier = "Ns";
  y->Ns = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 3, "Ns")),
      &thisId);
  thisId.fIdentifier = "ET_permit_N";
  y->ET_permit_N =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        4, "ET_permit_N")),
                         &thisId);
  thisId.fIdentifier = "PT_permit_N";
  y->PT_permit_N =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        5, "PT_permit_N")),
                         &thisId);
  thisId.fIdentifier = "VS_permit_N";
  y->VS_permit_N =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        6, "VS_permit_N")),
                         &thisId);
  thisId.fIdentifier = "VT_permit_N";
  y->VT_permit_N =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        7, "VT_permit_N")),
                         &thisId);
  thisId.fIdentifier = "CS_SFLAG_True";
  y->CS_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        8, "CS_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "TB_SFLAG_True";
  y->TB_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        9, "TB_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "SS_SFLAG_True";
  y->SS_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        10, "SS_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "WT_SFLAG_True";
  y->WT_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        11, "WT_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "IV_SFLAG_True";
  y->IV_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        12, "IV_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "BT_SFLAG_True";
  y->BT_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        13, "BT_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "MT_SFLAG_True";
  y->MT_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        14, "MT_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "CO_SFLAG_True";
  y->CO_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        15, "CO_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "MO_SFLAG_True";
  y->MO_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        16, "MO_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "SS_FFLAG_True";
  y->SS_FFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        17, "SS_FFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "AV_FFLAG_True";
  y->AV_FFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        18, "AV_FFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "GS_FFLAG_True";
  y->GS_FFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        19, "GS_FFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "VCU_PFLAG_VS";
  y->VCU_PFLAG_VS =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        20, "VCU_PFLAG_VS")),
                         &thisId);
  thisId.fIdentifier = "VCU_PFLAG_VT";
  y->VCU_PFLAG_VT =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        21, "VCU_PFLAG_VT")),
                         &thisId);
  thisId.fIdentifier = "TH_lb";
  y->TH_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 22, "TH_lb")),
      &thisId);
  thisId.fIdentifier = "ST_lb";
  y->ST_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 23, "ST_lb")),
      &thisId);
  thisId.fIdentifier = "VB_lb";
  y->VB_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 24, "VB_lb")),
      &thisId);
  thisId.fIdentifier = "WT_lb";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 25, "WT_lb")),
      &thisId, y->WT_lb);
  thisId.fIdentifier = "WM_lb";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 26, "WM_lb")),
      &thisId, y->WM_lb);
  thisId.fIdentifier = "GS_lb";
  y->GS_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 27, "GS_lb")),
      &thisId);
  thisId.fIdentifier = "AV_lb";
  e_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 28, "AV_lb")),
      &thisId, y->AV_lb);
  thisId.fIdentifier = "IB_lb";
  y->IB_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 29, "IB_lb")),
      &thisId);
  thisId.fIdentifier = "MT_lb";
  y->MT_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 30, "MT_lb")),
      &thisId);
  thisId.fIdentifier = "CT_lb";
  y->CT_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 31, "CT_lb")),
      &thisId);
  thisId.fIdentifier = "IT_lb";
  y->IT_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 32, "IT_lb")),
      &thisId);
  thisId.fIdentifier = "MC_lb";
  y->MC_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 33, "MC_lb")),
      &thisId);
  thisId.fIdentifier = "IC_lb";
  y->IC_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 34, "IC_lb")),
      &thisId);
  thisId.fIdentifier = "BT_lb";
  y->BT_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 35, "BT_lb")),
      &thisId);
  thisId.fIdentifier = "AG_lb";
  e_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 36, "AG_lb")),
      &thisId, y->AG_lb);
  thisId.fIdentifier = "TO_lb";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 37, "TO_lb")),
      &thisId, y->TO_lb);
  thisId.fIdentifier = "DB_lb";
  y->DB_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 38, "DB_lb")),
      &thisId);
  thisId.fIdentifier = "PI_lb";
  y->PI_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 39, "PI_lb")),
      &thisId);
  thisId.fIdentifier = "PP_lb";
  y->PP_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 40, "PP_lb")),
      &thisId);
  thisId.fIdentifier = "TH_ub";
  y->TH_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 41, "TH_ub")),
      &thisId);
  thisId.fIdentifier = "ST_ub";
  y->ST_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 42, "ST_ub")),
      &thisId);
  thisId.fIdentifier = "VB_ub";
  y->VB_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 43, "VB_ub")),
      &thisId);
  thisId.fIdentifier = "WT_ub";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 44, "WT_ub")),
      &thisId, y->WT_ub);
  thisId.fIdentifier = "WM_ub";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 45, "WM_ub")),
      &thisId, y->WM_ub);
  thisId.fIdentifier = "GS_ub";
  y->GS_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 46, "GS_ub")),
      &thisId);
  thisId.fIdentifier = "AV_ub";
  e_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 47, "AV_ub")),
      &thisId, y->AV_ub);
  thisId.fIdentifier = "IB_ub";
  y->IB_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 48, "IB_ub")),
      &thisId);
  thisId.fIdentifier = "MT_ub";
  y->MT_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 49, "MT_ub")),
      &thisId);
  thisId.fIdentifier = "CT_ub";
  y->CT_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 50, "CT_ub")),
      &thisId);
  thisId.fIdentifier = "IT_ub";
  y->IT_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 51, "IT_ub")),
      &thisId);
  thisId.fIdentifier = "MC_ub";
  y->MC_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 52, "MC_ub")),
      &thisId);
  thisId.fIdentifier = "IC_ub";
  y->IC_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 53, "IC_ub")),
      &thisId);
  thisId.fIdentifier = "BT_ub";
  y->BT_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 54, "BT_ub")),
      &thisId);
  thisId.fIdentifier = "AG_ub";
  e_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 55, "AG_ub")),
      &thisId, y->AG_ub);
  thisId.fIdentifier = "TO_ub";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 56, "TO_ub")),
      &thisId, y->TO_ub);
  thisId.fIdentifier = "DB_ub";
  y->DB_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 57, "DB_ub")),
      &thisId);
  thisId.fIdentifier = "PI_ub";
  y->PI_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 58, "PI_ub")),
      &thisId);
  thisId.fIdentifier = "PP_ub";
  y->PP_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 59, "PP_ub")),
      &thisId);
  thisId.fIdentifier = "CF_IB_filter_N";
  y->CF_IB_filter_N =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        60, "CF_IB_filter_N")),
                         &thisId);
  thisId.fIdentifier = "R";
  f_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 61, "R")),
      &thisId, y->R);
  thisId.fIdentifier = "Batt_Voc_brk";
  g_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 62,
                                                    "Batt_Voc_brk")),
                     &thisId, y->Batt_Voc_brk);
  thisId.fIdentifier = "Batt_As_Discharged_tbl";
  h_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 63,
                                                    "Batt_As_Discharged_tbl")),
                     &thisId, y->Batt_As_Discharged_tbl);
  thisId.fIdentifier = "zero_currents_to_update_SOC";
  y->zero_currents_to_update_SOC = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 64,
                                     "zero_currents_to_update_SOC")),
      &thisId);
  thisId.fIdentifier = "Batt_cell_zero_SOC_voltage";
  y->Batt_cell_zero_SOC_voltage = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 65,
                                     "Batt_cell_zero_SOC_voltage")),
      &thisId);
  thisId.fIdentifier = "Batt_cell_zero_SOC_capacity";
  y->Batt_cell_zero_SOC_capacity = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 66,
                                     "Batt_cell_zero_SOC_capacity")),
      &thisId);
  thisId.fIdentifier = "Batt_cell_full_SOC_voltage";
  y->Batt_cell_full_SOC_voltage = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 67,
                                     "Batt_cell_full_SOC_voltage")),
      &thisId);
  thisId.fIdentifier = "Batt_cell_full_SOC_capacity";
  y->Batt_cell_full_SOC_capacity = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 68,
                                     "Batt_cell_full_SOC_capacity")),
      &thisId);
  thisId.fIdentifier = "MAX_TORQUE_NOM";
  y->MAX_TORQUE_NOM =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        69, "MAX_TORQUE_NOM")),
                         &thisId);
  thisId.fIdentifier = "PT_WM_brkpt";
  i_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 70,
                                                    "PT_WM_brkpt")),
                     &thisId, y->PT_WM_brkpt);
  thisId.fIdentifier = "PT_VB_brkpt";
  j_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 71,
                                                    "PT_VB_brkpt")),
                     &thisId, y->PT_VB_brkpt);
  thisId.fIdentifier = "PT_TO_table";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 72,
                                                    "PT_TO_table")),
                     &thisId, y->PT_TO_table);
  thisId.fIdentifier = "PT_WM_lb";
  y->PT_WM_lb = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 73, "PT_WM_lb")),
      &thisId);
  thisId.fIdentifier = "PT_WM_ub";
  y->PT_WM_ub = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 74, "PT_WM_ub")),
      &thisId);
  thisId.fIdentifier = "PT_VB_lb";
  y->PT_VB_lb = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 75, "PT_VB_lb")),
      &thisId);
  thisId.fIdentifier = "PT_VB_ub";
  y->PT_VB_ub = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 76, "PT_VB_ub")),
      &thisId);
  thisId.fIdentifier = "mT_derating_full_T";
  y->mT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 77,
                                     "mT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "mT_derating_zero_T";
  y->mT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 78,
                                     "mT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "cT_derating_full_T";
  y->cT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 79,
                                     "cT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "cT_derating_zero_T";
  y->cT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 80,
                                     "cT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "bT_derating_full_T";
  y->bT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 81,
                                     "bT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "bT_derating_zero_T";
  y->bT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 82,
                                     "bT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "bI_derating_full_T";
  y->bI_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 83,
                                     "bI_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "bI_derating_zero_T";
  y->bI_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 84,
                                     "bI_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "Vb_derating_full_T";
  y->Vb_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 85,
                                     "Vb_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "Vb_derating_zero_T";
  y->Vb_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 86,
                                     "Vb_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "Ci_derating_full_T";
  y->Ci_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 87,
                                     "Ci_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "Ci_derating_zero_T";
  y->Ci_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 88,
                                     "Ci_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "Cm_derating_full_T";
  y->Cm_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 89,
                                     "Cm_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "Cm_derating_zero_T";
  y->Cm_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 90,
                                     "Cm_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "iT_derating_full_T";
  y->iT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 91,
                                     "iT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "iT_derating_zero_T";
  y->iT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 92,
                                     "iT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "dST_DB";
  y->dST_DB = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 93, "dST_DB")),
      &thisId);
  thisId.fIdentifier = "r_power_sat";
  y->r_power_sat =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        94, "r_power_sat")),
                         &thisId);
  thisId.fIdentifier = "TV_GS_brkpt";
  l_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 95,
                                                    "TV_GS_brkpt")),
                     &thisId, y->TV_GS_brkpt);
  thisId.fIdentifier = "TV_ST_brkpt";
  m_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 96,
                                                    "TV_ST_brkpt")),
                     &thisId, y->TV_ST_brkpt);
  thisId.fIdentifier = "TV_AV_table";
  n_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 97,
                                                    "TV_AV_table")),
                     &thisId, y->TV_AV_table);
  thisId.fIdentifier = "TV_ST_lb";
  y->TV_ST_lb = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 98, "TV_ST_lb")),
      &thisId);
  thisId.fIdentifier = "TV_ST_ub";
  y->TV_ST_ub = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 99, "TV_ST_ub")),
      &thisId);
  thisId.fIdentifier = "TV_GS_lb";
  y->TV_GS_lb = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 100, "TV_GS_lb")),
      &thisId);
  thisId.fIdentifier = "TV_GS_ub";
  y->TV_GS_ub = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 101, "TV_GS_ub")),
      &thisId);
  thisId.fIdentifier = "TC_eps";
  y->TC_eps = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 102, "TC_eps")),
      &thisId);
  thisId.fIdentifier = "TC_sl_threshold";
  y->TC_sl_threshold =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtConstCTX)sp, u, 0, 103, "TC_sl_threshold")),
                         &thisId);
  thisId.fIdentifier = "TC_throttle_mult";
  y->TC_throttle_mult =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtConstCTX)sp, u, 0, 104, "TC_throttle_mult")),
                         &thisId);
  thisId.fIdentifier = "TC_highs_to_engage";
  y->TC_highs_to_engage = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 105,
                                     "TC_highs_to_engage")),
      &thisId);
  thisId.fIdentifier = "TC_lows_to_disengage";
  y->TC_lows_to_disengage = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 106,
                                     "TC_lows_to_disengage")),
      &thisId);
  emlrtDestroyArray(&u);
}

static const mxArray *b_emlrt_marshallOut(const real_T u[5])
{
  static const int32_T iv[2] = {1, 5};
  const mxArray *m;
  const mxArray *y;
  real_T *pData;
  int32_T i;
  y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m);
  for (i = 0; i < 5; i++) {
    pData[i] = u[i];
  }
  emlrtAssign(&y, m);
  return y;
}

static void bb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[7500])
{
  static const int32_T dims[2] = {50, 150};
  real_T(*r)[7500];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[7500])emlrtMxGetData(src);
  for (i = 0; i < 7500; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = s_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *c_emlrt_marshallOut(const real_T u[2])
{
  static const int32_T iv[2] = {1, 2};
  const mxArray *m;
  const mxArray *y;
  real_T *pData;
  y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m);
  pData[0] = u[0];
  pData[1] = u[1];
  emlrtAssign(&y, m);
  return y;
}

static void cb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[51])
{
  static const int32_T dims[2] = {1, 51};
  real_T(*r)[51];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[51])emlrtMxGetData(src);
  for (i = 0; i < 51; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[2])
{
  t_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *d_emlrt_marshallOut(const real_T u[3])
{
  static const int32_T iv[2] = {1, 3};
  const mxArray *m;
  const mxArray *y;
  real_T *pData;
  y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m);
  pData[0] = u[0];
  pData[1] = u[1];
  pData[2] = u[2];
  emlrtAssign(&y, m);
  return y;
}

static void db_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[53])
{
  static const int32_T dims[2] = {1, 53};
  real_T(*r)[53];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[53])emlrtMxGetData(src);
  for (i = 0; i < 53; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[3])
{
  u_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[2703])
{
  static const int32_T dims[2] = {51, 53};
  real_T(*r)[2703];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[2703])emlrtMxGetData(src);
  for (i = 0; i < 2703; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                             const char_T *identifier, struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static const mxArray *emlrt_marshallOut(const struct1_T *u)
{
  static const int32_T iv[2] = {1, 10};
  static const char_T *sv[39] = {"ET_permit_buffer",
                                 "PT_permit_buffer",
                                 "VS_permit_buffer",
                                 "VT_permit_buffer",
                                 "VCU_mode",
                                 "IB_CF_buffer",
                                 "TH_CF",
                                 "ST_CF",
                                 "VB_CF",
                                 "WT_CF",
                                 "WM_CF",
                                 "GS_CF",
                                 "AV_CF",
                                 "IB_CF",
                                 "MT_CF",
                                 "CT_CF",
                                 "IT_CF",
                                 "MC_CF",
                                 "IC_CF",
                                 "BT_CF",
                                 "AG_CF",
                                 "TO_CF",
                                 "DB_CF",
                                 "PI_CF",
                                 "PP_CF",
                                 "Batt_SOC",
                                 "zero_current_counter",
                                 "TO_ET",
                                 "TO_AB_MX",
                                 "TO_DR_MX",
                                 "TO_PT",
                                 "WM_VS",
                                 "VT_mode",
                                 "TO_VT",
                                 "TV_AV_ref",
                                 "TV_delta_torque",
                                 "TC_highs",
                                 "TC_lows",
                                 "sl"};
  const mxArray *ab_y;
  const mxArray *b_y;
  const mxArray *bb_y;
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
  const mxArray *m21;
  const mxArray *m22;
  const mxArray *m23;
  const mxArray *m24;
  const mxArray *m25;
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
  const mxArray *w_y;
  const mxArray *x_y;
  const mxArray *y;
  const mxArray *y_y;
  real_T *pData;
  int32_T i;
  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 39, (const char_T **)&sv[0]));
  emlrtSetFieldR2017b(y, 0, "ET_permit_buffer",
                      b_emlrt_marshallOut(u->ET_permit_buffer), 0);
  emlrtSetFieldR2017b(y, 0, "PT_permit_buffer",
                      b_emlrt_marshallOut(u->PT_permit_buffer), 1);
  emlrtSetFieldR2017b(y, 0, "VS_permit_buffer",
                      b_emlrt_marshallOut(u->VS_permit_buffer), 2);
  emlrtSetFieldR2017b(y, 0, "VT_permit_buffer",
                      b_emlrt_marshallOut(u->VT_permit_buffer), 3);
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->VCU_mode);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "VCU_mode", b_y, 4);
  c_y = NULL;
  m1 = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m1);
  for (i = 0; i < 10; i++) {
    pData[i] = u->IB_CF_buffer[i];
  }
  emlrtAssign(&c_y, m1);
  emlrtSetFieldR2017b(y, 0, "IB_CF_buffer", c_y, 5);
  d_y = NULL;
  m2 = emlrtCreateDoubleScalar(u->TH_CF);
  emlrtAssign(&d_y, m2);
  emlrtSetFieldR2017b(y, 0, "TH_CF", d_y, 6);
  e_y = NULL;
  m3 = emlrtCreateDoubleScalar(u->ST_CF);
  emlrtAssign(&e_y, m3);
  emlrtSetFieldR2017b(y, 0, "ST_CF", e_y, 7);
  f_y = NULL;
  m4 = emlrtCreateDoubleScalar(u->VB_CF);
  emlrtAssign(&f_y, m4);
  emlrtSetFieldR2017b(y, 0, "VB_CF", f_y, 8);
  emlrtSetFieldR2017b(y, 0, "WT_CF", c_emlrt_marshallOut(u->WT_CF), 9);
  emlrtSetFieldR2017b(y, 0, "WM_CF", c_emlrt_marshallOut(u->WM_CF), 10);
  g_y = NULL;
  m5 = emlrtCreateDoubleScalar(u->GS_CF);
  emlrtAssign(&g_y, m5);
  emlrtSetFieldR2017b(y, 0, "GS_CF", g_y, 11);
  emlrtSetFieldR2017b(y, 0, "AV_CF", d_emlrt_marshallOut(u->AV_CF), 12);
  h_y = NULL;
  m6 = emlrtCreateDoubleScalar(u->IB_CF);
  emlrtAssign(&h_y, m6);
  emlrtSetFieldR2017b(y, 0, "IB_CF", h_y, 13);
  i_y = NULL;
  m7 = emlrtCreateDoubleScalar(u->MT_CF);
  emlrtAssign(&i_y, m7);
  emlrtSetFieldR2017b(y, 0, "MT_CF", i_y, 14);
  j_y = NULL;
  m8 = emlrtCreateDoubleScalar(u->CT_CF);
  emlrtAssign(&j_y, m8);
  emlrtSetFieldR2017b(y, 0, "CT_CF", j_y, 15);
  k_y = NULL;
  m9 = emlrtCreateDoubleScalar(u->IT_CF);
  emlrtAssign(&k_y, m9);
  emlrtSetFieldR2017b(y, 0, "IT_CF", k_y, 16);
  l_y = NULL;
  m10 = emlrtCreateDoubleScalar(u->MC_CF);
  emlrtAssign(&l_y, m10);
  emlrtSetFieldR2017b(y, 0, "MC_CF", l_y, 17);
  m_y = NULL;
  m11 = emlrtCreateDoubleScalar(u->IC_CF);
  emlrtAssign(&m_y, m11);
  emlrtSetFieldR2017b(y, 0, "IC_CF", m_y, 18);
  n_y = NULL;
  m12 = emlrtCreateDoubleScalar(u->BT_CF);
  emlrtAssign(&n_y, m12);
  emlrtSetFieldR2017b(y, 0, "BT_CF", n_y, 19);
  emlrtSetFieldR2017b(y, 0, "AG_CF", d_emlrt_marshallOut(u->AG_CF), 20);
  emlrtSetFieldR2017b(y, 0, "TO_CF", c_emlrt_marshallOut(u->TO_CF), 21);
  o_y = NULL;
  m13 = emlrtCreateDoubleScalar(u->DB_CF);
  emlrtAssign(&o_y, m13);
  emlrtSetFieldR2017b(y, 0, "DB_CF", o_y, 22);
  p_y = NULL;
  m14 = emlrtCreateDoubleScalar(u->PI_CF);
  emlrtAssign(&p_y, m14);
  emlrtSetFieldR2017b(y, 0, "PI_CF", p_y, 23);
  q_y = NULL;
  m15 = emlrtCreateDoubleScalar(u->PP_CF);
  emlrtAssign(&q_y, m15);
  emlrtSetFieldR2017b(y, 0, "PP_CF", q_y, 24);
  r_y = NULL;
  m16 = emlrtCreateDoubleScalar(u->Batt_SOC);
  emlrtAssign(&r_y, m16);
  emlrtSetFieldR2017b(y, 0, "Batt_SOC", r_y, 25);
  s_y = NULL;
  m17 = emlrtCreateDoubleScalar(u->zero_current_counter);
  emlrtAssign(&s_y, m17);
  emlrtSetFieldR2017b(y, 0, "zero_current_counter", s_y, 26);
  emlrtSetFieldR2017b(y, 0, "TO_ET", c_emlrt_marshallOut(u->TO_ET), 27);
  t_y = NULL;
  m18 = emlrtCreateDoubleScalar(u->TO_AB_MX);
  emlrtAssign(&t_y, m18);
  emlrtSetFieldR2017b(y, 0, "TO_AB_MX", t_y, 28);
  u_y = NULL;
  m19 = emlrtCreateDoubleScalar(u->TO_DR_MX);
  emlrtAssign(&u_y, m19);
  emlrtSetFieldR2017b(y, 0, "TO_DR_MX", u_y, 29);
  emlrtSetFieldR2017b(y, 0, "TO_PT", c_emlrt_marshallOut(u->TO_PT), 30);
  emlrtSetFieldR2017b(y, 0, "WM_VS", c_emlrt_marshallOut(u->WM_VS), 31);
  v_y = NULL;
  m20 = emlrtCreateDoubleScalar(u->VT_mode);
  emlrtAssign(&v_y, m20);
  emlrtSetFieldR2017b(y, 0, "VT_mode", v_y, 32);
  emlrtSetFieldR2017b(y, 0, "TO_VT", c_emlrt_marshallOut(u->TO_VT), 33);
  w_y = NULL;
  m21 = emlrtCreateDoubleScalar(u->TV_AV_ref);
  emlrtAssign(&w_y, m21);
  emlrtSetFieldR2017b(y, 0, "TV_AV_ref", w_y, 34);
  x_y = NULL;
  m22 = emlrtCreateDoubleScalar(u->TV_delta_torque);
  emlrtAssign(&x_y, m22);
  emlrtSetFieldR2017b(y, 0, "TV_delta_torque", x_y, 35);
  y_y = NULL;
  m23 = emlrtCreateDoubleScalar(u->TC_highs);
  emlrtAssign(&y_y, m23);
  emlrtSetFieldR2017b(y, 0, "TC_highs", y_y, 36);
  ab_y = NULL;
  m24 = emlrtCreateDoubleScalar(u->TC_lows);
  emlrtAssign(&ab_y, m24);
  emlrtSetFieldR2017b(y, 0, "TC_lows", ab_y, 37);
  bb_y = NULL;
  m25 = emlrtCreateDoubleScalar(u->sl);
  emlrtAssign(&bb_y, m25);
  emlrtSetFieldR2017b(y, 0, "sl", bb_y, 38);
  return y;
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[9])
{
  v_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[5])
{
  static const int32_T dims[2] = {1, 5};
  real_T(*r)[5];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[5])emlrtMxGetData(src);
  for (i = 0; i < 5; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[506])
{
  w_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[10])
{
  static const int32_T dims[2] = {1, 10};
  real_T(*r)[10];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[10])emlrtMxGetData(src);
  for (i = 0; i < 10; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[506])
{
  x_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[150])
{
  y_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[50])
{
  ab_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[7500])
{
  bb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[51])
{
  cb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[53])
{
  db_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[2703])
{
  eb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, struct1_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  p_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, struct1_T *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[39] = {"ET_permit_buffer",
                                         "PT_permit_buffer",
                                         "VS_permit_buffer",
                                         "VT_permit_buffer",
                                         "VCU_mode",
                                         "IB_CF_buffer",
                                         "TH_CF",
                                         "ST_CF",
                                         "VB_CF",
                                         "WT_CF",
                                         "WM_CF",
                                         "GS_CF",
                                         "AV_CF",
                                         "IB_CF",
                                         "MT_CF",
                                         "CT_CF",
                                         "IT_CF",
                                         "MC_CF",
                                         "IC_CF",
                                         "BT_CF",
                                         "AG_CF",
                                         "TO_CF",
                                         "DB_CF",
                                         "PI_CF",
                                         "PP_CF",
                                         "Batt_SOC",
                                         "zero_current_counter",
                                         "TO_ET",
                                         "TO_AB_MX",
                                         "TO_DR_MX",
                                         "TO_PT",
                                         "WM_VS",
                                         "VT_mode",
                                         "TO_VT",
                                         "TV_AV_ref",
                                         "TV_delta_torque",
                                         "TC_highs",
                                         "TC_lows",
                                         "sl"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 39,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "ET_permit_buffer";
  q_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 0,
                                                    "ET_permit_buffer")),
                     &thisId, y->ET_permit_buffer);
  thisId.fIdentifier = "PT_permit_buffer";
  q_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1,
                                                    "PT_permit_buffer")),
                     &thisId, y->PT_permit_buffer);
  thisId.fIdentifier = "VS_permit_buffer";
  q_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 2,
                                                    "VS_permit_buffer")),
                     &thisId, y->VS_permit_buffer);
  thisId.fIdentifier = "VT_permit_buffer";
  q_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 3,
                                                    "VT_permit_buffer")),
                     &thisId, y->VT_permit_buffer);
  thisId.fIdentifier = "VCU_mode";
  y->VCU_mode = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 4, "VCU_mode")),
      &thisId);
  thisId.fIdentifier = "IB_CF_buffer";
  r_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 5,
                                                    "IB_CF_buffer")),
                     &thisId, y->IB_CF_buffer);
  thisId.fIdentifier = "TH_CF";
  y->TH_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 6, "TH_CF")),
      &thisId);
  thisId.fIdentifier = "ST_CF";
  y->ST_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 7, "ST_CF")),
      &thisId);
  thisId.fIdentifier = "VB_CF";
  y->VB_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 8, "VB_CF")),
      &thisId);
  thisId.fIdentifier = "WT_CF";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 9, "WT_CF")),
      &thisId, y->WT_CF);
  thisId.fIdentifier = "WM_CF";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 10, "WM_CF")),
      &thisId, y->WM_CF);
  thisId.fIdentifier = "GS_CF";
  y->GS_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 11, "GS_CF")),
      &thisId);
  thisId.fIdentifier = "AV_CF";
  e_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 12, "AV_CF")),
      &thisId, y->AV_CF);
  thisId.fIdentifier = "IB_CF";
  y->IB_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 13, "IB_CF")),
      &thisId);
  thisId.fIdentifier = "MT_CF";
  y->MT_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 14, "MT_CF")),
      &thisId);
  thisId.fIdentifier = "CT_CF";
  y->CT_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 15, "CT_CF")),
      &thisId);
  thisId.fIdentifier = "IT_CF";
  y->IT_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 16, "IT_CF")),
      &thisId);
  thisId.fIdentifier = "MC_CF";
  y->MC_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 17, "MC_CF")),
      &thisId);
  thisId.fIdentifier = "IC_CF";
  y->IC_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 18, "IC_CF")),
      &thisId);
  thisId.fIdentifier = "BT_CF";
  y->BT_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 19, "BT_CF")),
      &thisId);
  thisId.fIdentifier = "AG_CF";
  e_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 20, "AG_CF")),
      &thisId, y->AG_CF);
  thisId.fIdentifier = "TO_CF";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 21, "TO_CF")),
      &thisId, y->TO_CF);
  thisId.fIdentifier = "DB_CF";
  y->DB_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 22, "DB_CF")),
      &thisId);
  thisId.fIdentifier = "PI_CF";
  y->PI_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 23, "PI_CF")),
      &thisId);
  thisId.fIdentifier = "PP_CF";
  y->PP_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 24, "PP_CF")),
      &thisId);
  thisId.fIdentifier = "Batt_SOC";
  y->Batt_SOC = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 25, "Batt_SOC")),
      &thisId);
  thisId.fIdentifier = "zero_current_counter";
  y->zero_current_counter = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 26,
                                     "zero_current_counter")),
      &thisId);
  thisId.fIdentifier = "TO_ET";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 27, "TO_ET")),
      &thisId, y->TO_ET);
  thisId.fIdentifier = "TO_AB_MX";
  y->TO_AB_MX = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 28, "TO_AB_MX")),
      &thisId);
  thisId.fIdentifier = "TO_DR_MX";
  y->TO_DR_MX = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 29, "TO_DR_MX")),
      &thisId);
  thisId.fIdentifier = "TO_PT";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 30, "TO_PT")),
      &thisId, y->TO_PT);
  thisId.fIdentifier = "WM_VS";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 31, "WM_VS")),
      &thisId, y->WM_VS);
  thisId.fIdentifier = "VT_mode";
  y->VT_mode = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 32, "VT_mode")),
      &thisId);
  thisId.fIdentifier = "TO_VT";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 33, "TO_VT")),
      &thisId, y->TO_VT);
  thisId.fIdentifier = "TV_AV_ref";
  y->TV_AV_ref = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 34, "TV_AV_ref")),
      &thisId);
  thisId.fIdentifier = "TV_delta_torque";
  y->TV_delta_torque =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        35, "TV_delta_torque")),
                         &thisId);
  thisId.fIdentifier = "TC_highs";
  y->TC_highs = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 36, "TC_highs")),
      &thisId);
  thisId.fIdentifier = "TC_lows";
  y->TC_lows = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 37, "TC_lows")),
      &thisId);
  thisId.fIdentifier = "sl";
  y->sl = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 38, "sl")),
      &thisId);
  emlrtDestroyArray(&u);
}

static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[5])
{
  fb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[10])
{
  gb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
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

static void t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
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

static void u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
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

static void v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[9])
{
  static const int32_T dims[2] = {3, 3};
  real_T(*r)[9];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[9])emlrtMxGetData(src);
  for (i = 0; i < 9; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

static void w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[506])
{
  static const int32_T dims = 506;
  real_T(*r)[506];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 1U,
                          (const void *)&dims);
  r = (real_T(*)[506])emlrtMxGetData(src);
  for (i = 0; i < 506; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

static void x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[506])
{
  static const int32_T dims[2] = {1, 506};
  real_T(*r)[506];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[506])emlrtMxGetData(src);
  for (i = 0; i < 506; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

static void y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, real_T ret[150])
{
  static const int32_T dims = 150;
  real_T(*r)[150];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 1U,
                          (const void *)&dims);
  r = (real_T(*)[150])emlrtMxGetData(src);
  for (i = 0; i < 150; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

void get_ET_api(const mxArray *const prhs[2], const mxArray **plhs)
{
  emlrtStack st = {NULL, NULL, NULL};
  struct0_T p;
  struct1_T y;
  st.tls = emlrtRootTLSGlobal;

  emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "p", &p);
  o_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "y", &y);

  get_ET(&p, &y);

  *plhs = emlrt_marshallOut(&y);
}

void get_ET_atexit(void)
{
  emlrtStack st = {NULL, NULL, NULL};
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  get_ET_xil_terminate();
  get_ET_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void get_ET_initialize(void)
{
  emlrtStack st = {NULL, NULL, NULL};
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

void get_ET_terminate(void)
{
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}
