#include "VCU_step.h"
#include "VCU_step_types.h"
#include <math.h>
#include <string.h>

static double interp1(const double varargin_1[2], const double varargin_2[2],
                      double varargin_3);

static double interp1(const double varargin_1[2], const double varargin_2[2],
                      double varargin_3)
{
  double Vq;
  double r;
  double x_idx_1;
  double y_idx_0;
  double y_idx_1;
  y_idx_0 = varargin_2[0];
  r = varargin_1[0];
  y_idx_1 = varargin_2[1];
  x_idx_1 = varargin_1[1];
  if (varargin_1[1] < varargin_1[0]) {
    r = varargin_1[1];
    x_idx_1 = varargin_1[0];
    y_idx_0 = varargin_2[1];
    y_idx_1 = varargin_2[0];
  }
  Vq = 0.0;
  if ((varargin_3 <= x_idx_1) && (varargin_3 >= r)) {
    r = (varargin_3 - r) / (x_idx_1 - r);
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

void VCU_step(const struct0_T *p, const struct1_T *f, const struct2_T *x,
              struct3_T *y)
{
  double varargin_1[506];
  double varargin_2[506];
  double dv[2];
  double minval[2];
  double Yqk;
  double qx1;
  double qx2;
  double rx;
  double xtmp;
  int b_low_i;
  int high_i;
  int low_i;
  int low_ip1;
  int mid_i;
  (void)f;
  y->TH_CF = fmax(fmin(x->TH_RAW, p->TH_ub), p->TH_lb);
  y->ST_CF = fmax(fmin(x->ST_RAW, p->ST_ub), p->ST_lb);
  y->VB_CF = fmax(fmin(x->VB_RAW, p->VB_ub), p->VB_lb);
  y->WT_CF[0] = fmax(fmin(x->WT_RAW[0], p->WT_ub[0]), p->WT_lb[0]);
  y->WT_CF[1] = fmax(fmin(x->WT_RAW[1], p->WT_ub[1]), p->WT_lb[1]);
  y->GS_CF = fmax(fmin(x->GS_RAW, p->GS_ub), p->GS_lb);
  rx = x->AV_RAW[0];
  xtmp = x->AV_RAW[1];
  qx2 = x->AV_RAW[2];
  for (low_ip1 = 0; low_ip1 < 3; low_ip1++) {
    y->AV_CF[low_ip1] =
        fmax(fmin((p->R[low_ip1] * rx + p->R[low_ip1 + 3] * xtmp) +
                      p->R[low_ip1 + 6] * qx2,
                  p->AV_ub[low_ip1]),
             p->AV_lb[low_ip1]);
  }
  for (low_ip1 = 0; low_ip1 < 9; low_ip1++) {
    y->IB_CF_vec[low_ip1] = y->IB_CF_vec[low_ip1 + 1];
  }
  y->IB_CF_vec[9] = fmax(fmin(x->IB_RAW, p->IB_ub), p->IB_lb);
  xtmp = y->IB_CF_vec[0];
  for (low_ip1 = 0; low_ip1 < 9; low_ip1++) {
    xtmp += y->IB_CF_vec[low_ip1 + 1];
  }
  y->IB_CF = xtmp / 10.0;
  y->MT_CF = fmax(fmin(x->MT_RAW, p->MT_ub), p->MT_lb);
  y->CT_CF = fmax(fmin(x->CT_RAW, p->CT_ub), p->CT_lb);
  y->IT_CF = fmax(fmin(x->IT_RAW, p->IT_ub), p->IT_lb);
  y->MC_CF = fmax(fmin(x->MC_RAW, p->MC_ub), p->MC_lb);
  y->IC_CF = fmax(fmin(x->IC_RAW, p->IC_ub), p->IC_lb);
  y->BT_CF = fmax(fmin(x->BT_RAW, p->BT_ub), p->BT_lb);
  rx = x->AG_RAW[0];
  xtmp = x->AG_RAW[1];
  qx2 = x->AG_RAW[2];
  for (low_ip1 = 0; low_ip1 < 3; low_ip1++) {
    y->AG_CF[low_ip1] =
        fmax(fmin((p->R[low_ip1] * rx + p->R[low_ip1 + 3] * xtmp) +
                      p->R[low_ip1 + 6] * qx2,
                  p->AG_ub[low_ip1]),
             p->AG_lb[low_ip1]);
  }
  y->TO_CF[0] = fmax(fmin(x->TO_RAW[0], p->TO_ub[0]), p->TO_lb[0]);
  y->TO_CF[1] = fmax(fmin(x->TO_RAW[1], p->TO_ub[1]), p->TO_lb[1]);
  y->DB_CF = fmax(fmin(x->DB_RAW, p->DB_ub), p->DB_lb);
  y->PI_CF = fmax(fmin(x->PI_RAW, p->PI_ub), p->PI_lb);
  y->PP_CF = fmax(fmin(x->PP_RAW, p->PP_ub), p->PP_lb);
  y->zero_current_counter =
      (y->zero_current_counter + 1.0) * (double)(y->IB_CF == 0.0);
  if (y->zero_current_counter >= p->zero_currents_to_update_SOC) {
    memcpy(&varargin_1[0], &p->Batt_Voc_brk[0], 506U * sizeof(double));
    memcpy(&varargin_2[0], &p->Batt_As_Discharged_tbl[0],
           506U * sizeof(double));
    qx2 = y->VB_CF / p->Ns;
    if (p->Batt_Voc_brk[1] < p->Batt_Voc_brk[0]) {
      for (low_ip1 = 0; low_ip1 < 253; low_ip1++) {
        xtmp = varargin_1[low_ip1];
        varargin_1[low_ip1] = varargin_1[505 - low_ip1];
        varargin_1[505 - low_ip1] = xtmp;
        xtmp = varargin_2[low_ip1];
        varargin_2[low_ip1] = varargin_2[505 - low_ip1];
        varargin_2[505 - low_ip1] = xtmp;
      }
    }
    xtmp = 0.0;
    if ((qx2 <= varargin_1[505]) && (qx2 >= varargin_1[0])) {
      low_i = 1;
      low_ip1 = 2;
      high_i = 506;
      while (high_i > low_ip1) {
        mid_i = (low_i + high_i) >> 1;
        if (qx2 >= varargin_1[mid_i - 1]) {
          low_i = mid_i;
          low_ip1 = mid_i + 1;
        } else {
          high_i = mid_i;
        }
      }
      xtmp = varargin_1[low_i - 1];
      xtmp = (qx2 - xtmp) / (varargin_1[low_i] - xtmp);
      if (xtmp == 0.0) {
        xtmp = varargin_2[low_i - 1];
      } else if (xtmp == 1.0) {
        xtmp = varargin_2[low_i];
      } else {
        qx2 = varargin_2[low_i - 1];
        if (qx2 == varargin_2[low_i]) {
          xtmp = qx2;
        } else {
          xtmp = (1.0 - xtmp) * qx2 + xtmp * varargin_2[low_i];
        }
      }
    }
    minval[0] = p->Batt_cell_zero_SOC_capacity;
    minval[1] = p->Batt_cell_full_SOC_capacity;
    dv[0] = 0.0;
    dv[1] = 1.0;
    y->Batt_SOC = fmax(fmin(interp1(minval, dv, xtmp), 1.0), 0.0);
  }
  if (y->VCU_mode >= 1.0) {
    y->TO_ET[0] = y->TH_CF * p->MAX_TORQUE_NOM;
    y->TO_ET[1] = y->TH_CF * p->MAX_TORQUE_NOM;
  }
  if (y->VCU_mode >= 1.0) {
    double b_varargin_1[8];
    double b_p[2];
    double c_p[2];
    double d_p[2];
    double dv1[2];
    double dv2[2];
    double dv3[2];
    double dv4[2];
    double dv5[2];
    double dv6[2];
    double dv7[2];
    double e_p[2];
    double f_p[2];
    double g_p[2];
    double h_p[2];
    minval[0] = y->WT_CF[0] * p->gr;
    minval[1] = y->WT_CF[1] * p->gr;
    if (minval[0] < minval[1]) {
      rx = minval[1];
    } else {
      rx = minval[0];
    }
    xtmp = fmax(fmin(rx, p->PT_WM_ub), p->PT_WM_lb);
    Yqk = fmax(fmin(y->VB_CF, p->PT_VB_ub), p->PT_VB_lb);
    if ((xtmp >= p->PT_WM_brkpt[0]) && (xtmp <= p->PT_WM_brkpt[149]) &&
        (Yqk >= p->PT_VB_brkpt[0]) && (Yqk <= p->PT_VB_brkpt[49])) {
      low_i = 0;
      low_ip1 = 2;
      high_i = 150;
      while (high_i > low_ip1) {
        mid_i = ((low_i + high_i) + 1) >> 1;
        if (xtmp >= p->PT_WM_brkpt[mid_i - 1]) {
          low_i = mid_i - 1;
          low_ip1 = mid_i + 1;
        } else {
          high_i = mid_i;
        }
      }
      b_low_i = 1;
      low_ip1 = 2;
      high_i = 50;
      while (high_i > low_ip1) {
        mid_i = (b_low_i + high_i) >> 1;
        if (Yqk >= p->PT_VB_brkpt[mid_i - 1]) {
          b_low_i = mid_i;
          low_ip1 = mid_i + 1;
        } else {
          high_i = mid_i;
        }
      }
      if (xtmp == p->PT_WM_brkpt[low_i]) {
        low_ip1 = b_low_i + 50 * low_i;
        qx1 = p->PT_TO_table[low_ip1 - 1];
        qx2 = p->PT_TO_table[low_ip1];
      } else {
        rx = p->PT_WM_brkpt[low_i + 1];
        if (xtmp == rx) {
          low_ip1 = b_low_i + 50 * (low_i + 1);
          qx1 = p->PT_TO_table[low_ip1 - 1];
          qx2 = p->PT_TO_table[low_ip1];
        } else {
          rx = (xtmp - p->PT_WM_brkpt[low_i]) / (rx - p->PT_WM_brkpt[low_i]);
          high_i = b_low_i + 50 * low_i;
          xtmp = p->PT_TO_table[high_i - 1];
          low_ip1 = b_low_i + 50 * (low_i + 1);
          qx2 = p->PT_TO_table[low_ip1 - 1];
          if (xtmp == qx2) {
            qx1 = xtmp;
          } else {
            qx1 = (1.0 - rx) * xtmp + rx * qx2;
          }
          xtmp = p->PT_TO_table[high_i];
          qx2 = p->PT_TO_table[low_ip1];
          if (xtmp == qx2) {
            qx2 = xtmp;
          } else {
            qx2 = (1.0 - rx) * xtmp + rx * qx2;
          }
        }
      }
      rx = p->PT_VB_brkpt[b_low_i - 1];
      if ((Yqk == rx) || (qx1 == qx2)) {
        qx2 = qx1;
      } else if (Yqk != p->PT_VB_brkpt[b_low_i]) {
        xtmp = (Yqk - rx) / (p->PT_VB_brkpt[b_low_i] - rx);
        qx2 = (1.0 - xtmp) * qx1 + xtmp * qx2;
      }
    } else {
      qx2 = 0.0;
    }
    y->TO_AB_MX = fmax(fmin(qx2, p->MAX_TORQUE_NOM), 0.0);
    minval[0] = p->mT_derating_full_T;
    minval[1] = p->mT_derating_zero_T;
    b_p[0] = p->cT_derating_full_T;
    b_p[1] = p->cT_derating_zero_T;
    c_p[0] = p->iT_derating_full_T;
    c_p[1] = p->iT_derating_zero_T;
    d_p[0] = p->Cm_derating_full_T;
    d_p[1] = p->Cm_derating_zero_T;
    e_p[0] = p->Ci_derating_full_T;
    e_p[1] = p->Ci_derating_zero_T;
    f_p[0] = p->bT_derating_full_T;
    f_p[1] = p->bT_derating_zero_T;
    g_p[0] = p->bI_derating_full_T;
    g_p[1] = p->bI_derating_zero_T;
    h_p[0] = p->Vb_derating_full_T;
    h_p[1] = p->Vb_derating_zero_T;
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
    b_varargin_1[0] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(minval, dv, y->MT_CF), 1.0), 0.0);
    b_varargin_1[1] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(b_p, dv1, y->CT_CF), 1.0), 0.0);
    b_varargin_1[2] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(c_p, dv2, y->IT_CF), 1.0), 0.0);
    b_varargin_1[3] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(d_p, dv3, y->MC_CF), 1.0), 0.0);
    b_varargin_1[4] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(e_p, dv4, y->IC_CF), 1.0), 0.0);
    b_varargin_1[5] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(f_p, dv5, y->BT_CF), 1.0), 0.0);
    b_varargin_1[6] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(g_p, dv6, y->IB_CF), 1.0), 0.0);
    b_varargin_1[7] =
        p->MAX_TORQUE_NOM * fmax(fmin(interp1(h_p, dv7, y->VB_CF), 1.0), 0.0);
    xtmp = b_varargin_1[0];
    for (low_ip1 = 0; low_ip1 < 7; low_ip1++) {
      rx = b_varargin_1[low_ip1 + 1];
      if (xtmp > rx) {
        xtmp = rx;
      }
    }
    y->TO_DR_MX = xtmp;
    xtmp = fmin(y->TO_AB_MX * y->TH_CF, xtmp);
    y->TO_PT[0] = xtmp;
    y->TO_PT[1] = xtmp;
  }
  if (y->VCU_mode == 1.0) {
    y->WM_VS[0] = 1.0;
    y->WM_VS[1] = 1.0;
  }
  if (y->VCU_mode == 1.0) {
    rx = fabs(y->ST_CF);
    xtmp = y->DB_CF + p->dST_DB;
    if (rx < xtmp) {
      y->VT_mode = 2.0;
    } else if (rx > xtmp) {
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
      xtmp = fmax(fmin(y->ST_CF, p->TV_ST_ub), p->TV_ST_lb);
      Yqk = fmax(fmin(y->GS_CF, p->TV_GS_ub), p->TV_GS_lb);
      if ((xtmp >= p->TV_ST_brkpt[0]) && (xtmp <= p->TV_ST_brkpt[52]) &&
          (Yqk >= p->TV_GS_brkpt[0]) && (Yqk <= p->TV_GS_brkpt[50])) {
        low_i = 0;
        low_ip1 = 2;
        high_i = 53;
        while (high_i > low_ip1) {
          mid_i = ((low_i + high_i) + 1) >> 1;
          if (xtmp >= p->TV_ST_brkpt[mid_i - 1]) {
            low_i = mid_i - 1;
            low_ip1 = mid_i + 1;
          } else {
            high_i = mid_i;
          }
        }
        b_low_i = 1;
        low_ip1 = 2;
        high_i = 51;
        while (high_i > low_ip1) {
          mid_i = (b_low_i + high_i) >> 1;
          if (Yqk >= p->TV_GS_brkpt[mid_i - 1]) {
            b_low_i = mid_i;
            low_ip1 = mid_i + 1;
          } else {
            high_i = mid_i;
          }
        }
        if (xtmp == p->TV_ST_brkpt[low_i]) {
          low_ip1 = b_low_i + 51 * low_i;
          qx1 = p->TV_AV_table[low_ip1 - 1];
          qx2 = p->TV_AV_table[low_ip1];
        } else {
          rx = p->TV_ST_brkpt[low_i + 1];
          if (xtmp == rx) {
            low_ip1 = b_low_i + 51 * (low_i + 1);
            qx1 = p->TV_AV_table[low_ip1 - 1];
            qx2 = p->TV_AV_table[low_ip1];
          } else {
            rx = (xtmp - p->TV_ST_brkpt[low_i]) / (rx - p->TV_ST_brkpt[low_i]);
            high_i = b_low_i + 51 * low_i;
            xtmp = p->TV_AV_table[high_i - 1];
            low_ip1 = b_low_i + 51 * (low_i + 1);
            qx2 = p->TV_AV_table[low_ip1 - 1];
            if (xtmp == qx2) {
              qx1 = xtmp;
            } else {
              qx1 = (1.0 - rx) * xtmp + rx * qx2;
            }
            xtmp = p->TV_AV_table[high_i];
            qx2 = p->TV_AV_table[low_ip1];
            if (xtmp == qx2) {
              qx2 = xtmp;
            } else {
              qx2 = (1.0 - rx) * xtmp + rx * qx2;
            }
          }
        }
        rx = p->TV_GS_brkpt[b_low_i - 1];
        if ((Yqk == rx) || (qx1 == qx2)) {
          qx2 = qx1;
        } else if (Yqk != p->TV_GS_brkpt[b_low_i]) {
          xtmp = (Yqk - rx) / (p->TV_GS_brkpt[b_low_i] - rx);
          qx2 = (1.0 - xtmp) * qx1 + xtmp * qx2;
        }
      } else {
        qx2 = 0.0;
      }
      xtmp = fmax(fmin((qx2 * y->PI_CF - y->AV_CF[2]) * y->PP_CF * p->ht[1],
                       y->TO_PT[0] * p->r_power_sat),
                  -y->TO_PT[0] * p->r_power_sat);
      if (xtmp > 0.0) {
        y->TO_VT[0] = y->TO_PT[0];
        y->TO_VT[1] = y->TO_PT[0] - xtmp;
      } else {
        y->TO_VT[0] = y->TO_PT[0] + xtmp;
        y->TO_VT[1] = y->TO_PT[0];
      }
    }
  }
}

void VCU_step_initialize(void)
{
}

void VCU_step_terminate(void)
{
}
