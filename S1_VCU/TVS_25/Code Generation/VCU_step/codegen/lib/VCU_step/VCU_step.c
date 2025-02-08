#include "VCU_step.h"
#include "VCU_step_types.h"
#include <math.h>
#include <string.h>

static double interp1(const double varargin_1[2], const double varargin_2[2],
                      double varargin_3);

static double interp2(const double varargin_1[53], const double varargin_2[51],
                      const double varargin_3[2703], double varargin_4,
                      double varargin_5);

static double rt_roundd(double u);

static double interp1(const double varargin_1[2], const double varargin_2[2],
                      double varargin_3)
{
  double Vq;
  double x_idx_0;
  double x_idx_1;
  double y_idx_0;
  double y_idx_1;
  y_idx_0 = varargin_2[0];
  x_idx_0 = varargin_1[0];
  y_idx_1 = varargin_2[1];
  x_idx_1 = varargin_1[1];
  if (varargin_1[1] < varargin_1[0]) {
    x_idx_0 = varargin_1[1];
    x_idx_1 = varargin_1[0];
    y_idx_0 = varargin_2[1];
    y_idx_1 = varargin_2[0];
  }
  Vq = 0.0;
  if ((varargin_3 <= x_idx_1) && (varargin_3 >= x_idx_0)) {
    double r;
    r = (varargin_3 - x_idx_0) / (x_idx_1 - x_idx_0);
    if (r == 0.0) {
      Vq = y_idx_0;
    } else if (r == 1.0) {
      Vq = y_idx_1;
    } else if (y_idx_0 == y_idx_1) {
      Vq = y_idx_0;
    } else {
      Vq = (1.0 - r) * y_idx_0 + r * y_idx_1;
    }
  }
  return Vq;
}

static double interp2(const double varargin_1[53], const double varargin_2[51],
                      const double varargin_3[2703], double varargin_4,
                      double varargin_5)
{
  double Vq;
  if ((varargin_4 >= varargin_1[0]) && (varargin_4 <= varargin_1[52]) &&
      (varargin_5 >= varargin_2[0]) && (varargin_5 <= varargin_2[50])) {
    double d1;
    double qx1;
    double qx2;
    int b_high_i;
    int b_low_i;
    int b_low_ip1;
    int high_i;
    int low_i;
    int low_ip1;
    low_i = 0;
    low_ip1 = 2;
    high_i = 53;
    while (high_i > low_ip1) {
      int mid_i;
      mid_i = ((low_i + high_i) + 1) >> 1;
      if (varargin_4 >= varargin_1[mid_i - 1]) {
        low_i = mid_i - 1;
        low_ip1 = mid_i + 1;
      } else {
        high_i = mid_i;
      }
    }
    b_low_i = 1;
    b_low_ip1 = 2;
    b_high_i = 51;
    while (b_high_i > b_low_ip1) {
      int b_mid_i;
      b_mid_i = (b_low_i + b_high_i) >> 1;
      if (varargin_5 >= varargin_2[b_mid_i - 1]) {
        b_low_i = b_mid_i;
        b_low_ip1 = b_mid_i + 1;
      } else {
        b_high_i = b_mid_i;
      }
    }
    if (varargin_4 == varargin_1[low_i]) {
      int qx1_tmp;
      qx1_tmp = b_low_i + 51 * low_i;
      qx1 = varargin_3[qx1_tmp - 1];
      qx2 = varargin_3[qx1_tmp];
    } else {
      double d;
      d = varargin_1[low_i + 1];
      if (varargin_4 == d) {
        int b_qx1_tmp;
        b_qx1_tmp = b_low_i + 51 * (low_i + 1);
        qx1 = varargin_3[b_qx1_tmp - 1];
        qx2 = varargin_3[b_qx1_tmp];
      } else {
        double b_qx2_tmp;
        double c_qx1_tmp;
        double d_qx1_tmp;
        double qx2_tmp;
        double rx;
        int b_qx1_tmp_tmp;
        int qx1_tmp_tmp;
        rx = (varargin_4 - varargin_1[low_i]) / (d - varargin_1[low_i]);
        qx1_tmp_tmp = b_low_i + 51 * low_i;
        c_qx1_tmp = varargin_3[qx1_tmp_tmp - 1];
        b_qx1_tmp_tmp = b_low_i + 51 * (low_i + 1);
        d_qx1_tmp = varargin_3[b_qx1_tmp_tmp - 1];
        if (c_qx1_tmp == d_qx1_tmp) {
          qx1 = c_qx1_tmp;
        } else {
          qx1 = (1.0 - rx) * c_qx1_tmp + rx * d_qx1_tmp;
        }
        qx2_tmp = varargin_3[qx1_tmp_tmp];
        b_qx2_tmp = varargin_3[b_qx1_tmp_tmp];
        if (qx2_tmp == b_qx2_tmp) {
          qx2 = qx2_tmp;
        } else {
          qx2 = (1.0 - rx) * qx2_tmp + rx * b_qx2_tmp;
        }
      }
    }
    d1 = varargin_2[b_low_i - 1];
    if ((varargin_5 == d1) || (qx1 == qx2)) {
      Vq = qx1;
    } else if (varargin_5 == varargin_2[b_low_i]) {
      Vq = qx2;
    } else {
      double ry;
      ry = (varargin_5 - d1) / (varargin_2[b_low_i] - d1);
      Vq = (1.0 - ry) * qx1 + ry * qx2;
    }
  } else {
    Vq = 0.0;
  }
  return Vq;
}

