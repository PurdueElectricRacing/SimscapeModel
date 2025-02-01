/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_get_y_cf_api.c
 *
 * MATLAB Coder version            : 24.2
 * C/C++ source code generated on  : 01-Feb-2025 14:01:15
 */

/* Include Files */
#include "_coder_get_y_cf_api.h"
#include "_coder_get_y_cf_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;

emlrtContext emlrtContextGlobal = {
    true,                                                 /* bFirstTime */
    false,                                                /* bInitialized */
    131659U,                                              /* fVersionInfo */
    NULL,                                                 /* fErrorFunction */
    "get_y_cf",                                           /* fFunctionName */
    NULL,                                                 /* fRTCallStack */
    false,                                                /* bDebugMode */
    {2045744189U, 2170104910U, 2743257031U, 4284093946U}, /* fSigWrd */
    NULL                                                  /* fSigMem */
};

/* Function Declarations */
static void ab_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                real_T y[10]);

static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               struct0_T *y);

static const mxArray *b_emlrt_marshallOut(const real_T u[2]);

static real_T bb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId);

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static const mxArray *c_emlrt_marshallOut(const real_T u[3]);

static void cb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[2]);

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[2]);

static void db_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId);

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static void eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[3]);

static void emlrtExitTimeCleanupDtorFcn(const void *r);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                             const char_T *identifier, struct0_T *y);

static const mxArray *emlrt_marshallOut(const struct3_T *u);

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[3]);

static void fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[9]);

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[9]);

static void gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[506]);

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[506]);

static void hb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[506]);

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[506]);

static void ib_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[150]);

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               griddedInterpolant *y);

static void jb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[50]);

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, cell_0 *y);

static void kb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[7500]);

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[150]);

static boolean_T lb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                     const emlrtMsgIdentifier *msgId);

static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[50]);

static void mb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId);

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[7500]);

static uint8_T nb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId);

static boolean_T o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static void ob_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[51]);

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static void pb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[53]);

static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static void qb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[2703]);

static uint8_T r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId);

static void rb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[10]);

static void s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[51]);

static void t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[53]);

static void u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[2703]);

static void v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, struct2_T *y);

static void w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               struct2_T *y);

static void x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, struct3_T *y);

static void y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               struct3_T *y);

/* Function Definitions */
/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[10]
 * Return Type  : void
 */
