//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// quadgk.cu
//
// Code generation for function 'quadgk'
//

// Include files
#include "quadgk.h"
#include "ec_wtc_fp_data.h"
#include "ec_wtc_fp_emxutil.h"
#include "ec_wtc_fp_mexutil.h"
#include "ec_wtc_fp_types.h"
#include "morseproperties.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo id_emlrtRTEI{
    63,                // lineNo
    57,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

static emlrtRTEInfo kd_emlrtRTEI{
    63,                // lineNo
    60,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

static emlrtRTEInfo ld_emlrtRTEI{
    1,                                                                // lineNo
    23,                                                               // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

static emlrtRTEInfo md_emlrtRTEI{
    63,                // lineNo
    16,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

static emlrtRTEInfo nd_emlrtRTEI{
    63,                // lineNo
    20,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

static emlrtRTEInfo od_emlrtRTEI{
    63,                // lineNo
    34,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

// Function Definitions
void binary_expand_op_3(emxArray_real_T *in1, const emxArray_real_T *in2,
                        const emxArray_real_T *in3, const emxArray_real_T *in4)
{
  int32_T i;
  int32_T stride_0_1;
  int32_T stride_1_1;
  nvtxRangePushA("#fcn#binary_expand_op_3#" MW_AT_LOCATION);
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  in1->size[1] = in4->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(in1, i, &cd_emlrtRTEI);
  stride_0_1 = (in2->size[1] != 1);
  stride_1_1 = (in3->size[1] != 1);
  profileLoopStart("binary_expand_op_3_loop_0", __LINE__,
                   (in4->size[1] - 1) + 1, "");
  for (i = 0; i < in4->size[1]; i++) {
    in1->data[i] =
        in2->data[i * stride_0_1] * in3->data[i * stride_1_1] * in4->data[i];
  }
  profileLoopEnd();
  nvtxRangePop();
}

//
//
namespace coder {
real_T quadgk(real_T fun_workspace_be, real_T fun_workspace_ga)
{
  emxArray_real_T *a;
  emxArray_real_T *b_dv1;
  emxArray_real_T *b_x;
  emxArray_real_T *b_y;
  emxArray_real_T *c_y;
  emxArray_real_T *d_y;
  emxArray_real_T *fx;
  emxArray_real_T *x;
  emxArray_real_T *xt;
  emxArray_real_T *y;
  real_T subs[1298];
  real_T interval[650];
  real_T errsub[649];
  real_T qsub[649];
  real_T pathlen;
  real_T q;
  int32_T ix;
  nvtxRangePushA("#fcn#quadgk#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  interval[0] = 0.0;
  interval[1] = 1.0;
  std::memset(&interval[2], 0, 648U * sizeof(real_T));
  q = 0.0;
  nvtxMarkA("#split#" MW_AT_LINE);
  ix = split(interval, 2, &pathlen);
  if (!(pathlen > 0.0)) {
    real_T midpt;
    nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
    nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
    midpt = fun_workspace_be * rt_powd_snf(rtInf, fun_workspace_be - 1.0) -
            fun_workspace_ga *
                rt_powd_snf(rtInf, (fun_workspace_be + fun_workspace_ga) - 1.0);
    nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
    q = rtInf *
        (midpt * midpt * std::exp(-2.0 * rt_powd_snf(rtInf, fun_workspace_ga)));
  } else {
    real_T err_ok;
    real_T q_ok;
    int32_T k;
    int32_T nsubs;
    boolean_T first_iteration;
    nsubs = ix - 2;
    profileLoopStart("quadgk_loop_0", __LINE__, nsubs + 1, "");
    for (k = 0; k <= nsubs; k++) {
      subs[k << 1] = interval[k];
      subs[(k << 1) + 1] = interval[k + 1];
    }
    profileLoopEnd();
    q_ok = 0.0;
    err_ok = 0.0;
    first_iteration = true;
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&x, 2, &wc_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&b_x, 2, &dd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&xt, 2, &ed_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&y, 2, &kd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&fx, 2, &ld_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&b_dv1, 2, &md_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&b_y, 2, &nd_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&c_y, 2, &od_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&d_y, 2, &md_emlrtRTEI, true);
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&a, 2, &jd_emlrtRTEI, true);
    nvtxRangePushA("#loop#quadgk_whileloop_0##" MW_AT_LINE);
    int32_T exitg1;
    do {
      real_T d;
      real_T halfh;
      real_T midpt;
      real_T tau;
      boolean_T guard1;
      exitg1 = 0;
      ix = x->size[0] * x->size[1];
      x->size[0] = 1;
      x->size[1] = 15 * (nsubs + 1);
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(x, ix, &wc_emlrtRTEI);
      ix = -1;
      profileLoopStart("quadgk_loop_1", __LINE__, nsubs + 1, "");
      for (k = 0; k <= nsubs; k++) {
        d = subs[k << 1];
        tau = subs[(k << 1) + 1];
        midpt = (d + tau) / 2.0;
        halfh = (tau - d) / 2.0;
        profileLoopStart("quadgk_loop_2", __LINE__, 14 + 1, "");
        for (int32_T j{0}; j < 15; j++) {
          x->data[(ix + j) + 1] = dv[j] * halfh + midpt;
        }
        profileLoopEnd();
        ix += 15;
      }
      profileLoopEnd();
      ix = b_x->size[0] * b_x->size[1];
      b_x->size[0] = 1;
      b_x->size[1] = x->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(b_x, ix, &xc_emlrtRTEI);
      ix = xt->size[0] * xt->size[1];
      xt->size[0] = 1;
      xt->size[1] = x->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(xt, ix, &yc_emlrtRTEI);
      ix = x->size[1];
      profileLoopStart("quadgk_loop_3", __LINE__, (ix - 1) + 1, "");
      for (k = 0; k < ix; k++) {
        d = x->data[k];
        midpt = d / (1.0 - d);
        b_x->data[k] = midpt * midpt;
        xt->data[k] = 2.0 * midpt / ((1.0 - d) * (1.0 - d));
      }
      profileLoopEnd();
      guard1 = false;
      if (!first_iteration) {
        boolean_T exitg2;
        midpt = std::abs(b_x->data[0]);
        k = 0;
        exitg2 = false;
        nvtxRangePushA("#loop#quadgk_whileloop_1##" MW_AT_LINE);
        while ((!exitg2) && (k <= b_x->size[1] - 2)) {
          tau = midpt;
          midpt = std::abs(b_x->data[k + 1]);
          if (std::abs(b_x->data[k + 1] - b_x->data[k]) <=
              2.2204460492503131E-14 * std::fmax(tau, midpt)) {
            first_iteration = true;
            exitg2 = true;
          } else {
            k++;
          }
        }
        nvtxRangePop();
        if (first_iteration) {
          int16_T dv_idx_1;
          dv_idx_1 = static_cast<int16_T>(x->size[1]);
          ix = fx->size[0] * fx->size[1];
          fx->size[0] = 1;
          fx->size[1] = x->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(fx, ix, &bd_emlrtRTEI);
          profileLoopStart("quadgk_loop_7", __LINE__, (dv_idx_1 - 1) + 1, "");
          for (ix = 0; ix < dv_idx_1; ix++) {
            fx->data[ix] = 0.0;
          }
          profileLoopEnd();
        } else {
          guard1 = true;
        }
      } else {
        guard1 = true;
      }
      if (guard1) {
        first_iteration = false;
        ix = y->size[0] * y->size[1];
        y->size[0] = 1;
        y->size[1] = b_x->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(y, ix, &kb_emlrtRTEI);
        ix = b_x->size[1];
        profileLoopStart("quadgk_loop_5", __LINE__, (ix - 1) + 1, "");
        for (k = 0; k < ix; k++) {
          nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
          y->data[k] = rt_powd_snf(b_x->data[k], fun_workspace_ga);
        }
        profileLoopEnd();
        ix = b_dv1->size[0] * b_dv1->size[1];
        b_dv1->size[0] = 1;
        b_dv1->size[1] = y->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_dv1, ix, &id_emlrtRTEI);
        profileLoopStart("quadgk_loop_9", __LINE__, (y->size[1] - 1) + 1, "");
        for (ix = 0; ix < y->size[1]; ix++) {
          b_dv1->data[ix] = -2.0 * y->data[ix];
        }
        profileLoopEnd();
        ix = b_x->size[1];
        profileLoopStart("quadgk_loop_10", __LINE__, (ix - 1) + 1, "");
        for (k = 0; k < ix; k++) {
          b_dv1->data[k] = std::exp(b_dv1->data[k]);
        }
        profileLoopEnd();
        ix = b_y->size[0] * b_y->size[1];
        b_y->size[0] = 1;
        b_y->size[1] = b_x->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_y, ix, &kb_emlrtRTEI);
        ix = b_x->size[1];
        profileLoopStart("quadgk_loop_12", __LINE__, (ix - 1) + 1, "");
        for (k = 0; k < ix; k++) {
          nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
          b_y->data[k] = rt_powd_snf(b_x->data[k], fun_workspace_be - 1.0);
        }
        profileLoopEnd();
        midpt = (fun_workspace_be + fun_workspace_ga) - 1.0;
        ix = c_y->size[0] * c_y->size[1];
        c_y->size[0] = 1;
        c_y->size[1] = b_x->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(c_y, ix, &kb_emlrtRTEI);
        ix = b_x->size[1];
        profileLoopStart("quadgk_loop_13", __LINE__, (ix - 1) + 1, "");
        for (k = 0; k < ix; k++) {
          nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
          c_y->data[k] = rt_powd_snf(b_x->data[k], midpt);
        }
        profileLoopEnd();
        if (b_y->size[1] == c_y->size[1]) {
          ix = a->size[0] * a->size[1];
          a->size[0] = 1;
          a->size[1] = b_y->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(a, ix, &jd_emlrtRTEI);
          profileLoopStart("quadgk_loop_14", __LINE__, (b_y->size[1] - 1) + 1,
                           "");
          for (ix = 0; ix < b_y->size[1]; ix++) {
            a->data[ix] = fun_workspace_be * b_y->data[ix] -
                          fun_workspace_ga * c_y->data[ix];
          }
          profileLoopEnd();
        } else {
          nvtxMarkA("#binary_expand_op_5#" MW_AT_LINE);
          binary_expand_op_5(a, fun_workspace_be, b_y, fun_workspace_ga, c_y);
        }
        ix = d_y->size[0] * d_y->size[1];
        d_y->size[0] = 1;
        d_y->size[1] = a->size[1];
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(d_y, ix, &kb_emlrtRTEI);
        ix = a->size[1];
        profileLoopStart("quadgk_loop_15", __LINE__, (ix - 1) + 1, "");
        for (k = 0; k < ix; k++) {
          d = a->data[k];
          d_y->data[k] = d * d;
        }
        profileLoopEnd();
        if (d_y->size[1] == b_dv1->size[1]) {
          ix = fx->size[0] * fx->size[1];
          fx->size[0] = 1;
          fx->size[1] = d_y->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(fx, ix, &cd_emlrtRTEI);
          profileLoopStart("quadgk_loop_16", __LINE__, (d_y->size[1] - 1) + 1,
                           "");
          for (ix = 0; ix < d_y->size[1]; ix++) {
            fx->data[ix] = d_y->data[ix] * b_dv1->data[ix] * xt->data[ix];
          }
          profileLoopEnd();
        } else {
          nvtxMarkA("#binary_expand_op_3#" MW_AT_LINE);
          binary_expand_op_3(fx, d_y, b_dv1, xt);
        }
      }
      if (first_iteration) {
        exitg1 = 1;
      } else {
        real_T tol;
        midpt = 0.0;
        ix = -1;
        profileLoopStart("quadgk_loop_4", __LINE__, nsubs + 1, "");
        for (k = 0; k <= nsubs; k++) {
          d = 0.0;
          tau = 0.0;
          profileLoopStart("quadgk_loop_6", __LINE__, 14 + 1, "");
          for (int32_T j{0}; j < 15; j++) {
            d += dv1[j] * fx->data[(ix + j) + 1];
            tau += dv2[j] * fx->data[(ix + j) + 1];
          }
          profileLoopEnd();
          ix += 15;
          halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
          d *= halfh;
          qsub[k] = d;
          midpt += d;
          errsub[k] = tau * halfh;
        }
        profileLoopEnd();
        q = midpt + q_ok;
        tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(q));
        tau = 2.0 * tol / pathlen;
        midpt = 0.0;
        ix = 0;
        profileLoopStart("quadgk_loop_8", __LINE__, nsubs + 1, "");
        for (k = 0; k <= nsubs; k++) {
          d = errsub[k];
          halfh = std::abs(d);
          if (halfh <= tau * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
            err_ok += d;
            q_ok += qsub[k];
          } else {
            midpt += halfh;
            ix++;
            subs[(ix - 1) << 1] = subs[k << 1];
            subs[((ix - 1) << 1) + 1] = subs[(k << 1) + 1];
          }
        }
        profileLoopEnd();
        midpt += std::abs(err_ok);
        if ((!std::isinf(q)) && (!std::isnan(q)) &&
            ((!std::isinf(midpt)) && (!std::isnan(midpt))) && (ix != 0) &&
            (!(midpt <= tol))) {
          nsubs = (ix << 1) - 1;
          if (nsubs + 1 > 650) {
            exitg1 = 1;
          } else {
            profileLoopStart("quadgk_loop_11", __LINE__, (ix - 1) + 1, "");
            for (k = 0; k < ix; k++) {
              subs[((((ix - k) << 1) - 1) << 1) + 1] =
                  subs[(((ix - k) - 1) << 1) + 1];
              subs[(((ix - k) << 1) - 1) << 1] =
                  (subs[((ix - k) - 1) << 1] +
                   subs[(((ix - k) - 1) << 1) + 1]) /
                  2.0;
              subs[((((ix - k) << 1) - 2) << 1) + 1] =
                  subs[(((ix - k) << 1) - 1) << 1];
              subs[(((ix - k) << 1) - 2) << 1] = subs[((ix - k) - 1) << 1];
            }
            profileLoopEnd();
          }
        } else {
          exitg1 = 1;
        }
      }
    } while (exitg1 == 0);
    nvtxRangePop();
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&a);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&d_y);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&c_y);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&b_y);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&b_dv1);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&fx);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&y);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&xt);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&b_x);
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&x);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
  return q;
}

