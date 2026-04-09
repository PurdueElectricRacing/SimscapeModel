#include "vcu_step.h"
#include "vcu_step_types.h"
#include <math.h>

static float interp1(const float varargin_1[2], const float varargin_2[2],
                     float varargin_3);

static float mean(const float x[10]);

static void minimum(const float x[28], float ex[4]);

static float interp1(const float varargin_1[2], const float varargin_2[2],
                     float varargin_3)
{
  float Vq;
  float x_idx_0;
  float x_idx_1;
  float y_idx_0;
  float y_idx_1;
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
  Vq = 0.0F;
  if ((varargin_3 <= x_idx_1) && (varargin_3 >= x_idx_0)) {
    float r;
    r = (varargin_3 - x_idx_0) / (x_idx_1 - x_idx_0);
    if (r == 0.0F) {
      Vq = y_idx_0;
    } else if (r == 1.0F) {
      Vq = y_idx_1;
    } else if (y_idx_0 == y_idx_1) {
      Vq = y_idx_0;
    } else {
      Vq = (1.0F - r) * y_idx_0 + r * y_idx_1;
    }
  }
  return Vq;
}

static float mean(const float x[10])
{
  float accumulatedData;
  int k;
  accumulatedData = x[0];
  for (k = 0; k < 9; k++) {
    accumulatedData += x[k + 1];
  }
  return accumulatedData / 10.0F;
}

static void minimum(const float x[28], float ex[4])
{
  int i;
  int j;
  for (j = 0; j < 4; j++) {
    float f;
    f = x[7 * j];
    for (i = 0; i < 6; i++) {
      float f1;
      f1 = x[(i + 7 * j) + 1];
      if (f > f1) {
        f = f1;
      }
    }
    ex[j] = f;
  }
}

