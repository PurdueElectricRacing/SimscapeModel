#include "VCU_step.h"
#include "interp1.h"
#include "vcu_step_types.h"
#include <math.h>

void VCU_step(const struct0_T *p, const struct1_T *x, struct2_T *y)
{
  float varargin_1[28];
  float b_p[2];
  float fv[2];
  float PB_derate_front;
  float PB_derate_rear;
  float PB_snipped;
  float ab_u1;
  float ab_y;
  float b;
  float b_b;
  float b_out;
  float b_u0;
  float b_u1;
  float b_y;
  float bb_u1;
  float bb_y;
  float c_b;
  float c_u0;
  float c_u1;
  float c_y;
  float cb_u1;
  float cb_y;
  float d_b;
  float d_u0;
  float d_u1;
  float d_y;
  float db_u1;
  float db_y;
  float e_b;
  float e_u0;
  float e_u1;
  float e_y;
  float eb_u1;
  float eb_y;
  float f;
  float f1;
  float f2;
  float f3;
  float f4;
  float f5;
  float f_b;
  float f_u0;
  float f_u1;
  float f_y;
  float fb_y;
  float g_b;
  float g_u0;
  float g_u1;
  float g_y;
  float gb_y;
  float h_b;
  float h_u0;
  float h_u1;
  float h_y;
  float hb_y;
  float i_b;
  float i_u0;
  float i_u1;
  float i_y;
  float j_b;
  float j_u0;
  float j_u1;
  float j_y;
  float k_b;
  float k_u0;
  float k_u1;
  float k_y;
  float l_b;
  float l_u0;
  float l_u1;
  float l_y;
  float m_b;
  float m_u0;
  float m_u1;
  float m_y;
  float n_u0;
  float n_u1;
  float n_y;
  float o_u0;
  float o_u1;
  float o_y;
  float out;
  float p_u0;
  float p_u1;
  float p_y;
  float q_u1;
  float q_y;
  float r_u1;
  float r_y;
  float s_u1;
  float s_y;
  float t_u1;
  float t_y;
  float u0;
  float u1;
  float u_u1;
  float u_y;
  float v_u1;
  float v_y;
  float w_u1;
  float w_y;
  float x_u1;
  float x_y;
  float y_u1;
  float y_y;
  int b_i;
  int b_j;
  int i;
  int j;
  y->TH = x->TH_RAW;
  u0 = x->TH_RAW;
  if (u0 >= 0.0F) {
    b_y = u0;
  } else {
    b_y = 0.0F;
  }
  if (b_y <= 1.0F) {
    c_y = b_y;
  } else {
    c_y = 1.0F;
  }
  y->TH_PO = c_y;
  b_u0 = x->TH_RAW;
  if (b_u0 >= -1.0F) {
    d_y = b_u0;
  } else {
    d_y = -1.0F;
  }
  if (d_y <= 0.0F) {
    e_y = d_y;
  } else {
    e_y = 0.0F;
  }
  y->TH_RG = (float)fabs(e_y);
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
  y->PB = x->VB_RAW * x->IB_RAW;
  if (x->TH_RAW >= 0.0F) {
    out = y->TH_PO * p->MAX_TO_ABS_PO;
    c_u0 = y->PB;
    u1 = p->PB_derating_half_T;
    if (c_u0 <= u1) {
      f_y = c_u0;
    } else {
      f_y = u1;
    }
    b_u1 = p->PB_derating_full_T;
    if (f_y >= b_u1) {
      PB_snipped = f_y;
    } else {
      PB_snipped = b_u1;
    }
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
    f_u0 = x->INV_T_RAW;
    g_u1 = p->INV_T_derating_zero_T;
    if (f_u0 <= g_u1) {
      k_y = f_u0;
    } else {
      k_y = g_u1;
    }
    h_u1 = p->INV_T_derating_full_T;
    if (k_y >= h_u1) {
      l_y = k_y;
    } else {
      l_y = h_u1;
    }
    c_b = interp1(b_p, fv, l_y);
    b_p[0] = p->IGBT_T_derating_full_T;
    b_p[1] = p->IGBT_T_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    h_u0 = x->IGBT_T_RAW;
    k_u1 = p->IGBT_T_derating_zero_T;
    if (h_u0 <= k_u1) {
      o_y = h_u0;
    } else {
      o_y = k_u1;
    }
    l_u1 = p->IGBT_T_derating_full_T;
    if (o_y >= l_u1) {
      p_y = o_y;
    } else {
      p_y = l_u1;
    }
    e_b = interp1(b_p, fv, p_y);
    b_p[0] = p->MT_derating_full_T;
    b_p[1] = p->MT_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    j_u0 = x->MT_RAW;
    o_u1 = p->MT_derating_zero_T;
    if (j_u0 <= o_u1) {
      s_y = j_u0;
    } else {
      s_y = o_u1;
    }
    p_u1 = p->MT_derating_full_T;
    if (s_y >= p_u1) {
      t_y = s_y;
    } else {
      t_y = p_u1;
    }
    g_b = interp1(b_p, fv, t_y);
    b_p[0] = p->BT_derating_full_T;
    b_p[1] = p->BT_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    l_u0 = x->BT_RAW;
    s_u1 = p->BT_derating_zero_T;
    if (l_u0 <= s_u1) {
      w_y = l_u0;
    } else {
      w_y = s_u1;
    }
    t_u1 = p->BT_derating_full_T;
    if (w_y >= t_u1) {
      x_y = w_y;
    } else {
      x_y = t_u1;
    }
    i_b = interp1(b_p, fv, x_y);
    b_p[0] = p->VB_derating_full_T;
    b_p[1] = p->VB_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    n_u0 = x->VB_RAW;
    w_u1 = p->VB_derating_zero_T;
    if (n_u0 <= w_u1) {
      bb_y = n_u0;
    } else {
      bb_y = w_u1;
    }
    x_u1 = p->VB_derating_full_T;
    if (bb_y >= x_u1) {
      cb_y = bb_y;
    } else {
      cb_y = x_u1;
    }
    k_b = interp1(b_p, fv, cb_y);
    b_p[0] = p->IB_derating_full_T;
    b_p[1] = p->IB_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    p_u0 = x->IB_RAW;
    bb_u1 = p->IB_derating_zero_T;
    if (p_u0 <= bb_u1) {
      fb_y = p_u0;
    } else {
      fb_y = bb_u1;
    }
    cb_u1 = p->IB_derating_full_T;
    if (fb_y >= cb_u1) {
      gb_y = fb_y;
    } else {
      gb_y = cb_u1;
    }
    m_b = interp1(b_p, fv, gb_y);
    varargin_1[0] = PB_derate_front;
    varargin_1[7] = PB_derate_front;
    varargin_1[14] = PB_derate_rear;
    varargin_1[21] = PB_derate_rear;
    for (b_j = 0; b_j < 4; b_j++) {
      varargin_1[7 * b_j + 1] = c_b;
      varargin_1[7 * b_j + 2] = e_b;
      varargin_1[7 * b_j + 3] = g_b;
      varargin_1[7 * b_j + 4] = i_b;
      varargin_1[7 * b_j + 5] = k_b;
      varargin_1[7 * b_j + 6] = m_b;
      f3 = varargin_1[7 * b_j];
      for (b_i = 0; b_i < 6; b_i++) {
        f4 = varargin_1[(b_i + 7 * b_j) + 1];
        if (f3 > f4) {
          f3 = f4;
        }
      }
      eb_u1 = p->MAX_TO_ABS_PO * f3;
      if (out <= eb_u1) {
        f5 = out;
      } else {
        f5 = eb_u1;
      }
      y->TORQUE_OUT[b_j] = f5;
      y->TO_BL_PO[b_j] = f5;
    }
  } else if (x->TH_RAW < 0.0F) {
    b_out = y->TH_RG * p->MAX_TO_ABS_RG;
    b_p[0] = p->GS_RG_derating_full;
    b_p[1] = p->GS_RG_derating_zero;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    d_u0 = x->GS_RAW;
    c_u1 = p->GS_RG_derating_zero;
    if (d_u0 <= c_u1) {
      g_y = d_u0;
    } else {
      g_y = c_u1;
    }
    d_u1 = p->GS_RG_derating_full;
    if (g_y >= d_u1) {
      h_y = g_y;
    } else {
      h_y = d_u1;
    }
    b = interp1(b_p, fv, h_y);
    b_p[0] = p->INV_T_derating_full_T;
    b_p[1] = p->INV_T_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    e_u0 = x->INV_T_RAW;
    e_u1 = p->INV_T_derating_zero_T;
    if (e_u0 <= e_u1) {
      i_y = e_u0;
    } else {
      i_y = e_u1;
    }
    f_u1 = p->INV_T_derating_full_T;
    if (i_y >= f_u1) {
      j_y = i_y;
    } else {
      j_y = f_u1;
    }
    b_b = interp1(b_p, fv, j_y);
    b_p[0] = p->IGBT_T_derating_full_T;
    b_p[1] = p->IGBT_T_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    g_u0 = x->IGBT_T_RAW;
    i_u1 = p->IGBT_T_derating_zero_T;
    if (g_u0 <= i_u1) {
      m_y = g_u0;
    } else {
      m_y = i_u1;
    }
    j_u1 = p->IGBT_T_derating_full_T;
    if (m_y >= j_u1) {
      n_y = m_y;
    } else {
      n_y = j_u1;
    }
    d_b = interp1(b_p, fv, n_y);
    b_p[0] = p->MT_derating_full_T;
    b_p[1] = p->MT_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    i_u0 = x->MT_RAW;
    m_u1 = p->MT_derating_zero_T;
    if (i_u0 <= m_u1) {
      q_y = i_u0;
    } else {
      q_y = m_u1;
    }
    n_u1 = p->MT_derating_full_T;
    if (q_y >= n_u1) {
      r_y = q_y;
    } else {
      r_y = n_u1;
    }
    f_b = interp1(b_p, fv, r_y);
    b_p[0] = p->BT_derating_full_T;
    b_p[1] = p->BT_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    k_u0 = x->BT_RAW;
    q_u1 = p->BT_derating_zero_T;
    if (k_u0 <= q_u1) {
      u_y = k_u0;
    } else {
      u_y = q_u1;
    }
    r_u1 = p->BT_derating_full_T;
    if (u_y >= r_u1) {
      v_y = u_y;
    } else {
      v_y = r_u1;
    }
    h_b = interp1(b_p, fv, v_y);
    b_p[0] = p->VB_RG_derating_full_T;
    b_p[1] = p->VB_RG_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    m_u0 = x->VB_RAW;
    u_u1 = p->VB_RG_derating_zero_T;
    if (m_u0 <= u_u1) {
      y_y = m_u0;
    } else {
      y_y = u_u1;
    }
    v_u1 = p->VB_RG_derating_full_T;
    if (y_y >= v_u1) {
      ab_y = y_y;
    } else {
      ab_y = v_u1;
    }
    j_b = interp1(b_p, fv, ab_y);
    b_p[0] = p->IB_RG_derating_full_T;
    b_p[1] = p->IB_RG_derating_zero_T;
    fv[0] = 1.0F;
    fv[1] = 0.0F;
    o_u0 = x->IB_RAW;
    y_u1 = p->IB_RG_derating_zero_T;
    if (o_u0 <= y_u1) {
      db_y = o_u0;
    } else {
      db_y = y_u1;
    }
    ab_u1 = p->IB_RG_derating_full_T;
    if (db_y >= ab_u1) {
      eb_y = db_y;
    } else {
      eb_y = ab_u1;
    }
    l_b = interp1(b_p, fv, eb_y);
    for (j = 0; j < 4; j++) {
      varargin_1[7 * j] = b_b;
      varargin_1[7 * j + 1] = d_b;
      varargin_1[7 * j + 2] = f_b;
      varargin_1[7 * j + 3] = h_b;
      varargin_1[7 * j + 4] = j_b;
      varargin_1[7 * j + 5] = l_b;
      varargin_1[7 * j + 6] = b;
      f = b_b;
      for (i = 0; i < 6; i++) {
        f1 = varargin_1[(i + 7 * j) + 1];
        if (f > f1) {
          f = f1;
        }
      }
      db_u1 = p->MAX_TO_ABS_RG * f;
      if (b_out <= db_u1) {
        hb_y = b_out;
      } else {
        hb_y = db_u1;
      }
      f2 = -hb_y;
      y->TO_BL_RG[j] = f2;
      y->TORQUE_OUT[j] = f2;
    }
  }
}
