//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// kaiser.cu
//
// Code generation for function 'kaiser'
//

// Include files
#include "kaiser.h"
#include "casyi.h"
#include "cmlri.h"
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "gammaln.h"
#include "rt_nonfinite.h"
#include "warning.h"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo nf_emlrtRTEI{
    37,                                                    // lineNo
    20,                                                    // colNo
    "kaiser",                                              // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/eml/kaiser.m" // pName
};

static emlrtRTEInfo of_emlrtRTEI{
    39,                                                    // lineNo
    5,                                                     // colNo
    "kaiser",                                              // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/eml/kaiser.m" // pName
};

// Function Definitions
//
//
namespace coder {
void kaiser(real_T N, emxArray_real_T *w)
{
  creal_T tmp;
  creal_T zd;
  real_T r;
  int32_T inw;
  int32_T iseven;
  int32_T nw;
  if (N == std::floor(N)) {
    nw = static_cast<int32_T>(N);
  } else {
    nw = static_cast<int32_T>(std::round(N));
    internal::warning();
  }
  iseven = w->size[0];
  w->size[0] = nw;
  emxEnsureCapacity_real_T(w, iseven, &nf_emlrtRTEI);
  if (nw <= 1) {
    iseven = w->size[0];
    w->size[0] = nw;
    emxEnsureCapacity_real_T(w, iseven, &of_emlrtRTEI);
    for (iseven = 0; iseven < nw; iseven++) {
      w->data[iseven] = 1.0;
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
      real_T hz_re;
      r = static_cast<real_T>(iseven +
                              ((static_cast<int32_T>(mid + k) - mid) << 1)) /
          (static_cast<real_T>(nw) - 1.0);
      zd.re = 5.0 * std::sqrt((1.0 - r) * (r + 1.0));
      if (std::isnan(zd.re)) {
        tmp.re = rtNaN;
        tmp.im = 0.0;
      } else {
        real_T az;
        int32_T b_nw;
        int32_T ierr;
        boolean_T guard1;
        ierr = 0;
        r = rt_hypotd_snf(zd.re, 0.0);
        if (r > 1.0737418235E+9) {
          ierr = 4;
        } else if (r > 32767.999992370605) {
          ierr = 3;
        }
        tmp.re = 0.0;
        tmp.im = 0.0;
        az = rt_hypotd_snf(zd.re, 0.0);
        guard1 = false;
        if (az <= 2.0) {
          b_nw = 0;
          r = rt_hypotd_snf(zd.re, 0.0);
          if (r == 0.0) {
            tmp.re = 1.0;
            tmp.im = 0.0;
          } else {
            real_T crsc_re;
            boolean_T iflag;
            crsc_re = 1.0;
            iflag = false;
            if (r < 2.2250738585072014E-305) {
              tmp.re = 1.0;
              tmp.im = 0.0;
            } else {
              real_T acz;
              real_T cz_re;
              hz_re = 0.5 * zd.re;
              if (r > 4.7170688552396617E-153) {
                cz_re = hz_re * hz_re;
                acz = rt_hypotd_snf(cz_re, 0.0);
              } else {
                cz_re = 0.0;
                acz = 0.0;
              }
              r = 1.0;
              gammaln(&r);
              hz_re = std::log(hz_re) * 0.0 - r;
              if (hz_re > -700.92179369444591) {
                real_T aa;
                real_T ascle;
                real_T b_atol;
                real_T coef_im;
                real_T coef_re;
                real_T s1_im;
                real_T s1_re;
                boolean_T guard2;
                ascle = 0.0;
                if (hz_re <= -664.87164553371019) {
                  iflag = true;
                  crsc_re = 2.2204460492503131E-16;
                  ascle = 1.0020841800044864E-289;
                }
                aa = std::exp(hz_re);
                if (iflag) {
                  aa /= 2.2204460492503131E-16;
                }
                coef_re = aa;
                coef_im = aa * 0.0;
                b_atol = 2.2204460492503131E-16 * acz;
                s1_re = 1.0;
                s1_im = 0.0;
                if (!(acz < 2.2204460492503131E-16)) {
                  real_T ak;
                  real_T s;
                  hz_re = 1.0;
                  r = 0.0;
                  ak = 3.0;
                  s = 1.0;
                  aa = 2.0;
                  real_T re;
                  real_T rs;
                  do {
                    rs = 1.0 / s;
                    re = hz_re * cz_re - r * 0.0;
                    r = hz_re * 0.0 + r * cz_re;
                    hz_re = rs * re;
                    r *= rs;
                    s1_re += hz_re;
                    s1_im += r;
                    s += ak;
                    ak += 2.0;
                    aa = aa * acz * rs;
                  } while (!!(aa > b_atol));
                }
                b_atol = s1_re * coef_re - s1_im * coef_im;
                r = s1_re * coef_im + s1_im * coef_re;
                guard2 = false;
                if (iflag) {
                  hz_re = std::abs(b_atol);
                  if (hz_re > r) {
                    aa = 0.0;
                  } else {
                    aa = hz_re;
                    hz_re = r;
                  }
                  if ((!(aa <= ascle)) ||
                      (!(hz_re < aa / 2.2204460492503131E-16))) {
                    guard2 = true;
                  }
                } else {
                  guard2 = true;
                }
                if (guard2) {
                  tmp.re = b_atol * crsc_re - r * 0.0;
                  tmp.im = b_atol * 0.0 + r * crsc_re;
                }
              } else {
                b_nw = 1;
                if (acz > 0.0) {
                  b_nw = -1;
                }
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
          r = tmp.re;
          tmp.re = r;
          tmp.im = 0.0;
        }
      }
      if (tmp.im == 0.0) {
        r = tmp.re / 27.239871823604449;
        hz_re = 0.0;
      } else if (tmp.re == 0.0) {
        r = 0.0;
        hz_re = tmp.im / 27.239871823604449;
      } else {
        r = tmp.re / 27.239871823604449;
        hz_re = tmp.im / 27.239871823604449;
      }
      w->data[static_cast<int32_T>(mid + k) - 1] = rt_hypotd_snf(r, hz_re);
    }
    for (iseven = 0; iseven <= mid - 2; iseven++) {
      w->data[iseven] = w->data[(nw - iseven) - 1];
    }
  }
}

} // namespace coder

// End of code generation (kaiser.cu)