void vcu_step(const pVCU_struct *p, const xVCU_struct *x, yVCU_struct *y)
{
  int i;
  y->TH = x->TH_RAW;
  y->TH_PO = fminf(fmaxf(x->TH_RAW, 0.0F), 1.0F);
  y->TH_RG = fabsf(fminf(fmaxf(x->TH_RAW, -1.0F), 0.0F));
  y->ST = x->ST_RAW;
  y->VB = x->VB_RAW;
  y->WM[0] = x->WM_RAW[0];
  y->WM[1] = x->WM_RAW[1];
  y->WM[2] = x->WM_RAW[2];
  y->WM[3] = x->WM_RAW[3];
  y->GS = x->GS_RAW;
  y->AV[0] = x->AV_RAW[0];
  y->AV[1] = x->AV_RAW[1];
  y->AV[2] = x->AV_RAW[2];
  y->IB = x->IB_RAW;
  y->MT = x->MT_RAW;
  y->IGBT_T = x->IGBT_T_RAW;
  y->INV_T = x->INV_T_RAW;
  y->MC = x->MC_RAW;
  y->IC = x->IC_RAW;
  y->BT = x->BT_RAW;
  y->TO[0] = x->TO_RAW[0];
  y->TO[1] = x->TO_RAW[1];
  y->TO[2] = x->TO_RAW[2];
  y->TO[3] = x->TO_RAW[3];
  for (i = 0; i < 9; i++) {
    y->IB_AVG_buffer[i] = y->IB_AVG_buffer[i + 1];
  }
  y->IB_AVG_buffer[9] = x->IB_RAW;
  y->IB_AVG = mean(y->IB_AVG_buffer);
  y->PB = x->VB_RAW * x->IB_RAW;
  if (x->TH_RAW > 0.0F) {
    float b_PB_derate_front[28];
    float fv1[4];
    float b_p[2];
    float fv[2];
    float PB_derate_front;
    float PB_derate_rear;
    float PB_snipped;
    float d_b;
    float f3;
    float f_b;
    float h_b;
    float j_b;
    float l_b;
    float n_b;
    float out;
    out = y->TH_PO * p->MAX_TO_ABS_PO;
    PB_snipped =
        fmaxf(fminf(y->PB, p->PB_derating_half_T), p->PB_derating_full_T);
    b_p[0] = p->PB_derating_full_T;
    b_p[1] = p->PB_derating_half_T;
    fv[0] = 1.0F;
    fv[1] = 1.0F - p->PB_derating_FR;
    PB_derate_front = interp1(b_p, fv, PB_snipped);
    b_p[0] = p->PB_derating_full_T;
    b_p[1] = p->PB_derating_half_T;
    fv[0] = 1.0F;
    fv[1] = p->PB_derating_FR;
    PB_derate_rear = interp1(b_p, fv, PB_snipped);
    b_p[0] = p->INV_T_derating_full_T;
    b_p[1] = p->INV_T_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    d_b = interp1(b_p, fv,
                  fmaxf(fminf(x->INV_T_RAW, p->INV_T_derating_zero_T),
                        p->INV_T_derating_full_T));
    b_p[0] = p->IGBT_T_derating_full_T;
    b_p[1] = p->IGBT_T_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    f_b = interp1(b_p, fv,
                  fmaxf(fminf(x->IGBT_T_RAW, p->IGBT_T_derating_zero_T),
                        p->IGBT_T_derating_full_T));
    b_p[0] = p->MT_derating_full_T;
    b_p[1] = p->MT_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    h_b = interp1(
        b_p, fv,
        fmaxf(fminf(x->MT_RAW, p->MT_derating_zero_T), p->MT_derating_full_T));
    b_p[0] = p->BT_derating_full_T;
    b_p[1] = p->BT_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    j_b = interp1(
        b_p, fv,
        fmaxf(fminf(x->BT_RAW, p->BT_derating_zero_T), p->BT_derating_full_T));
    b_p[0] = p->VB_derating_full_T;
    b_p[1] = p->VB_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    l_b = interp1(
        b_p, fv,
        fmaxf(fminf(x->VB_RAW, p->VB_derating_zero_T), p->VB_derating_full_T));
    b_p[0] = p->IB_derating_full_T;
    b_p[1] = p->IB_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    n_b = interp1(
        b_p, fv,
        fmaxf(fminf(y->IB_AVG, p->IB_derating_zero_T), p->IB_derating_full_T));
    b_PB_derate_front[0] = PB_derate_front;
    b_PB_derate_front[7] = PB_derate_front;
    b_PB_derate_front[14] = PB_derate_rear;
    b_PB_derate_front[21] = PB_derate_rear;
    b_PB_derate_front[1] = d_b;
    b_PB_derate_front[2] = f_b;
    b_PB_derate_front[3] = h_b;
    b_PB_derate_front[4] = j_b;
    b_PB_derate_front[5] = l_b;
    b_PB_derate_front[6] = n_b;
    b_PB_derate_front[8] = d_b;
    b_PB_derate_front[9] = f_b;
    b_PB_derate_front[10] = h_b;
    b_PB_derate_front[11] = j_b;
    b_PB_derate_front[12] = l_b;
    b_PB_derate_front[13] = n_b;
    b_PB_derate_front[15] = d_b;
    b_PB_derate_front[16] = f_b;
    b_PB_derate_front[17] = h_b;
    b_PB_derate_front[18] = j_b;
    b_PB_derate_front[19] = l_b;
    b_PB_derate_front[20] = n_b;
    b_PB_derate_front[22] = d_b;
    b_PB_derate_front[23] = f_b;
    b_PB_derate_front[24] = h_b;
    b_PB_derate_front[25] = j_b;
    b_PB_derate_front[26] = l_b;
    b_PB_derate_front[27] = n_b;
    minimum(b_PB_derate_front, fv1);
    f3 = fminf(out, p->MAX_TO_ABS_PO * fv1[0]);
    y->TORQUE_OUT[0] = f3;
    y->TO_BL_PO[0] = f3;
    f3 = fminf(out, p->MAX_TO_ABS_PO * fv1[1]);
    y->TORQUE_OUT[1] = f3;
    y->TO_BL_PO[1] = f3;
    f3 = fminf(out, p->MAX_TO_ABS_PO * fv1[2]);
    y->TORQUE_OUT[2] = f3;
    y->TO_BL_PO[2] = f3;
    f3 = fminf(out, p->MAX_TO_ABS_PO * fv1[3]);
    y->TORQUE_OUT[3] = f3;
    y->TO_BL_PO[3] = f3;
  } else if (x->TH_RAW < 0.0F) {
    float m_b[28];
    float fv1[4];
    float b_p[2];
    float fv[2];
    float b;
    float b_b;
    float b_out;
    float c_b;
    float e_b;
    float f;
    float f1;
    float f2;
    float f4;
    float g_b;
    float i_b;
    float k_b;
    b_out = y->TH_RG * p->MAX_TO_ABS_RG;
    b_p[0] = p->GS_RG_derating_full;
    b_p[1] = p->GS_RG_derating_zero;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    b = interp1(b_p, fv,
                fmaxf(fminf(x->GS_RAW, p->GS_RG_derating_zero),
                      p->GS_RG_derating_full));
    b_p[0] = p->INV_T_derating_full_T;
    b_p[1] = p->INV_T_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    b_b = interp1(b_p, fv,
                  fmaxf(fminf(x->INV_T_RAW, p->INV_T_derating_zero_T),
                        p->INV_T_derating_full_T));
    b_p[0] = p->IGBT_T_derating_full_T;
    b_p[1] = p->IGBT_T_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    c_b = interp1(b_p, fv,
                  fmaxf(fminf(x->IGBT_T_RAW, p->IGBT_T_derating_zero_T),
                        p->IGBT_T_derating_full_T));
    b_p[0] = p->MT_derating_full_T;
    b_p[1] = p->MT_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    e_b = interp1(
        b_p, fv,
        fmaxf(fminf(x->MT_RAW, p->MT_derating_zero_T), p->MT_derating_full_T));
    b_p[0] = p->BT_derating_full_T;
    b_p[1] = p->BT_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    g_b = interp1(
        b_p, fv,
        fmaxf(fminf(x->BT_RAW, p->BT_derating_zero_T), p->BT_derating_full_T));
    b_p[0] = p->VB_RG_derating_full_T;
    b_p[1] = p->VB_RG_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    i_b = interp1(b_p, fv,
                  fmaxf(fminf(x->VB_RAW, p->VB_RG_derating_zero_T),
                        p->VB_RG_derating_full_T));
    b_p[0] = p->IB_RG_derating_full_T;
    b_p[1] = p->IB_RG_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    k_b = interp1(b_p, fv,
                  fmaxf(fminf(y->IB_AVG, p->IB_RG_derating_zero_T),
                        p->IB_RG_derating_full_T));
    m_b[0] = b_b;
    m_b[1] = c_b;
    m_b[2] = e_b;
    m_b[3] = g_b;
    m_b[4] = i_b;
    m_b[5] = k_b;
    m_b[6] = b;
    m_b[7] = b_b;
    m_b[8] = c_b;
    m_b[9] = e_b;
    m_b[10] = g_b;
    m_b[11] = i_b;
    m_b[12] = k_b;
    m_b[13] = b;
    m_b[14] = b_b;
    m_b[15] = c_b;
    m_b[16] = e_b;
    m_b[17] = g_b;
    m_b[18] = i_b;
    m_b[19] = k_b;
    m_b[20] = b;
    m_b[21] = b_b;
    m_b[22] = c_b;
    m_b[23] = e_b;
    m_b[24] = g_b;
    m_b[25] = i_b;
    m_b[26] = k_b;
    m_b[27] = b;
    minimum(m_b, fv1);
    f = -fminf(b_out, p->MAX_TO_ABS_RG * fv1[0]);
    y->TO_BL_RG[0] = f;
    y->TORQUE_OUT[0] = f;
    f1 = -fminf(b_out, p->MAX_TO_ABS_RG * fv1[1]);
    y->TO_BL_RG[1] = f1;
    y->TORQUE_OUT[1] = f1;
    f2 = -fminf(b_out, p->MAX_TO_ABS_RG * fv1[2]);
    y->TO_BL_RG[2] = f2;
    y->TORQUE_OUT[2] = f2;
    f4 = -fminf(b_out, p->MAX_TO_ABS_RG * fv1[3]);
    y->TO_BL_RG[3] = f4;
    y->TORQUE_OUT[3] = f4;
  } else {
    y->TORQUE_OUT[0] = 0.0F;
    y->TORQUE_OUT[1] = 0.0F;
    y->TORQUE_OUT[2] = 0.0F;
    y->TORQUE_OUT[3] = 0.0F;
  }
}