static void ab_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                real_T y[10])
{
  rb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                struct0_T *y
 * Return Type  : void
 */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, struct0_T *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[93] = {"r",
                                         "ht",
                                         "gr",
                                         "series",
                                         "CS_SFLAG_True",
                                         "TB_SFLAG_True",
                                         "SS_SFLAG_True",
                                         "WT_SFLAG_True",
                                         "IV_SFLAG_True",
                                         "BT_SFLAG_True",
                                         "MT_SFLAG_True",
                                         "CT_SFLAG_True",
                                         "MO_SFLAG_True",
                                         "SS_FFLAG_True",
                                         "AV_FFLAG_True",
                                         "GS_FFLAG_True",
                                         "VS_PFLAG_True",
                                         "VT_PFLAG_True",
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
                                         "CF_IB_filter",
                                         "R",
                                         "Batt_Voc_brk",
                                         "Batt_As_Discharged_tbl",
                                         "zero_currents_to_update_SOC",
                                         "Batt_cell_zero_SOC_voltage",
                                         "Batt_cell_zero_SOC_capacity",
                                         "Batt_cell_full_SOC_voltage",
                                         "Batt_cell_full_SOC_capacity",
                                         "MAX_TORQUE_NOM",
                                         "torque_interpolant",
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
                                         "TV_vel_brkpt",
                                         "TV_phi_brkpt",
                                         "TV_yaw_table",
                                         "TC_eps",
                                         "TC_sl_threshold",
                                         "TC_throttle_mult",
                                         "TC_highs_to_engage",
                                         "TC_lows_to_disengage"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 93,
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
  e_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 2, "gr")),
      &thisId);
  thisId.fIdentifier = "series";
  y->series = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 3, "series")),
      &thisId);
  thisId.fIdentifier = "CS_SFLAG_True";
  y->CS_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        4, "CS_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "TB_SFLAG_True";
  y->TB_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        5, "TB_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "SS_SFLAG_True";
  y->SS_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        6, "SS_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "WT_SFLAG_True";
  y->WT_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        7, "WT_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "IV_SFLAG_True";
  y->IV_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        8, "IV_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "BT_SFLAG_True";
  y->BT_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        9, "BT_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "MT_SFLAG_True";
  y->MT_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        10, "MT_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "CT_SFLAG_True";
  y->CT_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        11, "CT_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "MO_SFLAG_True";
  y->MO_SFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        12, "MO_SFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "SS_FFLAG_True";
  y->SS_FFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        13, "SS_FFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "AV_FFLAG_True";
  y->AV_FFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        14, "AV_FFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "GS_FFLAG_True";
  y->GS_FFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        15, "GS_FFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "VS_PFLAG_True";
  y->VS_PFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        16, "VS_PFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "VT_PFLAG_True";
  y->VT_PFLAG_True =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        17, "VT_PFLAG_True")),
                         &thisId);
  thisId.fIdentifier = "TH_lb";
  y->TH_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 18, "TH_lb")),
      &thisId);
  thisId.fIdentifier = "ST_lb";
  y->ST_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 19, "ST_lb")),
      &thisId);
  thisId.fIdentifier = "VB_lb";
  y->VB_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 20, "VB_lb")),
      &thisId);
  thisId.fIdentifier = "WT_lb";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 21, "WT_lb")),
      &thisId, y->WT_lb);
  thisId.fIdentifier = "WM_lb";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 22, "WM_lb")),
      &thisId, y->WM_lb);
  thisId.fIdentifier = "GS_lb";
  y->GS_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 23, "GS_lb")),
      &thisId);
  thisId.fIdentifier = "AV_lb";
  f_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 24, "AV_lb")),
      &thisId, y->AV_lb);
  thisId.fIdentifier = "IB_lb";
  y->IB_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 25, "IB_lb")),
      &thisId);
  thisId.fIdentifier = "MT_lb";
  y->MT_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 26, "MT_lb")),
      &thisId);
  thisId.fIdentifier = "CT_lb";
  y->CT_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 27, "CT_lb")),
      &thisId);
  thisId.fIdentifier = "IT_lb";
  y->IT_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 28, "IT_lb")),
      &thisId);
  thisId.fIdentifier = "MC_lb";
  y->MC_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 29, "MC_lb")),
      &thisId);
  thisId.fIdentifier = "IC_lb";
  y->IC_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 30, "IC_lb")),
      &thisId);
  thisId.fIdentifier = "BT_lb";
  y->BT_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 31, "BT_lb")),
      &thisId);
  thisId.fIdentifier = "AG_lb";
  f_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 32, "AG_lb")),
      &thisId, y->AG_lb);
  thisId.fIdentifier = "TO_lb";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 33, "TO_lb")),
      &thisId, y->TO_lb);
  thisId.fIdentifier = "DB_lb";
  y->DB_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 34, "DB_lb")),
      &thisId);
  thisId.fIdentifier = "PI_lb";
  y->PI_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 35, "PI_lb")),
      &thisId);
  thisId.fIdentifier = "PP_lb";
  y->PP_lb = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 36, "PP_lb")),
      &thisId);
  thisId.fIdentifier = "TH_ub";
  y->TH_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 37, "TH_ub")),
      &thisId);
  thisId.fIdentifier = "ST_ub";
  y->ST_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 38, "ST_ub")),
      &thisId);
  thisId.fIdentifier = "VB_ub";
  y->VB_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 39, "VB_ub")),
      &thisId);
  thisId.fIdentifier = "WT_ub";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 40, "WT_ub")),
      &thisId, y->WT_ub);
  thisId.fIdentifier = "WM_ub";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 41, "WM_ub")),
      &thisId, y->WM_ub);
  thisId.fIdentifier = "GS_ub";
  y->GS_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 42, "GS_ub")),
      &thisId);
  thisId.fIdentifier = "AV_ub";
  f_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 43, "AV_ub")),
      &thisId, y->AV_ub);
  thisId.fIdentifier = "IB_ub";
  y->IB_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 44, "IB_ub")),
      &thisId);
  thisId.fIdentifier = "MT_ub";
  y->MT_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 45, "MT_ub")),
      &thisId);
  thisId.fIdentifier = "CT_ub";
  y->CT_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 46, "CT_ub")),
      &thisId);
  thisId.fIdentifier = "IT_ub";
  y->IT_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 47, "IT_ub")),
      &thisId);
  thisId.fIdentifier = "MC_ub";
  y->MC_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 48, "MC_ub")),
      &thisId);
  thisId.fIdentifier = "IC_ub";
  y->IC_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 49, "IC_ub")),
      &thisId);
  thisId.fIdentifier = "BT_ub";
  y->BT_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 50, "BT_ub")),
      &thisId);
  thisId.fIdentifier = "AG_ub";
  f_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 51, "AG_ub")),
      &thisId, y->AG_ub);
  thisId.fIdentifier = "TO_ub";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 52, "TO_ub")),
      &thisId, y->TO_ub);
  thisId.fIdentifier = "DB_ub";
  y->DB_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 53, "DB_ub")),
      &thisId);
  thisId.fIdentifier = "PI_ub";
  y->PI_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 54, "PI_ub")),
      &thisId);
  thisId.fIdentifier = "PP_ub";
  y->PP_ub = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 55, "PP_ub")),
      &thisId);
  thisId.fIdentifier = "CF_IB_filter";
  y->CF_IB_filter =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        56, "CF_IB_filter")),
                         &thisId);
  thisId.fIdentifier = "R";
  g_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 57, "R")),
      &thisId, y->R);
  thisId.fIdentifier = "Batt_Voc_brk";
  h_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 58,
                                                    "Batt_Voc_brk")),
                     &thisId, y->Batt_Voc_brk);
  thisId.fIdentifier = "Batt_As_Discharged_tbl";
  i_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 59,
                                                    "Batt_As_Discharged_tbl")),
                     &thisId, y->Batt_As_Discharged_tbl);
  thisId.fIdentifier = "zero_currents_to_update_SOC";
  y->zero_currents_to_update_SOC = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 60,
                                     "zero_currents_to_update_SOC")),
      &thisId);
  thisId.fIdentifier = "Batt_cell_zero_SOC_voltage";
  y->Batt_cell_zero_SOC_voltage = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 61,
                                     "Batt_cell_zero_SOC_voltage")),
      &thisId);
  thisId.fIdentifier = "Batt_cell_zero_SOC_capacity";
  y->Batt_cell_zero_SOC_capacity = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 62,
                                     "Batt_cell_zero_SOC_capacity")),
      &thisId);
  thisId.fIdentifier = "Batt_cell_full_SOC_voltage";
  y->Batt_cell_full_SOC_voltage = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 63,
                                     "Batt_cell_full_SOC_voltage")),
      &thisId);
  thisId.fIdentifier = "Batt_cell_full_SOC_capacity";
  y->Batt_cell_full_SOC_capacity = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 64,
                                     "Batt_cell_full_SOC_capacity")),
      &thisId);
  thisId.fIdentifier = "MAX_TORQUE_NOM";
  y->MAX_TORQUE_NOM =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        65, "MAX_TORQUE_NOM")),
                         &thisId);
  thisId.fIdentifier = "torque_interpolant";
  j_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 66,
                                                    "torque_interpolant")),
                     &thisId, &y->torque_interpolant);
  thisId.fIdentifier = "mT_derating_full_T";
  y->mT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 67,
                                     "mT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "mT_derating_zero_T";
  y->mT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 68,
                                     "mT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "cT_derating_full_T";
  e_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 69,
                                                    "cT_derating_full_T")),
                     &thisId);
  thisId.fIdentifier = "cT_derating_zero_T";
  e_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 70,
                                                    "cT_derating_zero_T")),
                     &thisId);
  thisId.fIdentifier = "bT_derating_full_T";
  y->bT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 71,
                                     "bT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "bT_derating_zero_T";
  y->bT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 72,
                                     "bT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "bI_derating_full_T";
  y->bI_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 73,
                                     "bI_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "bI_derating_zero_T";
  y->bI_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 74,
                                     "bI_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "Vb_derating_full_T";
  y->Vb_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 75,
                                     "Vb_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "Vb_derating_zero_T";
  y->Vb_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 76,
                                     "Vb_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "Ci_derating_full_T";
  y->Ci_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 77,
                                     "Ci_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "Ci_derating_zero_T";
  y->Ci_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 78,
                                     "Ci_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "Cm_derating_full_T";
  y->Cm_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 79,
                                     "Cm_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "Cm_derating_zero_T";
  y->Cm_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 80,
                                     "Cm_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "iT_derating_full_T";
  y->iT_derating_full_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 81,
                                     "iT_derating_full_T")),
      &thisId);
  thisId.fIdentifier = "iT_derating_zero_T";
  y->iT_derating_zero_T = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 82,
                                     "iT_derating_zero_T")),
      &thisId);
  thisId.fIdentifier = "dST_DB";
  y->dST_DB = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 83, "dST_DB")),
      &thisId);
  thisId.fIdentifier = "r_power_sat";
  y->r_power_sat =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        84, "r_power_sat")),
                         &thisId);
  thisId.fIdentifier = "TV_vel_brkpt";
  s_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 85,
                                                    "TV_vel_brkpt")),
                     &thisId, y->TV_vel_brkpt);
  thisId.fIdentifier = "TV_phi_brkpt";
  t_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 86,
                                                    "TV_phi_brkpt")),
                     &thisId, y->TV_phi_brkpt);
  thisId.fIdentifier = "TV_yaw_table";
  u_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 87,
                                                    "TV_yaw_table")),
                     &thisId, y->TV_yaw_table);
  thisId.fIdentifier = "TC_eps";
  y->TC_eps = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 88, "TC_eps")),
      &thisId);
  thisId.fIdentifier = "TC_sl_threshold";
  y->TC_sl_threshold =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0,
                                                        89, "TC_sl_threshold")),
                         &thisId);
  thisId.fIdentifier = "TC_throttle_mult";
  y->TC_throttle_mult =
      c_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtConstCTX)sp, u, 0, 90, "TC_throttle_mult")),
                         &thisId);
  thisId.fIdentifier = "TC_highs_to_engage";
  y->TC_highs_to_engage = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 91,
                                     "TC_highs_to_engage")),
      &thisId);
  thisId.fIdentifier = "TC_lows_to_disengage";
  y->TC_lows_to_disengage = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 92,
                                     "TC_lows_to_disengage")),
      &thisId);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const real_T u[2]
 * Return Type  : const mxArray *
 */