//
//
int32_T split(real_T x[650], int32_T nx, real_T *pathlen)
{
  int32_T n_idx_0;
  int32_T nxnew;
  nvtxRangePushA("#fcn#split#" MW_AT_LOCATION);
  *pathlen = x[1] - x[0];
  if (*pathlen > 0.0) {
    real_T udelta;
    udelta = 10.0 / *pathlen;
    n_idx_0 =
        static_cast<int32_T>(std::ceil(std::abs(x[1] - x[0]) * udelta) - 1.0);
    nxnew =
        static_cast<int32_T>(std::ceil(std::abs(x[1] - x[0]) * udelta) - 1.0) +
        2;
    if (nxnew > 2) {
      x[nxnew - 1] = x[1];
      udelta = (x[1] - x[0]) / static_cast<real_T>(n_idx_0 + 1);
      profileLoopStart("split_loop_1", __LINE__, (n_idx_0 - 1) + 1, "");
      for (int32_T j{0}; j < n_idx_0; j++) {
        x[(nxnew - j) - 2] = x[0] + static_cast<real_T>(n_idx_0 - j) * udelta;
      }
      profileLoopEnd();
    }
    nx = nxnew;
  } else {
    nxnew = 2;
  }
  n_idx_0 = 0;
  profileLoopStart("split_loop_0", __LINE__, (nx - 2) + 1, "");
  for (int32_T j{0}; j <= nx - 2; j++) {
    if (std::abs(x[j + 1] - x[n_idx_0]) > 0.0) {
      n_idx_0++;
      x[n_idx_0] = x[j + 1];
    } else {
      nxnew--;
    }
  }
  profileLoopEnd();
  if (nxnew < 2) {
    x[1] = x[nx - 1];
    nxnew = 2;
  }
  nvtxRangePop();
  return nxnew;
}

} // namespace coder

// End of code generation (quadgk.cu)
