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
#include "ec_wt2_fp_mexutil.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Function Definitions
//
//
namespace coder {
namespace wavelet {
namespace internal {
namespace cwt {
real_T getFreqFromCutoffMorse(real_T cutoff, real_T cf, real_T ga, real_T be)
{
  real_T omegac;
  real_T psihat_workspace_alpha;
  real_T psihat_workspace_anorm;
  nvtxRangePushA("#fcn#getFreqFromCutoffMorse#" MW_AT_LOCATION);
  psihat_workspace_anorm =
      2.0 * std::exp(be / ga * ((std::log(ga) - std::log(be)) + 1.0));
  psihat_workspace_alpha = 2.0 * cutoff;
  nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
  omegac = rt_powd_snf(750.0, 1.0 / ga);
  nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
  nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
  if (psihat_workspace_alpha - psihat_workspace_anorm * rt_powd_snf(cf, be) *
                                   std::exp(-rt_powd_snf(cf, ga)) >=
      0.0) {
    nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
    nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
    nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
    nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
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
    nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
    nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
    fa = psihat_workspace_alpha - psihat_workspace_anorm * rt_powd_snf(cf, be) *
                                      std::exp(-rt_powd_snf(cf, ga));
    nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
    nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
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
      nvtxRangePushA("#loop#getFreqFromCutoffMorse_whileloop_0##" MW_AT_LINE);
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
          nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
          nvtxMarkA("#rt_powd_snf#" MW_AT_LINE);
          fb = psihat_workspace_alpha - psihat_workspace_anorm *
                                            rt_powd_snf(omegac, be) *
                                            std::exp(-rt_powd_snf(omegac, ga));
        }
      }
      nvtxRangePop();
    }
  }
  nvtxRangePop();
  return omegac;
}

} // namespace cwt
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (cwtfreqlimits.cu)