static const mxArray *b_emlrt_marshallOut(const real_T u[2])
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real_T
 */
static real_T bb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real_T
 */
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = bb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const real_T u[3]
 * Return Type  : const mxArray *
 */
static const mxArray *c_emlrt_marshallOut(const real_T u[3])
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[2]
 * Return Type  : void
 */
static void cb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[2]
 * Return Type  : void
 */
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[2])
{
  cb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : void
 */
static void db_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims[2] = {0, 0};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  emlrtMxGetData(src);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : void
 */
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  db_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[3]
 * Return Type  : void
 */
static void eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
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

/*
 * Arguments    : const void *r
 * Return Type  : void
 */
static void emlrtExitTimeCleanupDtorFcn(const void *r)
{
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *nullptr
 *                const char_T *identifier
 *                struct0_T *y
 * Return Type  : void
 */
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

/*
 * Arguments    : const struct3_T *u
 * Return Type  : const mxArray *
 */
static const mxArray *emlrt_marshallOut(const struct3_T *u)
{
  static const int32_T iv[2] = {1, 10};
  static const int32_T iv1[2] = {0, 0};
  static const int32_T iv2[2] = {0, 0};
  static const char_T *sv[30] = {"IB_CF_vec", "TH_CF",
                                 "ST_CF",     "VB_CF",
                                 "WT_CF",     "WM_CF",
                                 "GS_CF",     "AV_CF",
                                 "IB_CF",     "MT_CF",
                                 "CT_CF",     "IT_CF",
                                 "MC_CF",     "IC_CF",
                                 "BT_CF",     "AG_CF",
                                 "TO_CF",     "DB_CF",
                                 "PI_CF",     "PP_CF",
                                 "Batt_SOC",  "zero_current_counter",
                                 "TO_ET",     "TO_AB_MX",
                                 "TO_DR_MX",  "TO_PT",
                                 "TC_highs",  "TC_lows",
                                 "VCU_mode",  "VT_mode"};
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
  real_T *pData;
  int32_T i;
  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 30, (const char_T **)&sv[0]));
  b_y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m);
  for (i = 0; i < 10; i++) {
    pData[i] = u->IB_CF_vec[i];
  }
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "IB_CF_vec", b_y, 0);
  c_y = NULL;
  m = emlrtCreateDoubleScalar(u->TH_CF);
  emlrtAssign(&c_y, m);
  emlrtSetFieldR2017b(y, 0, "TH_CF", c_y, 1);
  d_y = NULL;
  m = emlrtCreateDoubleScalar(u->ST_CF);
  emlrtAssign(&d_y, m);
  emlrtSetFieldR2017b(y, 0, "ST_CF", d_y, 2);
  e_y = NULL;
  m = emlrtCreateDoubleScalar(u->VB_CF);
  emlrtAssign(&e_y, m);
  emlrtSetFieldR2017b(y, 0, "VB_CF", e_y, 3);
  emlrtSetFieldR2017b(y, 0, "WT_CF", b_emlrt_marshallOut(u->WT_CF), 4);
  emlrtSetFieldR2017b(y, 0, "WM_CF", b_emlrt_marshallOut(u->WM_CF), 5);
  f_y = NULL;
  m = emlrtCreateDoubleScalar(u->GS_CF);
  emlrtAssign(&f_y, m);
  emlrtSetFieldR2017b(y, 0, "GS_CF", f_y, 6);
  emlrtSetFieldR2017b(y, 0, "AV_CF", c_emlrt_marshallOut(u->AV_CF), 7);
  g_y = NULL;
  m = emlrtCreateDoubleScalar(u->IB_CF);
  emlrtAssign(&g_y, m);
  emlrtSetFieldR2017b(y, 0, "IB_CF", g_y, 8);
  h_y = NULL;
  m = emlrtCreateDoubleScalar(u->MT_CF);
  emlrtAssign(&h_y, m);
  emlrtSetFieldR2017b(y, 0, "MT_CF", h_y, 9);
  i_y = NULL;
  m = emlrtCreateDoubleScalar(u->CT_CF);
  emlrtAssign(&i_y, m);
  emlrtSetFieldR2017b(y, 0, "CT_CF", i_y, 10);
  j_y = NULL;
  m = emlrtCreateDoubleScalar(u->IT_CF);
  emlrtAssign(&j_y, m);
  emlrtSetFieldR2017b(y, 0, "IT_CF", j_y, 11);
  k_y = NULL;
  m = emlrtCreateDoubleScalar(u->MC_CF);
  emlrtAssign(&k_y, m);
  emlrtSetFieldR2017b(y, 0, "MC_CF", k_y, 12);
  l_y = NULL;
  m = emlrtCreateDoubleScalar(u->IC_CF);
  emlrtAssign(&l_y, m);
  emlrtSetFieldR2017b(y, 0, "IC_CF", l_y, 13);
  m_y = NULL;
  m = emlrtCreateDoubleScalar(u->BT_CF);
  emlrtAssign(&m_y, m);
  emlrtSetFieldR2017b(y, 0, "BT_CF", m_y, 14);
  emlrtSetFieldR2017b(y, 0, "AG_CF", c_emlrt_marshallOut(u->AG_CF), 15);
  emlrtSetFieldR2017b(y, 0, "TO_CF", b_emlrt_marshallOut(u->TO_CF), 16);
  n_y = NULL;
  m = emlrtCreateDoubleScalar(u->DB_CF);
  emlrtAssign(&n_y, m);
  emlrtSetFieldR2017b(y, 0, "DB_CF", n_y, 17);
  o_y = NULL;
  m = emlrtCreateDoubleScalar(u->PI_CF);
  emlrtAssign(&o_y, m);
  emlrtSetFieldR2017b(y, 0, "PI_CF", o_y, 18);
  p_y = NULL;
  m = emlrtCreateDoubleScalar(u->PP_CF);
  emlrtAssign(&p_y, m);
  emlrtSetFieldR2017b(y, 0, "PP_CF", p_y, 19);
  q_y = NULL;
  m = emlrtCreateDoubleScalar(u->Batt_SOC);
  emlrtAssign(&q_y, m);
  emlrtSetFieldR2017b(y, 0, "Batt_SOC", q_y, 20);
  r_y = NULL;
  m = emlrtCreateDoubleScalar(u->zero_current_counter);
  emlrtAssign(&r_y, m);
  emlrtSetFieldR2017b(y, 0, "zero_current_counter", r_y, 21);
  emlrtSetFieldR2017b(y, 0, "TO_ET", b_emlrt_marshallOut(u->TO_ET), 22);
  emlrtSetFieldR2017b(y, 0, "TO_AB_MX", b_emlrt_marshallOut(u->TO_AB_MX), 23);
  emlrtSetFieldR2017b(y, 0, "TO_DR_MX", b_emlrt_marshallOut(u->TO_DR_MX), 24);
  emlrtSetFieldR2017b(y, 0, "TO_PT", b_emlrt_marshallOut(u->TO_PT), 25);
  s_y = NULL;
  m = emlrtCreateDoubleScalar(u->TC_highs);
  emlrtAssign(&s_y, m);
  emlrtSetFieldR2017b(y, 0, "TC_highs", s_y, 26);
  t_y = NULL;
  m = emlrtCreateDoubleScalar(u->TC_lows);
  emlrtAssign(&t_y, m);
  emlrtSetFieldR2017b(y, 0, "TC_lows", t_y, 27);
  u_y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv1[0], mxDOUBLE_CLASS, mxREAL);
  emlrtAssign(&u_y, m);
  emlrtSetFieldR2017b(y, 0, "VCU_mode", u_y, 28);
  v_y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv2[0], mxDOUBLE_CLASS, mxREAL);
  emlrtAssign(&v_y, m);
  emlrtSetFieldR2017b(y, 0, "VT_mode", v_y, 29);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[3]
 * Return Type  : void
 */
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[3])
{
  eb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[9]
 * Return Type  : void
 */
static void fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[9]
 * Return Type  : void
 */
static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[9])
{
  fb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[506]
 * Return Type  : void
 */
static void gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[506])
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[506]
 * Return Type  : void
 */
