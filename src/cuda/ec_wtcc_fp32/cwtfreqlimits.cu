//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// cwtfreqlimits.cu
//
// Code generation for function 'cwtfreqlimits'
//

// Include files
#include "cwtfreqlimits.h"
#include "ec_wtcc_mexutil.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
//
//
namespace coder {
namespace wavelet {
namespace internal {
namespace cwt {
real_T cwtfreqlimits(real_T N, real_T cutoff, real_T varargin_1,
                     real_T varargin_3, real_T *maxperiod, real_T *maxscale,
                     real_T *minscale, real_T *maxfreq, real_T *minperiod)
{
  real_T T;
  real_T minfreq;
  real_T omegac;
  real_T psihat_workspace_alpha;
  T = 1.0 / varargin_1;
  *maxscale = N / 2.8284271247461903;
  psihat_workspace_alpha = 2.0 * (cutoff / 100.0);
  if (psihat_workspace_alpha - 2.0 > 0.0) {
    omegac = 44.729833462074168;
  } else {
    real_T a;
    real_T fa;
    real_T fb;
    a = 6.0;
    omegac = 44.729833462074168;
    fa = psihat_workspace_alpha - 2.0;
    fb = psihat_workspace_alpha;
    if (psihat_workspace_alpha - 2.0 == 0.0) {
      omegac = 6.0;
    } else {
      real_T c;
      real_T d;
      real_T e;
      real_T fc;
      boolean_T exitg1;
      fc = psihat_workspace_alpha;
      c = 44.729833462074168;
      e = 0.0;
      d = 0.0;
      exitg1 = false;
      while ((!exitg1) && ((fb != 0.0) && (a != omegac))) {
        real_T m;
        real_T toler;
        if ((fb > 0.0) == (fc > 0.0)) {
          c = a;
          fc = fa;
          d = omegac - a;
          e = d;
        }
        if (std::abs(fc) < std::abs(fb)) {
          a = omegac;
          omegac = c;
          c = a;
          fa = fb;
          fb = fc;
          fc = fa;
        }
        m = 0.5 * (c - omegac);
        toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
        if ((std::abs(m) <= toler) || (fb == 0.0)) {
          exitg1 = true;
        } else {
          if ((std::abs(e) < toler) || (std::abs(fa) <= std::abs(fb))) {
            d = m;
            e = m;
          } else {
            real_T q;
            real_T s;
            s = fb / fa;
            if (a == c) {
              fa = 2.0 * m * s;
              q = 1.0 - s;
            } else {
              real_T r;
              q = fa / fc;
              r = fb / fc;
              fa = s * (2.0 * m * q * (q - r) - (omegac - a) * (r - 1.0));
              q = (q - 1.0) * (r - 1.0) * (s - 1.0);
            }
            if (fa > 0.0) {
              q = -q;
            } else {
              fa = -fa;
            }
            if ((2.0 * fa < 3.0 * m * q - std::abs(toler * q)) &&
                (fa < std::abs(0.5 * e * q))) {
              e = d;
              d = fa / q;
            } else {
              d = m;
              e = m;
            }
          }
          a = omegac;
          fa = fb;
          if (std::abs(d) > toler) {
            omegac += d;
          } else if (omegac > c) {
            omegac -= toler;
          } else {
            omegac += toler;
          }
          fb = psihat_workspace_alpha -
               2.0 * std::exp(-((omegac - 6.0) * (omegac - 6.0)) / 2.0);
        }
      }
    }
  }
  *minscale = omegac / 3.1415926535897931;
  if (*maxscale < *minscale * rt_powd_snf(2.0, 1.0 / varargin_3)) {
    *maxscale = *minscale * rt_powd_snf(2.0, 1.0 / varargin_3);
  }
  *minperiod = *minscale * 1.0471975511965976 * T;
  *maxfreq = 1.0 / (*minscale * 1.0471975511965976) * varargin_1;
  *maxperiod = *maxscale * 1.0471975511965976 * T;
  minfreq = 1.0 / (*maxscale * 1.0471975511965976) * varargin_1;
  if ((*maxfreq > varargin_1 / 2.0) || (*minperiod < 2.0 * T)) {
    *maxfreq = varargin_1 / 2.0;
    *minperiod = 2.0 * T;
  }
  return minfreq;
}

//
//
real_T getFreqFromCutoffAmor(real_T cutoff, real_T cf)
{
  real_T a;
  real_T omegac;
  real_T psihat_workspace_alpha;
  psihat_workspace_alpha = 2.0 * cutoff;
  a = cf - cf;
  if (psihat_workspace_alpha - 2.0 * std::exp(-(a * a) / 2.0) > 0.0) {
    omegac = cf + 38.729833462074168;
  } else {
    real_T fa;
    real_T fb;
    real_T p;
    a = cf;
    omegac = cf + 38.729833462074168;
    p = cf - cf;
    fa = psihat_workspace_alpha - 2.0 * std::exp(-(p * p) / 2.0);
    p = (cf + 38.729833462074168) - cf;
    fb = psihat_workspace_alpha - 2.0 * std::exp(-(p * p) / 2.0);
    if (fa == 0.0) {
      omegac = cf;
    } else if (!(fb == 0.0)) {
      real_T c;
      real_T d;
      real_T e;
      real_T fc;
      boolean_T exitg1;
      fc = fb;
      c = cf + 38.729833462074168;
      e = 0.0;
      d = 0.0;
      exitg1 = false;
      while ((!exitg1) && ((fb != 0.0) && (a != omegac))) {
        real_T m;
        real_T toler;
        if ((fb > 0.0) == (fc > 0.0)) {
          c = a;
          fc = fa;
          d = omegac - a;
          e = d;
        }
        if (std::abs(fc) < std::abs(fb)) {
          a = omegac;
          omegac = c;
          c = a;
          fa = fb;
          fb = fc;
          fc = fa;
        }
        m = 0.5 * (c - omegac);
        toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
        if ((std::abs(m) <= toler) || (fb == 0.0)) {
          exitg1 = true;
        } else {
          if ((std::abs(e) < toler) || (std::abs(fa) <= std::abs(fb))) {
            d = m;
            e = m;
          } else {
            real_T s;
            s = fb / fa;
            if (a == c) {
              p = 2.0 * m * s;
              fa = 1.0 - s;
            } else {
              real_T r;
              fa /= fc;
              r = fb / fc;
              p = s * (2.0 * m * fa * (fa - r) - (omegac - a) * (r - 1.0));
              fa = (fa - 1.0) * (r - 1.0) * (s - 1.0);
            }
            if (p > 0.0) {
              fa = -fa;
            } else {
              p = -p;
            }
            if ((2.0 * p < 3.0 * m * fa - std::abs(toler * fa)) &&
                (p < std::abs(0.5 * e * fa))) {
              e = d;
              d = p / fa;
            } else {
              d = m;
              e = m;
            }
          }
          a = omegac;
          fa = fb;
          if (std::abs(d) > toler) {
            omegac += d;
          } else if (omegac > c) {
            omegac -= toler;
          } else {
            omegac += toler;
          }
          p = omegac - cf;
          fb = psihat_workspace_alpha - 2.0 * std::exp(-(p * p) / 2.0);
        }
      }
    }
  }
  return omegac;
}

//
//
real_T getFreqFromCutoffBump(real_T cutoff, real_T cf)
{
  real_T omegac;
  int32_T exponent;
  if (cutoff < 4.94065645841247E-323) {
    real_T fa;
    real_T r;
    fa = std::abs(cf + 0.6);
    if (std::isinf(fa) || std::isnan(fa)) {
      r = rtNaN;
    } else if (fa < 4.4501477170144028E-308) {
      r = 4.94065645841247E-324;
    } else {
      std::frexp(fa, &exponent);
      r = std::ldexp(1.0, exponent - 53);
    }
    omegac = (cf + 0.6) - 10.0 * r;
  } else {
    real_T a;
    real_T epsilon;
    real_T fa;
    real_T fb;
    real_T psihat_workspace_alpha;
    psihat_workspace_alpha = 2.0 * cutoff;
    a = 4.94065645841247E-324;
    epsilon = 0.99999999999999978;
    fa = ((std::log(psihat_workspace_alpha) + 1.0) - 0.69314718055994529) - 1.0;
    fb = ((std::log(psihat_workspace_alpha) + 2.251799813685248E+15) -
          0.69314718055994529) -
         1.0;
    if (fa == 0.0) {
      epsilon = 4.94065645841247E-324;
    } else {
      real_T c;
      real_T d;
      real_T e;
      real_T fc;
      boolean_T exitg1;
      fc = fb;
      c = 0.99999999999999978;
      e = 0.0;
      d = 0.0;
      exitg1 = false;
      while ((!exitg1) && ((fb != 0.0) && (a != epsilon))) {
        real_T m;
        real_T toler;
        if ((fb > 0.0) == (fc > 0.0)) {
          c = a;
          fc = fa;
          d = epsilon - a;
          e = d;
        }
        if (std::abs(fc) < std::abs(fb)) {
          a = epsilon;
          epsilon = c;
          c = a;
          fa = fb;
          fb = fc;
          fc = fa;
        }
        m = 0.5 * (c - epsilon);
        toler = 4.4408920985006262E-16 * std::fmax(std::abs(epsilon), 1.0);
        if ((std::abs(m) <= toler) || (fb == 0.0)) {
          exitg1 = true;
        } else {
          if ((std::abs(e) < toler) || (std::abs(fa) <= std::abs(fb))) {
            d = m;
            e = m;
          } else {
            real_T q;
            real_T s;
            s = fb / fa;
            if (a == c) {
              fa = 2.0 * m * s;
              q = 1.0 - s;
            } else {
              real_T r;
              q = fa / fc;
              r = fb / fc;
              fa = s * (2.0 * m * q * (q - r) - (epsilon - a) * (r - 1.0));
              q = (q - 1.0) * (r - 1.0) * (s - 1.0);
            }
            if (fa > 0.0) {
              q = -q;
            } else {
              fa = -fa;
            }
            if ((2.0 * fa < 3.0 * m * q - std::abs(toler * q)) &&
                (fa < std::abs(0.5 * e * q))) {
              e = d;
              d = fa / q;
            } else {
              d = m;
              e = m;
            }
          }
          a = epsilon;
          fa = fb;
          if (std::abs(d) > toler) {
            epsilon += d;
          } else if (epsilon > c) {
            epsilon -= toler;
          } else {
            epsilon += toler;
          }
          fb = ((1.0 / (1.0 - epsilon * epsilon) +
                 std::log(psihat_workspace_alpha)) -
                0.69314718055994529) -
               1.0;
        }
      }
    }
    omegac = 0.6 * epsilon + cf;
  }
  return omegac;
}

//
//
real_T getFreqFromCutoffMorse(real_T cutoff, real_T cf, real_T ga, real_T be)
{
  real_T omegac;
  real_T psihat_workspace_alpha;
  real_T psihat_workspace_anorm;
  psihat_workspace_anorm =
      2.0 * std::exp(be / ga * ((std::log(ga) - std::log(be)) + 1.0));
  psihat_workspace_alpha = 2.0 * cutoff;
  omegac = rt_powd_snf(750.0, 1.0 / ga);
  if (psihat_workspace_alpha - psihat_workspace_anorm * rt_powd_snf(cf, be) *
                                   std::exp(-rt_powd_snf(cf, ga)) >=
      0.0) {
    if (!(psihat_workspace_alpha - psihat_workspace_anorm *
                                       rt_powd_snf(omegac, be) *
                                       std::exp(-rt_powd_snf(omegac, ga)) ==
          psihat_workspace_alpha - psihat_workspace_anorm *
                                       rt_powd_snf(cf, be) *
                                       std::exp(-rt_powd_snf(cf, ga)))) {
      omegac = cf;
    }
  } else {
    real_T a;
    real_T fa;
    real_T fb;
    a = cf;
    fa = psihat_workspace_alpha - psihat_workspace_anorm * rt_powd_snf(cf, be) *
                                      std::exp(-rt_powd_snf(cf, ga));
    fb = psihat_workspace_alpha - psihat_workspace_anorm *
                                      rt_powd_snf(omegac, be) *
                                      std::exp(-rt_powd_snf(omegac, ga));
    if (fa == 0.0) {
      omegac = cf;
    } else if (!(fb == 0.0)) {
      real_T c;
      real_T d;
      real_T e;
      real_T fc;
      boolean_T exitg1;
      fc = fb;
      c = omegac;
      e = 0.0;
      d = 0.0;
      exitg1 = false;
      while ((!exitg1) && ((fb != 0.0) && (a != omegac))) {
        real_T m;
        real_T toler;
        if ((fb > 0.0) == (fc > 0.0)) {
          c = a;
          fc = fa;
          d = omegac - a;
          e = d;
        }
        if (std::abs(fc) < std::abs(fb)) {
          a = omegac;
          omegac = c;
          c = a;
          fa = fb;
          fb = fc;
          fc = fa;
        }
        m = 0.5 * (c - omegac);
        toler = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
        if ((std::abs(m) <= toler) || (fb == 0.0)) {
          exitg1 = true;
        } else {
          if ((std::abs(e) < toler) || (std::abs(fa) <= std::abs(fb))) {
            d = m;
            e = m;
          } else {
            real_T q;
            real_T s;
            s = fb / fa;
            if (a == c) {
              fa = 2.0 * m * s;
              q = 1.0 - s;
            } else {
              real_T r;
              q = fa / fc;
              r = fb / fc;
              fa = s * (2.0 * m * q * (q - r) - (omegac - a) * (r - 1.0));
              q = (q - 1.0) * (r - 1.0) * (s - 1.0);
            }
            if (fa > 0.0) {
              q = -q;
            } else {
              fa = -fa;
            }
            if ((2.0 * fa < 3.0 * m * q - std::abs(toler * q)) &&
                (fa < std::abs(0.5 * e * q))) {
              e = d;
              d = fa / q;
            } else {
              d = m;
              e = m;
            }
          }
          a = omegac;
          fa = fb;
          if (std::abs(d) > toler) {
            omegac += d;
          } else if (omegac > c) {
            omegac -= toler;
          } else {
            omegac += toler;
          }
          fb = psihat_workspace_alpha - psihat_workspace_anorm *
                                            rt_powd_snf(omegac, be) *
                                            std::exp(-rt_powd_snf(omegac, ga));
        }
      }
    }
  }
  return omegac;
}

} // namespace cwt
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (cwtfreqlimits.cu)
