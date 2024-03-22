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
#include "ec_cwt_data.h"
#include "ec_cwt_emxutil.h"
#include "ec_cwt_mexutil.h"
#include "ec_cwt_types.h"
#include "morseproperties.h"
#include "rt_nonfinite.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo qc_emlrtRTEI{
    63,                // lineNo
    57,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

static emlrtRTEInfo rc_emlrtRTEI{
    63,                // lineNo
    20,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

static emlrtRTEInfo sc_emlrtRTEI{
    1,                                                                // lineNo
    23,                                                               // colNo
    "quadgk",                                                         // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/funfun/quadgk.m" // pName
};

static emlrtRTEInfo tc_emlrtRTEI{
    63,                // lineNo
    34,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

static emlrtRTEInfo uc_emlrtRTEI{
    63,                // lineNo
    16,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

static emlrtRTEInfo vc_emlrtRTEI{
    63,                // lineNo
    60,                // colNo
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
  i = in1->size[0] * in1->size[1];
  in1->size[0] = 1;
  in1->size[1] = in4->size[1];
  emxEnsureCapacity_real_T(in1, i, &jc_emlrtRTEI);
  stride_0_1 = (in2->size[1] != 1);
  stride_1_1 = (in3->size[1] != 1);
  for (i = 0; i < in4->size[1]; i++) {
    in1->data[i] =
        in2->data[i * stride_0_1] * in3->data[i * stride_1_1] * in4->data[i];
  }
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
  emxArray_real_T *dv4;
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
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  interval[0] = 0.0;
  interval[1] = 1.0;
  std::memset(&interval[2], 0, 648U * sizeof(real_T));
  q = 0.0;
  ix = split(interval, 2, &pathlen);
  if (!(pathlen > 0.0)) {
    real_T midpt;
    midpt = fun_workspace_be * rt_powd_snf(rtInf, fun_workspace_be - 1.0) -
            fun_workspace_ga *
                rt_powd_snf(rtInf, (fun_workspace_be + fun_workspace_ga) - 1.0);
    q = rtInf *
        (midpt * midpt * std::exp(-2.0 * rt_powd_snf(rtInf, fun_workspace_ga)));
  } else {
    real_T err_ok;
    real_T q_ok;
    int32_T k;
    int32_T nsubs;
    boolean_T first_iteration;
    nsubs = ix - 2;
    for (k = 0; k <= nsubs; k++) {
      subs[k << 1] = interval[k];
      subs[(k << 1) + 1] = interval[k + 1];
    }
    q_ok = 0.0;
    err_ok = 0.0;
    first_iteration = true;
    emxInit_real_T(&x, 2, &ec_emlrtRTEI, true);
    emxInit_real_T(&b_x, 2, &kc_emlrtRTEI, true);
    emxInit_real_T(&xt, 2, &lc_emlrtRTEI, true);
    emxInit_real_T(&y, 2, &rc_emlrtRTEI, true);
    emxInit_real_T(&fx, 2, &sc_emlrtRTEI, true);
    emxInit_real_T(&b_y, 2, &tc_emlrtRTEI, true);
    emxInit_real_T(&a, 2, &pc_emlrtRTEI, true);
    emxInit_real_T(&b_dv1, 2, &uc_emlrtRTEI, true);
    emxInit_real_T(&c_y, 2, &vc_emlrtRTEI, true);
    emxInit_real_T(&dv4, 2, &uc_emlrtRTEI, true);
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
      emxEnsureCapacity_real_T(x, ix, &ec_emlrtRTEI);
      ix = -1;
      for (k = 0; k <= nsubs; k++) {
        d = subs[k << 1];
        tau = subs[(k << 1) + 1];
        midpt = (d + tau) / 2.0;
        halfh = (tau - d) / 2.0;
        for (int32_T j{0}; j < 15; j++) {
          x->data[(ix + j) + 1] = dv[j] * halfh + midpt;
        }
        ix += 15;
      }
      ix = b_x->size[0] * b_x->size[1];
      b_x->size[0] = 1;
      b_x->size[1] = x->size[1];
      emxEnsureCapacity_real_T(b_x, ix, &fc_emlrtRTEI);
      ix = xt->size[0] * xt->size[1];
      xt->size[0] = 1;
      xt->size[1] = x->size[1];
      emxEnsureCapacity_real_T(xt, ix, &gc_emlrtRTEI);
      ix = x->size[1];
      for (k = 0; k < ix; k++) {
        d = x->data[k];
        midpt = d / (1.0 - d);
        b_x->data[k] = midpt * midpt;
        xt->data[k] = 2.0 * midpt / ((1.0 - d) * (1.0 - d));
      }
      guard1 = false;
      if (!first_iteration) {
        boolean_T exitg2;
        midpt = std::abs(b_x->data[0]);
        k = 0;
        exitg2 = false;
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
        if (first_iteration) {
          int16_T dv_idx_1;
          dv_idx_1 = static_cast<int16_T>(x->size[1]);
          ix = fx->size[0] * fx->size[1];
          fx->size[0] = 1;
          fx->size[1] = x->size[1];
          emxEnsureCapacity_real_T(fx, ix, &ic_emlrtRTEI);
          for (ix = 0; ix < dv_idx_1; ix++) {
            fx->data[ix] = 0.0;
          }
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
        emxEnsureCapacity_real_T(y, ix, &bb_emlrtRTEI);
        ix = b_x->size[1];
        for (k = 0; k < ix; k++) {
          y->data[k] = rt_powd_snf(b_x->data[k], fun_workspace_be - 1.0);
        }
        midpt = (fun_workspace_be + fun_workspace_ga) - 1.0;
        ix = b_y->size[0] * b_y->size[1];
        b_y->size[0] = 1;
        b_y->size[1] = b_x->size[1];
        emxEnsureCapacity_real_T(b_y, ix, &bb_emlrtRTEI);
        ix = b_x->size[1];
        for (k = 0; k < ix; k++) {
          b_y->data[k] = rt_powd_snf(b_x->data[k], midpt);
        }
        if (y->size[1] == b_y->size[1]) {
          ix = a->size[0] * a->size[1];
          a->size[0] = 1;
          a->size[1] = y->size[1];
          emxEnsureCapacity_real_T(a, ix, &pc_emlrtRTEI);
          for (ix = 0; ix < y->size[1]; ix++) {
            a->data[ix] = fun_workspace_be * y->data[ix] -
                          fun_workspace_ga * b_y->data[ix];
          }
        } else {
          binary_expand_op_5(a, fun_workspace_be, y, fun_workspace_ga, b_y);
        }
        ix = b_dv1->size[0] * b_dv1->size[1];
        b_dv1->size[0] = 1;
        b_dv1->size[1] = a->size[1];
        emxEnsureCapacity_real_T(b_dv1, ix, &bb_emlrtRTEI);
        ix = a->size[1];
        for (k = 0; k < ix; k++) {
          d = a->data[k];
          b_dv1->data[k] = d * d;
        }
        ix = c_y->size[0] * c_y->size[1];
        c_y->size[0] = 1;
        c_y->size[1] = b_x->size[1];
        emxEnsureCapacity_real_T(c_y, ix, &bb_emlrtRTEI);
        ix = b_x->size[1];
        for (k = 0; k < ix; k++) {
          c_y->data[k] = rt_powd_snf(b_x->data[k], fun_workspace_ga);
        }
        ix = dv4->size[0] * dv4->size[1];
        dv4->size[0] = 1;
        dv4->size[1] = c_y->size[1];
        emxEnsureCapacity_real_T(dv4, ix, &qc_emlrtRTEI);
        for (ix = 0; ix < c_y->size[1]; ix++) {
          dv4->data[ix] = -2.0 * c_y->data[ix];
        }
        ix = b_x->size[1];
        for (k = 0; k < ix; k++) {
          dv4->data[k] = std::exp(dv4->data[k]);
        }
        if (b_dv1->size[1] == dv4->size[1]) {
          ix = fx->size[0] * fx->size[1];
          fx->size[0] = 1;
          fx->size[1] = b_dv1->size[1];
          emxEnsureCapacity_real_T(fx, ix, &jc_emlrtRTEI);
          for (ix = 0; ix < b_dv1->size[1]; ix++) {
            fx->data[ix] = b_dv1->data[ix] * dv4->data[ix] * xt->data[ix];
          }
        } else {
          binary_expand_op_3(fx, b_dv1, dv4, xt);
        }
      }
      if (first_iteration) {
        exitg1 = 1;
      } else {
        real_T tol;
        midpt = 0.0;
        ix = -1;
        for (k = 0; k <= nsubs; k++) {
          d = 0.0;
          tau = 0.0;
          for (int32_T j{0}; j < 15; j++) {
            d += dv1[j] * fx->data[(ix + j) + 1];
            tau += dv2[j] * fx->data[(ix + j) + 1];
          }
          ix += 15;
          halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
          d *= halfh;
          qsub[k] = d;
          midpt += d;
          errsub[k] = tau * halfh;
        }
        q = midpt + q_ok;
        tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(q));
        tau = 2.0 * tol / pathlen;
        midpt = 0.0;
        ix = 0;
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
        midpt += std::abs(err_ok);
        if ((!std::isinf(q)) && (!std::isnan(q)) &&
            ((!std::isinf(midpt)) && (!std::isnan(midpt))) && (ix != 0) &&
            (!(midpt <= tol))) {
          nsubs = (ix << 1) - 1;
          if (nsubs + 1 > 650) {
            exitg1 = 1;
          } else {
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
          }
        } else {
          exitg1 = 1;
        }
      }
    } while (exitg1 == 0);
    emxFree_real_T(&dv4);
    emxFree_real_T(&c_y);
    emxFree_real_T(&b_dv1);
    emxFree_real_T(&a);
    emxFree_real_T(&b_y);
    emxFree_real_T(&fx);
    emxFree_real_T(&y);
    emxFree_real_T(&xt);
    emxFree_real_T(&b_x);
    emxFree_real_T(&x);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  return q;
}

//
//
int32_T split(real_T x[650], int32_T nx, real_T *pathlen)
{
  int32_T n_idx_0;
  int32_T nxnew;
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
      for (int32_T j{0}; j < n_idx_0; j++) {
        x[(nxnew - j) - 2] = x[0] + static_cast<real_T>(n_idx_0 - j) * udelta;
      }
    }
    nx = nxnew;
  } else {
    nxnew = 2;
  }
  n_idx_0 = 0;
  for (int32_T j{0}; j <= nx - 2; j++) {
    if (std::abs(x[j + 1] - x[n_idx_0]) > 0.0) {
      n_idx_0++;
      x[n_idx_0] = x[j + 1];
    } else {
      nxnew--;
    }
  }
  if (nxnew < 2) {
    x[1] = x[nx - 1];
    nxnew = 2;
  }
  return nxnew;
}

} // namespace coder

// End of code generation (quadgk.cu)