static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[506])
{
  gb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[506]
 * Return Type  : void
 */
static void hb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[506])
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[506]
 * Return Type  : void
 */
static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[506])
{
  hb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[150]
 * Return Type  : void
 */
static void ib_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[150])
{
  static const int32_T dims[2] = {1, 150};
  real_T(*r)[150];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[150])emlrtMxGetData(src);
  for (i = 0; i < 150; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                griddedInterpolant *y
 * Return Type  : void
 */
static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               griddedInterpolant *y)
{
  emlrtMsgIdentifier thisId;
  const mxArray *propValues[8];
  int32_T i;
  const char_T *propClasses[8] = {
      "coder.internal.griddedInterpolant", "coder.internal.griddedInterpolant",
      "coder.internal.griddedInterpolant", "coder.internal.griddedInterpolant",
      "coder.internal.griddedInterpolant", "coder.internal.griddedInterpolant",
      "coder.internal.griddedInterpolant", "coder.internal.griddedInterpolant"};
  const char_T *propNames[8] = {"gridVectors_",        "gridValues",
                                "validState",          "ppStruct1DInterp",
                                "ppStruct1DExtrap",    "interpToUseForCubic",
                                "extrapToUseForCubic", "splineCoefsND"};
  for (i = 0; i < 8; i++) {
    propValues[i] = NULL;
  }
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u, "griddedInterpolant");
  emlrtAssign(&u, emlrtConvertInstanceToRedirectTarget(
                      (emlrtCTX)sp, u, 0, "coder.internal.griddedInterpolant"));
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u,
                           "coder.internal.griddedInterpolant");
  emlrtGetAllProperties((emlrtCTX)sp, u, 0, 8, (const char_T **)&propNames[0],
                        (const char_T **)&propClasses[0], &propValues[0]);
  thisId.fIdentifier = "gridVectors_";
  k_emlrt_marshallIn(sp, emlrtAlias(propValues[0]), &thisId, &y->gridVectors_);
  thisId.fIdentifier = "gridValues";
  n_emlrt_marshallIn(sp, emlrtAlias(propValues[1]), &thisId, y->gridValues);
  thisId.fIdentifier = "validState";
  y->validState = o_emlrt_marshallIn(sp, emlrtAlias(propValues[2]), &thisId);
  thisId.fIdentifier = "ppStruct1DInterp";
  p_emlrt_marshallIn(sp, emlrtAlias(propValues[3]), &thisId);
  thisId.fIdentifier = "ppStruct1DExtrap";
  p_emlrt_marshallIn(sp, emlrtAlias(propValues[4]), &thisId);
  thisId.fIdentifier = "interpToUseForCubic";
  y->interpToUseForCubic =
      r_emlrt_marshallIn(sp, emlrtAlias(propValues[5]), &thisId);
  thisId.fIdentifier = "extrapToUseForCubic";
  y->extrapToUseForCubic =
      r_emlrt_marshallIn(sp, emlrtAlias(propValues[6]), &thisId);
  thisId.fIdentifier = "splineCoefsND";
  q_emlrt_marshallIn(sp, emlrtAlias(propValues[7]), &thisId);
  emlrtDestroyArrays(8, &propValues[0]);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[50]
 * Return Type  : void
 */