static double rt_roundd(double u)
{
  double y;
  if (fabs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = floor(u + 0.5);
    } else if (u > -0.5) {
      y = 0.0;
    } else {
      y = ceil(u - 0.5);
    }
  } else {
    y = u;
  }
  return y;
}

void VCU_step(const struct0_T *p, const struct1_T *f, const struct2_T *x,
              struct3_T *y)
{
  double b_x[506];
  double c_y[506];
  double d_f[13];
  double e_p[13];
  double c_f[10];
  double d_p[10];
  double b_f[7];
  double c_p[7];
  double b_p[2];
  double dv[2];
  double b_y;
  double d;
  double d1;
  double d2;
  double d3;
  double d4;
  double d5;
  int b_j1;
  int b_k;
  int c_k;
  int d_k;
  int e_k;
  int f_k;
  int g_k;
  int i;
  int i1;
  int i2;
  int i3;
  int i4;
  int i5;
  int i6;
  int k;
  bool c_varargin_1[36];
  bool b_varargin_1[26];
  bool VT_sensors[23];
  bool b_VT_sensors[23];
  bool varargin_1[20];
  bool VS_sensors[16];
  bool b_VS_sensors[16];
  bool PT_sensors[13];
  bool b_PT_sensors[13];
  bool ET_permit_RAW;
  bool PT_permit_RAW;
  bool VS_permit_RAW;
  bool VT_permit_RAW;
  ET_permit_RAW = ((x->TH_RAW >= p->TH_lb) && (x->TH_RAW <= p->TH_ub));
  ET_permit_RAW = (((int)ET_permit_RAW <= (p->CS_SFLAG_True == f->CS_SFLAG)) &&
                   ET_permit_RAW);
  ET_permit_RAW = (((int)ET_permit_RAW <= (p->TB_SFLAG_True == f->TB_SFLAG)) &&
                   ET_permit_RAW);
  y->ET_permit_buffer[0] = y->ET_permit_buffer[1];
  y->ET_permit_buffer[1] = y->ET_permit_buffer[2];
  y->ET_permit_buffer[2] = y->ET_permit_buffer[3];
  y->ET_permit_buffer[3] = y->ET_permit_buffer[4];
  y->ET_permit_buffer[4] = ET_permit_RAW;
  PT_sensors[0] = (x->TH_RAW >= p->TH_lb);
  PT_sensors[1] = (x->VB_RAW >= p->VB_lb);
  PT_sensors[6] = (x->IB_RAW >= p->IB_lb);
  PT_sensors[7] = (x->MT_RAW >= p->MT_lb);
  PT_sensors[8] = (x->CT_RAW >= p->CT_lb);
  PT_sensors[9] = (x->IT_RAW >= p->IT_lb);
  PT_sensors[10] = (x->MC_RAW >= p->MC_lb);
  PT_sensors[11] = (x->IC_RAW >= p->IC_lb);
  PT_sensors[12] = (x->BT_RAW >= p->BT_lb);
  b_PT_sensors[0] = (x->TH_RAW <= p->TH_ub);
  b_PT_sensors[1] = (x->VB_RAW <= p->VB_ub);
  PT_sensors[2] = (x->WT_RAW[0] >= p->WT_lb[0]);
  PT_sensors[4] = (x->WM_RAW[0] >= p->WM_lb[0]);
  b_PT_sensors[2] = (x->WT_RAW[0] <= p->WT_ub[0]);
  b_PT_sensors[4] = (x->WM_RAW[0] <= p->WM_ub[0]);
  PT_sensors[3] = (x->WT_RAW[1] >= p->WT_lb[1]);
  PT_sensors[5] = (x->WM_RAW[1] >= p->WM_lb[1]);
  b_PT_sensors[3] = (x->WT_RAW[1] <= p->WT_ub[1]);
  b_PT_sensors[5] = (x->WM_RAW[1] <= p->WM_ub[1]);
  b_PT_sensors[6] = (x->IB_RAW <= p->IB_ub);
  b_PT_sensors[7] = (x->MT_RAW <= p->MT_ub);
  b_PT_sensors[8] = (x->CT_RAW <= p->CT_ub);
  b_PT_sensors[9] = (x->IT_RAW <= p->IT_ub);
  b_PT_sensors[10] = (x->MC_RAW <= p->MC_ub);
  b_PT_sensors[11] = (x->IC_RAW <= p->IC_ub);
  b_PT_sensors[12] = (x->BT_RAW <= p->BT_ub);
  c_p[0] = p->CS_SFLAG_True;
  c_p[1] = p->TB_SFLAG_True;
  c_p[2] = p->WT_SFLAG_True;
  c_p[3] = p->IV_SFLAG_True;
  c_p[4] = p->BT_SFLAG_True;
  c_p[5] = p->MT_SFLAG_True;
  c_p[6] = p->CO_SFLAG_True;
  b_f[0] = f->CS_SFLAG;
  b_f[1] = f->TB_SFLAG;
  b_f[2] = f->WT_SFLAG;
  b_f[3] = f->IV_SFLAG;
  b_f[4] = f->BT_SFLAG;
  b_f[5] = f->MT_SFLAG;
  b_f[6] = f->CO_SFLAG;
  for (i = 0; i < 13; i++) {
    varargin_1[i] = (PT_sensors[i] && b_PT_sensors[i]);
  }
  for (i1 = 0; i1 < 7; i1++) {
    varargin_1[i1 + 13] = (c_p[i1] == b_f[i1]);
  }
  PT_permit_RAW = varargin_1[0];
  for (k = 0; k < 19; k++) {
    PT_permit_RAW =
        (((int)PT_permit_RAW <= (int)varargin_1[k + 1]) && PT_permit_RAW);
  }
  y->PT_permit_buffer[0] = y->PT_permit_buffer[1];
  y->PT_permit_buffer[1] = y->PT_permit_buffer[2];
  y->PT_permit_buffer[2] = y->PT_permit_buffer[3];
  y->PT_permit_buffer[3] = y->PT_permit_buffer[4];
  y->PT_permit_buffer[4] = PT_permit_RAW;
  VS_sensors[0] = (x->TH_RAW >= p->TH_lb);
  VS_sensors[1] = (x->VB_RAW >= p->VB_lb);
  b_VS_sensors[0] = (x->TH_RAW <= p->TH_ub);
  b_VS_sensors[1] = (x->VB_RAW <= p->VB_ub);
  VS_sensors[2] = (x->WT_RAW[0] >= p->WT_lb[0]);
  VS_sensors[4] = (x->WM_RAW[0] >= p->WM_lb[0]);
  VS_sensors[14] = (x->TO_RAW[0] >= p->TO_lb[0]);
  b_VS_sensors[2] = (x->WT_RAW[0] <= p->WT_ub[0]);
  b_VS_sensors[4] = (x->WM_RAW[0] <= p->WM_ub[0]);
  b_VS_sensors[14] = (x->TO_RAW[0] <= p->TO_ub[0]);
  VS_sensors[3] = (x->WT_RAW[1] >= p->WT_lb[1]);
  VS_sensors[5] = (x->WM_RAW[1] >= p->WM_lb[1]);
  VS_sensors[15] = (x->TO_RAW[1] >= p->TO_lb[1]);
  b_VS_sensors[3] = (x->WT_RAW[1] <= p->WT_ub[1]);
  b_VS_sensors[5] = (x->WM_RAW[1] <= p->WM_ub[1]);
  b_VS_sensors[15] = (x->TO_RAW[1] <= p->TO_ub[1]);
  VS_sensors[6] = (x->GS_RAW >= p->GS_lb);
  VS_sensors[7] = (x->IB_RAW >= p->IB_lb);
  VS_sensors[8] = (x->MT_RAW >= p->MT_lb);
  VS_sensors[9] = (x->CT_RAW >= p->CT_lb);
  VS_sensors[10] = (x->IT_RAW >= p->IT_lb);
  VS_sensors[11] = (x->MC_RAW >= p->MC_lb);
  VS_sensors[12] = (x->IC_RAW >= p->IC_lb);
  VS_sensors[13] = (x->BT_RAW >= p->BT_lb);
  b_VS_sensors[6] = (x->GS_RAW <= p->GS_ub);
  b_VS_sensors[7] = (x->IB_RAW <= p->IB_ub);
  b_VS_sensors[8] = (x->MT_RAW <= p->MT_ub);
  b_VS_sensors[9] = (x->CT_RAW <= p->CT_ub);
  b_VS_sensors[10] = (x->IT_RAW <= p->IT_ub);
  b_VS_sensors[11] = (x->MC_RAW <= p->MC_ub);
  b_VS_sensors[12] = (x->IC_RAW <= p->IC_ub);
  b_VS_sensors[13] = (x->BT_RAW <= p->BT_ub);
  d_p[0] = p->CS_SFLAG_True;
  d_p[1] = p->TB_SFLAG_True;
  d_p[2] = p->WT_SFLAG_True;
  d_p[3] = p->IV_SFLAG_True;
  d_p[4] = p->BT_SFLAG_True;
  d_p[5] = p->MT_SFLAG_True;
  d_p[6] = p->CO_SFLAG_True;
  d_p[7] = p->MO_SFLAG_True;
  d_p[8] = p->GS_FFLAG_True;
  d_p[9] = p->VCU_PFLAG_VS;
  c_f[0] = f->CS_SFLAG;
  c_f[1] = f->TB_SFLAG;
  c_f[2] = f->WT_SFLAG;
  c_f[3] = f->IV_SFLAG;
  c_f[4] = f->BT_SFLAG;
  c_f[5] = f->MT_SFLAG;
  c_f[6] = f->CO_SFLAG;
  c_f[7] = f->MO_SFLAG;
  c_f[8] = f->GS_FFLAG;
  c_f[9] = f->VCU_PFLAG;
  for (i2 = 0; i2 < 16; i2++) {
    b_varargin_1[i2] = (VS_sensors[i2] && b_VS_sensors[i2]);
  }
  for (i3 = 0; i3 < 10; i3++) {
    b_varargin_1[i3 + 16] = (d_p[i3] == c_f[i3]);
  }
  VS_permit_RAW = b_varargin_1[0];
  for (b_k = 0; b_k < 25; b_k++) {
    VS_permit_RAW =
        (((int)VS_permit_RAW <= (int)b_varargin_1[b_k + 1]) && VS_permit_RAW);
  }
  y->VS_permit_buffer[0] = y->VS_permit_buffer[1];
  y->VS_permit_buffer[1] = y->VS_permit_buffer[2];
  y->VS_permit_buffer[2] = y->VS_permit_buffer[3];
  y->VS_permit_buffer[3] = y->VS_permit_buffer[4];
  y->VS_permit_buffer[4] = VS_permit_RAW;
  VT_sensors[0] = (x->TH_RAW >= p->TH_lb);
  VT_sensors[1] = (x->ST_RAW >= p->ST_lb);
  VT_sensors[2] = (x->VB_RAW >= p->VB_lb);
  VT_sensors[3] = (x->WT_RAW[0] >= p->WT_lb[0]);
  VT_sensors[5] = (x->WM_RAW[0] >= p->WM_lb[0]);
  VT_sensors[4] = (x->WT_RAW[1] >= p->WT_lb[1]);
  VT_sensors[6] = (x->WM_RAW[1] >= p->WM_lb[1]);
  VT_sensors[7] = (x->GS_RAW >= p->GS_lb);
  VT_sensors[8] = (x->AV_RAW[0] >= p->AV_lb[0]);
  VT_sensors[9] = (x->AV_RAW[1] >= p->AV_lb[1]);
  VT_sensors[10] = (x->AV_RAW[2] >= p->AV_lb[2]);
  VT_sensors[11] = (x->IB_RAW >= p->IB_lb);
  VT_sensors[12] = (x->MT_RAW >= p->MT_lb);
  VT_sensors[13] = (x->CT_RAW >= p->CT_lb);
  VT_sensors[14] = (x->IT_RAW >= p->IT_lb);
  VT_sensors[15] = (x->MC_RAW >= p->MC_lb);
  VT_sensors[16] = (x->IC_RAW >= p->IC_lb);
  VT_sensors[17] = (x->BT_RAW >= p->BT_lb);
  VT_sensors[20] = (x->DB_RAW >= p->DB_lb);
  VT_sensors[21] = (x->PI_RAW >= p->PI_lb);
  VT_sensors[22] = (x->PP_RAW >= p->PP_lb);
  b_VT_sensors[0] = (x->TH_RAW <= p->TH_ub);
  b_VT_sensors[1] = (x->ST_RAW <= p->ST_ub);
  b_VT_sensors[2] = (x->VB_RAW <= p->VB_ub);
  VT_sensors[18] = (x->TO_RAW[0] >= p->TO_lb[0]);
  b_VT_sensors[3] = (x->WT_RAW[0] <= p->WT_ub[0]);
  b_VT_sensors[5] = (x->WM_RAW[0] <= p->WM_ub[0]);
  VT_sensors[19] = (x->TO_RAW[1] >= p->TO_lb[1]);
  b_VT_sensors[4] = (x->WT_RAW[1] <= p->WT_ub[1]);
  b_VT_sensors[6] = (x->WM_RAW[1] <= p->WM_ub[1]);
  b_VT_sensors[7] = (x->GS_RAW <= p->GS_ub);
  b_VT_sensors[8] = (x->AV_RAW[0] <= p->AV_ub[0]);
  b_VT_sensors[9] = (x->AV_RAW[1] <= p->AV_ub[1]);
  b_VT_sensors[10] = (x->AV_RAW[2] <= p->AV_ub[2]);
  b_VT_sensors[11] = (x->IB_RAW <= p->IB_ub);
  b_VT_sensors[12] = (x->MT_RAW <= p->MT_ub);
  b_VT_sensors[13] = (x->CT_RAW <= p->CT_ub);
  b_VT_sensors[14] = (x->IT_RAW <= p->IT_ub);
  b_VT_sensors[15] = (x->MC_RAW <= p->MC_ub);
  b_VT_sensors[16] = (x->IC_RAW <= p->IC_ub);
  b_VT_sensors[17] = (x->BT_RAW <= p->BT_ub);
  b_VT_sensors[18] = (x->TO_RAW[0] <= p->TO_ub[0]);
  b_VT_sensors[19] = (x->TO_RAW[1] <= p->TO_ub[1]);
  b_VT_sensors[20] = (x->DB_RAW <= p->DB_ub);
  b_VT_sensors[21] = (x->PI_RAW <= p->PI_ub);
  b_VT_sensors[22] = (x->PP_RAW <= p->PP_ub);
  e_p[0] = p->CS_SFLAG_True;
  e_p[1] = p->TB_SFLAG_True;
  e_p[2] = p->SS_SFLAG_True;
  e_p[3] = p->WT_SFLAG_True;
  e_p[4] = p->IV_SFLAG_True;
  e_p[5] = p->BT_SFLAG_True;
  e_p[6] = p->MT_SFLAG_True;
  e_p[7] = p->CO_SFLAG_True;
  e_p[8] = p->MO_SFLAG_True;
  e_p[9] = p->SS_FFLAG_True;
  e_p[10] = p->AV_FFLAG_True;
  e_p[11] = p->GS_FFLAG_True;
  e_p[12] = p->VCU_PFLAG_VT;
  d_f[0] = f->CS_SFLAG;
  d_f[1] = f->TB_SFLAG;
  d_f[2] = f->SS_SFLAG;
  d_f[3] = f->WT_SFLAG;
  d_f[4] = f->IV_SFLAG;
  d_f[5] = f->BT_SFLAG;
  d_f[6] = f->MT_SFLAG;
  d_f[7] = f->CO_SFLAG;
  d_f[8] = f->MO_SFLAG;
  d_f[9] = f->SS_FFLAG;
  d_f[10] = f->AV_FFLAG;
  d_f[11] = f->GS_FFLAG;
  d_f[12] = f->VCU_PFLAG;
  for (i4 = 0; i4 < 23; i4++) {
    c_varargin_1[i4] = (VT_sensors[i4] && b_VT_sensors[i4]);
  }
  for (i5 = 0; i5 < 13; i5++) {
    c_varargin_1[i5 + 23] = (e_p[i5] == d_f[i5]);
  }
  VT_permit_RAW = c_varargin_1[0];
  for (c_k = 0; c_k < 35; c_k++) {
    VT_permit_RAW =
        (((int)VT_permit_RAW <= (int)c_varargin_1[c_k + 1]) && VT_permit_RAW);
  }
  y->VT_permit_buffer[0] = y->VT_permit_buffer[1];
  y->VT_permit_buffer[1] = y->VT_permit_buffer[2];
  y->VT_permit_buffer[2] = y->VT_permit_buffer[3];
  y->VT_permit_buffer[3] = y->VT_permit_buffer[4];
  y->VT_permit_buffer[4] = VT_permit_RAW;
  if (rt_roundd(((((y->VT_permit_buffer[0] + y->VT_permit_buffer[1]) +
                   y->VT_permit_buffer[2]) +
                  y->VT_permit_buffer[3]) +
                 y->VT_permit_buffer[4]) /
                5.0) != 0.0) {
    y->VCU_mode = 4.0;
  } else if (rt_roundd(((((y->VS_permit_buffer[0] + y->VS_permit_buffer[1]) +
                          y->VS_permit_buffer[2]) +
                         y->VS_permit_buffer[3]) +
                        y->VS_permit_buffer[4]) /
                       5.0) != 0.0) {
    y->VCU_mode = 3.0;
  } else if (rt_roundd(((((y->PT_permit_buffer[0] + y->PT_permit_buffer[1]) +
                          y->PT_permit_buffer[2]) +
                         y->PT_permit_buffer[3]) +
                        y->PT_permit_buffer[4]) /
                       5.0) != 0.0) {
    y->VCU_mode = 2.0;
  } else {
    y->VCU_mode =
        (rt_roundd(((((y->ET_permit_buffer[0] + y->ET_permit_buffer[1]) +
                      y->ET_permit_buffer[2]) +
                     y->ET_permit_buffer[3]) +
                    y->ET_permit_buffer[4]) /
                   5.0) != 0.0);
  }
  y->TH_CF = fmax(fmin(x->TH_RAW, p->TH_ub), p->TH_lb);
  y->ST_CF = fmax(fmin(x->ST_RAW, p->ST_ub), p->ST_lb);
  y->VB_CF = fmax(fmin(x->VB_RAW, p->VB_ub), p->VB_lb);
  y->WT_CF[0] = fmax(fmin(x->WT_RAW[0], p->WT_ub[0]), p->WT_lb[0]);
  y->WT_CF[1] = fmax(fmin(x->WT_RAW[1], p->WT_ub[1]), p->WT_lb[1]);
  y->GS_CF = fmax(fmin(x->GS_RAW, p->GS_ub), p->GS_lb);
  d = x->AV_RAW[0];
  d1 = x->AV_RAW[1];
  d2 = x->AV_RAW[2];
  for (d_k = 0; d_k < 3; d_k++) {
    y->AV_CF[d_k] =
        fmax(fmin((p->R[d_k] * d + p->R[d_k + 3] * d1) + p->R[d_k + 6] * d2,
                  p->AV_ub[d_k]),
             p->AV_lb[d_k]);
  }
  for (i6 = 0; i6 < 9; i6++) {
    y->IB_CF_buffer[i6] = y->IB_CF_buffer[i6 + 1];
  }
  y->IB_CF_buffer[9] = fmax(fmin(x->IB_RAW, p->IB_ub), p->IB_lb);
  b_y = y->IB_CF_buffer[0];
  for (e_k = 0; e_k < 9; e_k++) {
    b_y += y->IB_CF_buffer[e_k + 1];
  }
  y->IB_CF = b_y / 10.0;
  y->MT_CF = fmax(fmin(x->MT_RAW, p->MT_ub), p->MT_lb);
  y->CT_CF = fmax(fmin(x->CT_RAW, p->CT_ub), p->CT_lb);
  y->IT_CF = fmax(fmin(x->IT_RAW, p->IT_ub), p->IT_lb);
  y->MC_CF = fmax(fmin(x->MC_RAW, p->MC_ub), p->MC_lb);
  y->IC_CF = fmax(fmin(x->IC_RAW, p->IC_ub), p->IC_lb);
  y->BT_CF = fmax(fmin(x->BT_RAW, p->BT_ub), p->BT_lb);
  d3 = x->AG_RAW[0];
  d4 = x->AG_RAW[1];
  d5 = x->AG_RAW[2];
  for (f_k = 0; f_k < 3; f_k++) {
    y->AG_CF[f_k] =
        fmax(fmin((p->R[f_k] * d3 + p->R[f_k + 3] * d4) + p->R[f_k + 6] * d5,
                  p->AG_ub[f_k]),
             p->AG_lb[f_k]);
  }
  y->TO_CF[0] = fmax(fmin(x->TO_RAW[0], p->TO_ub[0]), p->TO_lb[0]);
  y->TO_CF[1] = fmax(fmin(x->TO_RAW[1], p->TO_ub[1]), p->TO_lb[1]);
  y->DB_CF = fmax(fmin(x->DB_RAW, p->DB_ub), p->DB_lb);
  y->PI_CF = fmax(fmin(x->PI_RAW, p->PI_ub), p->PI_lb);
  y->PP_CF = fmax(fmin(x->PP_RAW, p->PP_ub), p->PP_lb);
  y->zero_current_counter =
      (y->zero_current_counter + 1.0) * (double)(y->IB_CF == 0.0);
  if (y->zero_current_counter >= p->zero_currents_to_update_SOC) {
    double Vq;
    double varargin_3;
    memcpy(&b_x[0], &p->Batt_Voc_brk[0], 506U * sizeof(double));
    memcpy(&c_y[0], &p->Batt_As_Discharged_tbl[0], 506U * sizeof(double));
    varargin_3 = y->VB_CF / p->Ns;
    if (p->Batt_Voc_brk[1] < p->Batt_Voc_brk[0]) {
      for (b_j1 = 0; b_j1 < 253; b_j1++) {
        double b_xtmp;
        double xtmp;
        xtmp = b_x[b_j1];
        b_x[b_j1] = b_x[505 - b_j1];
        b_x[505 - b_j1] = xtmp;
        b_xtmp = c_y[b_j1];
        c_y[b_j1] = c_y[505 - b_j1];
        c_y[505 - b_j1] = b_xtmp;
      }
    }
    Vq = 0.0;
    if ((varargin_3 <= b_x[505]) && (varargin_3 >= b_x[0])) {
      double r;
      int high_i;
      int low_i;
      int low_ip1;
      low_i = 1;
      low_ip1 = 2;
      high_i = 506;
      while (high_i > low_ip1) {
        int mid_i;
        mid_i = (low_i + high_i) >> 1;
        if (varargin_3 >= b_x[mid_i - 1]) {
          low_i = mid_i;
          low_ip1 = mid_i + 1;
        } else {
          high_i = mid_i;
        }
      }
      double r_tmp;
      r_tmp = b_x[low_i - 1];
      r = (varargin_3 - r_tmp) / (b_x[low_i] - r_tmp);
      if (r == 0.0) {
        Vq = c_y[low_i - 1];
      } else if (r == 1.0) {
        Vq = c_y[low_i];
      } else {
        double Vq_tmp;
        Vq_tmp = c_y[low_i - 1];
        if (Vq_tmp == c_y[low_i]) {
          Vq = Vq_tmp;
        } else {
          Vq = (1.0 - r) * Vq_tmp + r * c_y[low_i];
        }
      }
    }
    b_p[0] = p->Batt_cell_zero_SOC_capacity;
    b_p[1] = p->Batt_cell_full_SOC_capacity;
    dv[0] = 0.0;
    dv[1] = 1.0;
    y->Batt_SOC = fmax(fmin(interp1(b_p, dv, Vq), 1.0), 0.0);
  }
  if (y->VCU_mode >= 1.0) {
    y->TO_ET[0] = y->TH_CF * p->MAX_TORQUE_NOM;
    y->TO_ET[1] = y->TH_CF * p->MAX_TORQUE_NOM;
  }
  if (y->VCU_mode >= 2.0) {
    double d_varargin_1[8];
    double dv1[2];
    double dv2[2];
    double dv3[2];
    double dv4[2];
    double dv5[2];
    double dv6[2];
    double dv7[2];
    double f_p[2];
    double g_p[2];
    double h_p[2];
    double i_p[2];
    double j_p[2];
    double k_p[2];
    double l_p[2];
    double b_Vq;
    double d6;
    double ex;
    double varargin_1_idx_0;
    double varargin_1_idx_1;
    double varargin_4;
    double varargin_5;
    varargin_1_idx_0 = y->WT_CF[0] * p->gr;
    varargin_1_idx_1 = y->WT_CF[1] * p->gr;
    if (varargin_1_idx_0 < varargin_1_idx_1) {
      d6 = varargin_1_idx_1;
    } else {
      d6 = varargin_1_idx_0;
    }
    varargin_4 = fmax(fmin(d6, p->PT_WM_ub), p->PT_WM_lb);
    varargin_5 = fmax(fmin(y->VB_CF, p->PT_VB_ub), p->PT_VB_lb);
    if ((varargin_4 >= p->PT_WM_brkpt[0]) &&
        (varargin_4 <= p->PT_WM_brkpt[149]) &&
        (varargin_5 >= p->PT_VB_brkpt[0]) &&
        (varargin_5 <= p->PT_VB_brkpt[49])) {
      double d10;
      double qx1;
      double qx2;
      int b_high_i;
      int b_low_i;
      int b_low_ip1;
      int c_high_i;
      int c_low_i;
      int c_low_ip1;
      b_low_i = 0;
      b_low_ip1 = 2;
      b_high_i = 150;
      while (b_high_i > b_low_ip1) {
        int b_mid_i;
        b_mid_i = ((b_low_i + b_high_i) + 1) >> 1;
        if (varargin_4 >= p->PT_WM_brkpt[b_mid_i - 1]) {
          b_low_i = b_mid_i - 1;
          b_low_ip1 = b_mid_i + 1;
        } else {
          b_high_i = b_mid_i;
        }
      }
      c_low_i = 1;
      c_low_ip1 = 2;
      c_high_i = 50;
      while (c_high_i > c_low_ip1) {
        int c_mid_i;
        c_mid_i = (c_low_i + c_high_i) >> 1;
        if (varargin_5 >= p->PT_VB_brkpt[c_mid_i - 1]) {
          c_low_i = c_mid_i;
          c_low_ip1 = c_mid_i + 1;
        } else {
          c_high_i = c_mid_i;
        }
      }
      if (varargin_4 == p->PT_WM_brkpt[b_low_i]) {
        int qx1_tmp;
        qx1_tmp = c_low_i + 50 * b_low_i;
        qx1 = p->PT_TO_table[qx1_tmp - 1];
        qx2 = p->PT_TO_table[qx1_tmp];
      } else {
        double d9;
        d9 = p->PT_WM_brkpt[b_low_i + 1];
        if (varargin_4 == d9) {
          int b_qx1_tmp;
          b_qx1_tmp = c_low_i + 50 * (b_low_i + 1);
          qx1 = p->PT_TO_table[b_qx1_tmp - 1];
          qx2 = p->PT_TO_table[b_qx1_tmp];
        } else {
          double b_qx2_tmp;
          double c_qx1_tmp;
          double d_qx1_tmp;
          double qx2_tmp;
          double rx;
          int b_qx1_tmp_tmp;
          int qx1_tmp_tmp;
          rx = (varargin_4 - p->PT_WM_brkpt[b_low_i]) /
               (d9 - p->PT_WM_brkpt[b_low_i]);
          qx1_tmp_tmp = c_low_i + 50 * b_low_i;
          c_qx1_tmp = p->PT_TO_table[qx1_tmp_tmp - 1];
          b_qx1_tmp_tmp = c_low_i + 50 * (b_low_i + 1);
          d_qx1_tmp = p->PT_TO_table[b_qx1_tmp_tmp - 1];
          if (c_qx1_tmp == d_qx1_tmp) {
            qx1 = c_qx1_tmp;
          } else {
            qx1 = (1.0 - rx) * c_qx1_tmp + rx * d_qx1_tmp;
          }
          qx2_tmp = p->PT_TO_table[qx1_tmp_tmp];
          b_qx2_tmp = p->PT_TO_table[b_qx1_tmp_tmp];
          if (qx2_tmp == b_qx2_tmp) {
            qx2 = qx2_tmp;
          } else {
            qx2 = (1.0 - rx) * qx2_tmp + rx * b_qx2_tmp;
          }
        }
      }
      d10 = p->PT_VB_brkpt[c_low_i - 1];
      if ((varargin_5 == d10) || (qx1 == qx2)) {
        b_Vq = qx1;
      } else if (varargin_5 == p->PT_VB_brkpt[c_low_i]) {
        b_Vq = qx2;
      } else {
        double ry;
        ry = (varargin_5 - d10) / (p->PT_VB_brkpt[c_low_i] - d10);
        b_Vq = (1.0 - ry) * qx1 + ry * qx2;
      }
    } else {
      b_Vq = 0.0;
    }
    y->TO_AB_MX = fmax(fmin(b_Vq, p->MAX_TORQUE_NOM), 0.0);
    b_p[0] = p->mT_derating_full_T;
    b_p[1] = p->mT_derating_zero_T;
    f_p[0] = p->cT_derating_full_T;
    f_p[1] = p->cT_derating_zero_T;
    g_p[0] = p->iT_derating_full_T;
    g_p[1] = p->iT_derating_zero_T;
    h_p[0] = p->Cm_derating_full_T;
    h_p[1] = p->Cm_derating_zero_T;
    i_p[0] = p->Ci_derating_full_T;
    i_p[1] = p->Ci_derating_zero_T;
    j_p[0] = p->bT_derating_full_T;
    j_p[1] = p->bT_derating_zero_T;
    k_p[0] = p->bI_derating_full_T;
    k_p[1] = p->bI_derating_zero_T;
    l_p[0] = p->Vb_derating_full_T;
    l_p[1] = p->Vb_derating_zero_T;
    dv[0] = 1.0;
    dv1[0] = 1.0;
    dv2[0] = 1.0;
    dv3[0] = 1.0;
    dv4[0] = 1.0;
    dv5[0] = 1.0;
    dv6[0] = 1.0;
    dv7[0] = 1.0;
    dv[1] = 0.0;
    dv1[1] = 0.0;
    dv2[1] = 0.0;
    dv3[1] = 0.0;
    dv4[1] = 0.0;
    dv5[1] = 0.0;
    dv6[1] = 0.0;
    dv7[1] = 0.0;
    d_varargin_1[0] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(b_p, dv, y->MT_CF), 1.0), 0.0);
    d_varargin_1[1] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(f_p, dv1, y->CT_CF), 1.0), 0.0);
    d_varargin_1[2] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(g_p, dv2, y->IT_CF), 1.0), 0.0);
    d_varargin_1[3] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(h_p, dv3, y->MC_CF), 1.0), 0.0);
    d_varargin_1[4] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(i_p, dv4, y->IC_CF), 1.0), 0.0);
    d_varargin_1[5] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(j_p, dv5, y->BT_CF), 1.0), 0.0);
    d_varargin_1[6] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(k_p, dv6, y->IB_CF), 1.0), 0.0);
    d_varargin_1[7] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(l_p, dv7, y->VB_CF), 1.0), 0.0);
    ex = d_varargin_1[0];
    for (g_k = 0; g_k < 7; g_k++) {
      double d11;
      d11 = d_varargin_1[g_k + 1];
      if (ex > d11) {
        ex = d11;
      }
    }
    double a;
    y->TO_DR_MX = ex;
    a = fmin(y->TO_AB_MX * y->TH_CF, ex);
    y->TO_PT[0] = a;
    y->TO_PT[1] = a;
  }
  if (y->VCU_mode == 3.0) {
    y->WM_VS[0] = 1.0;
    y->WM_VS[1] = 1.0;
  }
  if (y->VCU_mode == 4.0) {
    double d7;
    double d8;
    d7 = fabs(y->ST_CF);
    d8 = y->DB_CF + p->dST_DB;
    if (d7 < d8) {
      y->VT_mode = 2.0;
    } else if (d7 > d8) {
      y->VT_mode = 1.0;
    }
    if (y->VT_mode == 1.0) {
      y->sl =
          (y->WT_CF[0] + y->WT_CF[1]) / 2.0 * p->r / (y->GS_CF + p->TC_eps) -
          1.0;
      if (y->sl >= p->TC_sl_threshold) {
        y->TC_highs++;
        y->TC_lows = 0.0;
      } else if (y->sl < p->TC_sl_threshold) {
        y->TC_lows++;
        y->TC_highs = 0.0;
      } else {
        y->TC_lows = 0.0;
        y->TC_highs = 0.0;
      }
      if (y->TC_highs >= p->TC_highs_to_engage) {
        y->TO_VT[0] = y->TO_PT[0] * p->TC_throttle_mult;
        y->TO_VT[1] = y->TO_PT[1] * p->TC_throttle_mult;
      } else if (y->TC_lows >= p->TC_lows_to_disengage) {
        y->TO_VT[0] = y->TO_PT[0];
        y->TO_VT[1] = y->TO_PT[1];
      }
    } else if (y->VT_mode == 2.0) {
      y->TV_AV_ref = interp2(p->TV_ST_brkpt, p->TV_GS_brkpt, p->TV_AV_table,
                             fmax(fmin(y->ST_CF, p->TV_ST_ub), p->TV_ST_lb),
                             fmax(fmin(y->GS_CF, p->TV_GS_ub), p->TV_GS_lb));
      y->TV_delta_torque = fmax(
          fmin((y->TV_AV_ref * y->PI_CF - y->AV_CF[2]) * y->PP_CF * p->ht[1],
               y->TO_PT[0] * p->r_power_sat),
          -y->TO_PT[0] * p->r_power_sat);
      if (y->TV_delta_torque > 0.0) {
        y->TO_VT[0] = y->TO_PT[0];
        y->TO_VT[1] = y->TO_PT[0] - y->TV_delta_torque;
      } else {
        y->TO_VT[0] = y->TO_PT[0] + y->TV_delta_torque;
        y->TO_VT[1] = y->TO_PT[0];
      }
    }
  }
}
