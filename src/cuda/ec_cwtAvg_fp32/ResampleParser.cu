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
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_emxutil.h"
#include "ec_cwtAvg_mexutil.h"
#include "ec_cwtAvg_types.h"
#include "firls.h"
#include "gammaln.h"
#include "rt_nonfinite.h"
#include "warning.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo wf_emlrtRTEI{
    816,              // lineNo
    22,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo xf_emlrtRTEI{
    37,                                                    // lineNo
    20,                                                    // colNo
    "kaiser",                                              // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/eml/kaiser.m" // pName
};

static emlrtRTEInfo yf_emlrtRTEI{
    816,              // lineNo
    63,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo ag_emlrtRTEI{
    816,              // lineNo
    17,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo bg_emlrtRTEI{
    745,              // lineNo
    21,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo cg_emlrtRTEI{
    777,              // lineNo
    13,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo dg_emlrtRTEI{
    778,              // lineNo
    15,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo eg_emlrtRTEI{
    778,              // lineNo
    27,               // colNo
    "ResampleParser", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/ResampleParser.m" // pName
};

static emlrtRTEInfo fg_emlrtRTEI{
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
void c_ResampleParser_createFilterAn(const real_T *obj_p, const real_T *obj_q,
                                     emxArray_real32_T *obj_filter,
                                     emxArray_real32_T *obj_filterWithPadding,
                                     real_T *obj_filterDelay,
                                     const emxArray_real32_T *obj_x)
{
  emxArray_int32_T *iv;
  emxArray_real_T *b_dv1;
  emxArray_real_T *c_dv;
  emxArray_real_T *h1;
  emxArray_real_T *r;
  emxArray_uint32_T *y;
  creal_T tmp;
  creal_T zd;
  real_T b_dv[4];
  real_T ak;
  real_T fc;
  real_T pqmax;
  int32_T inw;
  int32_T iseven;
  int32_T nw;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  pqmax = std::fmax(*obj_p, *obj_q);
  fc = 0.5 / pqmax;
  pqmax = 20.0 * pqmax + 1.0;
  b_dv[0] = 0.0;
  b_dv[1] = 2.0 * fc;
  b_dv[2] = 2.0 * fc;
  b_dv[3] = 1.0;
  emxInit_real_T(&r, 2, &wf_emlrtRTEI, true);
  firls(pqmax - 1.0, b_dv, r);
  emxInit_real_T(&c_dv, 1, &wf_emlrtRTEI, true);
  iseven = c_dv->size[0];
  c_dv->size[0] = r->size[1];
  emxEnsureCapacity_real_T(c_dv, iseven, &wf_emlrtRTEI);
  for (iseven = 0; iseven < r->size[1]; iseven++) {
    c_dv->data[iseven] = r->data[iseven];
  }
  emxFree_real_T(&r);
  if (pqmax == std::floor(pqmax)) {
    nw = static_cast<int32_T>(pqmax);
  } else {
    nw = static_cast<int32_T>(std::round(pqmax));
    ::coder::internal::warning();
  }
  emxInit_real_T(&b_dv1, 1, &wf_emlrtRTEI, true);
  iseven = b_dv1->size[0];
  b_dv1->size[0] = nw;
  emxEnsureCapacity_real_T(b_dv1, iseven, &xf_emlrtRTEI);
  if (nw <= 1) {
    iseven = b_dv1->size[0];
    b_dv1->size[0] = nw;
    emxEnsureCapacity_real_T(b_dv1, iseven, &yf_emlrtRTEI);
    for (iseven = 0; iseven < nw; iseven++) {
      b_dv1->data[iseven] = 1.0;
    }
  } else {
    int64_T b;
    int32_T mid;
    iseven = 1 - (nw & 1);
    mid = (nw >> 1) + 1;
    if (computeEndIdx(static_cast<int64_T>(mid), static_cast<int64_T>(nw),
                      1L) >= 0L) {
      zd.im = 0.0;
    }
    b = computeEndIdx(static_cast<int64_T>(mid), static_cast<int64_T>(nw), 1L);
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
        pqmax = rt_hypotd_snf(zd.re, 0.0);
        if (pqmax > 1.0737418235E+9) {
          ierr = 4;
        } else if (pqmax > 32767.999992370605) {
          ierr = 3;
        }
        tmp.re = 0.0;
        tmp.im = 0.0;
        az = rt_hypotd_snf(zd.re, 0.0);
        guard1 = false;
        if (az <= 2.0) {
          b_nw = 0;
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
              acz = rt_hypotd_snf(cz_re, 0.0);
            } else {
              cz_re = 0.0;
              acz = 0.0;
            }
            pqmax = 1.0;
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
      b_dv1->data[static_cast<int32_T>(mid + k) - 1] = rt_hypotd_snf(pqmax, fc);
    }
    for (iseven = 0; iseven <= mid - 2; iseven++) {
      b_dv1->data[iseven] = b_dv1->data[(nw - iseven) - 1];
    }
  }
  emxInit_real_T(&h1, 1, &ag_emlrtRTEI, true);
  iseven = h1->size[0];
  h1->size[0] = c_dv->size[0];
  emxEnsureCapacity_real_T(h1, iseven, &ag_emlrtRTEI);
  for (iseven = 0; iseven < c_dv->size[0]; iseven++) {
    h1->data[iseven] = c_dv->data[iseven] * b_dv1->data[iseven];
  }
  emxFree_real_T(&b_dv1);
  emxFree_real_T(&c_dv);
  inw = h1->size[0];
  if (h1->size[0] == 0) {
    pqmax = 0.0;
  } else {
    pqmax = h1->data[0];
    for (iseven = 0; iseven <= inw - 2; iseven++) {
      pqmax += h1->data[iseven + 1];
    }
  }
  iseven = obj_filter->size[0];
  obj_filter->size[0] = h1->size[0];
  emxEnsureCapacity_real32_T(obj_filter, iseven, &bg_emlrtRTEI);
  for (iseven = 0; iseven < h1->size[0]; iseven++) {
    obj_filter->data[iseven] =
        static_cast<real32_T>(*obj_p * h1->data[iseven] / pqmax);
  }
  emxFree_real_T(&h1);
  fc = (static_cast<real_T>(obj_filter->size[0]) - 1.0) / 2.0;
  pqmax = fc;
  if (*obj_q == 0.0) {
    if (fc == 0.0) {
      pqmax = 0.0;
    }
  } else if (std::isnan(*obj_q)) {
    pqmax = rtNaN;
  } else if (fc == 0.0) {
    pqmax = 0.0 / *obj_q;
  } else if (std::isinf(*obj_q)) {
    if (fc < 0.0) {
      pqmax = *obj_q;
    }
  } else {
    pqmax = std::fmod(fc, *obj_q);
    if (pqmax == 0.0) {
      pqmax = *obj_q * 0.0;
    } else if (fc < 0.0) {
      pqmax += *obj_q;
    }
  }
  ak = std::floor(*obj_q - pqmax);
  *obj_filterDelay = std::floor(std::ceil(fc + ak) / *obj_q);
  pqmax = static_cast<real_T>(obj_filter->size[0]) + ak;
  fc = 0.0;
  inw = obj_x->size[0];
  while (std::ceil((((static_cast<real_T>(inw) - 1.0) * *obj_p + pqmax) + fc) /
                   *obj_q) -
             *obj_filterDelay <
         std::ceil(static_cast<real_T>(inw) * *obj_p / *obj_q)) {
    fc++;
  }
  inw = static_cast<int32_T>((ak + static_cast<real_T>(obj_filter->size[0])) +
                             fc);
  iseven = obj_filterWithPadding->size[0];
  obj_filterWithPadding->size[0] = inw;
  emxEnsureCapacity_real32_T(obj_filterWithPadding, iseven, &cg_emlrtRTEI);
  if (inw - 1 >= 0) {
    std::memset(&obj_filterWithPadding->data[0], 0,
                static_cast<uint32_T>(inw) * sizeof(real32_T));
  }
  emxInit_uint32_T(&y, 2, &eg_emlrtRTEI, true);
  if (obj_filter->size[0] < 1) {
    y->size[0] = 1;
    y->size[1] = 0;
  } else {
    uint32_T u;
    u = static_cast<uint32_T>(obj_filter->size[0]);
    iseven = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = static_cast<int32_T>(u);
    emxEnsureCapacity_uint32_T(y, iseven, &gb_emlrtRTEI);
    for (iseven = 0; iseven < static_cast<int32_T>(u); iseven++) {
      y->data[iseven] = static_cast<uint32_T>(iseven) + 1U;
    }
  }
  emxInit_int32_T(&iv, 2, &fg_emlrtRTEI, true);
  iseven = iv->size[0] * iv->size[1];
  iv->size[0] = 1;
  iv->size[1] = y->size[1];
  emxEnsureCapacity_int32_T(iv, iseven, &dg_emlrtRTEI);
  for (iseven = 0; iseven < y->size[1]; iseven++) {
    iv->data[iseven] =
        static_cast<int32_T>(ak + static_cast<real_T>(y->data[iseven]));
  }
  emxFree_uint32_T(&y);
  for (iseven = 0; iseven < iv->size[1]; iseven++) {
    obj_filterWithPadding->data[iv->data[iseven] - 1] =
        obj_filter->data[iseven];
  }
  emxFree_int32_T(&iv);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

} // namespace resample
} // namespace internal
} // namespace b_signal
} // namespace coder

// End of code generation (ResampleParser.cu)