static void jb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[50])
{
  static const int32_T dims[2] = {1, 50};
  real_T(*r)[50];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[50])emlrtMxGetData(src);
  for (i = 0; i < 50; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                cell_0 *y
 * Return Type  : void
 */
static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, cell_0 *y)
{
  emlrtMsgIdentifier thisId;
  int32_T iv[2];
  boolean_T bv[2];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  bv[0] = false;
  iv[0] = 1;
  bv[1] = false;
  iv[1] = 2;
  emlrtCheckCell((emlrtCTX)sp, parentId, u, 2U, &iv[0], &bv[0]);
  thisId.fIdentifier = "1";
  l_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 0)),
                     &thisId, y->f1);
  thisId.fIdentifier = "2";
  m_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 1)),
                     &thisId, y->f2);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[7500]
 * Return Type  : void
 */
static void kb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[7500])
{
  static const int32_T dims[2] = {150, 50};
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[150]
 * Return Type  : void
 */
static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[150])
{
  ib_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : boolean_T
 */
static boolean_T lb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                     const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  boolean_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "logical", false, 0U,
                          (const void *)&dims);
  ret = *emlrtMxGetLogicals(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[50]
 * Return Type  : void
 */
static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[50])
{
  jb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : void
 */
static void mb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims[2] = {1, 0};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  emlrtMxGetData(src);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[7500]
 * Return Type  : void
 */
static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[7500])
{
  kb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : uint8_T
 */
static uint8_T nb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  uint8_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "uint8", false, 0U,
                          (const void *)&dims);
  ret = *(uint8_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : boolean_T
 */
static boolean_T o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  boolean_T y;
  y = lb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[51]
 * Return Type  : void
 */
static void ob_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : void
 */
static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[2] = {"breaks", "coefs"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 2,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "breaks";
  q_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 0, "breaks")),
      &thisId);
  thisId.fIdentifier = "coefs";
  q_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1, "coefs")),
      &thisId);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[53]
 * Return Type  : void
 */
