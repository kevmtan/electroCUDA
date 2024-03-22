//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// cmlri.cu
//
// Code generation for function 'cmlri'
//

// Include files
#include "cmlri.h"
#include "ec_wtcc_data.h"
#include "ec_wtcc_mexutil.h"
#include "gammaln.h"
#include "rt_nonfinite.h"
#include "rt_defines.h"
#include <cmath>

// Function Declarations
static real_T rt_atan2d_snf(real_T u0, real_T u1);

// Function Definitions
static real_T rt_atan2d_snf(real_T u0, real_T u1)
{
  real_T y;
  if (std::isnan(u0) || std::isnan(u1)) {
    y = rtNaN;
  } else if (std::isinf(u0) && std::isinf(u1)) {
    int32_T b;
    int32_T c;
    if (u1 > 0.0) {
      b = 1;
    } else {
      b = -1;
    }
    if (u0 > 0.0) {
      c = 1;
    } else {
      c = -1;
    }
    y = std::atan2(static_cast<real_T>(c), static_cast<real_T>(b));
  } else if (u1 == 0.0) {
    if (u0 > 0.0) {
      y = RT_PI / 2.0;
    } else if (u0 < 0.0) {
      y = -(RT_PI / 2.0);
    } else {
      y = 0.0;
    }
  } else {
    y = std::atan2(u0, u1);
  }
  return y;
}

