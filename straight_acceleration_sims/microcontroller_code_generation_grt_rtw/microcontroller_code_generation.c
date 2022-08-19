/*
 * microcontroller_code_generation.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "microcontroller_code_generation".
 *
 * Model version              : 1.1
 * Simulink Coder version : 9.6 (R2021b) 14-May-2021
 * C source code generated on : Tue Aug 16 15:45:47 2022
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "microcontroller_code_generation.h"
#include "microcontroller_code_generation_private.h"

/* Block states (default storage) */
DW_microcontroller_code_gener_T microcontroller_code_generat_DW;

/* Real-time model */
static RT_MODEL_microcontroller_code_T microcontroller_code_generat_M_;
RT_MODEL_microcontroller_code_T *const microcontroller_code_generat_M =
  &microcontroller_code_generat_M_;

/* Forward declaration for local functions */
static real_T microcontroller_code_gener_norm(const real_T x[2]);
static void microcontroller_code_gene_pchip(const real_T x[7], const real_T y[7],
  const real_T xx[4], real_T v[4]);
real_T rt_powd_snf(real_T u0, real_T u1)
{
  real_T y;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = (rtNaN);
  } else {
    real_T tmp;
    real_T tmp_0;
    tmp = fabs(u0);
    tmp_0 = fabs(u1);
    if (rtIsInf(u1)) {
      if (tmp == 1.0) {
        y = 1.0;
      } else if (tmp > 1.0) {
        if (u1 > 0.0) {
          y = (rtInf);
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = (rtInf);
      }
    } else if (tmp_0 == 0.0) {
      y = 1.0;
    } else if (tmp_0 == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > floor(u1))) {
      y = (rtNaN);
    } else {
      y = pow(u0, u1);
    }
  }

  return y;
}

real_T rt_atan2d_snf(real_T u0, real_T u1)
{
  real_T y;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = (rtNaN);
  } else if (rtIsInf(u0) && rtIsInf(u1)) {
    int32_T u0_0;
    int32_T u1_0;
    if (u0 > 0.0) {
      u0_0 = 1;
    } else {
      u0_0 = -1;
    }

    if (u1 > 0.0) {
      u1_0 = 1;
    } else {
      u1_0 = -1;
    }

    y = atan2(u0_0, u1_0);
  } else if (u1 == 0.0) {
    if (u0 > 0.0) {
      y = RT_PI / 2.0;
    } else if (u0 < 0.0) {
      y = -(RT_PI / 2.0);
    } else {
      y = 0.0;
    }
  } else {
    y = atan2(u0, u1);
  }

  return y;
}

/* Function for MATLAB Function: '<S1>/Tire Model' */
static real_T microcontroller_code_gener_norm(const real_T x[2])
{
  real_T absxk;
  real_T scale;
  real_T t;
  real_T y;
  scale = 3.3121686421112381E-170;
  absxk = fabs(x[0]);
  if (absxk > 3.3121686421112381E-170) {
    y = 1.0;
    scale = absxk;
  } else {
    t = absxk / 3.3121686421112381E-170;
    y = t * t;
  }

  absxk = fabs(x[1]);
  if (absxk > scale) {
    t = scale / absxk;
    y = y * t * t + 1.0;
    scale = absxk;
  } else {
    t = absxk / scale;
    y += t * t;
  }

  return scale * sqrt(y);
}

/* Function for MATLAB Function: '<S1>/Tire Model' */
static void microcontroller_code_gene_pchip(const real_T x[7], const real_T y[7],
  const real_T xx[4], real_T v[4])
{
  __m128d tmp_2;
  real_T pp_coefs[24];
  real_T d_s[7];
  real_T del[6];
  real_T h[6];
  real_T dzzdx;
  real_T hs;
  real_T hs_tmp;
  int32_T k;
  for (k = 0; k <= 4; k += 2) {
    tmp_2 = _mm_sub_pd(_mm_loadu_pd(&x[k + 1]), _mm_loadu_pd(&x[k]));
    _mm_storeu_pd(&del[k], _mm_div_pd(_mm_sub_pd(_mm_loadu_pd(&y[k + 1]),
      _mm_loadu_pd(&y[k])), tmp_2));
    _mm_storeu_pd(&h[k], tmp_2);
  }

  for (k = 0; k < 5; k++) {
    real_T hs3;
    hs_tmp = h[k + 1];
    hs = hs_tmp + h[k];
    hs3 = 3.0 * hs;
    dzzdx = (h[k] + hs) / hs3;
    hs = (hs_tmp + hs) / hs3;
    d_s[k + 1] = 0.0;
    if (del[k] < 0.0) {
      hs_tmp = del[k + 1];
      if (hs_tmp <= del[k]) {
        d_s[k + 1] = del[k] / (del[k] / hs_tmp * dzzdx + hs);
      } else if (hs_tmp < 0.0) {
        d_s[k + 1] = hs_tmp / (hs_tmp / del[k] * hs + dzzdx);
      }
    } else if (del[k] > 0.0) {
      hs_tmp = del[k + 1];
      if (hs_tmp >= del[k]) {
        d_s[k + 1] = del[k] / (del[k] / hs_tmp * dzzdx + hs);
      } else if (hs_tmp > 0.0) {
        d_s[k + 1] = hs_tmp / (hs_tmp / del[k] * hs + dzzdx);
      }
    }
  }

  dzzdx = ((2.0 * h[0] + h[1]) * del[0] - h[0] * del[1]) / (h[0] + h[1]);
  if (del[0] < 0.0) {
    hs = -1.0;
  } else if (del[0] > 0.0) {
    hs = 1.0;
  } else if (del[0] == 0.0) {
    hs = 0.0;
  } else {
    hs = (rtNaN);
  }

  if (dzzdx < 0.0) {
    hs_tmp = -1.0;
  } else if (dzzdx > 0.0) {
    hs_tmp = 1.0;
  } else if (dzzdx == 0.0) {
    hs_tmp = 0.0;
  } else {
    hs_tmp = (rtNaN);
  }

  if (hs_tmp != hs) {
    dzzdx = 0.0;
  } else {
    if (del[1] < 0.0) {
      hs_tmp = -1.0;
    } else if (del[1] > 0.0) {
      hs_tmp = 1.0;
    } else if (del[1] == 0.0) {
      hs_tmp = 0.0;
    } else {
      hs_tmp = (rtNaN);
    }

    if ((hs != hs_tmp) && (fabs(dzzdx) > fabs(3.0 * del[0]))) {
      dzzdx = 3.0 * del[0];
    }
  }

  d_s[0] = dzzdx;
  dzzdx = ((2.0 * h[5] + h[4]) * del[5] - del[4] * h[5]) / (h[4] + h[5]);
  if (del[5] < 0.0) {
    hs = -1.0;
  } else if (del[5] > 0.0) {
    hs = 1.0;
  } else if (del[5] == 0.0) {
    hs = 0.0;
  } else {
    hs = (rtNaN);
  }

  if (dzzdx < 0.0) {
    hs_tmp = -1.0;
  } else if (dzzdx > 0.0) {
    hs_tmp = 1.0;
  } else if (dzzdx == 0.0) {
    hs_tmp = 0.0;
  } else {
    hs_tmp = (rtNaN);
  }

  if (hs_tmp != hs) {
    dzzdx = 0.0;
  } else {
    if (del[4] < 0.0) {
      hs_tmp = -1.0;
    } else if (del[4] > 0.0) {
      hs_tmp = 1.0;
    } else if (del[4] == 0.0) {
      hs_tmp = 0.0;
    } else {
      hs_tmp = (rtNaN);
    }

    if ((hs != hs_tmp) && (fabs(dzzdx) > fabs(3.0 * del[5]))) {
      dzzdx = 3.0 * del[5];
    }
  }

  d_s[6] = dzzdx;
  for (k = 0; k <= 4; k += 2) {
    __m128d tmp;
    __m128d tmp_0;
    __m128d tmp_1;
    tmp_2 = _mm_loadu_pd(&del[k]);
    tmp = _mm_loadu_pd(&d_s[k]);
    tmp_0 = _mm_loadu_pd(&h[k]);
    tmp = _mm_div_pd(_mm_sub_pd(tmp_2, tmp), tmp_0);
    tmp_1 = _mm_loadu_pd(&d_s[k + 1]);
    tmp_2 = _mm_div_pd(_mm_sub_pd(tmp_1, tmp_2), tmp_0);
    _mm_storeu_pd(&pp_coefs[k], _mm_div_pd(_mm_sub_pd(tmp_2, tmp), tmp_0));
    _mm_storeu_pd(&pp_coefs[k + 6], _mm_sub_pd(_mm_mul_pd(_mm_set1_pd(2.0), tmp),
      tmp_2));
    tmp_2 = _mm_loadu_pd(&d_s[k]);
    _mm_storeu_pd(&pp_coefs[k + 12], tmp_2);
    _mm_storeu_pd(&pp_coefs[k + 18], _mm_loadu_pd(&y[k]));
  }

  for (k = 0; k < 4; k++) {
    if (rtIsNaN(xx[k])) {
      v[k] = xx[k];
    } else {
      int32_T high_i;
      int32_T low_i;
      int32_T low_ip1;
      high_i = 7;
      low_i = 0;
      low_ip1 = 2;
      while (high_i > low_ip1) {
        int32_T mid_i;
        mid_i = ((low_i + high_i) + 1) >> 1;
        if (xx[k] >= x[mid_i - 1]) {
          low_i = mid_i - 1;
          low_ip1 = mid_i + 1;
        } else {
          high_i = mid_i;
        }
      }

      dzzdx = xx[k] - x[low_i];
      v[k] = ((dzzdx * pp_coefs[low_i] + pp_coefs[low_i + 6]) * dzzdx +
              pp_coefs[low_i + 12]) * dzzdx + pp_coefs[low_i + 18];
    }
  }
}