static void pb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : void
 */
static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  mb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[2703]
 * Return Type  : void
 */
static void qb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : uint8_T
 */
static uint8_T r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId)
{
  uint8_T y;
  y = nb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret[10]
 * Return Type  : void
 */
static void rb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[51]
 * Return Type  : void
 */
static void s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[51])
{
  ob_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[53]
 * Return Type  : void
 */
static void t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[53])
{
  pb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y[2703]
 * Return Type  : void
 */
static void u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[2703])
{
  qb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *nullptr
 *                const char_T *identifier
 *                struct2_T *y
 * Return Type  : void
 */
static void v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, struct2_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  w_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                struct2_T *y
 * Return Type  : void
 */
static void w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, struct2_T *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[19] = {
      "TH_RAW", "ST_RAW", "VB_RAW", "WT_RAW", "WM_RAW", "GS_RAW", "AV_RAW",
      "IB_RAW", "MT_RAW", "CT_RAW", "IT_RAW", "MC_RAW", "IC_RAW", "BT_RAW",
      "AG_RAW", "TO_RAW", "DB_RAW", "PI_RAW", "PP_RAW"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 19,
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
  thisId.fIdentifier = "WT_RAW";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 3, "WT_RAW")),
      &thisId, y->WT_RAW);
  thisId.fIdentifier = "WM_RAW";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 4, "WM_RAW")),
      &thisId, y->WM_RAW);
  thisId.fIdentifier = "GS_RAW";
  y->GS_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 5, "GS_RAW")),
      &thisId);
  thisId.fIdentifier = "AV_RAW";
  f_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 6, "AV_RAW")),
      &thisId, y->AV_RAW);
  thisId.fIdentifier = "IB_RAW";
  y->IB_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 7, "IB_RAW")),
      &thisId);
  thisId.fIdentifier = "MT_RAW";
  y->MT_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 8, "MT_RAW")),
      &thisId);
  thisId.fIdentifier = "CT_RAW";
  y->CT_RAW = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 9, "CT_RAW")),
      &thisId);
  thisId.fIdentifier = "IT_RAW";
  y->IT_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 10, "IT_RAW")),
      &thisId);
  thisId.fIdentifier = "MC_RAW";
  y->MC_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 11, "MC_RAW")),
      &thisId);
  thisId.fIdentifier = "IC_RAW";
  y->IC_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 12, "IC_RAW")),
      &thisId);
  thisId.fIdentifier = "BT_RAW";
  y->BT_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 13, "BT_RAW")),
      &thisId);
  thisId.fIdentifier = "AG_RAW";
  f_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 14, "AG_RAW")),
      &thisId, y->AG_RAW);
  thisId.fIdentifier = "TO_RAW";
  d_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 15, "TO_RAW")),
      &thisId, y->TO_RAW);
  thisId.fIdentifier = "DB_RAW";
  y->DB_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 16, "DB_RAW")),
      &thisId);
  thisId.fIdentifier = "PI_RAW";
  y->PI_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 17, "PI_RAW")),
      &thisId);
  thisId.fIdentifier = "PP_RAW";
  y->PP_RAW = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 18, "PP_RAW")),
      &thisId);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *nullptr
 *                const char_T *identifier
 *                struct3_T *y
 * Return Type  : void
 */
