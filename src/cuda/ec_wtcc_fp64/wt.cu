//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// wt.cu
//
// Code generation for function 'wt'
//

// Include files
#include "wt.h"
#include "bsxfun.h"
#include "colon.h"
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "fft.h"
#include "ifft.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo pd_emlrtRTEI{
    188,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo qd_emlrtRTEI{
    205,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo rd_emlrtRTEI{
    209,  // lineNo
    9,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo sd_emlrtRTEI{
    125,                                                          // lineNo
    9,                                                            // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

// Function Declarations
static __global__ void
cwtfilterbank_wt_kernel26(const int32_T i, const int32_T b, emxArray_real_T x);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void cwtfilterbank_wt_kernel26(
    const int32_T i, const int32_T b, emxArray_real_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T xtmp;
    int32_T b_j1;
    int32_T j2;
    b_j1 = static_cast<int32_T>(idx);
    j2 = i - b_j1;
    xtmp = x.data[b_j1];
    x.data[b_j1] = x.data[j2 - 1];
    x.data[j2 - 1] = xtmp;
  }
}

//
//
namespace coder {
void cwtfilterbank_wt(const cwtfilterbank *self, const emxArray_real_T *x,
                      emxArray_creal_T *varargout_1,
                      emxArray_real_T *varargout_2,
                      emxArray_real_T *varargout_3)
{
  dim3 block;
  dim3 grid;
  emxArray_creal_T gpu_xposdft;
  emxArray_creal_T *cpu_xposdft;
  emxArray_creal_T *r;
  emxArray_real_T gpu_r1;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xv;
  emxArray_real_T *cpu_r1;
  emxArray_real_T *cpu_x;
  emxArray_real_T *cpu_xv;
  emxArray_real_T *samples;
  real_T M;
  real_T Norig;
  real_T cf;
  real_T d3;
  real_T sigmaPsi;
  int32_T b_i;
  int32_T i;
  int32_T i1;
  int32_T i3;
  int32_T i5;
  int32_T nd2;
  char_T wname_idx_0;
  boolean_T r1_outdatedOnCpu;
  boolean_T r1_outdatedOnGpu;
  boolean_T xv_outdatedOnCpu;
  boolean_T xv_outdatedOnGpu;
  gpuEmxReset_real_T(&gpu_r1);
  gpuEmxReset_real_T(&gpu_x);
  gpuEmxReset_creal_T(&gpu_xposdft);
  gpuEmxReset_real_T(&gpu_xv);
  r1_outdatedOnCpu = false;
  r1_outdatedOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&cpu_xv, 2, &hb_emlrtRTEI, true);
  xv_outdatedOnCpu = false;
  xv_outdatedOnGpu = false;
  i = cpu_xv->size[0] * cpu_xv->size[1];
  cpu_xv->size[0] = 1;
  cpu_xv->size[1] = x->size[0];
  emxEnsureCapacity_real_T(cpu_xv, i, &hb_emlrtRTEI);
  for (i = 0; i < x->size[0]; i++) {
    cpu_xv->data[i] = x->data[i];
    xv_outdatedOnGpu = true;
  }
  Norig = self->SignalLength;
  if (self->SignalPad > 0.0) {
    boolean_T validLaunchParams;
    M = self->SignalPad;
    if (M < 1.0) {
      b_i = 0;
    } else {
      b_i = static_cast<int32_T>(M);
    }
    M = (static_cast<real_T>(x->size[0]) - self->SignalPad) + 1.0;
    if (M > x->size[0]) {
      i1 = 0;
      i3 = 1;
      i5 = -1;
    } else {
      i1 = x->size[0] - 1;
      i3 = -1;
      i5 = static_cast<int32_T>(M) - 1;
    }
    emxInit_real_T(&cpu_x, 2, &ib_emlrtRTEI, true);
    r1_outdatedOnCpu = false;
    i = cpu_x->size[0] * cpu_x->size[1];
    cpu_x->size[0] = 1;
    cpu_x->size[1] = b_i;
    emxEnsureCapacity_real_T(cpu_x, i, &ib_emlrtRTEI);
    for (i = 0; i < b_i; i++) {
      cpu_x->data[i] = x->data[i];
      r1_outdatedOnCpu = true;
    }
    mwGetLaunchParameters1D(computeNumIters((b_i >> 1) - 1), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_x, &gpu_x, !r1_outdatedOnCpu);
    if (r1_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      cwtfilterbank_wt_kernel26<<<grid, block>>>(b_i, (b_i >> 1) - 1, gpu_x);
    }
    r1_outdatedOnCpu = true;
    xv_outdatedOnGpu = false;
    i = cpu_xv->size[0] * cpu_xv->size[1];
    cpu_xv->size[0] = 1;
    cpu_xv->size[1] =
        ((x->size[0] + cpu_x->size[1]) + div_s32(i5 - i1, i3)) + 1;
    emxEnsureCapacity_real_T(cpu_xv, i, &lb_emlrtRTEI);
    b_i = cpu_x->size[1];
    for (i = 0; i < b_i; i++) {
      if (r1_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_x, &gpu_x);
      }
      r1_outdatedOnCpu = false;
      cpu_xv->data[i] = cpu_x->data[i];
      xv_outdatedOnGpu = true;
    }
    b_i = x->size[0];
    for (i = 0; i < b_i; i++) {
      cpu_xv->data[i + cpu_x->size[1]] = x->data[i];
      xv_outdatedOnGpu = true;
    }
    b_i = div_s32(i5 - i1, i3);
    for (i = 0; i <= b_i; i++) {
      cpu_xv->data[(i + x->size[0]) + cpu_x->size[1]] = x->data[i1 + i3 * i];
      xv_outdatedOnGpu = true;
    }
    emxFree_real_T(&cpu_x);
  }
  emxInit_creal_T(&cpu_xposdft, 2, &qb_emlrtRTEI, true);
  fft(cpu_xv, &xv_outdatedOnCpu, &gpu_xv, &xv_outdatedOnGpu, cpu_xposdft,
      &r1_outdatedOnCpu, &gpu_xposdft, &r1_outdatedOnGpu);
  emxFree_real_T(&cpu_xv);
  emxInit_creal_T(&r, 2, &vb_emlrtRTEI, true);
  if (r1_outdatedOnCpu) {
    gpuEmxMemcpyGpuToCpu_creal_T(cpu_xposdft, &gpu_xposdft);
  }
  bsxfun(cpu_xposdft, self->PsiDFT, r);
  emxFree_creal_T(&cpu_xposdft);
  ifft(r, varargout_1);
  emxFree_creal_T(&r);
  if (self->SignalPad > 0.0) {
    M = self->SignalPad + 1.0;
    d3 = self->SignalPad + Norig;
    if (M > d3) {
      nd2 = 0;
      i1 = 0;
    } else {
      nd2 = static_cast<int32_T>(M) - 1;
      i1 = static_cast<int32_T>(d3);
    }
    i3 = varargout_1->size[0];
    b_i = i1 - nd2;
    for (i = 0; i < b_i; i++) {
      for (i5 = 0; i5 < i3; i5++) {
        varargout_1->data[i5 + i3 * i] =
            varargout_1->data[i5 + varargout_1->size[0] * (nd2 + i)];
      }
    }
    i = varargout_1->size[0] * varargout_1->size[1];
    varargout_1->size[1] = i1 - nd2;
    emxEnsureCapacity_creal_T(varargout_1, i, &jb_emlrtRTEI);
  }
  i = varargout_2->size[0];
  varargout_2->size[0] = self->WaveletCenterFrequencies->size[0];
  emxEnsureCapacity_real_T(varargout_2, i, &pd_emlrtRTEI);
  for (i = 0; i < self->WaveletCenterFrequencies->size[0]; i++) {
    varargout_2->data[i] = self->WaveletCenterFrequencies->data[i];
  }
  wname_idx_0 = cv[static_cast<uint8_T>(self->Wavelet[0]) & 127];
  if (wname_idx_0 == 'm') {
    cf = rtNaN;
  } else if (wname_idx_0 == 'a') {
    cf = 6.0;
    sigmaPsi = 1.4142135623730951;
  } else {
    cf = 5.0;
    sigmaPsi = 5.847705;
  }
  emxInit_real_T(&samples, 1, &qd_emlrtRTEI, true);
  i = samples->size[0];
  samples->size[0] = static_cast<int32_T>(Norig);
  emxEnsureCapacity_real_T(samples, i, &qd_emlrtRTEI);
  for (i = 0; i < static_cast<int32_T>(Norig); i++) {
    samples->data[i] = 0.0;
  }
  if (std::isinf(Norig)) {
    M = rtNaN;
  } else if (Norig == 0.0) {
    M = 0.0;
  } else {
    M = std::fmod(Norig, 2.0);
  }
  if (M == 1.0) {
    M = std::ceil(Norig / 2.0);
    if (!(M < 1.0)) {
      for (i = 0; i <= static_cast<int32_T>(M - 1.0); i++) {
        samples->data[i] = static_cast<real_T>(i) + 1.0;
      }
    }
    if (M + 1.0 > Norig) {
      nd2 = 0;
    } else {
      nd2 = static_cast<int32_T>(static_cast<uint32_T>(M));
    }
    if (!(M - 1.0 < 1.0)) {
      for (i = 0; i <= static_cast<int32_T>(-(1.0 - (M - 1.0))); i++) {
        samples->data[nd2 + i] = (M - 1.0) - static_cast<real_T>(i);
      }
    }
  } else {
    M = Norig / 2.0;
    if (!(M < 1.0)) {
      for (i = 0; i <= static_cast<int32_T>(M - 1.0); i++) {
        samples->data[i] = static_cast<real_T>(i) + 1.0;
      }
    }
    M = Norig / 2.0 + 1.0;
    if (M > Norig) {
      nd2 = 0;
    } else {
      nd2 = static_cast<int32_T>(M) - 1;
    }
    M = Norig / 2.0;
    if (!(M < 1.0)) {
      if (std::floor(M) == M) {
        for (i = 0; i <= static_cast<int32_T>(-(1.0 - M)); i++) {
          samples->data[nd2 + i] = M - static_cast<real_T>(i);
        }
      } else {
        emxInit_real_T(&cpu_r1, 2, &sd_emlrtRTEI, true);
        eml_float_colon(M, cpu_r1, &r1_outdatedOnCpu, &gpu_r1,
                        &r1_outdatedOnGpu);
        for (i = 0; i < cpu_r1->size[1]; i++) {
          if (r1_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_r1, &gpu_r1);
          }
          r1_outdatedOnCpu = false;
          samples->data[nd2 + i] = cpu_r1->data[i];
        }
        emxFree_real_T(&cpu_r1);
      }
    }
  }
  M = 6.2831853071795862 / cf / sigmaPsi * (1.0 / self->SamplingFrequency);
  i = varargout_3->size[0];
  varargout_3->size[0] = samples->size[0];
  emxEnsureCapacity_real_T(varargout_3, i, &rd_emlrtRTEI);
  for (i = 0; i < samples->size[0]; i++) {
    varargout_3->data[i] = 1.0 / (M * samples->data[i]);
  }
  emxFree_real_T(&samples);
  nd2 = self->WaveletCenterFrequencies->size[0];
  M = self->WaveletCenterFrequencies->data[0];
  d3 = self->WaveletCenterFrequencies->data[0];
  for (b_i = 0; b_i <= nd2 - 2; b_i++) {
    cf = self->WaveletCenterFrequencies->data[b_i + 1];
    if (std::isnan(cf)) {
      r1_outdatedOnCpu = false;
    } else if (std::isnan(M)) {
      r1_outdatedOnCpu = true;
    } else {
      r1_outdatedOnCpu = (M < cf);
    }
    if (r1_outdatedOnCpu) {
      M = cf;
    }
    if (std::isnan(cf)) {
      r1_outdatedOnCpu = false;
    } else if (std::isnan(d3)) {
      r1_outdatedOnCpu = true;
    } else {
      r1_outdatedOnCpu = (d3 < cf);
    }
    if (r1_outdatedOnCpu) {
      d3 = cf;
    }
  }
  nd2 = varargout_3->size[0] - 1;
  for (b_i = 0; b_i <= nd2; b_i++) {
    if (varargout_3->data[b_i] > M) {
      varargout_3->data[b_i] = d3;
    }
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&gpu_xv);
  gpuEmxFree_creal_T(&gpu_xposdft);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_r1);
}

} // namespace coder

// End of code generation (wt.cu)
