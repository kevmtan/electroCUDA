//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// numCpsi.cu
//
// Code generation for function 'numCpsi'
//

// Include files
#include "numCpsi.h"
#include "cospiAndSinpi.h"
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_emxutil.h"
#include "ec_cwtAvg_mexutil.h"
#include "ec_cwtAvg_types.h"
#include "quadgk.h"
#include "rt_nonfinite.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo ad_emlrtRTEI{
    28,        // lineNo
    47,        // colNo
    "numCpsi", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "numCpsi.m" // pName
};

static emlrtRTEInfo bd_emlrtRTEI{
    28,        // lineNo
    36,        // colNo
    "numCpsi", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "numCpsi.m" // pName
};

static emlrtRTEInfo cd_emlrtRTEI{
    28,        // lineNo
    23,        // colNo
    "numCpsi", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "numCpsi.m" // pName
};

static emlrtRTEInfo dd_emlrtRTEI{
    28,        // lineNo
    46,        // colNo
    "numCpsi", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "numCpsi.m" // pName
};

static emlrtRTEInfo ed_emlrtRTEI{
    1,         // lineNo
    17,        // colNo
    "numCpsi", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "numCpsi.m" // pName
};

static emlrtRTEInfo fd_emlrtRTEI{
    28,        // lineNo
    19,        // colNo
    "numCpsi", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "numCpsi.m" // pName
};