static void x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, struct3_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                struct3_T *y
 * Return Type  : void
 */
static void y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, struct3_T *y)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[30] = {"IB_CF_vec", "TH_CF",
                                         "ST_CF",     "VB_CF",
                                         "WT_CF",     "WM_CF",
                                         "GS_CF",     "AV_CF",
                                         "IB_CF",     "MT_CF",
                                         "CT_CF",     "IT_CF",
                                         "MC_CF",     "IC_CF",
                                         "BT_CF",     "AG_CF",
                                         "TO_CF",     "DB_CF",
                                         "PI_CF",     "PP_CF",
                                         "Batt_SOC",  "zero_current_counter",
                                         "TO_ET",     "TO_AB_MX",
                                         "TO_DR_MX",  "TO_PT",
                                         "TC_highs",  "TC_lows",
                                         "VCU_mode",  "VT_mode"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 30,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "IB_CF_vec";
  ab_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 0, "IB_CF_vec")),
      &thisId, y->IB_CF_vec);
  thisId.fIdentifier = "TH_CF";
  y->TH_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1, "TH_CF")),
      &thisId);
  thisId.fIdentifier = "ST_CF";
  y->ST_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 2, "ST_CF")),
      &thisId);
  thisId.fIdentifier = "VB_CF";
  y->VB_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 3, "VB_CF")),
      &thisId);
  thisId.fIdentifier = "WT_CF";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 4, "WT_CF")),
      &thisId, y->WT_CF);
  thisId.fIdentifier = "WM_CF";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 5, "WM_CF")),
      &thisId, y->WM_CF);
  thisId.fIdentifier = "GS_CF";
  y->GS_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 6, "GS_CF")),
      &thisId);
  thisId.fIdentifier = "AV_CF";
  f_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 7, "AV_CF")),
      &thisId, y->AV_CF);
  thisId.fIdentifier = "IB_CF";
  y->IB_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 8, "IB_CF")),
      &thisId);
  thisId.fIdentifier = "MT_CF";
  y->MT_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 9, "MT_CF")),
      &thisId);
  thisId.fIdentifier = "CT_CF";
  y->CT_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 10, "CT_CF")),
      &thisId);
  thisId.fIdentifier = "IT_CF";
  y->IT_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 11, "IT_CF")),
      &thisId);
  thisId.fIdentifier = "MC_CF";
  y->MC_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 12, "MC_CF")),
      &thisId);
  thisId.fIdentifier = "IC_CF";
  y->IC_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 13, "IC_CF")),
      &thisId);
  thisId.fIdentifier = "BT_CF";
  y->BT_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 14, "BT_CF")),
      &thisId);
  thisId.fIdentifier = "AG_CF";
  f_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 15, "AG_CF")),
      &thisId, y->AG_CF);
  thisId.fIdentifier = "TO_CF";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 16, "TO_CF")),
      &thisId, y->TO_CF);
  thisId.fIdentifier = "DB_CF";
  y->DB_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 17, "DB_CF")),
      &thisId);
  thisId.fIdentifier = "PI_CF";
  y->PI_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 18, "PI_CF")),
      &thisId);
  thisId.fIdentifier = "PP_CF";
  y->PP_CF = c_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 19, "PP_CF")),
      &thisId);
  thisId.fIdentifier = "Batt_SOC";
  y->Batt_SOC = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 20, "Batt_SOC")),
      &thisId);
  thisId.fIdentifier = "zero_current_counter";
  y->zero_current_counter = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 21,
                                     "zero_current_counter")),
      &thisId);
  thisId.fIdentifier = "TO_ET";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 22, "TO_ET")),
      &thisId, y->TO_ET);
  thisId.fIdentifier = "TO_AB_MX";
  d_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 23, "TO_AB_MX")),
      &thisId, y->TO_AB_MX);
  thisId.fIdentifier = "TO_DR_MX";
  d_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 24, "TO_DR_MX")),
      &thisId, y->TO_DR_MX);
  thisId.fIdentifier = "TO_PT";
  d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 25, "TO_PT")),
      &thisId, y->TO_PT);
  thisId.fIdentifier = "TC_highs";
  y->TC_highs = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 26, "TC_highs")),
      &thisId);
  thisId.fIdentifier = "TC_lows";
  y->TC_lows = c_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 27, "TC_lows")),
      &thisId);
  thisId.fIdentifier = "VCU_mode";
  e_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 28, "VCU_mode")),
      &thisId);
  thisId.fIdentifier = "VT_mode";
  e_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 29, "VT_mode")),
      &thisId);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const mxArray * const prhs[3]
 *                const mxArray **plhs
 * Return Type  : void
 */