/* Model step function */
void microcontroller_code_generation_step(void)
{
  __m128d tmp_3;
  real_T pp_coefs[36];
  real_T c_s[10];
  real_T del[9];
  real_T h[9];
  real_T C[4];
  real_T max_current[4];
  real_T rtb_FY[4];
  real_T rtb_TmpSignalConversionAtSFun_0[2];
  real_T C_tmp;
  real_T C_tmp_0;
  real_T C_tmp_1;
  real_T C_tmp_2;
  real_T SA_fr;
  real_T SA_idx_0;
  real_T SA_idx_2;
  real_T SA_idx_3;
  real_T SL_idx_2;
  real_T a_bar_idx_0;
  real_T a_bar_idx_1;
  real_T a_bar_idx_2;
  real_T a_bar_tmp;
  real_T acker_steer_angles_idx_0;
  real_T acker_steer_angles_idx_1;
  real_T k_tmp;
  real_T k_tmp_tmp;
  real_T kx_idx_1;
  real_T kx_idx_2;
  real_T kx_idx_3;
  real_T left_steering_angle;
  real_T mu_x;
  real_T mu_x_0;
  real_T mu_x_1;
  real_T mu_x_2;
  real_T mu_x_tmp;
  real_T mu_x_tmp_tmp;
  real_T mu_y;
  real_T mu_y_0;
  real_T mu_y_1;
  real_T n_idx_0;
  real_T n_idx_1;
  real_T n_idx_2;
  real_T n_idx_3;
  real_T phi_fl;
  real_T phi_rl;
  real_T rack_displacement;
  real_T rtb_Fx_max_idx_0;
  real_T rtb_Fx_max_idx_1;
  real_T rtb_Fx_max_idx_2;
  real_T rtb_T_brake_idx_0;
  real_T rtb_T_brake_idx_1;
  real_T rtb_T_brake_idx_2;
  real_T rtb_T_brake_idx_3;
  real_T rtb_steering_idx_0;
  real_T rtb_steering_idx_1;
  real_T rtb_steering_idx_2;
  real_T x_tmp;
  int32_T high_i;
  int32_T low_i;
  int32_T low_ip1;
  real32_T c_x[5];
  real32_T lb_f[4];
  real32_T rtb_lb_idx_3;
  real32_T rtb_ub_idx_0;
  real32_T rtb_ub_idx_1;
  real32_T rtb_ub_idx_2;
  real32_T rtb_ub_idx_3;
  real32_T slip_limit_idx_0;
  real32_T slip_limit_idx_1;
  real32_T slip_limit_idx_2;
  real32_T slip_limit_idx_3;
  boolean_T exitg1;
  boolean_T tmp;

  /* MATLAB Function: '<S1>/Brake Model' incorporates:
   *  Constant: '<Root>/Constant'
   *  MATLAB Function: '<S1>/Reference Generation'
   *  MATLAB Function: '<S1>/Tire Model'
   */
  rtb_T_brake_idx_0 = 0.0;
  rtb_T_brake_idx_1 = 0.0;
  rtb_T_brake_idx_2 = 0.0;
  rtb_T_brake_idx_3 = 0.0;
  x_tmp = fabs(microcontroller_code_generati_P.Constant_Value);
  if (x_tmp > 5.0) {
    if (microcontroller_code_generati_P.Constant_Value < 0.0) {
      left_steering_angle = -1.0;
    } else if (microcontroller_code_generati_P.Constant_Value > 0.0) {
      left_steering_angle = 1.0;
    } else if (microcontroller_code_generati_P.Constant_Value == 0.0) {
      left_steering_angle = 0.0;
    } else {
      left_steering_angle = (rtNaN);
    }

    rtb_T_brake_idx_0 = -61.327819610128337 * left_steering_angle *
      microcontroller_code_generati_P.Constant_Value;
    rtb_T_brake_idx_1 = rtb_T_brake_idx_0;
    rtb_T_brake_idx_2 = -40.536598327799823 * left_steering_angle *
      microcontroller_code_generati_P.Constant_Value;
    rtb_T_brake_idx_3 = rtb_T_brake_idx_2;
  }

  /* End of MATLAB Function: '<S1>/Brake Model' */

  /* MATLAB Function: '<S1>/Steering Model' incorporates:
   *  Constant: '<Root>/Constant'
   */
  rack_displacement = microcontroller_code_generati_P.steer_slope *
    microcontroller_code_generati_P.inch2mm *
    microcontroller_code_generati_P.Constant_Value;
  left_steering_angle = -(((-rack_displacement * -rack_displacement *
    microcontroller_code_generati_P.S2 + microcontroller_code_generati_P.S1 *
    rt_powd_snf(-rack_displacement, 3.0)) + microcontroller_code_generati_P.S3 *
    -rack_displacement) + microcontroller_code_generati_P.S4) *
    microcontroller_code_generati_P.deg2rad;
  rack_displacement = (((rack_displacement * rack_displacement *
    microcontroller_code_generati_P.S2 + microcontroller_code_generati_P.S1 *
    rt_powd_snf(rack_displacement, 3.0)) + microcontroller_code_generati_P.S3 *
                        rack_displacement) + microcontroller_code_generati_P.S4)
    * microcontroller_code_generati_P.deg2rad;
  rtb_steering_idx_0 = (left_steering_angle + rack_displacement) / 2.0;
  rtb_steering_idx_1 = left_steering_angle;
  rtb_steering_idx_2 = rack_displacement;

  /* MATLAB Function: '<S1>/Tire Model' incorporates:
   *  Constant: '<Root>/Constant'
   *  Constant: '<Root>/Constant1'
   *  MATLAB Function: '<S1>/Normal Force Model'
   *  MATLAB Function: '<S1>/Steering Model'
   */
  acker_steer_angles_idx_0 = left_steering_angle;
  acker_steer_angles_idx_1 = rack_displacement;
  if (x_tmp > 0.1) {
    left_steering_angle = microcontroller_code_generati_P.s[0] *
      microcontroller_code_generati_P.Constant_Value;
    rack_displacement = microcontroller_code_generati_P.l[0] *
      microcontroller_code_generati_P.Constant_Value +
      microcontroller_code_generati_P.Constant_Value;
    phi_fl = rt_atan2d_snf(rack_displacement, left_steering_angle +
      microcontroller_code_generati_P.Constant_Value);
    left_steering_angle = rt_atan2d_snf(rack_displacement,
      microcontroller_code_generati_P.Constant_Value - left_steering_angle);
    n_idx_1 = microcontroller_code_generati_P.s[1] *
      microcontroller_code_generati_P.Constant_Value;
    rack_displacement = microcontroller_code_generati_P.Constant_Value -
      microcontroller_code_generati_P.l[1] *
      microcontroller_code_generati_P.Constant_Value;
    phi_rl = rt_atan2d_snf(rack_displacement, n_idx_1 +
      microcontroller_code_generati_P.Constant_Value);
    rack_displacement = rt_atan2d_snf(rack_displacement,
      microcontroller_code_generati_P.Constant_Value - n_idx_1);
  } else {
    phi_fl = 0.0;
    left_steering_angle = 0.0;
    phi_rl = 0.0;
    rack_displacement = 0.0;
  }

  phi_fl = -phi_fl + acker_steer_angles_idx_0;
  SA_fr = -left_steering_angle + acker_steer_angles_idx_1;
  SA_idx_0 = phi_fl;
  SA_idx_2 = -phi_rl;
  SA_idx_3 = -rack_displacement;
  rtb_TmpSignalConversionAtSFun_0[0] =
    microcontroller_code_generati_P.Constant_Value *
    microcontroller_code_generati_P.s[0] +
    microcontroller_code_generati_P.Constant_Value;
  acker_steer_angles_idx_0 = microcontroller_code_generati_P.Constant_Value *
    microcontroller_code_generati_P.l[0] +
    microcontroller_code_generati_P.Constant_Value;
  rtb_TmpSignalConversionAtSFun_0[1] = acker_steer_angles_idx_0;
  left_steering_angle = microcontroller_code_gener_norm
    (rtb_TmpSignalConversionAtSFun_0);
  mu_x_tmp = cos(phi_fl);
  if (fabs(left_steering_angle * mu_x_tmp) > 0.0) {
    acker_steer_angles_idx_1 = microcontroller_code_generati_P.RE *
      microcontroller_code_generati_P.Constant_Value;
    left_steering_angle = acker_steer_angles_idx_1 / (left_steering_angle *
      mu_x_tmp) - 1.0;
    rtb_TmpSignalConversionAtSFun_0[0] =
      microcontroller_code_generati_P.Constant_Value *
      -microcontroller_code_generati_P.s[0] +
      microcontroller_code_generati_P.Constant_Value;
    rtb_TmpSignalConversionAtSFun_0[1] = acker_steer_angles_idx_0;
    phi_fl = acker_steer_angles_idx_1 / (microcontroller_code_gener_norm
      (rtb_TmpSignalConversionAtSFun_0) * cos(SA_fr)) - 1.0;
    rtb_TmpSignalConversionAtSFun_0[0] =
      microcontroller_code_generati_P.Constant_Value *
      microcontroller_code_generati_P.s[1] +
      microcontroller_code_generati_P.Constant_Value;
    acker_steer_angles_idx_0 = microcontroller_code_generati_P.Constant_Value *
      -microcontroller_code_generati_P.l[1] +
      microcontroller_code_generati_P.Constant_Value;
    rtb_TmpSignalConversionAtSFun_0[1] = acker_steer_angles_idx_0;
    phi_rl = acker_steer_angles_idx_1 / (microcontroller_code_gener_norm
      (rtb_TmpSignalConversionAtSFun_0) * cos(-phi_rl)) - 1.0;
    rtb_TmpSignalConversionAtSFun_0[0] =
      microcontroller_code_generati_P.Constant_Value *
      -microcontroller_code_generati_P.s[1] +
      microcontroller_code_generati_P.Constant_Value;
    rtb_TmpSignalConversionAtSFun_0[1] = acker_steer_angles_idx_0;
    rack_displacement = acker_steer_angles_idx_1 /
      (microcontroller_code_gener_norm(rtb_TmpSignalConversionAtSFun_0) * cos
       (-rack_displacement)) - 1.0;
  } else {
    left_steering_angle = 0.0;
    phi_fl = 0.0;
    phi_rl = 0.0;
    rack_displacement = 0.0;
  }

  acker_steer_angles_idx_1 = microcontroller_code_generati_P.A1 *
    microcontroller_code_generati_P.Constant1_Value[0] +
    microcontroller_code_generati_P.A2;
  max_current[0] = fabs(microcontroller_code_generati_P.Constant1_Value[0]);
  acker_steer_angles_idx_0 = microcontroller_code_generati_P.Constant1_Value[0] *
    microcontroller_code_generati_P.Constant1_Value[0];
  mu_x = (acker_steer_angles_idx_0 * microcontroller_code_generati_P.B1 +
          microcontroller_code_generati_P.B2 *
          microcontroller_code_generati_P.Constant1_Value[0]) +
    microcontroller_code_generati_P.B3;
  kx_idx_1 = microcontroller_code_generati_P.A1 *
    microcontroller_code_generati_P.Constant1_Value[1] +
    microcontroller_code_generati_P.A2;
  max_current[1] = fabs(microcontroller_code_generati_P.Constant1_Value[1]);
  n_idx_2 = microcontroller_code_generati_P.Constant1_Value[1] *
    microcontroller_code_generati_P.Constant1_Value[1];
  mu_x_0 = (n_idx_2 * microcontroller_code_generati_P.B1 +
            microcontroller_code_generati_P.B2 *
            microcontroller_code_generati_P.Constant1_Value[1]) +
    microcontroller_code_generati_P.B3;
  kx_idx_2 = microcontroller_code_generati_P.A1 *
    microcontroller_code_generati_P.Constant1_Value[2] +
    microcontroller_code_generati_P.A2;
  max_current[2] = fabs(microcontroller_code_generati_P.Constant1_Value[2]);
  rtb_Fx_max_idx_2 = microcontroller_code_generati_P.Constant1_Value[2] *
    microcontroller_code_generati_P.Constant1_Value[2];
  mu_x_1 = (rtb_Fx_max_idx_2 * microcontroller_code_generati_P.B1 +
            microcontroller_code_generati_P.B2 *
            microcontroller_code_generati_P.Constant1_Value[2]) +
    microcontroller_code_generati_P.B3;
  kx_idx_3 = microcontroller_code_generati_P.A1 *
    microcontroller_code_generati_P.Constant1_Value[3] +
    microcontroller_code_generati_P.A2;
  max_current[3] = fabs(microcontroller_code_generati_P.Constant1_Value[3]);
  mu_x_tmp = microcontroller_code_generati_P.Constant1_Value[3] *
    microcontroller_code_generati_P.Constant1_Value[3];
  mu_x_2 = (mu_x_tmp * microcontroller_code_generati_P.B1 +
            microcontroller_code_generati_P.B2 *
            microcontroller_code_generati_P.Constant1_Value[3]) +
    microcontroller_code_generati_P.B3;
  microcontroller_code_gene_pchip(microcontroller_code_generati_P.FZ_C,
    microcontroller_code_generati_P.C_param, max_current, C);
  mu_y = ((acker_steer_angles_idx_0 * microcontroller_code_generati_P.C2 +
           microcontroller_code_generati_P.C1 * rt_powd_snf
           (microcontroller_code_generati_P.Constant1_Value[0], 3.0)) +
          microcontroller_code_generati_P.C3 *
          microcontroller_code_generati_P.Constant1_Value[0]) +
    microcontroller_code_generati_P.C4;
  acker_steer_angles_idx_0 = mu_x *
    microcontroller_code_generati_P.Constant1_Value[0];
  n_idx_1 = acker_steer_angles_idx_1 * left_steering_angle /
    acker_steer_angles_idx_0;
  rtb_Fx_max_idx_0 = acker_steer_angles_idx_0;
  mu_y_0 = ((n_idx_2 * microcontroller_code_generati_P.C2 +
             microcontroller_code_generati_P.C1 * rt_powd_snf
             (microcontroller_code_generati_P.Constant1_Value[1], 3.0)) +
            microcontroller_code_generati_P.C3 *
            microcontroller_code_generati_P.Constant1_Value[1]) +
    microcontroller_code_generati_P.C4;
  acker_steer_angles_idx_0 = mu_x_0 *
    microcontroller_code_generati_P.Constant1_Value[1];
  n_idx_2 = kx_idx_1 * phi_fl / acker_steer_angles_idx_0;
  rtb_Fx_max_idx_1 = acker_steer_angles_idx_0;
  SL_idx_2 = ((rtb_Fx_max_idx_2 * microcontroller_code_generati_P.C2 +
               microcontroller_code_generati_P.C1 * rt_powd_snf
               (microcontroller_code_generati_P.Constant1_Value[2], 3.0)) +
              microcontroller_code_generati_P.C3 *
              microcontroller_code_generati_P.Constant1_Value[2]) +
    microcontroller_code_generati_P.C4;
  acker_steer_angles_idx_0 = mu_x_1 *
    microcontroller_code_generati_P.Constant1_Value[2];
  n_idx_3 = kx_idx_2 * phi_rl / acker_steer_angles_idx_0;
  rtb_Fx_max_idx_2 = acker_steer_angles_idx_0;
  mu_y_1 = ((mu_x_tmp * microcontroller_code_generati_P.C2 +
             microcontroller_code_generati_P.C1 * rt_powd_snf
             (microcontroller_code_generati_P.Constant1_Value[3], 3.0)) +
            microcontroller_code_generati_P.C3 *
            microcontroller_code_generati_P.Constant1_Value[3]) +
    microcontroller_code_generati_P.C4;
  acker_steer_angles_idx_0 = mu_x_2 *
    microcontroller_code_generati_P.Constant1_Value[3];
  mu_x_tmp = kx_idx_3 * rack_displacement / acker_steer_angles_idx_0;
  a_bar_tmp = tan(SA_idx_0);
  SA_idx_0 = C[0] * a_bar_tmp / (mu_y *
    microcontroller_code_generati_P.Constant1_Value[0]);
  C_tmp = C[0] * mu_x / (acker_steer_angles_idx_1 * mu_y);
  n_idx_0 = 1.0;
  a_bar_idx_0 = SA_idx_0;
  max_current[0] = sqrt(n_idx_1 * n_idx_1 + SA_idx_0 * SA_idx_0);
  SA_fr = tan(SA_fr);
  SA_idx_0 = C[1] * SA_fr / (mu_y_0 *
    microcontroller_code_generati_P.Constant1_Value[1]);
  C_tmp_0 = C[1] * mu_x_0 / (kx_idx_1 * mu_y_0);
  n_idx_1 = 1.0;
  a_bar_idx_1 = SA_idx_0;
  max_current[1] = sqrt(n_idx_2 * n_idx_2 + SA_idx_0 * SA_idx_0);
  SA_idx_2 = tan(SA_idx_2);
  SA_idx_0 = C[2] * SA_idx_2 / (SL_idx_2 *
    microcontroller_code_generati_P.Constant1_Value[2]);
  C_tmp_1 = C[2] * mu_x_1 / (kx_idx_2 * SL_idx_2);
  n_idx_2 = 1.0;
  a_bar_idx_2 = SA_idx_0;
  max_current[2] = sqrt(n_idx_3 * n_idx_3 + SA_idx_0 * SA_idx_0);
  SA_idx_3 = tan(SA_idx_3);
  SA_idx_0 = C[3] * SA_idx_3 / (mu_y_1 *
    microcontroller_code_generati_P.Constant1_Value[3]);
  C_tmp_2 = C[3] * mu_x_2 / (kx_idx_3 * mu_y_1);
  k_tmp_tmp = SA_idx_0 * SA_idx_0;
  k_tmp = sqrt(mu_x_tmp * mu_x_tmp + k_tmp_tmp);
  n_idx_3 = 1.0;
  max_current[3] = k_tmp;
  for (low_i = 0; low_i < 4; low_i++) {
    if (fabs(max_current[low_i]) <= 6.2831853071795862) {
      n_idx_0 = (C_tmp + 1.0) * 0.5 - cos(max_current[0] / 2.0) * 0.5 * (1.0 -
        C_tmp);
      n_idx_1 = (C_tmp_0 + 1.0) * 0.5 - cos(max_current[1] / 2.0) * 0.5 * (1.0 -
        C_tmp_0);
      n_idx_2 = (C_tmp_1 + 1.0) * 0.5 - cos(max_current[2] / 2.0) * 0.5 * (1.0 -
        C_tmp_1);
      n_idx_3 = (C_tmp_2 + 1.0) * 0.5 - cos(k_tmp / 2.0) * 0.5 * (1.0 - C_tmp_2);
    }

    rtb_FY[low_i] = 0.0;
    C[low_i] = exp(microcontroller_code_generati_P.b * max_current[low_i]) *
      microcontroller_code_generati_P.a + exp(microcontroller_code_generati_P.d *
      max_current[low_i]) * microcontroller_code_generati_P.c;
  }

  mu_x_tmp_tmp = a_bar_tmp * a_bar_tmp;
  mu_x_tmp = sqrt(n_idx_0 * n_idx_0 * mu_x_tmp_tmp + left_steering_angle *
                  left_steering_angle);
  if (fabs(mu_x_tmp) < 0.001) {
    rtb_TmpSignalConversionAtSFun_0[0] =
      microcontroller_code_generati_P.Constant_Value;
    rtb_TmpSignalConversionAtSFun_0[1] =
      microcontroller_code_generati_P.Constant_Value;
    if (microcontroller_code_gener_norm(rtb_TmpSignalConversionAtSFun_0) < 3.0)
    {
    } else {
      rtb_FY[0] = n_idx_0 * C[0] * a_bar_tmp * mu_y *
        microcontroller_code_generati_P.Constant1_Value[0] / mu_x_tmp;
    }
  } else {
    rtb_FY[0] = n_idx_0 * C[0] * a_bar_tmp * mu_y *
      microcontroller_code_generati_P.Constant1_Value[0] / mu_x_tmp;
  }

  left_steering_angle = SA_fr * SA_fr;
  mu_x_tmp = sqrt(n_idx_1 * n_idx_1 * left_steering_angle + phi_fl * phi_fl);
  if (fabs(mu_x_tmp) < 0.001) {
    rtb_TmpSignalConversionAtSFun_0[0] =
      microcontroller_code_generati_P.Constant_Value;
    rtb_TmpSignalConversionAtSFun_0[1] =
      microcontroller_code_generati_P.Constant_Value;
    if (microcontroller_code_gener_norm(rtb_TmpSignalConversionAtSFun_0) < 3.0)
    {
    } else {
      rtb_FY[1] = n_idx_1 * C[1] * SA_fr * mu_y_0 *
        microcontroller_code_generati_P.Constant1_Value[1] / mu_x_tmp;
    }
  } else {
    rtb_FY[1] = n_idx_1 * C[1] * SA_fr * mu_y_0 *
      microcontroller_code_generati_P.Constant1_Value[1] / mu_x_tmp;
  }

  phi_fl = SA_idx_2 * SA_idx_2;
  mu_x_tmp = sqrt(n_idx_2 * n_idx_2 * phi_fl + phi_rl * phi_rl);
  if (fabs(mu_x_tmp) < 0.001) {
    rtb_TmpSignalConversionAtSFun_0[0] =
      microcontroller_code_generati_P.Constant_Value;
    rtb_TmpSignalConversionAtSFun_0[1] =
      microcontroller_code_generati_P.Constant_Value;
    if (microcontroller_code_gener_norm(rtb_TmpSignalConversionAtSFun_0) < 3.0)
    {
    } else {
      rtb_FY[2] = n_idx_2 * C[2] * SA_idx_2 * SL_idx_2 *
        microcontroller_code_generati_P.Constant1_Value[2] / mu_x_tmp;
    }
  } else {
    rtb_FY[2] = n_idx_2 * C[2] * SA_idx_2 * SL_idx_2 *
      microcontroller_code_generati_P.Constant1_Value[2] / mu_x_tmp;
  }

  a_bar_tmp = SA_idx_3 * SA_idx_3;
  mu_x_tmp = sqrt(n_idx_3 * n_idx_3 * a_bar_tmp + rack_displacement *
                  rack_displacement);
  if (fabs(mu_x_tmp) < 0.001) {
    rtb_TmpSignalConversionAtSFun_0[0] =
      microcontroller_code_generati_P.Constant_Value;
    rtb_TmpSignalConversionAtSFun_0[1] =
      microcontroller_code_generati_P.Constant_Value;
    if (microcontroller_code_gener_norm(rtb_TmpSignalConversionAtSFun_0) < 3.0)
    {
    } else {
      rtb_FY[3] = n_idx_3 * C[3] * SA_idx_3 * mu_y_1 *
        microcontroller_code_generati_P.Constant1_Value[3] / mu_x_tmp;
    }
  } else {
    rtb_FY[3] = n_idx_3 * C[3] * SA_idx_3 * mu_y_1 *
      microcontroller_code_generati_P.Constant1_Value[3] / mu_x_tmp;
  }

  n_idx_1 = 1.0;
  n_idx_2 = 1.0;
  n_idx_3 = 1.0;
  mu_x_tmp = 1.0;
  if (fabs(k_tmp) <= 6.2831853071795862) {
    mu_x_tmp = cos(microcontroller_code_generati_P.k_limit / 2.0) * 0.5;
    n_idx_1 = (C_tmp + 1.0) * 0.5 - (1.0 - C_tmp) * mu_x_tmp;
    n_idx_2 = (C_tmp_0 + 1.0) * 0.5 - (1.0 - C_tmp_0) * mu_x_tmp;
    n_idx_3 = (C_tmp_1 + 1.0) * 0.5 - (1.0 - C_tmp_1) * mu_x_tmp;
    mu_x_tmp = (C_tmp_2 + 1.0) * 0.5 - (1.0 - C_tmp_2) * mu_x_tmp;
  }

  mu_y = 0.0;
  if (microcontroller_code_generati_P.k_limit > fabs(a_bar_idx_0)) {
    mu_y = sqrt(microcontroller_code_generati_P.k_limit *
                microcontroller_code_generati_P.k_limit - a_bar_idx_0 *
                a_bar_idx_0);
  }

  mu_y = mu_y * mu_x * microcontroller_code_generati_P.Constant1_Value[0] /
    acker_steer_angles_idx_1;
  mu_x = exp(microcontroller_code_generati_P.b *
             microcontroller_code_generati_P.k_limit) *
    microcontroller_code_generati_P.a + exp(microcontroller_code_generati_P.d *
    microcontroller_code_generati_P.k_limit) * microcontroller_code_generati_P.c;
  acker_steer_angles_idx_1 = mu_x * rtb_Fx_max_idx_0 * mu_y / sqrt(n_idx_1 *
    n_idx_1 * mu_x_tmp_tmp + mu_y * mu_y);
  mu_y = 0.0;
  if (microcontroller_code_generati_P.k_limit > fabs(a_bar_idx_1)) {
    mu_y = sqrt(microcontroller_code_generati_P.k_limit *
                microcontroller_code_generati_P.k_limit - a_bar_idx_1 *
                a_bar_idx_1);
  }

  mu_y = mu_y * mu_x_0 * microcontroller_code_generati_P.Constant1_Value[1] /
    kx_idx_1;
  kx_idx_1 = mu_x * rtb_Fx_max_idx_1 * mu_y / sqrt(n_idx_2 * n_idx_2 *
    left_steering_angle + mu_y * mu_y);
  mu_y = 0.0;
  if (microcontroller_code_generati_P.k_limit > fabs(a_bar_idx_2)) {
    mu_y = sqrt(microcontroller_code_generati_P.k_limit *
                microcontroller_code_generati_P.k_limit - a_bar_idx_2 *
                a_bar_idx_2);
  }

  mu_y = mu_y * mu_x_1 * microcontroller_code_generati_P.Constant1_Value[2] /
    kx_idx_2;
  kx_idx_2 = mu_x * rtb_Fx_max_idx_2 * mu_y / sqrt(n_idx_3 * n_idx_3 * phi_fl +
    mu_y * mu_y);
  mu_y = 0.0;
  if (microcontroller_code_generati_P.k_limit > fabs(SA_idx_0)) {
    mu_y = sqrt(microcontroller_code_generati_P.k_limit *
                microcontroller_code_generati_P.k_limit - k_tmp_tmp);
  }

  mu_y = mu_y * mu_x_2 * microcontroller_code_generati_P.Constant1_Value[3] /
    kx_idx_3;

  /* MATLAB Function: '<S1>/Reference Generation' */
  rack_displacement = 3.3121686421112381E-170;
  if (x_tmp > 3.3121686421112381E-170) {
    left_steering_angle = 1.0;
    rack_displacement = x_tmp;
  } else {
    phi_fl = x_tmp / 3.3121686421112381E-170;
    left_steering_angle = phi_fl * phi_fl;
  }

  if (x_tmp > rack_displacement) {
    phi_fl = rack_displacement / x_tmp;
    left_steering_angle = left_steering_angle * phi_fl * phi_fl + 1.0;
    rack_displacement = x_tmp;
  } else {
    phi_fl = x_tmp / rack_displacement;
    left_steering_angle += phi_fl * phi_fl;
  }

  left_steering_angle = rack_displacement * sqrt(left_steering_angle);
  for (low_ip1 = 0; low_ip1 <= 6; low_ip1 += 2) {
    /* MATLAB Function: '<S1>/Reference Generation' */
    tmp_3 = _mm_sub_pd(_mm_loadu_pd
                       (&microcontroller_code_generati_P.V_target[low_ip1 + 1]),
                       _mm_loadu_pd
                       (&microcontroller_code_generati_P.V_target[low_ip1]));
    _mm_storeu_pd(&del[low_ip1], _mm_div_pd(_mm_sub_pd(_mm_loadu_pd
      (&microcontroller_code_generati_P.max_yaw_field[low_ip1 + 1]),
      _mm_loadu_pd(&microcontroller_code_generati_P.max_yaw_field[low_ip1])),
      tmp_3));
    _mm_storeu_pd(&h[low_ip1], tmp_3);
  }

  /* MATLAB Function: '<S1>/Reference Generation' */
  for (low_ip1 = 8; low_ip1 < 9; low_ip1++) {
    phi_fl = microcontroller_code_generati_P.V_target[low_ip1 + 1] -
      microcontroller_code_generati_P.V_target[low_ip1];
    del[low_ip1] = (microcontroller_code_generati_P.max_yaw_field[low_ip1 + 1] -
                    microcontroller_code_generati_P.max_yaw_field[low_ip1]) /
      phi_fl;
    h[low_ip1] = phi_fl;
  }

  for (low_ip1 = 0; low_ip1 < 8; low_ip1++) {
    n_idx_1 = h[low_ip1 + 1];
    phi_rl = n_idx_1 + h[low_ip1];
    phi_fl = 3.0 * phi_rl;
    rack_displacement = (h[low_ip1] + phi_rl) / phi_fl;
    phi_rl = (n_idx_1 + phi_rl) / phi_fl;
    c_s[low_ip1 + 1] = 0.0;
    if (del[low_ip1] < 0.0) {
      x_tmp = del[low_ip1 + 1];
      if (x_tmp <= del[low_ip1]) {
        c_s[low_ip1 + 1] = del[low_ip1] / (del[low_ip1] / x_tmp *
          rack_displacement + phi_rl);
      } else if (x_tmp < 0.0) {
        c_s[low_ip1 + 1] = x_tmp / (x_tmp / del[low_ip1] * phi_rl +
          rack_displacement);
      }
    } else if (del[low_ip1] > 0.0) {
      x_tmp = del[low_ip1 + 1];
      if (x_tmp >= del[low_ip1]) {
        c_s[low_ip1 + 1] = del[low_ip1] / (del[low_ip1] / x_tmp *
          rack_displacement + phi_rl);
      } else if (x_tmp > 0.0) {
        c_s[low_ip1 + 1] = x_tmp / (x_tmp / del[low_ip1] * phi_rl +
          rack_displacement);
      }
    }
  }

  rack_displacement = ((2.0 * h[0] + h[1]) * del[0] - h[0] * del[1]) / (h[0] +
    h[1]);
  if (del[0] < 0.0) {
    phi_rl = -1.0;
  } else if (del[0] > 0.0) {
    phi_rl = 1.0;
  } else if (del[0] == 0.0) {
    phi_rl = 0.0;
  } else {
    phi_rl = (rtNaN);
  }

  if (rack_displacement < 0.0) {
    phi_fl = -1.0;
  } else if (rack_displacement > 0.0) {
    phi_fl = 1.0;
  } else if (rack_displacement == 0.0) {
    phi_fl = 0.0;
  } else {
    phi_fl = (rtNaN);
  }

  if (phi_fl != phi_rl) {
    rack_displacement = 0.0;
  } else {
    if (del[1] < 0.0) {
      n_idx_1 = -1.0;
    } else if (del[1] > 0.0) {
      n_idx_1 = 1.0;
    } else if (del[1] == 0.0) {
      n_idx_1 = 0.0;
    } else {
      n_idx_1 = (rtNaN);
    }

    if ((phi_rl != n_idx_1) && (fabs(rack_displacement) > fabs(3.0 * del[0]))) {
      rack_displacement = 3.0 * del[0];
    }
  }

  c_s[0] = rack_displacement;
  rack_displacement = ((2.0 * h[8] + h[7]) * del[8] - del[7] * h[8]) / (h[7] +
    h[8]);
  if (del[8] < 0.0) {
    phi_rl = -1.0;
  } else if (del[8] > 0.0) {
    phi_rl = 1.0;
  } else if (del[8] == 0.0) {
    phi_rl = 0.0;
  } else {
    phi_rl = (rtNaN);
  }

  if (rack_displacement < 0.0) {
    phi_fl = -1.0;
  } else if (rack_displacement > 0.0) {
    phi_fl = 1.0;
  } else if (rack_displacement == 0.0) {
    phi_fl = 0.0;
  } else {
    phi_fl = (rtNaN);
  }

  if (phi_fl != phi_rl) {
    rack_displacement = 0.0;
  } else {
    if (del[7] < 0.0) {
      n_idx_1 = -1.0;
    } else if (del[7] > 0.0) {
      n_idx_1 = 1.0;
    } else if (del[7] == 0.0) {
      n_idx_1 = 0.0;
    } else {
      n_idx_1 = (rtNaN);
    }

    if ((phi_rl != n_idx_1) && (fabs(rack_displacement) > fabs(3.0 * del[8]))) {
      rack_displacement = 3.0 * del[8];
    }
  }

  c_s[9] = rack_displacement;
  for (low_i = 0; low_i <= 6; low_i += 2) {
    __m128d tmp_0;
    __m128d tmp_1;
    __m128d tmp_2;

    /* MATLAB Function: '<S1>/Reference Generation' */
    tmp_3 = _mm_loadu_pd(&del[low_i]);
    tmp_0 = _mm_loadu_pd(&c_s[low_i]);
    tmp_1 = _mm_loadu_pd(&h[low_i]);
    tmp_0 = _mm_div_pd(_mm_sub_pd(tmp_3, tmp_0), tmp_1);

    /* MATLAB Function: '<S1>/Reference Generation' */
    tmp_2 = _mm_loadu_pd(&c_s[low_i + 1]);
    tmp_3 = _mm_div_pd(_mm_sub_pd(tmp_2, tmp_3), tmp_1);

    /* MATLAB Function: '<S1>/Reference Generation' */
    _mm_storeu_pd(&pp_coefs[low_i], _mm_div_pd(_mm_sub_pd(tmp_3, tmp_0), tmp_1));
    _mm_storeu_pd(&pp_coefs[low_i + 9], _mm_sub_pd(_mm_mul_pd(_mm_set1_pd(2.0),
      tmp_0), tmp_3));
    tmp_3 = _mm_loadu_pd(&c_s[low_i]);
    _mm_storeu_pd(&pp_coefs[low_i + 18], tmp_3);
    _mm_storeu_pd(&pp_coefs[low_i + 27], _mm_loadu_pd
                  (&microcontroller_code_generati_P.max_yaw_field[low_i]));
  }

  /* MATLAB Function: '<S1>/Reference Generation' */
  for (low_i = 8; low_i < 9; low_i++) {
    phi_fl = h[low_i];
    n_idx_1 = del[low_i];
    rack_displacement = (n_idx_1 - c_s[low_i]) / phi_fl;
    phi_rl = (c_s[low_i + 1] - n_idx_1) / phi_fl;
    pp_coefs[low_i] = (phi_rl - rack_displacement) / phi_fl;
    pp_coefs[low_i + 9] = 2.0 * rack_displacement - phi_rl;
    pp_coefs[low_i + 18] = c_s[low_i];
    pp_coefs[low_i + 27] = microcontroller_code_generati_P.max_yaw_field[low_i];
  }

  if (rtIsNaN(left_steering_angle)) {
    rack_displacement = left_steering_angle;
  } else {
    low_i = 0;
    low_ip1 = 2;
    high_i = 10;
    while (high_i > low_ip1) {
      int32_T mid_i;
      mid_i = ((low_i + high_i) + 1) >> 1;
      if (left_steering_angle >= microcontroller_code_generati_P.V_target[mid_i
          - 1]) {
        low_i = mid_i - 1;
        low_ip1 = mid_i + 1;
      } else {
        high_i = mid_i;
      }
    }

    phi_rl = left_steering_angle -
      microcontroller_code_generati_P.V_target[low_i];
    rack_displacement = ((phi_rl * pp_coefs[low_i] + pp_coefs[low_i + 9]) *
                         phi_rl + pp_coefs[low_i + 18]) * phi_rl +
      pp_coefs[low_i + 27];
  }

  left_steering_angle = left_steering_angle * rtb_steering_idx_0 /
    (left_steering_angle * left_steering_angle *
     microcontroller_code_generati_P.Ku + (microcontroller_code_generati_P.l[0]
      + microcontroller_code_generati_P.l[1]));
  if (left_steering_angle == 0.0) {
    left_steering_angle = 0.0;
  } else {
    phi_rl = fabs(left_steering_angle);
    rack_displacement = fabs(rack_displacement);
    if ((phi_rl > rack_displacement) || (rtIsNaN(phi_rl) && (!rtIsNaN
          (rack_displacement)))) {
    } else {
      rack_displacement = phi_rl;
    }

    if (left_steering_angle < 0.0) {
      left_steering_angle = -1.0;
    } else if (left_steering_angle > 0.0) {
      left_steering_angle = 1.0;
    } else if (left_steering_angle == 0.0) {
      left_steering_angle = 0.0;
    } else {
      left_steering_angle = (rtNaN);
    }

    left_steering_angle *= rack_displacement;
  }

  /* Sum: '<S5>/Sum1' incorporates:
   *  Constant: '<Root>/Constant'
   */
  left_steering_angle -= microcontroller_code_generati_P.Constant_Value;

  /* UnitDelay: '<S1>/Unit Delay4' */
  rack_displacement = microcontroller_code_generat_DW.UnitDelay4_DSTATE;

  /* DiscreteIntegrator: '<S5>/Discrete-Time Integrator' incorporates:
   *  UnitDelay: '<S1>/Unit Delay4'
   */
  if ((microcontroller_code_generat_DW.UnitDelay4_DSTATE <= 0.0) &&
      (microcontroller_code_generat_DW.DiscreteTimeIntegrator_PrevRese == 1)) {
    microcontroller_code_generat_DW.DiscreteTimeIntegrator_DSTATE =
      microcontroller_code_generati_P.DiscreteTimeIntegrator_IC;
  }

  /* DiscreteIntegrator: '<S5>/Discrete-Time Integrator' incorporates:
   *  Gain: '<S5>/I'
   *  Product: '<S5>/Product'
   *  UnitDelay: '<S1>/Unit Delay'
   */
  phi_rl = microcontroller_code_generati_P.I * left_steering_angle *
    microcontroller_code_generat_DW.UnitDelay_DSTATE *
    microcontroller_code_generati_P.DiscreteTimeIntegrator_gainval +
    microcontroller_code_generat_DW.DiscreteTimeIntegrator_DSTATE;

  /* DiscreteIntegrator: '<S5>/Discrete-Time Integrator2' incorporates:
   *  UnitDelay: '<S1>/Unit Delay4'
   */
  if ((microcontroller_code_generat_DW.UnitDelay4_DSTATE <= 0.0) &&
      (microcontroller_code_generat_DW.DiscreteTimeIntegrator2_PrevRes == 1)) {
    microcontroller_code_generat_DW.DiscreteTimeIntegrator2_DSTATE =
      microcontroller_code_generati_P.DiscreteTimeIntegrator2_IC;
  }

  /* DiscreteIntegrator: '<S5>/Discrete-Time Integrator2' incorporates:
   *  Constant: '<Root>/Constant'
   *  Gain: '<S5>/T'
   *  Product: '<S5>/Product1'
   *  Sum: '<S5>/Sum5'
   *  UnitDelay: '<S1>/Unit Delay'
   *  UnitDelay: '<S1>/Unit Delay1'
   */
  phi_fl = (microcontroller_code_generat_DW.UnitDelay1_DSTATE -
            microcontroller_code_generati_P.Constant_Value) *
    microcontroller_code_generati_P.T *
    microcontroller_code_generat_DW.UnitDelay_DSTATE *
    microcontroller_code_generati_P.DiscreteTimeIntegrator2_gainval +
    microcontroller_code_generat_DW.DiscreteTimeIntegrator2_DSTATE;

  /* Sum: '<S5>/Sum7' incorporates:
   *  Gain: '<S5>/P'
   *  Product: '<S5>/Product2'
   *  Sum: '<S5>/Sum'
   *  UnitDelay: '<S1>/Unit Delay4'
   */
  SA_fr = (microcontroller_code_generati_P.P * left_steering_angle *
           microcontroller_code_generat_DW.UnitDelay4_DSTATE + phi_rl) + phi_fl;

  /* MATLAB Function: '<S1>/Constraint Generation' incorporates:
   *  Constant: '<Root>/Constant'
   *  MATLAB Function: '<S1>/Tire Model'
   *  UnitDelay: '<S1>/Unit Delay3'
   */
  left_steering_angle = sin(rtb_steering_idx_1);
  rtb_steering_idx_0 = cos(rtb_steering_idx_1);
  rtb_steering_idx_1 = sin(rtb_steering_idx_2);
  x_tmp = cos(rtb_steering_idx_2);
  n_idx_1 = microcontroller_code_generati_P.s[0] * rtb_steering_idx_0 +
    microcontroller_code_generati_P.l[0] * left_steering_angle;
  n_idx_2 = -microcontroller_code_generati_P.s[0] * x_tmp +
    microcontroller_code_generati_P.l[0] * rtb_steering_idx_1;
  rtb_steering_idx_2 = exp(-microcontroller_code_generati_P.t /
    microcontroller_code_generati_P.tau);
  slip_limit_idx_0 = (real32_T)(acker_steer_angles_idx_1 - rtb_T_brake_idx_0 /
    microcontroller_code_generati_P.RE) / microcontroller_code_generati_P.T2F[0];
  mu_x_2 = microcontroller_code_generati_P.Constant_Value *
    microcontroller_code_generati_P.gr[0];
  mu_x_1 = microcontroller_code_generati_P.motor_limit_power[0] *
    microcontroller_code_generati_P.motor_efficiency[0] / mu_x_2;
  if (mu_x_1 > 25.0) {
    mu_x_1 = 25.0;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 >
              microcontroller_code_generati_P.min_speed_regen)) {
    mu_x_1 = -25.0;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 > 0.0)) {
    mu_x_1 = -0.01;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 < 0.0)) {
    mu_x_1 = 25.0;
  }

  mu_y_0 = mu_x_2 * 9.5492965964254;
  if (mu_y_0 < 7000.0) {
    mu_y_0 = 70.0;
  } else {
    mu_y_0 = (66.353 - sqrt(4402.7206089999991 - (10452.0 - mu_y_0) * 1.0668)) *
      1.8747656542932134;
  }

  mu_y_0 = ((mu_y_0 * mu_y_0 * -0.0987 + 45.799 * mu_y_0) + -129.65) / 100.0;
  if (mu_y_0 < 0.0) {
    mu_y_0 = 0.0;
  }

  mu_x_0 = microcontroller_code_generati_P.Constant_Value * rtb_steering_idx_2;
  SA_idx_3 = (1.0 - rtb_steering_idx_2) *
    microcontroller_code_generati_P.motor_limit_torque[1] + mu_x_0;
  acker_steer_angles_idx_1 = SA_idx_3;
  if (rtIsNaN(mu_x_0 + 0.01)) {
    tmp = false;
  } else if (rtIsNaN(SA_idx_3)) {
    tmp = true;
  } else {
    tmp = (SA_idx_3 < mu_x_0 + 0.01);
  }

  if (tmp) {
    acker_steer_angles_idx_1 = mu_x_0 + 0.01;
  }

  rtb_steering_idx_2 = (1.0 - rtb_steering_idx_2) *
    microcontroller_code_generati_P.motor_limit_torque[0] + mu_x_0;
  rtb_Fx_max_idx_0 = rtb_steering_idx_2;
  rtb_T_brake_idx_0 = mu_x_2;
  SA_idx_0 = mu_x_1;
  C[0] = mu_y_0;
  slip_limit_idx_1 = (real32_T)(kx_idx_1 - rtb_T_brake_idx_1 /
    microcontroller_code_generati_P.RE) / microcontroller_code_generati_P.T2F[1];
  mu_x_2 = microcontroller_code_generati_P.Constant_Value *
    microcontroller_code_generati_P.gr[1];
  mu_x_1 = microcontroller_code_generati_P.motor_limit_power[1] *
    microcontroller_code_generati_P.motor_efficiency[1] / mu_x_2;
  if (mu_x_1 > 25.0) {
    mu_x_1 = 25.0;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 >
              microcontroller_code_generati_P.min_speed_regen)) {
    mu_x_1 = -25.0;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 > 0.0)) {
    mu_x_1 = -0.01;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 < 0.0)) {
    mu_x_1 = 25.0;
  }

  mu_y_0 = mu_x_2 * 9.5492965964254;
  if (mu_y_0 < 7000.0) {
    mu_y_0 = 70.0;
  } else {
    mu_y_0 = (66.353 - sqrt(4402.7206089999991 - (10452.0 - mu_y_0) * 1.0668)) *
      1.8747656542932134;
  }

  mu_y_0 = ((mu_y_0 * mu_y_0 * -0.0987 + 45.799 * mu_y_0) + -129.65) / 100.0;
  if (mu_y_0 < 0.0) {
    mu_y_0 = 0.0;
  }

  kx_idx_1 = SA_idx_3;
  if (rtIsNaN(mu_x_0 + 0.01)) {
    tmp = false;
  } else if (rtIsNaN(SA_idx_3)) {
    tmp = true;
  } else {
    tmp = (SA_idx_3 < mu_x_0 + 0.01);
  }

  if (tmp) {
    kx_idx_1 = mu_x_0 + 0.01;
  }

  n_idx_3 = rtb_steering_idx_2;
  rtb_T_brake_idx_1 = mu_x_2;
  rtb_Fx_max_idx_2 = mu_x_1;
  C[1] = mu_y_0;
  slip_limit_idx_2 = (real32_T)(kx_idx_2 - rtb_T_brake_idx_2 /
    microcontroller_code_generati_P.RE) / microcontroller_code_generati_P.T2F[2];
  mu_x_2 = microcontroller_code_generati_P.Constant_Value *
    microcontroller_code_generati_P.gr[2];
  mu_x_1 = microcontroller_code_generati_P.motor_limit_power[2] *
    microcontroller_code_generati_P.motor_efficiency[2] / mu_x_2;
  if (mu_x_1 > 25.0) {
    mu_x_1 = 25.0;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 >
              microcontroller_code_generati_P.min_speed_regen)) {
    mu_x_1 = -25.0;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 > 0.0)) {
    mu_x_1 = -0.01;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 < 0.0)) {
    mu_x_1 = 25.0;
  }

  mu_y_0 = mu_x_2 * 9.5492965964254;
  if (mu_y_0 < 7000.0) {
    mu_y_0 = 70.0;
  } else {
    mu_y_0 = (66.353 - sqrt(4402.7206089999991 - (10452.0 - mu_y_0) * 1.0668)) *
      1.8747656542932134;
  }

  mu_y_0 = ((mu_y_0 * mu_y_0 * -0.0987 + 45.799 * mu_y_0) + -129.65) / 100.0;
  if (mu_y_0 < 0.0) {
    mu_y_0 = 0.0;
  }

  kx_idx_2 = SA_idx_3;
  if (rtIsNaN(mu_x_0 + 0.01)) {
    tmp = false;
  } else if (rtIsNaN(SA_idx_3)) {
    tmp = true;
  } else {
    tmp = (SA_idx_3 < mu_x_0 + 0.01);
  }

  if (tmp) {
    kx_idx_2 = mu_x_0 + 0.01;
  }

  SL_idx_2 = rtb_steering_idx_2;
  rtb_T_brake_idx_2 = mu_x_2;
  SA_idx_2 = mu_x_1;
  C[2] = mu_y_0;
  slip_limit_idx_3 = (real32_T)(mu_x * acker_steer_angles_idx_0 * mu_y / sqrt
    (mu_x_tmp * mu_x_tmp * a_bar_tmp + mu_y * mu_y) - rtb_T_brake_idx_3 /
    microcontroller_code_generati_P.RE) / microcontroller_code_generati_P.T2F[3];
  mu_x_2 = microcontroller_code_generati_P.Constant_Value *
    microcontroller_code_generati_P.gr[3];
  mu_x_1 = microcontroller_code_generati_P.motor_limit_power[3] *
    microcontroller_code_generati_P.motor_efficiency[3] / mu_x_2;
  if (mu_x_1 > 25.0) {
    mu_x_1 = 25.0;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 >
              microcontroller_code_generati_P.min_speed_regen)) {
    mu_x_1 = -25.0;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 > 0.0)) {
    mu_x_1 = -0.01;
  } else if ((mu_x_1 < -25.0) && (mu_x_2 < 0.0)) {
    mu_x_1 = 25.0;
  }

  mu_y_0 = mu_x_2 * 9.5492965964254;
  if (mu_y_0 < 7000.0) {
    mu_y_0 = 70.0;
  } else {
    mu_y_0 = (66.353 - sqrt(4402.7206089999991 - (10452.0 - mu_y_0) * 1.0668)) *
      1.8747656542932134;
  }

  mu_y_0 = ((mu_y_0 * mu_y_0 * -0.0987 + 45.799 * mu_y_0) + -129.65) / 100.0;
  if (mu_y_0 < 0.0) {
    mu_y_0 = 0.0;
  }

  rtb_T_brake_idx_3 = SA_idx_3;
  if (rtIsNaN(mu_x_0 + 0.01)) {
    tmp = false;
  } else if (rtIsNaN(SA_idx_3)) {
    tmp = true;
  } else {
    tmp = (SA_idx_3 < mu_x_0 + 0.01);
  }

  if (tmp) {
    rtb_T_brake_idx_3 = mu_x_0 + 0.01;
  }

  acker_steer_angles_idx_0 = rtb_steering_idx_2;
  if (rtIsNaN(mu_x_0 - 0.01)) {
    tmp = false;
  } else if (rtIsNaN(rtb_steering_idx_2)) {
    tmp = true;
  } else {
    tmp = (rtb_steering_idx_2 > mu_x_0 - 0.01);
  }

  if (tmp) {
    rtb_Fx_max_idx_0 = mu_x_0 - 0.01;
  }

  c_x[0] = slip_limit_idx_0;
  c_x[1] = (real32_T)SA_idx_0;
  c_x[2] = (real32_T)microcontroller_code_generati_P.motor_limit_torque[1];
  c_x[3] = (real32_T)acker_steer_angles_idx_1;
  c_x[4] = (real32_T)C[0];
  if (!rtIsNaNF(slip_limit_idx_0)) {
    high_i = 1;
  } else {
    high_i = 0;
    low_ip1 = 2;
    exitg1 = false;
    while ((!exitg1) && (low_ip1 <= 5)) {
      if (!rtIsNaNF(c_x[low_ip1 - 1])) {
        high_i = low_ip1;
        exitg1 = true;
      } else {
        low_ip1++;
      }
    }
  }

  if (high_i == 0) {
    rtb_ub_idx_0 = slip_limit_idx_0;
  } else {
    rtb_lb_idx_3 = c_x[high_i - 1];
    while (high_i + 1 < 6) {
      if (rtb_lb_idx_3 > c_x[high_i]) {
        rtb_lb_idx_3 = c_x[high_i];
      }

      high_i++;
    }

    rtb_ub_idx_0 = rtb_lb_idx_3;
  }

  lb_f[0] = -slip_limit_idx_0;
  lb_f[1] = (real32_T)-SA_idx_0;
  lb_f[2] = (real32_T)microcontroller_code_generati_P.motor_limit_torque[0];
  lb_f[3] = (real32_T)rtb_Fx_max_idx_0;
  if (!rtIsNaNF(-slip_limit_idx_0)) {
    high_i = 1;
  } else {
    high_i = 0;
    low_ip1 = 2;
    exitg1 = false;
    while ((!exitg1) && (low_ip1 <= 4)) {
      if (!rtIsNaNF(lb_f[low_ip1 - 1])) {
        high_i = low_ip1;
        exitg1 = true;
      } else {
        low_ip1++;
      }
    }
  }

  if (high_i == 0) {
    slip_limit_idx_0 = -slip_limit_idx_0;
  } else {
    rtb_lb_idx_3 = lb_f[high_i - 1];
    while (high_i + 1 < 5) {
      if (rtb_lb_idx_3 < lb_f[high_i]) {
        rtb_lb_idx_3 = lb_f[high_i];
      }

      high_i++;
    }

    slip_limit_idx_0 = rtb_lb_idx_3;
  }

  if ((rtb_T_brake_idx_0 < microcontroller_code_generati_P.min_speed_regen) &&
      (slip_limit_idx_0 < 0.0F)) {
    slip_limit_idx_0 = 0.001F;
  }

  if (rtIsNaN(mu_x_0 - 0.01)) {
    tmp = false;
  } else if (rtIsNaN(rtb_steering_idx_2)) {
    tmp = true;
  } else {
    tmp = (rtb_steering_idx_2 > mu_x_0 - 0.01);
  }

  if (tmp) {
    n_idx_3 = mu_x_0 - 0.01;
  }

  c_x[0] = slip_limit_idx_1;
  c_x[1] = (real32_T)rtb_Fx_max_idx_2;
  c_x[2] = (real32_T)microcontroller_code_generati_P.motor_limit_torque[1];
  c_x[3] = (real32_T)kx_idx_1;
  c_x[4] = (real32_T)C[1];
  if (!rtIsNaNF(slip_limit_idx_1)) {
    high_i = 1;
  } else {
    high_i = 0;
    low_ip1 = 2;
    exitg1 = false;
    while ((!exitg1) && (low_ip1 <= 5)) {
      if (!rtIsNaNF(c_x[low_ip1 - 1])) {
        high_i = low_ip1;
        exitg1 = true;
      } else {
        low_ip1++;
      }
    }
  }

  if (high_i == 0) {
    rtb_ub_idx_1 = slip_limit_idx_1;
  } else {
    rtb_lb_idx_3 = c_x[high_i - 1];
    while (high_i + 1 < 6) {
      if (rtb_lb_idx_3 > c_x[high_i]) {
        rtb_lb_idx_3 = c_x[high_i];
      }

      high_i++;
    }

    rtb_ub_idx_1 = rtb_lb_idx_3;
  }

  lb_f[0] = -slip_limit_idx_1;
  lb_f[1] = (real32_T)-rtb_Fx_max_idx_2;
  lb_f[2] = (real32_T)microcontroller_code_generati_P.motor_limit_torque[0];
  lb_f[3] = (real32_T)n_idx_3;
  if (!rtIsNaNF(-slip_limit_idx_1)) {
    high_i = 1;
  } else {
    high_i = 0;
    low_ip1 = 2;
    exitg1 = false;
    while ((!exitg1) && (low_ip1 <= 4)) {
      if (!rtIsNaNF(lb_f[low_ip1 - 1])) {
        high_i = low_ip1;
        exitg1 = true;
      } else {
        low_ip1++;
      }
    }
  }

  if (high_i == 0) {
    slip_limit_idx_1 = -slip_limit_idx_1;
  } else {
    rtb_lb_idx_3 = lb_f[high_i - 1];
    while (high_i + 1 < 5) {
      if (rtb_lb_idx_3 < lb_f[high_i]) {
        rtb_lb_idx_3 = lb_f[high_i];
      }

      high_i++;
    }

    slip_limit_idx_1 = rtb_lb_idx_3;
  }

  if ((rtb_T_brake_idx_1 < microcontroller_code_generati_P.min_speed_regen) &&
      (slip_limit_idx_1 < 0.0F)) {
    slip_limit_idx_1 = 0.001F;
  }

  if (rtIsNaN(mu_x_0 - 0.01)) {
    tmp = false;
  } else if (rtIsNaN(rtb_steering_idx_2)) {
    tmp = true;
  } else {
    tmp = (rtb_steering_idx_2 > mu_x_0 - 0.01);
  }

  if (tmp) {
    SL_idx_2 = mu_x_0 - 0.01;
  }

  c_x[0] = slip_limit_idx_2;
  c_x[1] = (real32_T)SA_idx_2;
  c_x[2] = (real32_T)microcontroller_code_generati_P.motor_limit_torque[1];
  c_x[3] = (real32_T)kx_idx_2;
  c_x[4] = (real32_T)C[2];
  if (!rtIsNaNF(slip_limit_idx_2)) {
    high_i = 1;
  } else {
    high_i = 0;
    low_ip1 = 2;
    exitg1 = false;
    while ((!exitg1) && (low_ip1 <= 5)) {
      if (!rtIsNaNF(c_x[low_ip1 - 1])) {
        high_i = low_ip1;
        exitg1 = true;
      } else {
        low_ip1++;
      }
    }
  }

  if (high_i == 0) {
    rtb_ub_idx_2 = slip_limit_idx_2;
  } else {
    rtb_lb_idx_3 = c_x[high_i - 1];
    while (high_i + 1 < 6) {
      if (rtb_lb_idx_3 > c_x[high_i]) {
        rtb_lb_idx_3 = c_x[high_i];
      }

      high_i++;
    }

    rtb_ub_idx_2 = rtb_lb_idx_3;
  }

  lb_f[0] = -slip_limit_idx_2;
  lb_f[1] = (real32_T)-SA_idx_2;
  lb_f[2] = (real32_T)microcontroller_code_generati_P.motor_limit_torque[0];
  lb_f[3] = (real32_T)SL_idx_2;
  if (!rtIsNaNF(-slip_limit_idx_2)) {
    high_i = 1;
  } else {
    high_i = 0;
    low_ip1 = 2;
    exitg1 = false;
    while ((!exitg1) && (low_ip1 <= 4)) {
      if (!rtIsNaNF(lb_f[low_ip1 - 1])) {
        high_i = low_ip1;
        exitg1 = true;
      } else {
        low_ip1++;
      }
    }
  }

  if (high_i == 0) {
    slip_limit_idx_2 = -slip_limit_idx_2;
  } else {
    rtb_lb_idx_3 = lb_f[high_i - 1];
    while (high_i + 1 < 5) {
      if (rtb_lb_idx_3 < lb_f[high_i]) {
        rtb_lb_idx_3 = lb_f[high_i];
      }

      high_i++;
    }

    slip_limit_idx_2 = rtb_lb_idx_3;
  }

  if ((rtb_T_brake_idx_2 < microcontroller_code_generati_P.min_speed_regen) &&
      (slip_limit_idx_2 < 0.0F)) {
    slip_limit_idx_2 = 0.001F;
  }

  if (rtIsNaN(mu_x_0 - 0.01)) {
    tmp = false;
  } else if (rtIsNaN(rtb_steering_idx_2)) {
    tmp = true;
  } else {
    tmp = (rtb_steering_idx_2 > mu_x_0 - 0.01);
  }

  if (tmp) {
    acker_steer_angles_idx_0 = mu_x_0 - 0.01;
  }

  c_x[0] = slip_limit_idx_3;
  c_x[1] = (real32_T)mu_x_1;
  c_x[2] = (real32_T)microcontroller_code_generati_P.motor_limit_torque[1];
  c_x[3] = (real32_T)rtb_T_brake_idx_3;
  c_x[4] = (real32_T)mu_y_0;
  if (!rtIsNaNF(slip_limit_idx_3)) {
    high_i = 1;
  } else {
    high_i = 0;
    low_ip1 = 2;
    exitg1 = false;
    while ((!exitg1) && (low_ip1 <= 5)) {
      if (!rtIsNaNF(c_x[low_ip1 - 1])) {
        high_i = low_ip1;
        exitg1 = true;
      } else {
        low_ip1++;
      }
    }
  }

  if (high_i == 0) {
    rtb_ub_idx_3 = slip_limit_idx_3;
  } else {
    rtb_lb_idx_3 = c_x[high_i - 1];
    while (high_i + 1 < 6) {
      if (rtb_lb_idx_3 > c_x[high_i]) {
        rtb_lb_idx_3 = c_x[high_i];
      }

      high_i++;
    }

    rtb_ub_idx_3 = rtb_lb_idx_3;
  }

  lb_f[0] = -slip_limit_idx_3;
  lb_f[1] = (real32_T)-mu_x_1;
  lb_f[2] = (real32_T)microcontroller_code_generati_P.motor_limit_torque[0];
  lb_f[3] = (real32_T)acker_steer_angles_idx_0;
  if (!rtIsNaNF(-slip_limit_idx_3)) {
    high_i = 1;
  } else {
    high_i = 0;
    low_ip1 = 2;
    exitg1 = false;
    while ((!exitg1) && (low_ip1 <= 4)) {
      if (!rtIsNaNF(lb_f[low_ip1 - 1])) {
        high_i = low_ip1;
        exitg1 = true;
      } else {
        low_ip1++;
      }
    }
  }

  if (high_i == 0) {
    rtb_lb_idx_3 = -slip_limit_idx_3;
  } else {
    rtb_lb_idx_3 = lb_f[high_i - 1];
    while (high_i + 1 < 5) {
      if (rtb_lb_idx_3 < lb_f[high_i]) {
        rtb_lb_idx_3 = lb_f[high_i];
      }

      high_i++;
    }
  }

  if ((mu_x_2 < microcontroller_code_generati_P.min_speed_regen) &&
      (rtb_lb_idx_3 < 0.0F)) {
    rtb_lb_idx_3 = 0.001F;
  }

  slip_limit_idx_3 = (real32_T)((((-microcontroller_code_generati_P.s[0] *
    left_steering_angle + microcontroller_code_generati_P.l[0] *
    rtb_steering_idx_0) * (rtb_FY[0] * microcontroller_code_generati_P.mu_factor)
    + (microcontroller_code_generati_P.s[0] * rtb_steering_idx_1 +
       microcontroller_code_generati_P.l[0] * x_tmp) * (rtb_FY[1] *
    microcontroller_code_generati_P.mu_factor)) + rtb_FY[2] *
    microcontroller_code_generati_P.mu_factor *
    -microcontroller_code_generati_P.l[1]) + rtb_FY[3] *
    microcontroller_code_generati_P.mu_factor *
    -microcontroller_code_generati_P.l[1]);
  rtb_lb_idx_3 = ((((rtb_ub_idx_0 * microcontroller_code_generati_P.T2F[0] *
                     (real32_T)n_idx_1 + rtb_ub_idx_2 *
                     microcontroller_code_generati_P.T2F[2] * (real32_T)
                     microcontroller_code_generati_P.s[1]) + slip_limit_idx_1 *
                    microcontroller_code_generati_P.T2F[1] * (real32_T)n_idx_2)
                   + rtb_lb_idx_3 * microcontroller_code_generati_P.T2F[3] *
                   (real32_T)-microcontroller_code_generati_P.s[1]) +
                  slip_limit_idx_3) / (real32_T)
    microcontroller_code_generati_P.J_z;
  rtb_ub_idx_0 = ((((rtb_ub_idx_1 * microcontroller_code_generati_P.T2F[1] *
                     (real32_T)n_idx_2 + rtb_ub_idx_3 *
                     microcontroller_code_generati_P.T2F[3] * (real32_T)
                     -microcontroller_code_generati_P.s[1]) + slip_limit_idx_0 *
                    microcontroller_code_generati_P.T2F[0] * (real32_T)n_idx_1)
                   + slip_limit_idx_2 * microcontroller_code_generati_P.T2F[2] *
                   (real32_T)microcontroller_code_generati_P.s[1]) +
                  slip_limit_idx_3) / (real32_T)
    microcontroller_code_generati_P.J_z;
  if (SA_fr >= rtb_lb_idx_3) {
    SA_fr = rtb_lb_idx_3;

    /* Update for UnitDelay: '<S1>/Unit Delay' */
    microcontroller_code_generat_DW.UnitDelay_DSTATE = 0.0;
  } else if (SA_fr <= rtb_ub_idx_0) {
    SA_fr = rtb_ub_idx_0;

    /* Update for UnitDelay: '<S1>/Unit Delay' */
    microcontroller_code_generat_DW.UnitDelay_DSTATE = 0.0;
  } else {
    /* Update for UnitDelay: '<S1>/Unit Delay' */
    microcontroller_code_generat_DW.UnitDelay_DSTATE = 1.0;
  }

  if (SA_fr >= 40.0) {
    SA_fr = 40.0;

    /* Update for UnitDelay: '<S1>/Unit Delay' */
    microcontroller_code_generat_DW.UnitDelay_DSTATE = 0.0;
  } else if (SA_fr <= -40.0) {
    SA_fr = -40.0;

    /* Update for UnitDelay: '<S1>/Unit Delay' */
    microcontroller_code_generat_DW.UnitDelay_DSTATE = 0.0;
  }

  if ((microcontroller_code_generati_P.Constant_Value <
       microcontroller_code_generati_P.min_speed_regen) &&
      (microcontroller_code_generati_P.Constant_Value <= 0.0)) {
    SA_fr = 0.0;
  }

  if (microcontroller_code_generat_DW.UnitDelay3_DSTATE < 0.0) {
    x_tmp = -1.0;
  } else if (microcontroller_code_generat_DW.UnitDelay3_DSTATE > 0.0) {
    x_tmp = 1.0;
  } else if (microcontroller_code_generat_DW.UnitDelay3_DSTATE == 0.0) {
    x_tmp = 0.0;
  } else {
    x_tmp = (rtNaN);
  }

  if (microcontroller_code_generati_P.Constant_Value < 0.0) {
    rtb_T_brake_idx_0 = -1.0;
  } else if (microcontroller_code_generati_P.Constant_Value > 0.0) {
    rtb_T_brake_idx_0 = 1.0;
  } else if (microcontroller_code_generati_P.Constant_Value == 0.0) {
    rtb_T_brake_idx_0 = 0.0;
  } else {
    rtb_T_brake_idx_0 = (rtNaN);
  }

  /* Update for UnitDelay: '<S1>/Unit Delay4' incorporates:
   *  MATLAB Function: '<S1>/Constraint Generation'
   */
  microcontroller_code_generat_DW.UnitDelay4_DSTATE = !(x_tmp !=
    rtb_T_brake_idx_0);

  /* Update for DiscreteIntegrator: '<S5>/Discrete-Time Integrator' incorporates:
   *  DiscreteIntegrator: '<S5>/Discrete-Time Integrator2'
   */
  microcontroller_code_generat_DW.DiscreteTimeIntegrator_DSTATE = phi_rl;
  if (rack_displacement > 0.0) {
    microcontroller_code_generat_DW.DiscreteTimeIntegrator_PrevRese = 1;
    microcontroller_code_generat_DW.DiscreteTimeIntegrator2_PrevRes = 1;
  } else {
    if (rack_displacement < 0.0) {
      microcontroller_code_generat_DW.DiscreteTimeIntegrator_PrevRese = -1;
    } else if (rack_displacement == 0.0) {
      microcontroller_code_generat_DW.DiscreteTimeIntegrator_PrevRese = 0;
    } else {
      microcontroller_code_generat_DW.DiscreteTimeIntegrator_PrevRese = 2;
    }

    if (rack_displacement < 0.0) {
      microcontroller_code_generat_DW.DiscreteTimeIntegrator2_PrevRes = -1;
    } else if (rack_displacement == 0.0) {
      microcontroller_code_generat_DW.DiscreteTimeIntegrator2_PrevRes = 0;
    } else {
      microcontroller_code_generat_DW.DiscreteTimeIntegrator2_PrevRes = 2;
    }
  }

  /* End of Update for DiscreteIntegrator: '<S5>/Discrete-Time Integrator' */

  /* Update for UnitDelay: '<S1>/Unit Delay1' incorporates:
   *  MATLAB Function: '<S1>/Constraint Generation'
   */
  microcontroller_code_generat_DW.UnitDelay1_DSTATE = SA_fr;

  /* Update for DiscreteIntegrator: '<S5>/Discrete-Time Integrator2' */
  microcontroller_code_generat_DW.DiscreteTimeIntegrator2_DSTATE = phi_fl;

  /* Update for UnitDelay: '<S1>/Unit Delay3' incorporates:
   *  Constant: '<Root>/Constant'
   */
  microcontroller_code_generat_DW.UnitDelay3_DSTATE =
    microcontroller_code_generati_P.Constant_Value;

  /* Matfile logging */
  rt_UpdateTXYLogVars(microcontroller_code_generat_M->rtwLogInfo,
                      (&microcontroller_code_generat_M->Timing.taskTime0));

  /* signal main to stop simulation */
  {                                    /* Sample time: [0.015s, 0.0s] */
    if ((rtmGetTFinal(microcontroller_code_generat_M)!=-1) &&
        !((rtmGetTFinal(microcontroller_code_generat_M)-
           microcontroller_code_generat_M->Timing.taskTime0) >
          microcontroller_code_generat_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(microcontroller_code_generat_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++microcontroller_code_generat_M->Timing.clockTick0)) {
    ++microcontroller_code_generat_M->Timing.clockTickH0;
  }

  microcontroller_code_generat_M->Timing.taskTime0 =
    microcontroller_code_generat_M->Timing.clockTick0 *
    microcontroller_code_generat_M->Timing.stepSize0 +
    microcontroller_code_generat_M->Timing.clockTickH0 *
    microcontroller_code_generat_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void microcontroller_code_generation_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)microcontroller_code_generat_M, 0,
                sizeof(RT_MODEL_microcontroller_code_T));
  rtmSetTFinal(microcontroller_code_generat_M, 9.99);
  microcontroller_code_generat_M->Timing.stepSize0 = 0.015;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = (NULL);
    microcontroller_code_generat_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(microcontroller_code_generat_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(microcontroller_code_generat_M->rtwLogInfo, (NULL));
    rtliSetLogT(microcontroller_code_generat_M->rtwLogInfo, "tout");
    rtliSetLogX(microcontroller_code_generat_M->rtwLogInfo, "");
    rtliSetLogXFinal(microcontroller_code_generat_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(microcontroller_code_generat_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(microcontroller_code_generat_M->rtwLogInfo, 4);
    rtliSetLogMaxRows(microcontroller_code_generat_M->rtwLogInfo, 0);
    rtliSetLogDecimation(microcontroller_code_generat_M->rtwLogInfo, 1);
    rtliSetLogY(microcontroller_code_generat_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(microcontroller_code_generat_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(microcontroller_code_generat_M->rtwLogInfo, (NULL));
  }

  /* states (dwork) */
  (void) memset((void *)&microcontroller_code_generat_DW, 0,
                sizeof(DW_microcontroller_code_gener_T));

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(microcontroller_code_generat_M->rtwLogInfo,
    0.0, rtmGetTFinal(microcontroller_code_generat_M),
    microcontroller_code_generat_M->Timing.stepSize0, (&rtmGetErrorStatus
    (microcontroller_code_generat_M)));

  /* InitializeConditions for UnitDelay: '<S1>/Unit Delay4' */
  microcontroller_code_generat_DW.UnitDelay4_DSTATE =
    microcontroller_code_generati_P.UnitDelay4_InitialCondition;

  /* InitializeConditions for UnitDelay: '<S1>/Unit Delay' */
  microcontroller_code_generat_DW.UnitDelay_DSTATE =
    microcontroller_code_generati_P.UnitDelay_InitialCondition;

  /* InitializeConditions for DiscreteIntegrator: '<S5>/Discrete-Time Integrator' */
  microcontroller_code_generat_DW.DiscreteTimeIntegrator_DSTATE =
    microcontroller_code_generati_P.DiscreteTimeIntegrator_IC;
  microcontroller_code_generat_DW.DiscreteTimeIntegrator_PrevRese = 2;

  /* InitializeConditions for UnitDelay: '<S1>/Unit Delay1' */
  microcontroller_code_generat_DW.UnitDelay1_DSTATE =
    microcontroller_code_generati_P.UnitDelay1_InitialCondition;

  /* InitializeConditions for DiscreteIntegrator: '<S5>/Discrete-Time Integrator2' */
  microcontroller_code_generat_DW.DiscreteTimeIntegrator2_DSTATE =
    microcontroller_code_generati_P.DiscreteTimeIntegrator2_IC;
  microcontroller_code_generat_DW.DiscreteTimeIntegrator2_PrevRes = 2;

  /* InitializeConditions for UnitDelay: '<S1>/Unit Delay3' */
  microcontroller_code_generat_DW.UnitDelay3_DSTATE =
    microcontroller_code_generati_P.UnitDelay3_InitialCondition;
}

/* Model terminate function */
void microcontroller_code_generation_terminate(void)
{
  /* (no terminate code required) */
}
