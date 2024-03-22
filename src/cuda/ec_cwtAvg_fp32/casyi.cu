//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// casyi.cu
//
// Code generation for function 'casyi'
//

// Include files
#include "casyi.h"
#include "cospiAndSinpi.h"
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_mexutil.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
//
//
namespace coder {
int32_T casyi(const creal_T z, real_T fnu, int32_T kode, creal_T *y)
{
  real_T absxi;
  real_T absxr;
  real_T ak1_im;
  real_T ak1_re;
  real_T cz_im;
  real_T p1_re;
  real_T yr;
  int32_T nz;
  nz = 0;
  if (z.im == 0.0) {
    ak1_re = 0.15915494309189535 / z.re;
    ak1_im = 0.0;
  } else if (z.re == 0.0) {
    ak1_re = 0.0;
    ak1_im = -(0.15915494309189535 / z.im);
  } else {
    ak1_im = std::abs(z.re);
    absxi = std::abs(z.im);
    if (ak1_im > absxi) {
      absxi = z.im / z.re;
      absxr = z.re + absxi * z.im;
      ak1_re = (absxi * 0.0 + 0.15915494309189535) / absxr;
      ak1_im = (0.0 - absxi * 0.15915494309189535) / absxr;
    } else if (absxi == ak1_im) {
      if (z.re > 0.0) {
        absxi = 0.5;
      } else {
        absxi = -0.5;
      }
      if (z.im > 0.0) {
        absxr = 0.5;
      } else {
        absxr = -0.5;
      }
      ak1_re = (0.15915494309189535 * absxi + 0.0 * absxr) / ak1_im;
      ak1_im = (0.0 * absxi - 0.15915494309189535 * absxr) / ak1_im;
    } else {
      absxi = z.re / z.im;
      absxr = z.im + absxi * z.re;
      ak1_re = absxi * 0.15915494309189535 / absxr;
      ak1_im = (absxi * 0.0 - 0.15915494309189535) / absxr;
    }
  }
  if (ak1_im == 0.0) {
    if (ak1_re < 0.0) {
      yr = 0.0;
      absxr = std::sqrt(-ak1_re);
    } else {
      yr = std::sqrt(ak1_re);
      absxr = 0.0;
    }
  } else if (ak1_re == 0.0) {
    if (ak1_im < 0.0) {
      yr = std::sqrt(-ak1_im / 2.0);
      absxr = -yr;
    } else {
      yr = std::sqrt(ak1_im / 2.0);
      absxr = yr;
    }
  } else if (std::isnan(ak1_re)) {
    yr = rtNaN;
    absxr = rtNaN;
  } else if (std::isnan(ak1_im)) {
    yr = rtNaN;
    absxr = rtNaN;
  } else if (std::isinf(ak1_im)) {
    yr = std::abs(ak1_im);
    absxr = ak1_im;
  } else if (std::isinf(ak1_re)) {
    if (ak1_re < 0.0) {
      yr = 0.0;
      absxr = ak1_im * -ak1_re;
    } else {
      yr = ak1_re;
      absxr = 0.0;
    }
  } else {
    absxr = std::abs(ak1_re);
    absxi = std::abs(ak1_im);
    if ((absxr > 4.4942328371557893E+307) ||
        (absxi > 4.4942328371557893E+307)) {
      absxr *= 0.5;
      absxi = rt_hypotd_snf(absxr, absxi * 0.5);
      if (absxi > absxr) {
        yr = std::sqrt(absxi) * std::sqrt(absxr / absxi + 1.0);
      } else {
        yr = std::sqrt(absxi) * 1.4142135623730951;
      }
    } else {
      yr = std::sqrt((rt_hypotd_snf(absxr, absxi) + absxr) * 0.5);
    }
    if (ak1_re > 0.0) {
      absxr = 0.5 * (ak1_im / yr);
    } else {
      if (ak1_im < 0.0) {
        absxr = -yr;
      } else {
        absxr = yr;
      }
      yr = 0.5 * (ak1_im / absxr);
    }
  }
  if (kode == 2) {
    ak1_re = 0.0;
    cz_im = z.im;
    absxi = 0.0;
  } else {
    ak1_re = z.re;
    cz_im = z.im;
    absxi = z.re;
  }
  if (std::abs(absxi) > 700.92179369444591) {
    nz = -1;
    y->re = rtNaN;
    y->im = 0.0;
  } else {
    real_T aa;
    real_T aez;
    real_T ak;
    real_T b_re;
    real_T bb;
    real_T bk;
    real_T ck_im;
    real_T cs1_im;
    real_T cs1_re;
    real_T cs2_im;
    real_T cs2_re;
    real_T dk_im;
    real_T dk_re;
    real_T ez_im;
    real_T ez_re;
    real_T im;
    real_T re;
    real_T sqk;
    int32_T i;
    boolean_T errflag;
    boolean_T exitg1;
    absxi = fnu + fnu;
    if (ak1_re == 0.0) {
      ak1_re = std::cos(cz_im);
      cz_im = std::sin(cz_im);
    } else if (cz_im == 0.0) {
      ak1_re = std::exp(ak1_re);
      cz_im = 0.0;
    } else if (std::isinf(cz_im) && std::isinf(ak1_re) && (ak1_re < 0.0)) {
      ak1_re = 0.0;
      cz_im = 0.0;
    } else {
      ak1_im = std::exp(ak1_re / 2.0);
      ak1_re = ak1_im * (ak1_im * std::cos(cz_im));
      cz_im = ak1_im * (ak1_im * std::sin(cz_im));
    }
    re = yr * ak1_re - absxr * cz_im;
    im = yr * cz_im + absxr * ak1_re;
    absxr = 0.0;
    if (absxi > 4.7170688552396617E-153) {
      absxr = absxi * absxi;
    }
    ez_re = 8.0 * z.re;
    ez_im = 8.0 * z.im;
    aez = 8.0 * rt_hypotd_snf(z.re, z.im);
    if (z.im != 0.0) {
      bk = internal::scalar::cospiAndSinpi(
          fnu - static_cast<real_T>(static_cast<int32_T>(fnu)), &p1_re);
      if (z.im < 0.0) {
        bk = -bk;
      }
      if (static_cast<int32_T>(fnu) != 0) {
        bk = -bk;
      } else {
        p1_re = -p1_re;
      }
    } else {
      p1_re = 0.0;
      bk = 0.0;
    }
    sqk = absxr - 1.0;
    yr = 2.2204460492503131E-16 / aez * std::abs(absxr - 1.0);
    ak1_re = 1.0;
    cs1_re = 1.0;
    cs1_im = 0.0;
    cs2_re = 1.0;
    cs2_im = 0.0;
    cz_im = 1.0;
    ck_im = 0.0;
    ak = 0.0;
    aa = 1.0;
    bb = aez;
    dk_re = ez_re;
    dk_im = ez_im;
    errflag = true;
    i = 1;
    exitg1 = false;
    while ((!exitg1) && (i < 46)) {
      cz_im *= sqk;
      ck_im *= sqk;
      if (dk_im == 0.0) {
        if (ck_im == 0.0) {
          b_re = cz_im / dk_re;
          ck_im = 0.0;
        } else if (cz_im == 0.0) {
          b_re = 0.0;
          ck_im /= dk_re;
        } else {
          b_re = cz_im / dk_re;
          ck_im /= dk_re;
        }
      } else if (dk_re == 0.0) {
        if (cz_im == 0.0) {
          b_re = ck_im / dk_im;
          ck_im = 0.0;
        } else if (ck_im == 0.0) {
          b_re = 0.0;
          ck_im = -(cz_im / dk_im);
        } else {
          b_re = ck_im / dk_im;
          ck_im = -(cz_im / dk_im);
        }
      } else {
        ak1_im = std::abs(dk_re);
        absxi = std::abs(dk_im);
        if (ak1_im > absxi) {
          absxi = dk_im / dk_re;
          absxr = dk_re + absxi * dk_im;
          b_re = (cz_im + absxi * ck_im) / absxr;
          ck_im = (ck_im - absxi * cz_im) / absxr;
        } else if (absxi == ak1_im) {
          if (dk_re > 0.0) {
            absxi = 0.5;
          } else {
            absxi = -0.5;
          }
          if (dk_im > 0.0) {
            absxr = 0.5;
          } else {
            absxr = -0.5;
          }
          b_re = (cz_im * absxi + ck_im * absxr) / ak1_im;
          ck_im = (ck_im * absxi - cz_im * absxr) / ak1_im;
        } else {
          absxi = dk_re / dk_im;
          absxr = dk_im + absxi * dk_re;
          b_re = (absxi * cz_im + ck_im) / absxr;
          ck_im = (absxi * ck_im - cz_im) / absxr;
        }
      }
      cz_im = b_re;
      cs2_re += b_re;
      cs2_im += ck_im;
      ak1_re = -ak1_re;
      cs1_re += b_re * ak1_re;
      cs1_im += ck_im * ak1_re;
      dk_re += ez_re;
      dk_im += ez_im;
      aa = aa * std::abs(sqk) / bb;
      bb += aez;
      ak += 8.0;
      sqk -= ak;
      if (aa <= yr) {
        errflag = false;
        exitg1 = true;
      } else {
        i++;
      }
    }
    if (errflag) {
      nz = -2;
    } else {
      if (z.re + z.re < 700.92179369444591) {
        ak1_re = -2.0 * z.re;
        cz_im = -2.0 * z.im;
        if (ak1_re == 0.0) {
          ak1_re = std::cos(cz_im);
          cz_im = std::sin(cz_im);
        } else if (cz_im == 0.0) {
          ak1_re = std::exp(ak1_re);
          cz_im = 0.0;
        } else if (std::isinf(cz_im) && std::isinf(ak1_re) && (ak1_re < 0.0)) {
          ak1_re = 0.0;
          cz_im = 0.0;
        } else {
          ak1_im = std::exp(ak1_re / 2.0);
          ak1_re = ak1_im * (ak1_im * std::cos(cz_im));
          cz_im = ak1_im * (ak1_im * std::sin(cz_im));
        }
        b_re = ak1_re * cs2_re - cz_im * cs2_im;
        absxi = ak1_re * cs2_im + cz_im * cs2_re;
        cs1_re += b_re * p1_re - absxi * bk;
        cs1_im += b_re * bk + absxi * p1_re;
      }
      y->re = cs1_re * re - cs1_im * im;
      y->im = cs1_re * im + cs1_im * re;
    }
  }
  return nz;
}

} // namespace coder

// End of code generation (casyi.cu)