// Function Definitions
//
//
namespace coder {
namespace wavelet {
namespace internal {
namespace cwt {
real_T numCpsi(const char_T wname[5], real_T varargin_1, real_T varargin_2)
{
  static const real_T gam[23]{1.0,
                              1.0,
                              2.0,
                              6.0,
                              24.0,
                              120.0,
                              720.0,
                              5040.0,
                              40320.0,
                              362880.0,
                              3.6288E+6,
                              3.99168E+7,
                              4.790016E+8,
                              6.2270208E+9,
                              8.71782912E+10,
                              1.307674368E+12,
                              2.0922789888E+13,
                              3.55687428096E+14,
                              6.402373705728E+15,
                              1.21645100408832E+17,
                              2.43290200817664E+18,
                              5.109094217170944E+19,
                              1.1240007277776077E+21};
  static const real_T p[8]{-1.716185138865495,  24.76565080557592,
                           -379.80425647094563, 629.3311553128184,
                           866.96620279041326,  -31451.272968848367,
                           -36144.413418691176, 66456.143820240541};
  static const real_T q[8]{-30.840230011973897, 315.35062697960416,
                           -1015.1563674902192, -3107.7716715723109,
                           22538.11842098015,   4755.8462775278813,
                           -134659.95986496931, -115132.25967555349};
  static const char_T cv1[5]{'m', 'o', 'r', 's', 'e'};
  static const char_T vstr[5]{'m', 'o', 'r', 's', 'e'};
  emxArray_real_T *a;
  emxArray_real_T *b_a;
  emxArray_real_T *b_x;
  emxArray_real_T *c_x;
  emxArray_real_T *d_x;
  emxArray_real_T *e_x;
  emxArray_real_T *f_x;
  emxArray_real_T *fx;
  emxArray_real_T *xt;
  emxArray_real_T *y;
  real_T interval[650];
  real_T absxk;
  real_T anorm;
  real_T cpsi;
  real_T pathlen;
  int32_T exitg1;
  int32_T ix;
  int32_T nx;
  char_T partial_match[5];
  char_T wavname[5];
  boolean_T first_iteration;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nx = 0;
  first_iteration = false;
  ix = 0;
  do {
    exitg1 = 0;
    if (ix + 1 < 6) {
      if (cv[static_cast<uint8_T>(wname[ix]) & 127] !=
          cv[static_cast<int32_T>(cv1[ix])]) {
        exitg1 = 1;
      } else {
        ix++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);
  if (first_iteration) {
    nx = 1;
    for (ix = 0; ix < 5; ix++) {
      partial_match[ix] = vstr[ix];
    }
  } else {
    for (ix = 0; ix < 5; ix++) {
      partial_match[ix] = ' ';
    }
  }
  if (nx != 0) {
    for (ix = 0; ix < 5; ix++) {
      wavname[ix] = partial_match[ix];
    }
  }
  anorm = 2.0 * std::exp(varargin_2 / varargin_1 *
                         ((std::log(varargin_1) - std::log(varargin_2)) + 1.0));
  first_iteration = false;
  ix = 0;
  do {
    exitg1 = 0;
    if (ix + 1 < 6) {
      if (cv[static_cast<int32_T>(wavname[ix])] !=
          cv[static_cast<int32_T>(cv1[ix])]) {
        exitg1 = 1;
      } else {
        ix++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);
  if (first_iteration) {
    real_T x;
    x = 2.0 * varargin_2 / varargin_1;
    if ((x >= 1.0) && (x <= 23.0) && (x == std::floor(x))) {
      x = gam[static_cast<int32_T>(x) - 1];
    } else if ((x < 1.0) && (x == std::floor(x))) {
      x = rtInf;
    } else if (!std::isnan(x)) {
      if (std::isinf(x)) {
        x = rtInf;
      } else {
        real_T midpt;
        real_T tol;
        tol = 1.0;
        nx = 1;
        first_iteration = false;
        if (x <= 0.0) {
          midpt = std::floor(-x);
          first_iteration = (midpt != std::floor(-x / 2.0) * 2.0);
          ::coder::internal::scalar::cospiAndSinpi(-x - midpt, &absxk);
          tol = -3.1415926535897931 / absxk;
          x = -x + 1.0;
        }
        if (x < 12.0) {
          real_T abserrsubk;
          real_T halfh;
          abserrsubk = x;
          if (x < 1.0) {
            midpt = x;
            x++;
          } else {
            nx = static_cast<int32_T>(std::floor(x));
            x -= std::floor(x) - 1.0;
            midpt = x - 1.0;
          }
          absxk = 0.0 * midpt;
          halfh = 1.0;
          for (ix = 0; ix < 8; ix++) {
            absxk = (absxk + p[ix]) * midpt;
            halfh = halfh * midpt + q[ix];
          }
          midpt = absxk / halfh + 1.0;
          if (abserrsubk < x) {
            midpt /= abserrsubk;
          } else if (abserrsubk > x) {
            for (int32_T j{0}; j <= nx - 2; j++) {
              midpt *= x;
              x++;
            }
          }
        } else {
          real_T halfh;
          midpt = x * x;
          halfh = 0.0057083835261;
          for (ix = 0; ix < 6; ix++) {
            halfh = halfh / midpt + dv3[ix];
          }
          halfh = (halfh / x - x) + 0.91893853320467278;
          halfh += (x - 0.5) * std::log(x);
          midpt = std::exp(halfh);
        }
        if (first_iteration) {
          midpt = -midpt;
        }
        if (tol != 1.0) {
          midpt = tol / midpt;
        }
        x = midpt;
      }
    }
    cpsi = anorm * anorm / (2.0 * varargin_1) *
           rt_powd_snf(0.5, 2.0 * (varargin_2 / varargin_1) - 1.0) * x;
  } else {
    real_T subs[1298];
    real_T errsub[649];
    real_T qsub[649];
    interval[0] = -1.0;
    interval[1] = 1.0;
    std::memset(&interval[2], 0, 648U * sizeof(real_T));
    cpsi = 0.0;
    ix = split(interval, 2, &pathlen);
    if (!(pathlen > 0.0)) {
      cpsi = 0.47999999999999976;
    } else {
      real_T err_ok;
      real_T q_ok;
      int32_T k;
      int32_T nsubs;
      nsubs = ix - 2;
      for (k = 0; k <= nsubs; k++) {
        subs[k << 1] = interval[k];
        subs[(k << 1) + 1] = interval[k + 1];
      }
      q_ok = 0.0;
      err_ok = 0.0;
      first_iteration = true;
      emxInit_real_T(&b_x, 2, &hc_emlrtRTEI, true);
      emxInit_real_T(&c_x, 2, &nc_emlrtRTEI, true);
      emxInit_real_T(&xt, 2, &oc_emlrtRTEI, true);
      emxInit_real_T(&y, 2, &dd_emlrtRTEI, true);
      emxInit_real_T(&a, 2, &ad_emlrtRTEI, true);
      emxInit_real_T(&fx, 2, &ed_emlrtRTEI, true);
      emxInit_real_T(&d_x, 2, &bd_emlrtRTEI, true);
      emxInit_real_T(&b_a, 2, &ad_emlrtRTEI, true);
      emxInit_real_T(&e_x, 2, &cd_emlrtRTEI, true);
      emxInit_real_T(&f_x, 2, &fd_emlrtRTEI, true);
      do {
        real_T halfh;
        real_T midpt;
        boolean_T guard1;
        exitg1 = 0;
        ix = b_x->size[0] * b_x->size[1];
        b_x->size[0] = 1;
        b_x->size[1] = 15 * (nsubs + 1);
        emxEnsureCapacity_real_T(b_x, ix, &hc_emlrtRTEI);
        ix = -1;
        for (k = 0; k <= nsubs; k++) {
          anorm = subs[k << 1];
          absxk = subs[(k << 1) + 1];
          midpt = (anorm + absxk) / 2.0;
          halfh = (absxk - anorm) / 2.0;
          for (int32_T j{0}; j < 15; j++) {
            b_x->data[(ix + j) + 1] = dv[j] * halfh + midpt;
          }
          ix += 15;
        }
        ix = c_x->size[0] * c_x->size[1];
        c_x->size[0] = 1;
        c_x->size[1] = b_x->size[1];
        emxEnsureCapacity_real_T(c_x, ix, &ic_emlrtRTEI);
        ix = xt->size[0] * xt->size[1];
        xt->size[0] = 1;
        xt->size[1] = b_x->size[1];
        emxEnsureCapacity_real_T(xt, ix, &jc_emlrtRTEI);
        ix = b_x->size[1];
        for (k = 0; k < ix; k++) {
          anorm = b_x->data[k];
          midpt = anorm * anorm;
          c_x->data[k] = 0.29999999999999982 * anorm * (3.0 - midpt) + 5.0;
          xt->data[k] = 0.89999999999999947 * (1.0 - midpt);
        }
        guard1 = false;
        if (!first_iteration) {
          boolean_T exitg2;
          absxk = std::abs(c_x->data[0]);
          k = 0;
          exitg2 = false;
          while ((!exitg2) && (k <= c_x->size[1] - 2)) {
            real_T x;
            x = absxk;
            absxk = std::abs(c_x->data[k + 1]);
            if (std::abs(c_x->data[k + 1] - c_x->data[k]) <=
                2.2204460492503131E-14 * std::fmax(x, absxk)) {
              first_iteration = true;
              exitg2 = true;
            } else {
              k++;
            }
          }
          if (first_iteration) {
            int16_T dv_idx_1;
            dv_idx_1 = static_cast<int16_T>(b_x->size[1]);
            ix = fx->size[0] * fx->size[1];
            fx->size[0] = 1;
            fx->size[1] = b_x->size[1];
            emxEnsureCapacity_real_T(fx, ix, &lc_emlrtRTEI);
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
          ix = a->size[0] * a->size[1];
          a->size[0] = 1;
          a->size[1] = c_x->size[1];
          emxEnsureCapacity_real_T(a, ix, &ad_emlrtRTEI);
          for (ix = 0; ix < c_x->size[1]; ix++) {
            a->data[ix] = (c_x->data[ix] - 5.0) / 0.6;
          }
          ix = y->size[0] * y->size[1];
          y->size[0] = 1;
          y->size[1] = a->size[1];
          emxEnsureCapacity_real_T(y, ix, &m_emlrtRTEI);
          nx = a->size[1];
          for (k = 0; k < nx; k++) {
            anorm = a->data[k];
            y->data[k] = anorm * anorm;
          }
          ix = d_x->size[0] * d_x->size[1];
          d_x->size[0] = 1;
          d_x->size[1] = y->size[1];
          emxEnsureCapacity_real_T(d_x, ix, &bd_emlrtRTEI);
          for (ix = 0; ix < y->size[1]; ix++) {
            d_x->data[ix] = -2.0 * (1.0 / (1.0 - y->data[ix]));
          }
          ix = b_a->size[0] * b_a->size[1];
          b_a->size[0] = 1;
          b_a->size[1] = c_x->size[1];
          emxEnsureCapacity_real_T(b_a, ix, &ad_emlrtRTEI);
          for (ix = 0; ix < c_x->size[1]; ix++) {
            b_a->data[ix] = (c_x->data[ix] - 5.0) / 0.6;
          }
          nx = b_a->size[1];
          for (k = 0; k < nx; k++) {
            d_x->data[k] = std::exp(d_x->data[k]);
          }
          ix = e_x->size[0] * e_x->size[1];
          e_x->size[0] = 1;
          e_x->size[1] = d_x->size[1];
          emxEnsureCapacity_real_T(e_x, ix, &cd_emlrtRTEI);
          for (ix = 0; ix < d_x->size[1]; ix++) {
            e_x->data[ix] = 14.7781121978613 * d_x->data[ix];
          }
          nx = d_x->size[1];
          ix = f_x->size[0] * f_x->size[1];
          f_x->size[0] = 1;
          f_x->size[1] = e_x->size[1];
          emxEnsureCapacity_real_T(f_x, ix, &l_emlrtRTEI);
          for (k = 0; k < nx; k++) {
            f_x->data[k] = std::abs(e_x->data[k]);
          }
          if (f_x->size[1] == c_x->size[1]) {
            ix = fx->size[0] * fx->size[1];
            fx->size[0] = 1;
            fx->size[1] = f_x->size[1];
            emxEnsureCapacity_real_T(fx, ix, &mc_emlrtRTEI);
            for (ix = 0; ix < f_x->size[1]; ix++) {
              fx->data[ix] = f_x->data[ix] / c_x->data[ix] * xt->data[ix];
            }
          } else {
            binary_expand_op_7(fx, f_x, c_x, xt);
          }
        }
        if (first_iteration) {
          exitg1 = 1;
        } else {
          real_T tol;
          midpt = 0.0;
          ix = -1;
          for (k = 0; k <= nsubs; k++) {
            anorm = 0.0;
            absxk = 0.0;
            for (int32_T j{0}; j < 15; j++) {
              anorm += dv1[j] * fx->data[(ix + j) + 1];
              absxk += dv2[j] * fx->data[(ix + j) + 1];
            }
            ix += 15;
            halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
            anorm *= halfh;
            qsub[k] = anorm;
            midpt += anorm;
            errsub[k] = absxk * halfh;
          }
          cpsi = midpt + q_ok;
          tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(cpsi));
          absxk = 2.0 * tol / pathlen;
          midpt = 0.0;
          ix = 0;
          for (k = 0; k <= nsubs; k++) {
            real_T abserrsubk;
            anorm = errsub[k];
            abserrsubk = std::abs(anorm);
            if (abserrsubk <=
                absxk * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
              err_ok += anorm;
              q_ok += qsub[k];
            } else {
              midpt += abserrsubk;
              ix++;
              subs[(ix - 1) << 1] = subs[k << 1];
              subs[((ix - 1) << 1) + 1] = subs[(k << 1) + 1];
            }
          }
          halfh = std::abs(err_ok) + midpt;
          if ((!std::isinf(cpsi)) && (!std::isnan(cpsi)) &&
              ((!std::isinf(halfh)) && (!std::isnan(halfh))) && (ix != 0) &&
              (!(halfh <= tol))) {
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
      emxFree_real_T(&f_x);
      emxFree_real_T(&e_x);
      emxFree_real_T(&b_a);
      emxFree_real_T(&d_x);
      emxFree_real_T(&fx);
      emxFree_real_T(&a);
      emxFree_real_T(&y);
      emxFree_real_T(&xt);
      emxFree_real_T(&c_x);
      emxFree_real_T(&b_x);
    }
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  return cpsi;
}

} // namespace cwt
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (numCpsi.cu)
