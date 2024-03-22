//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ResampleParser.cu
//
// Code generation for function 'ResampleParser'
//

// Include files
#include "ResampleParser.h"
#include "casyi.h"
#include "cmlri.h"
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "firls.h"
#include "gammaln.h"
#include "rt_nonfinite.h"
#include "warning.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo re_emlrtRTEI{
    694,              // lineNo
    48,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo se_emlrtRTEI{
    816,              // lineNo
    22,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo te_emlrtRTEI{
    37,                                                    // lineNo
    20,                                                    // colNo
    "kaiser",                                              // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/eml/kaiser.m" // pName
};

static emlrtRTEInfo ue_emlrtRTEI{
    816,              // lineNo
    63,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo ve_emlrtRTEI{
    816,              // lineNo
    17,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo we_emlrtRTEI{
    819,              // lineNo
    17,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo xe_emlrtRTEI{
    777,              // lineNo
    13,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo ye_emlrtRTEI{
    778,              // lineNo
    15,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo af_emlrtRTEI{
    778,              // lineNo
    27,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo bf_emlrtRTEI{
    778,              // lineNo
    13,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

// Function Definitions
//
//
namespace coder {
namespace b_signal {
namespace internal {
namespace resample {
void c_ResampleParser_createFilterAn(int32_T obj_dim, real_T obj_p,
                                     real_T obj_q,
                                     const real_T obj_inputSize[2],
                                     boolean_T obj_isRowVectorInput,
                                     const emxArray_creal_T *obj_x,
                                     ResampleParser *obj)
{
  emxArray_int32_T *iv;
  emxArray_real_T *b_dv1;
  emxArray_real_T *c_dv;
  emxArray_real_T *h1;
  emxArray_real_T *r;
  emxArray_uint32_T *y;
  creal_T tmp;
  creal_T zd;
  real_T ak;
  real_T fc;
  real_T pqmax;
  int32_T inw;
  int32_T iseven;
  int32_T nw;
  nvtxRangePushA("#fcn#c_ResampleParser_createFilterAn#" MW_AT_LOCATION);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  obj->dim = obj_dim;
  obj->p = obj_p;
  obj->q = obj_q;
  obj->inputSize[0] = obj_inputSize[0];
  obj->inputSize[1] = obj_inputSize[1];
  obj->isRowVectorInput = obj_isRowVectorInput;
  inw = obj->x->size[0] * obj->x->size[1];
  obj->x->size[0] = obj_x->size[0];
  obj->x->size[1] = obj_x->size[1];
  nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
  emxEnsureCapacity_creal_T(obj->x, inw, &re_emlrtRTEI);
  profileLoopStart("c_ResampleParser_createFilterAn_loop_0", __LINE__,
                   (obj_x->size[0] * obj_x->size[1] - 1) + 1, "");
  for (inw = 0; inw < obj_x->size[0] * obj_x->size[1]; inw++) {
    obj->x->data[inw] = obj_x->data[inw];
  }
  real_T b_dv[4];
  profileLoopEnd();
  pqmax = std::fmax(obj_p, obj_q);
  fc = 0.5 / pqmax;
  pqmax = 20.0 * pqmax + 1.0;
  b_dv[0] = 0.0;
  b_dv[1] = 2.0 * fc;
  b_dv[2] = 2.0 * fc;
  b_dv[3] = 1.0;
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&r, 2, &se_emlrtRTEI, true);
  nvtxMarkA("#firls#" MW_AT_LINE);
  firls(pqmax - 1.0, b_dv, r);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_dv, 1, &se_emlrtRTEI, true);
  inw = c_dv->size[0];
  c_dv->size[0] = r->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(c_dv, inw, &se_emlrtRTEI);
  profileLoopStart("c_ResampleParser_createFilterAn_loop_1", __LINE__,
                   (r->size[1] - 1) + 1, "");
  for (inw = 0; inw < r->size[1]; inw++) {
    c_dv->data[inw] = r->data[inw];
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&r);
  if (pqmax == std::floor(pqmax)) {
    nw = static_cast<int32_T>(pqmax);
  } else {
    nw = static_cast<int32_T>(std::round(pqmax));
    nvtxMarkA("#warning#" MW_AT_LINE);
    ::coder::internal::warning();
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_dv1, 1, &se_emlrtRTEI, true);
  inw = b_dv1->size[0];
  b_dv1->size[0] = nw;
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(b_dv1, inw, &te_emlrtRTEI);
  if (nw <= 1) {
    inw = b_dv1->size[0];
    b_dv1->size[0] = nw;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(b_dv1, inw, &ue_emlrtRTEI);
    profileLoopStart("c_ResampleParser_createFilterAn_loop_2", __LINE__,
                     (nw - 1) + 1, "");
    for (inw = 0; inw < nw; inw++) {
      b_dv1->data[inw] = 1.0;
    }
    profileLoopEnd();
  } else {
    int64_T b;
    int32_T mid;
    iseven = 1 - (nw & 1);
    mid = (nw >> 1) + 1;
    nvtxMarkA("#computeEndIdx#" MW_AT_LINE);
    if (computeEndIdx(static_cast<int64_T>(mid), static_cast<int64_T>(nw),
                      1L) >= 0L) {
      zd.im = 0.0;
    }
    nvtxMarkA("#computeEndIdx#" MW_AT_LINE);
    b = computeEndIdx(static_cast<int64_T>(mid), static_cast<int64_T>(nw), 1L);
    profileLoopStart("c_ResampleParser_createFilterAn_loop_3", __LINE__, b + 1L,
                     "");
    for (int64_T k{0L}; k <= b; k++) {
      pqmax = static_cast<real_T>(
                  iseven + ((static_cast<int32_T>(mid + k) - mid) << 1)) /
              (static_cast<real_T>(nw) - 1.0);
      zd.re = 5.0 * std::sqrt((1.0 - pqmax) * (pqmax + 1.0));
      if (std::isnan(zd.re)) {
        tmp.re = rtNaN;
        tmp.im = 0.0;
      } else {
        real_T az;
        int32_T b_nw;
        int32_T ierr;
        boolean_T guard1;
        ierr = 0;
        nvtxMarkA("#rt_hypotd_snf#" MW_AT_LINE);
        pqmax = rt_hypotd_snf(zd.re, 0.0);
        if (pqmax > 1.0737418235E+9) {
          ierr = 4;
        } else if (pqmax > 32767.999992370605) {
          ierr = 3;
        }
        tmp.re = 0.0;
        tmp.im = 0.0;
        nvtxMarkA("#rt_hypotd_snf#" MW_AT_LINE);
        az = rt_hypotd_snf(zd.re, 0.0);
        guard1 = false;
        if (az <= 2.0) {
          b_nw = 0;
          nvtxMarkA("#rt_hypotd_snf#" MW_AT_LINE);
          pqmax = rt_hypotd_snf(zd.re, 0.0);
          if (pqmax == 0.0) {
            tmp.re = 1.0;
            tmp.im = 0.0;
          } else if (pqmax < 2.2250738585072014E-305) {
            tmp.re = 1.0;
            tmp.im = 0.0;
          } else {
            real_T acz;
            real_T cz_re;
            fc = 0.5 * zd.re;
            if (pqmax > 4.7170688552396617E-153) {
              cz_re = fc * fc;
              nvtxMarkA("#rt_hypotd_snf#" MW_AT_LINE);
              acz = rt_hypotd_snf(cz_re, 0.0);
            } else {
              cz_re = 0.0;
              acz = 0.0;
            }
            pqmax = 1.0;
            nvtxMarkA("#gammaln#" MW_AT_LINE);
            gammaln(&pqmax);
            fc = std::log(fc) * 0.0 - pqmax;
            if (fc > -700.92179369444591) {
              real_T b_atol;
              real_T coef_im;
              real_T coef_re;
              real_T s1_im;
              real_T s1_re;
              coef_re = std::exp(fc);
              coef_im = std::exp(fc) * 0.0;
              b_atol = 2.2204460492503131E-16 * acz;
              s1_re = 1.0;
              s1_im = 0.0;
              if (!(acz < 2.2204460492503131E-16)) {
                real_T aa;
                real_T s;
                fc = 1.0;
                pqmax = 0.0;
                ak = 3.0;
                s = 1.0;
                aa = 2.0;
                nvtxRangePushA("#loop#c_ResampleParser_createFilterAn_"
                               "whileloop_1##" MW_AT_LINE);
                real_T re;
                real_T rs;
                do {
                  rs = 1.0 / s;
                  re = fc * cz_re - pqmax * 0.0;
                  pqmax = fc * 0.0 + pqmax * cz_re;
                  fc = rs * re;
                  pqmax *= rs;
                  s1_re += fc;
                  s1_im += pqmax;
                  s += ak;
                  ak += 2.0;
                  aa = aa * acz * rs;
                } while (!!(aa > b_atol));
                nvtxRangePop();
              }
              pqmax = s1_re * coef_re - s1_im * coef_im;
              s1_im = s1_re * coef_im + s1_im * coef_re;
              tmp.re = pqmax - s1_im * 0.0;
              tmp.im = pqmax * 0.0 + s1_im;
            } else {
              b_nw = 1;
              if (acz > 0.0) {
                b_nw = -1;
              }
            }
          }
          if (b_nw < 0) {
            inw = 1;
          } else {
            inw = b_nw;
          }
          if ((1 - inw != 0) && (b_nw < 0)) {
            guard1 = true;
          }
        } else {
          guard1 = true;
        }
        if (guard1) {
          if (az < 21.784271729432426) {
            nvtxMarkA("#cmlri#" MW_AT_LINE);
            b_nw = cmlri(zd, 0.0, 1, &tmp);
            if (b_nw < 0) {
              if (b_nw == -2) {
                inw = -2;
              } else {
                inw = -1;
              }
            } else {
              inw = 0;
            }
          } else {
            nvtxMarkA("#casyi#" MW_AT_LINE);
            b_nw = casyi(zd, 0.0, 1, &tmp);
            if (b_nw < 0) {
              if (b_nw == -2) {
                inw = -2;
              } else {
                inw = -1;
              }
            } else {
              inw = 0;
            }
          }
        }
        guard1 = false;
        if (inw < 0) {
          if (inw == -2) {
            tmp.re = rtNaN;
            tmp.im = 0.0;
          } else {
            ierr = 2;
            guard1 = true;
          }
        } else {
          guard1 = true;
        }
        if (guard1 && (ierr == 2)) {
          tmp.re = rtInf;
          tmp.im = 0.0;
        }
        if (zd.re > 0.0) {
          pqmax = tmp.re;
          tmp.re = pqmax;
          tmp.im = 0.0;
        }
      }
      if (tmp.im == 0.0) {
        pqmax = tmp.re / 27.239871823604449;
        fc = 0.0;
      } else if (tmp.re == 0.0) {
        pqmax = 0.0;
        fc = tmp.im / 27.239871823604449;
      } else {
        pqmax = tmp.re / 27.239871823604449;
        fc = tmp.im / 27.239871823604449;
      }
      nvtxMarkA("#rt_hypotd_snf#" MW_AT_LINE);
      b_dv1->data[static_cast<int32_T>(mid + k) - 1] = rt_hypotd_snf(pqmax, fc);
    }
    profileLoopEnd();
    profileLoopStart("c_ResampleParser_createFilterAn_loop_4", __LINE__,
                     (mid - 2) + 1, "");
    for (iseven = 0; iseven <= mid - 2; iseven++) {
      b_dv1->data[iseven] = b_dv1->data[(nw - iseven) - 1];
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&h1, 1, &ve_emlrtRTEI, true);
  inw = h1->size[0];
  h1->size[0] = c_dv->size[0];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(h1, inw, &ve_emlrtRTEI);
  profileLoopStart("c_ResampleParser_createFilterAn_loop_5", __LINE__,
                   (c_dv->size[0] - 1) + 1, "");
  for (inw = 0; inw < c_dv->size[0]; inw++) {
    h1->data[inw] = c_dv->data[inw] * b_dv1->data[inw];
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_dv1);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_dv);
  inw = h1->size[0];
  if (h1->size[0] == 0) {
    pqmax = 0.0;
  } else {
    pqmax = h1->data[0];
    profileLoopStart("c_ResampleParser_createFilterAn_loop_6", __LINE__,
                     (inw - 2) + 1, "");
    for (iseven = 0; iseven <= inw - 2; iseven++) {
      pqmax += h1->data[iseven + 1];
    }
    profileLoopEnd();
  }
  inw = obj->filter->size[0];
  obj->filter->size[0] = h1->size[0];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(obj->filter, inw, &we_emlrtRTEI);
  profileLoopStart("c_ResampleParser_createFilterAn_loop_7", __LINE__,
                   (h1->size[0] - 1) + 1, "");
  for (inw = 0; inw < h1->size[0]; inw++) {
    obj->filter->data[inw] = obj_p * h1->data[inw] / pqmax;
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&h1);
  fc = (static_cast<real_T>(obj->filter->size[0]) - 1.0) / 2.0;
  pqmax = fc;
  if (obj_q == 0.0) {
    if (fc == 0.0) {
      pqmax = 0.0;
    }
  } else if (std::isnan(obj_q)) {
    pqmax = rtNaN;
  } else if (fc == 0.0) {
    pqmax = 0.0 / obj_q;
  } else if (std::isinf(obj_q)) {
    if (fc < 0.0) {
      pqmax = obj_q;
    }
  } else {
    pqmax = std::fmod(fc, obj_q);
    if (pqmax == 0.0) {
      pqmax = obj_q * 0.0;
    } else if (fc < 0.0) {
      pqmax += obj_q;
    }
  }
  ak = std::floor(obj_q - pqmax);
  obj->filterDelay = std::floor(std::ceil(fc + ak) / obj_q);
  pqmax = static_cast<real_T>(obj->filter->size[0]) + ak;
  fc = 0.0;
  inw = obj_x->size[0];
  nvtxRangePushA(
      "#loop#c_ResampleParser_createFilterAn_whileloop_0##" MW_AT_LINE);
  while (std::ceil((((static_cast<real_T>(inw) - 1.0) * obj_p + pqmax) + fc) /
                   obj_q) -
             obj->filterDelay <
         std::ceil(static_cast<real_T>(inw) * obj_p / obj_q)) {
    fc++;
  }
  nvtxRangePop();
  inw = obj->filterWithPadding->size[0];
  obj->filterWithPadding->size[0] = static_cast<int32_T>(
      (ak + static_cast<real_T>(obj->filter->size[0])) + fc);
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(obj->filterWithPadding, inw, &xe_emlrtRTEI);
  profileLoopStart("c_ResampleParser_createFilterAn_loop_8", __LINE__,
                   (static_cast<int32_T>(
                        (ak + static_cast<real_T>(obj->filter->size[0])) + fc) -
                    1) +
                       1,
                   "");
  for (inw = 0;
       inw < static_cast<int32_T>(
                 (ak + static_cast<real_T>(obj->filter->size[0])) + fc);
       inw++) {
    obj->filterWithPadding->data[inw] = 0.0;
  }
  profileLoopEnd();
  nvtxMarkA("#emxInit_uint32_T#" MW_AT_LINE);
  emxInit_uint32_T(&y, 2, &af_emlrtRTEI, true);
  if (obj->filter->size[0] < 1) {
    y->size[0] = 1;
    y->size[1] = 0;
  } else {
    uint32_T u;
    u = static_cast<uint32_T>(obj->filter->size[0]);
    inw = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = obj->filter->size[0];
    nvtxMarkA("#emxEnsureCapacity_uint32_T#" MW_AT_LINE);
    emxEnsureCapacity_uint32_T(y, inw, &ib_emlrtRTEI);
    profileLoopStart("c_ResampleParser_createFilterAn_loop_9", __LINE__,
                     (static_cast<int32_T>(u) - 1) + 1, "");
    for (inw = 0; inw < static_cast<int32_T>(u); inw++) {
      y->data[inw] = static_cast<uint32_T>(inw) + 1U;
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&iv, 2, &bf_emlrtRTEI, true);
  inw = iv->size[0] * iv->size[1];
  iv->size[0] = 1;
  iv->size[1] = y->size[1];
  nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
  emxEnsureCapacity_int32_T(iv, inw, &ye_emlrtRTEI);
  profileLoopStart("c_ResampleParser_createFilterAn_loop_10", __LINE__,
                   (y->size[1] - 1) + 1, "");
  for (inw = 0; inw < y->size[1]; inw++) {
    iv->data[inw] =
        static_cast<int32_T>(ak + static_cast<real_T>(y->data[inw]));
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_uint32_T#" MW_AT_LINE);
  emxFree_uint32_T(&y);
  profileLoopStart("c_ResampleParser_createFilterAn_loop_11", __LINE__,
                   (iv->size[1] - 1) + 1, "");
  for (inw = 0; inw < iv->size[1]; inw++) {
    obj->filterWithPadding->data[iv->data[inw] - 1] = obj->filter->data[inw];
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&iv);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxRangePop();
}

} // namespace resample
} // namespace internal
} // namespace b_signal
} // namespace coder

// End of code generation (ResampleParser.cu)