//
//
namespace coder {
int32_T cmlri(const creal_T z, real_T fnu, int32_T kode, creal_T *y)
{
  real_T ack;
  real_T ak;
  real_T az;
  real_T bk;
  real_T ck_im;
  real_T ck_re;
  real_T flooraz;
  real_T p1_im;
  real_T p1_re;
  real_T p2_im;
  real_T p2_re;
  real_T pt_im;
  real_T pt_re;
  real_T rho2;
  real_T rz_im;
  real_T rz_re;
  real_T tst;
  int32_T i;
  int32_T icounter;
  int32_T nz;
  boolean_T earlyExit;
  boolean_T exitg1;
  nz = 0;
  az = rt_hypotd_snf(z.re, z.im);
  flooraz = std::floor(az);
  if (z.im == 0.0) {
    ck_re = (flooraz + 1.0) / z.re;
    ck_im = 0.0;
    rz_re = 2.0 / z.re;
    rz_im = 0.0;
  } else if (z.re == 0.0) {
    ck_re = 0.0;
    ck_im = -((flooraz + 1.0) / z.im);
    rz_re = 0.0;
    rz_im = -(2.0 / z.im);
  } else {
    bk = std::abs(z.re);
    ack = std::abs(z.im);
    if (bk > ack) {
      ack = z.im / z.re;
      rho2 = z.re + ack * z.im;
      ck_re = ((flooraz + 1.0) + ack * 0.0) / rho2;
      ck_im = (0.0 - ack * (flooraz + 1.0)) / rho2;
    } else if (ack == bk) {
      if (z.re > 0.0) {
        ack = 0.5;
      } else {
        ack = -0.5;
      }
      if (z.im > 0.0) {
        rho2 = 0.5;
      } else {
        rho2 = -0.5;
      }
      ck_re = ((flooraz + 1.0) * ack + 0.0 * rho2) / bk;
      ck_im = (0.0 * ack - (flooraz + 1.0) * rho2) / bk;
    } else {
      ack = z.re / z.im;
      rho2 = z.im + ack * z.re;
      ck_re = ack * (flooraz + 1.0) / rho2;
      ck_im = (ack * 0.0 - (flooraz + 1.0)) / rho2;
    }
    bk = std::abs(z.re);
    ack = std::abs(z.im);
    if (bk > ack) {
      ack = z.im / z.re;
      rho2 = z.re + ack * z.im;
      rz_re = (ack * 0.0 + 2.0) / rho2;
      rz_im = (0.0 - ack * 2.0) / rho2;
    } else if (ack == bk) {
      if (z.re > 0.0) {
        ack = 0.5;
      } else {
        ack = -0.5;
      }
      if (z.im > 0.0) {
        rho2 = 0.5;
      } else {
        rho2 = -0.5;
      }
      rz_re = (2.0 * ack + 0.0 * rho2) / bk;
      rz_im = (0.0 * ack - 2.0 * rho2) / bk;
    } else {
      ack = z.re / z.im;
      rho2 = z.im + ack * z.re;
      rz_re = ack * 2.0 / rho2;
      rz_im = (ack * 0.0 - 2.0) / rho2;
    }
  }
  p1_re = 0.0;
  p1_im = 0.0;
  p2_re = 1.0;
  p2_im = 0.0;
  ack = ((flooraz + 1.0) + 1.0) / az;
  ack += std::sqrt(ack * ack - 1.0);
  rho2 = ack * ack;
  tst = (rho2 + rho2) / ((rho2 - 1.0) * (ack - 1.0)) / 2.2204460492503131E-16;
  ak = flooraz + 1.0;
  earlyExit = true;
  icounter = 1;
  i = 1;
  exitg1 = false;
  while ((!exitg1) && (i < 81)) {
    icounter++;
    pt_re = p2_re;
    pt_im = p2_im;
    ack = ck_re * p2_re - ck_im * p2_im;
    rho2 = ck_re * p2_im + ck_im * p2_re;
    p2_re = p1_re - ack;
    p2_im = p1_im - rho2;
    p1_re = pt_re;
    p1_im = pt_im;
    ck_re += rz_re;
    ck_im += rz_im;
    if (rt_hypotd_snf(p2_re, p2_im) > tst * ak * ak) {
      earlyExit = false;
      exitg1 = true;
    } else {
      ak++;
      i++;
    }
  }
  if (earlyExit) {
    nz = -2;
  } else {
    int32_T kcounter;
    boolean_T guard1;
    kcounter = 1;
    guard1 = false;
    if (static_cast<int32_T>(flooraz) <= 0) {
      int32_T itime;
      p1_re = 0.0;
      p1_im = 0.0;
      p2_re = 1.0;
      p2_im = 0.0;
      if (z.im == 0.0) {
        ck_re = 1.0 / z.re;
        ck_im = 0.0;
      } else if (z.re == 0.0) {
        ck_re = 0.0;
        ck_im = -(1.0 / z.im);
      } else {
        bk = std::abs(z.re);
        ack = std::abs(z.im);
        if (bk > ack) {
          ack = z.im / z.re;
          rho2 = z.re + ack * z.im;
          ck_re = (ack * 0.0 + 1.0) / rho2;
          ck_im = (0.0 - ack) / rho2;
        } else if (ack == bk) {
          if (z.re > 0.0) {
            ack = 0.5;
          } else {
            ack = -0.5;
          }
          if (z.im > 0.0) {
            rho2 = 0.5;
          } else {
            rho2 = -0.5;
          }
          ck_re = (ack + 0.0 * rho2) / bk;
          ck_im = (0.0 * ack - rho2) / bk;
        } else {
          ack = z.re / z.im;
          rho2 = z.im + ack * z.re;
          ck_re = ack / rho2;
          ck_im = (ack * 0.0 - 1.0) / rho2;
        }
      }
      tst = std::sqrt(1.0 / az / 2.2204460492503131E-16);
      itime = 1;
      earlyExit = true;
      i = 1;
      exitg1 = false;
      while ((!exitg1) && (i < 81)) {
        kcounter++;
        pt_re = p2_re;
        pt_im = p2_im;
        ack = ck_re * p2_re - ck_im * p2_im;
        rho2 = ck_re * p2_im + ck_im * p2_re;
        p2_re = p1_re - ack;
        p2_im = p1_im - rho2;
        p1_re = pt_re;
        p1_im = pt_im;
        ck_re += rz_re;
        ck_im += rz_im;
        rho2 = rt_hypotd_snf(p2_re, p2_im);
        if (rho2 >= tst * ak * ak) {
          if (itime == 2) {
            earlyExit = false;
            exitg1 = true;
          } else {
            ack = rt_hypotd_snf(ck_re, ck_im);
            ack = std::fmin(ack + std::sqrt(ack * ack - 1.0),
                            rho2 / rt_hypotd_snf(pt_re, pt_im));
            tst *= std::sqrt(ack / (ack * ack - 1.0));
            itime = 2;
            i++;
          }
        } else {
          i++;
        }
      }
      if (earlyExit) {
        nz = -2;
      } else {
        guard1 = true;
      }
    } else {
      guard1 = true;
    }
    if (guard1) {
      icounter += static_cast<int32_T>(flooraz);
      if (icounter >= kcounter) {
        kcounter = icounter;
      }
      az = kcounter;
      p1_re = 0.0;
      p1_im = 0.0;
      p2_re = 1.0020841800044864E-289;
      p2_im = 0.0;
      ak = fnu + fnu;
      tst = (static_cast<real_T>(kcounter) + ak) + 1.0;
      gammaln(&tst);
      rho2 = static_cast<real_T>(kcounter) + 1.0;
      gammaln(&rho2);
      ack = ak + 1.0;
      gammaln(&ack);
      bk = std::exp((tst - rho2) - ack);
      flooraz = 0.0;
      ck_re = 0.0;
      for (i = 0; i < kcounter; i++) {
        pt_re = p2_re;
        pt_im = p2_im;
        rho2 = (az + fnu) * rz_re;
        ack = (az + fnu) * rz_im;
        tst = rho2 * p2_re - ack * p2_im;
        ack = rho2 * p2_im + ack * p2_re;
        p2_re = p1_re + tst;
        p2_im = p1_im + ack;
        p1_re = pt_re;
        p1_im = pt_im;
        ack = bk * (1.0 - ak / (az + ak));
        flooraz += (ack + bk) * pt_re;
        ck_re += (ack + bk) * pt_im;
        bk = ack;
        az--;
      }
      y->re = p2_re;
      y->im = p2_im;
      pt_re = z.re;
      pt_im = z.im;
      if (kode == 2) {
        pt_re = z.re - z.re;
        pt_im = z.im;
      }
      if (rz_im == 0.0) {
        if (rz_re < 0.0) {
          ack = std::log(std::abs(rz_re));
          tst = 3.1415926535897931;
        } else {
          ack = std::log(rz_re);
          tst = 0.0;
        }
      } else if ((std::abs(rz_re) > 8.9884656743115785E+307) ||
                 (std::abs(rz_im) > 8.9884656743115785E+307)) {
        ack = std::log(rt_hypotd_snf(rz_re / 2.0, rz_im / 2.0)) +
              0.69314718055994529;
        tst = rt_atan2d_snf(rz_im, rz_re);
      } else {
        ack = std::log(rt_hypotd_snf(rz_re, rz_im));
        tst = rt_atan2d_snf(rz_im, rz_re);
      }
      rho2 = -fnu * ack - -0.0 * tst;
      bk = -fnu * tst + -0.0 * ack;
      tst = fnu + 1.0;
      gammaln(&tst);
      ack = (rho2 + pt_re) - tst;
      tst = bk + pt_im;
      p2_re += flooraz;
      p2_im += ck_re;
      p1_re = 1.0 / rt_hypotd_snf(p2_re, p2_im);
      if (ack == 0.0) {
        ack = std::cos(tst);
        tst = std::sin(tst);
      } else if (tst == 0.0) {
        ack = std::exp(ack);
        tst = 0.0;
      } else if (std::isinf(tst) && std::isinf(ack) && (ack < 0.0)) {
        ack = 0.0;
        tst = 0.0;
      } else {
        rho2 = std::exp(ack / 2.0);
        ack = rho2 * (rho2 * std::cos(tst));
        tst = rho2 * (rho2 * std::sin(tst));
      }
      bk = ack * p1_re - tst * 0.0;
      tst = ack * 0.0 + tst * p1_re;
      rho2 = p2_re * p1_re + p2_im * 0.0;
      p2_im = p2_re * 0.0 - p2_im * p1_re;
      ack = bk * rho2 - tst * p2_im;
      rho2 = bk * p2_im + tst * rho2;
      bk = y->re * rho2 + y->im * ack;
      y->re = y->re * ack - y->im * rho2;
      y->im = bk;
    }
  }
  return nz;
}

} // namespace coder

// End of code generation (cmlri.cu)