void get_y_cf_api(const mxArray *const prhs[3], const mxArray **plhs)
{
  static const int32_T iv[7] = {2, 3, 4, 3, 4, 5, 5};
  static const uint32_T uv[8] = {1623791239U, 672017963U,  399208792U,
                                 1837378609U, 1623791239U, 672017963U,
                                 399208792U,  1837378609U};
  static const char_T *sv[10] = {"torque_interpolant",
                                 "p.torque_interpolant",
                                 "coder.internal.griddedInterpolant",
                                 "interpMethodID",
                                 "p.torque_interpolant.interpMethodID",
                                 "p.torque_interpolant.interpMethodID",
                                 "coder.internal.griddedInterpolant",
                                 "extrapMethodID",
                                 "p.torque_interpolant.extrapMethodID",
                                 "p.torque_interpolant.extrapMethodID"};
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  struct0_T p;
  struct2_T x;
  struct3_T y;
  st.tls = emlrtRootTLSGlobal;
  /* Check constant function inputs */
  emlrtCheckArrayChecksumR2018b(&st, prhs[0], false, &iv[0],
                                (const char_T **)&sv[0], &uv[0]);
  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "p", &p);
  v_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "x", &x);
  x_emlrt_marshallIn(&st, emlrtAliasP(prhs[2]), "y", &y);
  /* Invoke the target function */
  get_y_cf(&p, &x, &y);
  /* Marshall function outputs */
  *plhs = emlrt_marshallOut(&y);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void get_y_cf_atexit(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtPushHeapReferenceStackR2021a(
      &st, false, NULL, (void *)&emlrtExitTimeCleanupDtorFcn, NULL, NULL, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  get_y_cf_xil_terminate();
  get_y_cf_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void get_y_cf_initialize(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void get_y_cf_terminate(void)
{
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/*
 * File trailer for _coder_get_y_cf_api.c
 *
 * [EOF]
 */
