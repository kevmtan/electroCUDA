//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// wavCFandSD.cu
//
// Code generation for function 'wavCFandSD'
//

// Include files
#include "wavCFandSD.h"
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "gammaln.h"
#include "quadgk.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo oc_emlrtRTEI{
    64,                // lineNo
    28,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

static emlrtRTEInfo tc_emlrtRTEI{
    64,                // lineNo
    31,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

static emlrtRTEInfo uc_emlrtRTEI{
    1,            // lineNo
    39,           // colNo
    "wavCFandSD", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavCFandSD.m" // pName
};

static emlrtRTEInfo vc_emlrtRTEI{
    64,                // lineNo
    12,                // colNo
    "morseproperties", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morseproperties.m" // pName
};

// Function Definitions
//
//
namespace coder {
namespace wavelet {
namespace internal {
namespace cwt {
real_T wavCFandSD(char_T wname[5], real_T varargin_1, real_T varargin_2,
                  real_T *sigmaT, real_T *cf)
{
  emxArray_real_T *b_dv1;
  emxArray_real_T *b_x;
  emxArray_real_T *b_y;
  emxArray_real_T *fx;
  emxArray_real_T *x;
  emxArray_real_T *xt;
  emxArray_real_T *y;
  real_T interval[650];
  real_T FourierFactor;
  real_T b_be;
  real_T d;
  real_T d1;
  real_T d2;
  real_T d3;
  real_T d4;
  real_T err_ok;
  int32_T k;
  nvtxRangePushA("#fcn#wavCFandSD#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  profileLoopStart("wavCFandSD_loop_0", __LINE__, 4 + 1, "");
  for (k = 0; k < 5; k++) {
    wname[k] = cv[static_cast<uint8_T>(wname[k]) & 127];
  }
  profileLoopEnd();
  if (wname[0] == 'm') {
    real_T abserrsubk;
    real_T be;
    real_T halfh;
    real_T intFsq;
    real_T midpt;
    real_T q_ok;
    real_T tol;
    *cf = std::exp(1.0 / varargin_1 *
                   (std::log(varargin_2) - std::log(varargin_1)));
    midpt = 2.0 * (varargin_2 - 1.0);
    halfh = 2.0 * varargin_2;
    abserrsubk = (varargin_2 - 1.0) + varargin_1;
    tol = 2.0 * ((varargin_2 - 1.0) + varargin_1);
    intFsq = 2.0 * varargin_2;
    be = (varargin_2 - 1.0) + varargin_1 / 2.0;
    b_be = 2.0 * ((varargin_2 - 1.0) + varargin_1 / 2.0);
    q_ok = 2.0 * varargin_2;
    d = (2.0 * (varargin_2 - 1.0) + 1.0) / varargin_1;
    nvtxMarkA("#gammaln#" MW_AT_LINE);
    gammaln(&d);
    d1 = (2.0 * varargin_2 + 1.0) / varargin_1;
    nvtxMarkA("#gammaln#" MW_AT_LINE);
    gammaln(&d1);
    err_ok = (2.0 * ((varargin_2 - 1.0) + varargin_1) + 1.0) / varargin_1;
    nvtxMarkA("#gammaln#" MW_AT_LINE);
    gammaln(&err_ok);
    d2 = (2.0 * varargin_2 + 1.0) / varargin_1;
    nvtxMarkA("#gammaln#" MW_AT_LINE);
    gammaln(&d2);
    d3 = (2.0 * ((varargin_2 - 1.0) + varargin_1 / 2.0) + 1.0) / varargin_1;
    nvtxMarkA("#gammaln#" MW_AT_LINE);
    gammaln(&d3);
    d4 = (2.0 * varargin_2 + 1.0) / varargin_1;
    nvtxMarkA("#gammaln#" MW_AT_LINE);
    gammaln(&d4);
    *sigmaT = std::sqrt(
        (std::exp(((((((2.0 * (varargin_2 / varargin_1 *
                               ((std::log(varargin_1) + 1.0) -
                                std::log(varargin_2))) -
                        2.0 * ((varargin_2 - 1.0) / varargin_1 *
                               ((std::log(varargin_1) + 1.0) -
                                std::log(varargin_2 - 1.0)))) +
                       midpt / varargin_1 *
                           ((std::log(varargin_1) + 1.0) - std::log(midpt))) -
                      halfh / varargin_1 *
                          ((std::log(varargin_1) + 1.0) - std::log(halfh))) +
                     2.0 / varargin_1 * std::log(varargin_2 / varargin_1)) +
                    2.0 * std::log(varargin_2)) +
                   d) -
                  d1) +
         std::exp(((((((2.0 * (varargin_2 / varargin_1 *
                               ((std::log(varargin_1) + 1.0) -
                                std::log(varargin_2))) -
                        2.0 * (abserrsubk / varargin_1 *
                               ((std::log(varargin_1) + 1.0) -
                                std::log(abserrsubk)))) +
                       tol / varargin_1 *
                           ((std::log(varargin_1) + 1.0) - std::log(tol))) -
                      intFsq / varargin_1 *
                          ((std::log(varargin_1) + 1.0) - std::log(intFsq))) +
                     2.0 / varargin_1 * std::log(varargin_2 / varargin_1)) +
                    2.0 * std::log(varargin_1)) +
                   err_ok) -
                  d2)) -
        std::exp(
            ((((((((2.0 * (varargin_2 / varargin_1 *
                           ((std::log(varargin_1) + 1.0) -
                            std::log(varargin_2))) -
                    2.0 * (be / varargin_1 *
                           ((std::log(varargin_1) + 1.0) - std::log(be)))) +
                   b_be / varargin_1 *
                       ((std::log(varargin_1) + 1.0) - std::log(b_be))) -
                  q_ok / varargin_1 *
                      ((std::log(varargin_1) + 1.0) - std::log(q_ok))) +
                 2.0 / varargin_1 * std::log(varargin_2 / varargin_1)) +
                0.69314718055994529) +
               std::log(varargin_2)) +
              std::log(varargin_1)) +
             d3) -
            d4));
    if (std::isinf(*sigmaT) || std::isnan(*sigmaT)) {
      real_T subs[1298];
      real_T errsub[649];
      real_T qsub[649];
      int32_T ix;
      be = std::exp(1.0 / varargin_1 *
                    (std::log(varargin_2) - std::log(varargin_1)));
      interval[0] = 0.0;
      interval[1] = 1.0;
      std::memset(&interval[2], 0, 648U * sizeof(real_T));
      intFsq = 0.0;
      nvtxMarkA("#split#" MW_AT_LINE);
      ix = split(interval, 2, &b_be);
      if (!(b_be > 0.0)) {
        nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
        nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
        intFsq = rtInf * (rt_powd_snf(rtInf, 2.0 * varargin_2) *
                          std::exp(-2.0 * rt_powd_snf(rtInf, varargin_1)));
      } else {
        int32_T nsubs;
        boolean_T first_iteration;
        nsubs = ix - 2;
        profileLoopStart("wavCFandSD_loop_1", __LINE__, nsubs + 1, "");
        for (k = 0; k <= nsubs; k++) {
          subs[k << 1] = interval[k];
          subs[(k << 1) + 1] = interval[k + 1];
        }
        profileLoopEnd();
        q_ok = 0.0;
        err_ok = 0.0;
        first_iteration = true;
        nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
        emxInit_real_T(&x, 2, &lc_emlrtRTEI, true);
        nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
        emxInit_real_T(&b_x, 2, &rc_emlrtRTEI, true);
        nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
        emxInit_real_T(&xt, 2, &sc_emlrtRTEI, true);
        nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
        emxInit_real_T(&y, 2, &tc_emlrtRTEI, true);
        nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
        emxInit_real_T(&fx, 2, &uc_emlrtRTEI, true);
        nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
        emxInit_real_T(&b_dv1, 2, &vc_emlrtRTEI, true);
        nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
        emxInit_real_T(&b_y, 2, &vc_emlrtRTEI, true);
        nvtxRangePushA("#loop#wavCFandSD_whileloop_0##" MW_AT_LINE);
        int32_T exitg1;
        do {
          boolean_T guard1;
          exitg1 = 0;
          ix = x->size[0] * x->size[1];
          x->size[0] = 1;
          x->size[1] = 15 * (nsubs + 1);
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(x, ix, &lc_emlrtRTEI);
          ix = -1;
          profileLoopStart("wavCFandSD_loop_2", __LINE__, nsubs + 1, "");
          for (k = 0; k <= nsubs; k++) {
            d = subs[k << 1];
            d1 = subs[(k << 1) + 1];
            midpt = (d + d1) / 2.0;
            halfh = (d1 - d) / 2.0;
            profileLoopStart("wavCFandSD_loop_3", __LINE__, 14 + 1, "");
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
          emxEnsureCapacity_real_T(b_x, ix, &mc_emlrtRTEI);
          ix = xt->size[0] * xt->size[1];
          xt->size[0] = 1;
          xt->size[1] = x->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(xt, ix, &nc_emlrtRTEI);
          ix = x->size[1];
          profileLoopStart("wavCFandSD_loop_4", __LINE__, (ix - 1) + 1, "");
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
            nvtxRangePushA("#loop#wavCFandSD_whileloop_1##" MW_AT_LINE);
            while ((!exitg2) && (k <= b_x->size[1] - 2)) {
              halfh = midpt;
              midpt = std::abs(b_x->data[k + 1]);
              if (std::abs(b_x->data[k + 1] - b_x->data[k]) <=
                  2.2204460492503131E-14 * std::fmax(halfh, midpt)) {
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
              emxEnsureCapacity_real_T(fx, ix, &pc_emlrtRTEI);
              profileLoopStart("wavCFandSD_loop_8", __LINE__,
                               (dv_idx_1 - 1) + 1, "");
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
            emxEnsureCapacity_real_T(y, ix, &m_emlrtRTEI);
            ix = b_x->size[1];
            profileLoopStart("wavCFandSD_loop_6", __LINE__, (ix - 1) + 1, "");
            for (k = 0; k < ix; k++) {
              nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
              y->data[k] = rt_powd_snf(b_x->data[k], varargin_1);
            }
            profileLoopEnd();
            ix = b_dv1->size[0] * b_dv1->size[1];
            b_dv1->size[0] = 1;
            b_dv1->size[1] = y->size[1];
            nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
            emxEnsureCapacity_real_T(b_dv1, ix, &oc_emlrtRTEI);
            profileLoopStart("wavCFandSD_loop_10", __LINE__,
                             (y->size[1] - 1) + 1, "");
            for (ix = 0; ix < y->size[1]; ix++) {
              b_dv1->data[ix] = -2.0 * y->data[ix];
            }
            profileLoopEnd();
            ix = b_x->size[1];
            profileLoopStart("wavCFandSD_loop_11", __LINE__, (ix - 1) + 1, "");
            for (k = 0; k < ix; k++) {
              b_dv1->data[k] = std::exp(b_dv1->data[k]);
            }
            profileLoopEnd();
            midpt = 2.0 * varargin_2;
            ix = b_y->size[0] * b_y->size[1];
            b_y->size[0] = 1;
            b_y->size[1] = b_x->size[1];
            nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
            emxEnsureCapacity_real_T(b_y, ix, &m_emlrtRTEI);
            ix = b_x->size[1];
            profileLoopStart("wavCFandSD_loop_13", __LINE__, (ix - 1) + 1, "");
            for (k = 0; k < ix; k++) {
              nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
              b_y->data[k] = rt_powd_snf(b_x->data[k], midpt);
            }
            profileLoopEnd();
            if (b_y->size[1] == b_dv1->size[1]) {
              ix = fx->size[0] * fx->size[1];
              fx->size[0] = 1;
              fx->size[1] = b_y->size[1];
              nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
              emxEnsureCapacity_real_T(fx, ix, &qc_emlrtRTEI);
              profileLoopStart("wavCFandSD_loop_14", __LINE__,
                               (b_y->size[1] - 1) + 1, "");
              for (ix = 0; ix < b_y->size[1]; ix++) {
                fx->data[ix] = b_y->data[ix] * b_dv1->data[ix] * xt->data[ix];
              }
              profileLoopEnd();
            } else {
              nvtxMarkA("#binary_expand_op_3#" MW_AT_LINE);
              binary_expand_op_3(fx, b_y, b_dv1, xt);
            }
          }
          if (first_iteration) {
            exitg1 = 1;
          } else {
            midpt = 0.0;
            ix = -1;
            profileLoopStart("wavCFandSD_loop_5", __LINE__, nsubs + 1, "");
            for (k = 0; k <= nsubs; k++) {
              d = 0.0;
              d1 = 0.0;
              profileLoopStart("wavCFandSD_loop_7", __LINE__, 14 + 1, "");
              for (int32_T j{0}; j < 15; j++) {
                d += dv1[j] * fx->data[(ix + j) + 1];
                d1 += dv2[j] * fx->data[(ix + j) + 1];
              }
              profileLoopEnd();
              ix += 15;
              halfh = (subs[(k << 1) + 1] - subs[k << 1]) / 2.0;
              d *= halfh;
              qsub[k] = d;
              midpt += d;
              errsub[k] = d1 * halfh;
            }
            profileLoopEnd();
            intFsq = midpt + q_ok;
            tol = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
            midpt = 2.0 * tol / b_be;
            halfh = 0.0;
            ix = 0;
            profileLoopStart("wavCFandSD_loop_9", __LINE__, nsubs + 1, "");
            for (k = 0; k <= nsubs; k++) {
              d = errsub[k];
              abserrsubk = std::abs(d);
              if (abserrsubk <=
                  midpt * ((subs[(k << 1) + 1] - subs[k << 1]) / 2.0)) {
                err_ok += d;
                q_ok += qsub[k];
              } else {
                halfh += abserrsubk;
                ix++;
                subs[(ix - 1) << 1] = subs[k << 1];
                subs[((ix - 1) << 1) + 1] = subs[(k << 1) + 1];
              }
            }
            profileLoopEnd();
            midpt = std::abs(err_ok) + halfh;
            if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) &&
                ((!std::isinf(midpt)) && (!std::isnan(midpt))) && (ix != 0) &&
                (!(midpt <= tol))) {
              nsubs = (ix << 1) - 1;
              if (nsubs + 1 > 650) {
                exitg1 = 1;
              } else {
                profileLoopStart("wavCFandSD_loop_12", __LINE__, (ix - 1) + 1,
                                 "");
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
      nvtxMarkA("#quadgk#" MW_AT_LINE);
      *sigmaT = std::sqrt(be * be * (quadgk(varargin_2, varargin_1) / intFsq));
    }
  } else if (wname[0] == 'a') {
    *cf = 6.0;
    *sigmaT = 1.4142135623730951;
  } else {
    *cf = 5.0;
    *sigmaT = 5.847705;
  }
  FourierFactor = 6.2831853071795862 / *cf;
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
  return FourierFactor;
}

} // namespace cwt
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (wavCFandSD.cu)
