//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// scaleSpectrum.cu
//
// Code generation for function 'scaleSpectrum'
//

// Include files
#include "scaleSpectrum.h"
#include "div.h"
#include "ec_wtAvg_fp_data.h"
#include "ec_wtAvg_fp_emxutil.h"
#include "ec_wtAvg_fp_mexutil.h"
#include "ec_wtAvg_fp_types.h"
#include "numCpsi.h"
#include "rt_nonfinite.h"
#include "vvarstd.h"
#include "wt.h"
#include "MWCUBLASUtils.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWErrorCodeUtils.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include <cmath>
#include <cstdlib>

// Variable Definitions
static emlrtRTEInfo cd_emlrtRTEI{
    12,                                                               // lineNo
    5,                                                                // colNo
    "trapz",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m" // pName
};

static emlrtRTEInfo dd_emlrtRTEI{
    211,                                                              // lineNo
    24,                                                               // colNo
    "trapz",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m" // pName
};

static emlrtRTEInfo ed_emlrtRTEI{
    96,                                                               // lineNo
    5,                                                                // colNo
    "trapz",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m" // pName
};

static emlrtRTEInfo gd_emlrtRTEI{
    298,             // lineNo
    18,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo hd_emlrtRTEI{
    297,             // lineNo
    5,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo id_emlrtRTEI{
    12,            // lineNo
    12,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo jd_emlrtRTEI{
    22,            // lineNo
    32,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo kd_emlrtRTEI{
    12,            // lineNo
    1,             // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo ld_emlrtRTEI{
    26,            // lineNo
    43,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo md_emlrtRTEI{
    26,            // lineNo
    37,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo nd_emlrtRTEI{
    293,             // lineNo
    14,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

// Function Declarations
static void cublasCheck(cublasStatus_t errCode, const char_T *file,
                        uint32_T b_line);

static void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                           const char_T *errorName, const char_T *errorString);

static real_T rt_hypotd_snf(real_T u0, real_T u1);

// Function Definitions
static void cublasCheck(cublasStatus_t errCode, const char_T *file,
                        uint32_T b_line)
{
  const char *errName;
  const char *errString;
  nvtxRangePushA("#fcn#cublasCheck#" MW_AT_LOCATION);
  if (errCode != CUBLAS_STATUS_SUCCESS) {
    cublasGetErrorName(errCode, &errName);
    cublasGetErrorString(errCode, &errString);
    nvtxMarkA("#raiseCudaError#" MW_AT_LINE);
    raiseCudaError(errCode, file, b_line, errName, errString);
  }
  nvtxRangePop();
}

static void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                           const char_T *errorName, const char_T *errorString)
{
  emlrtRTEInfo rtInfo;
  uint64_T len;
  char_T *brk;
  char_T *fn;
  char_T *pn;
  nvtxRangePushA("#fcn#raiseCudaError#" MW_AT_LOCATION);
  len = strlen(file);
  pn = static_cast<char_T *>(std::calloc(static_cast<uint32_T>(len + 1UL), 1U));
  fn = static_cast<char_T *>(std::calloc(static_cast<uint32_T>(len + 1UL), 1U));
  memcpy(pn, file, len);
  memcpy(fn, file, len);
  brk = strrchr(fn, '.');
  *brk = '\x00';
  brk = strrchr(fn, '/');
  if (brk == nullptr) {
    brk = strrchr(fn, '\\');
  }
  if (brk == nullptr) {
    brk = fn;
  } else {
    brk++;
  }
  rtInfo.lineNo = static_cast<int32_T>(b_line);
  rtInfo.colNo = 0;
  rtInfo.fName = brk;
  rtInfo.pName = pn;
  emlrtCUDAError(static_cast<uint32_T>(errCode), (char_T *)errorName,
                 (char_T *)errorString, &rtInfo, emlrtRootTLSGlobal);
  nvtxRangePop();
}

static real_T rt_hypotd_snf(real_T u0, real_T u1)
{
  real_T a;
  real_T b;
  real_T y;
  nvtxRangePushA("#fcn#rt_hypotd_snf#" MW_AT_LOCATION);
  a = std::abs(u0);
  b = std::abs(u1);
  if (a < b) {
    a /= b;
    y = b * std::sqrt(a * a + 1.0);
  } else if (a > b) {
    b /= a;
    y = a * std::sqrt(b * b + 1.0);
  } else if (std::isnan(b)) {
    y = rtNaN;
  } else {
    y = a * 1.4142135623730951;
  }
  nvtxRangePop();
  return y;
}

//
//
namespace coder {
void cwtfilterbank_scaleSpectrum(cwtfilterbank *self, const emxArray_real_T *x,
                                 emxArray_real_T *cpu_savgp,
                                 boolean_T *savgp_outdatedOnCpu,
                                 emxArray_real_T *gpu_savgp,
                                 boolean_T *savgp_outdatedOnGpu)
{
  emxArray_creal_T *cfs;
  emxArray_real_T b_gpu_c;
  emxArray_real_T c_gpu_c;
  emxArray_real_T gpu_abscfssq;
  emxArray_real_T gpu_c;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_z;
  emxArray_real_T *a;
  emxArray_real_T *abswt2S;
  emxArray_real_T *b_cpu_c;
  emxArray_real_T *c_cpu_c;
  emxArray_real_T *c_y;
  emxArray_real_T *cpu_abscfssq;
  emxArray_real_T *cpu_c;
  emxArray_real_T *cpu_y;
  emxArray_real_T *cpu_z;
  emxArray_real_T *d_y;
  emxArray_real_T *y;
  emxArray_uint32_T *b_y;
  real_T alpha1;
  real_T b_cpu_z;
  real_T c1;
  real_T normfac;
  real_T *b_gpu_z;
  int32_T acoef;
  int32_T nx;
  int32_T u1;
  uint32_T defaultSL_idx_1;
  boolean_T abscfssq_outdatedOnGpu;
  boolean_T z_needsGpuEnsureCapacity;
  boolean_T z_outdatedOnGpu;
  nvtxRangePushA("#fcn#cwtfilterbank_scaleSpectrum#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_c);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_c);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&b_gpu_z, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_c);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_z);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_abscfssq);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  defaultSL_idx_1 = static_cast<uint32_T>(self->Scales->size[1]);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cfs, 2, &o_emlrtRTEI, true);
  nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
  cwtfilterbank_wt(self, x, cfs);
  nvtxMarkA("#vvarstd#" MW_AT_LINE);
  normfac = vvarstd(x, x->size[0]);
  nx = cfs->size[0] * cfs->size[1];
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&y, 2, &id_emlrtRTEI, true);
  acoef = y->size[0] * y->size[1];
  y->size[0] = cfs->size[0];
  y->size[1] = cfs->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(y, acoef, &f_emlrtRTEI);
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_0", __LINE__, (nx - 1) + 1,
                   "");
  for (int32_T k{0}; k < nx; k++) {
    nvtxMarkA("#rt_hypotd_snf#" MW_AT_LINE);
    y->data[k] = rt_hypotd_snf(cfs->data[k].re, cfs->data[k].im);
  }
  profileLoopEnd();
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&a, 2, &jd_emlrtRTEI, true);
  acoef = a->size[0] * a->size[1];
  a->size[0] = y->size[0];
  a->size[1] = y->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(a, acoef, &h_emlrtRTEI);
  nx = y->size[0] * y->size[1];
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_1", __LINE__, (nx - 1) + 1,
                   "");
  for (int32_T k{0}; k < nx; k++) {
    a->data[k] = y->data[k] * y->data[k];
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&y);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_abscfssq, 2, &kd_emlrtRTEI, true);
  abscfssq_outdatedOnGpu = false;
  acoef = cpu_abscfssq->size[0] * cpu_abscfssq->size[1];
  nx = self->Scales->size[1];
  u1 = a->size[0];
  if (nx <= u1) {
    u1 = nx;
  }
  if (self->Scales->size[1] == 1) {
    cpu_abscfssq->size[0] = a->size[0];
  } else if (a->size[0] == 1) {
    cpu_abscfssq->size[0] = self->Scales->size[1];
  } else if (a->size[0] == self->Scales->size[1]) {
    cpu_abscfssq->size[0] = a->size[0];
  } else {
    cpu_abscfssq->size[0] = u1;
  }
  cpu_abscfssq->size[1] = a->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(cpu_abscfssq, acoef, &i_emlrtRTEI);
  nx = self->Scales->size[1];
  u1 = a->size[0];
  if (nx <= u1) {
    u1 = nx;
  }
  if (self->Scales->size[1] == 1) {
    u1 = a->size[0];
  } else if (a->size[0] == 1) {
    u1 = self->Scales->size[1];
  } else if (a->size[0] == self->Scales->size[1]) {
    u1 = a->size[0];
  }
  if ((u1 != 0) && (a->size[1] != 0)) {
    int32_T bcoef;
    nx = (a->size[1] != 1);
    u1 = a->size[1] - 1;
    acoef = (a->size[0] != 1);
    bcoef = (self->Scales->size[1] != 1);
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_2", __LINE__, u1 + 1,
                     "");
    for (int32_T k{0}; k <= u1; k++) {
      int32_T i1;
      int32_T varargin_2;
      varargin_2 = nx * k;
      i1 = cpu_abscfssq->size[0] - 1;
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_3", __LINE__, i1 + 1,
                       "");
      for (int32_T b_k{0}; b_k <= i1; b_k++) {
        cpu_abscfssq->data[b_k + cpu_abscfssq->size[0] * k] =
            a->data[acoef * b_k + a->size[0] * varargin_2] /
            self->Scales->data[bcoef * b_k];
        abscfssq_outdatedOnGpu = true;
      }
      profileLoopEnd();
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&a);
  nvtxMarkA("#emxInit_uint32_T#" MW_AT_LINE);
  emxInit_uint32_T(&b_y, 2, &ld_emlrtRTEI, true);
  if (cpu_abscfssq->size[1] < 1) {
    b_y->size[0] = 1;
    b_y->size[1] = 0;
  } else {
    uint32_T u;
    u = static_cast<uint32_T>(cpu_abscfssq->size[1]);
    acoef = b_y->size[0] * b_y->size[1];
    b_y->size[0] = 1;
    b_y->size[1] = cpu_abscfssq->size[1];
    nvtxMarkA("#emxEnsureCapacity_uint32_T#" MW_AT_LINE);
    emxEnsureCapacity_uint32_T(b_y, acoef, &w_emlrtRTEI);
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_4", __LINE__,
                     (static_cast<int32_T>(u) - 1) + 1, "");
    for (acoef = 0; acoef < static_cast<int32_T>(u); acoef++) {
      b_y->data[acoef] = static_cast<uint32_T>(acoef) + 1U;
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_z, 1, &md_emlrtRTEI, true);
  z_outdatedOnGpu = false;
  acoef = cpu_z->size[0];
  cpu_z->size[0] = cpu_abscfssq->size[0];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(cpu_z, acoef, &cd_emlrtRTEI);
  z_needsGpuEnsureCapacity = true;
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_5", __LINE__,
                   (cpu_abscfssq->size[0] - 1) + 1, "");
  for (acoef = 0; acoef < cpu_abscfssq->size[0]; acoef++) {
    cpu_z->data[acoef] = 0.0;
    z_outdatedOnGpu = true;
  }
  profileLoopEnd();
  if (cpu_abscfssq->size[1] > 1) {
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_c, 1, &ed_emlrtRTEI, true);
    if (b_y->size[1] == 1) {
      nx = cpu_abscfssq->size[1];
      acoef = cpu_c->size[0];
      cpu_c->size[0] = cpu_abscfssq->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_c, acoef, &ed_emlrtRTEI);
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_6", __LINE__,
                       (nx - 1) + 1, "");
      for (acoef = 0; acoef < nx; acoef++) {
        cpu_c->data[acoef] = b_y->data[0];
      }
      profileLoopEnd();
      c1 = 0.5 * static_cast<real_T>(b_y->data[0]);
      cpu_c->data[0] = c1;
      cpu_c->data[cpu_abscfssq->size[1] - 1] = c1;
    } else {
      acoef = cpu_c->size[0];
      cpu_c->size[0] = cpu_abscfssq->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_c, acoef, &dd_emlrtRTEI);
      cpu_c->data[0] =
          0.5 * static_cast<real_T>(static_cast<int32_T>(b_y->data[1]) -
                                    static_cast<int32_T>(b_y->data[0]));
      nx = cpu_abscfssq->size[1];
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_7", __LINE__,
                       (nx - 3) + 1, "");
      for (int32_T k{0}; k <= nx - 3; k++) {
        cpu_c->data[k + 1] =
            0.5 * static_cast<real_T>(static_cast<int32_T>(b_y->data[k + 2]) -
                                      static_cast<int32_T>(b_y->data[k]));
      }
      profileLoopEnd();
      cpu_c->data[cpu_abscfssq->size[1] - 1] =
          0.5 * static_cast<real_T>(
                    static_cast<int32_T>(b_y->data[cpu_abscfssq->size[1] - 1]) -
                    static_cast<int32_T>(b_y->data[cpu_abscfssq->size[1] - 2]));
    }
    if (cpu_abscfssq->size[0] >= 1) {
      c1 = 0.0;
      alpha1 = 1.0;
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_abscfssq, &gpu_abscfssq,
                                  !abscfssq_outdatedOnGpu);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_c, &gpu_c, false);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_z, &gpu_z, !z_outdatedOnGpu);
      z_needsGpuEnsureCapacity = false;
      if (abscfssq_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_abscfssq, cpu_abscfssq);
      }
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_c, cpu_c);
      if (z_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, cpu_z);
      }
      nvtxMarkA("#cublasCheck#" MW_AT_LINE);
      cublasCheck(cublasDgemv(getCublasGlobalHandle(), CUBLAS_OP_N,
                              cpu_abscfssq->size[0], cpu_abscfssq->size[1],
                              (double *)&alpha1,
                              (double *)&gpu_abscfssq.data[0],
                              cpu_abscfssq->size[0], (double *)&gpu_c.data[0],
                              1, (double *)&c1, (double *)&gpu_z.data[0], 1),
                  __FILE__, __LINE__);
      z_outdatedOnGpu = false;
    }
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_c);
  }
  nvtxMarkA("#emxFree_uint32_T#" MW_AT_LINE);
  emxFree_uint32_T(&b_y);
  b_cpu_z = 0.0;
  abscfssq_outdatedOnGpu = false;
  if (cpu_z->size[0] <= 1) {
    if ((self->Scales->size[1] == 1) && (std::isinf(self->Scales->data[0]) ||
                                         std::isnan(self->Scales->data[0]))) {
      b_cpu_z = rtNaN;
    }
  } else {
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&b_cpu_c, 1, &ed_emlrtRTEI, true);
    if (self->Scales->size[1] == 1) {
      nx = cpu_z->size[0];
      acoef = b_cpu_c->size[0];
      b_cpu_c->size[0] = cpu_z->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(b_cpu_c, acoef, &ed_emlrtRTEI);
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_8", __LINE__,
                       (nx - 1) + 1, "");
      for (acoef = 0; acoef < nx; acoef++) {
        b_cpu_c->data[acoef] = self->Scales->data[0];
      }
      profileLoopEnd();
      c1 = 0.5 * self->Scales->data[0];
      b_cpu_c->data[0] = c1;
      b_cpu_c->data[cpu_z->size[0] - 1] = c1;
    } else {
      acoef = b_cpu_c->size[0];
      b_cpu_c->size[0] = cpu_z->size[0];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(b_cpu_c, acoef, &dd_emlrtRTEI);
      b_cpu_c->data[0] = 0.5 * (self->Scales->data[1] - self->Scales->data[0]);
      nx = cpu_z->size[0];
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_9", __LINE__,
                       (nx - 3) + 1, "");
      for (int32_T k{0}; k <= nx - 3; k++) {
        b_cpu_c->data[k + 1] =
            0.5 * (self->Scales->data[k + 2] - self->Scales->data[k]);
      }
      profileLoopEnd();
      b_cpu_c->data[cpu_z->size[0] - 1] =
          0.5 * (self->Scales->data[cpu_z->size[0] - 1] -
                 self->Scales->data[cpu_z->size[0] - 2]);
    }
    c1 = 0.0;
    alpha1 = 1.0;
    if (z_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_z, &gpu_z, !z_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(b_cpu_c, &c_gpu_c, false);
    if (z_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, cpu_z);
    }
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_c, b_cpu_c);
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
    checkCudaError(cudaMemcpy(b_gpu_z, &b_cpu_z, 8UL, cudaMemcpyHostToDevice),
                   __FILE__, __LINE__);
    nvtxMarkA("#cublasCheck#" MW_AT_LINE);
    cublasCheck(cublasDgemv(getCublasGlobalHandle(), CUBLAS_OP_T,
                            cpu_z->size[0], 1, (double *)&alpha1,
                            (double *)&gpu_z.data[0], cpu_z->size[0],
                            (double *)&c_gpu_c.data[0], 1, (double *)&c1,
                            (double *)b_gpu_z, 1),
                __FILE__, __LINE__);
    abscfssq_outdatedOnGpu = true;
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&b_cpu_c);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_z);
  if (!(normfac == 0.0)) {
    if (abscfssq_outdatedOnGpu) {
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
      checkCudaError(cudaMemcpy(&b_cpu_z, b_gpu_z, 8UL, cudaMemcpyDeviceToHost),
                     __FILE__, __LINE__);
    }
    nvtxMarkA("#numCpsi#" MW_AT_LINE);
    c1 = std::sqrt(normfac /
                   (2.0 /
                    wavelet::internal::cwt::numCpsi(self->Wavelet, self->Gamma,
                                                    self->Beta) /
                    static_cast<real_T>(cpu_abscfssq->size[1]) * b_cpu_z));
    acoef = cfs->size[0] * cfs->size[1];
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_10", __LINE__,
                     (acoef - 1) + 1, "");
    for (u1 = 0; u1 < acoef; u1++) {
      cfs->data[u1].re *= c1;
      cfs->data[u1].im *= c1;
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_abscfssq);
  nx = cfs->size[0] * cfs->size[1];
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_y, 2, &nd_emlrtRTEI, true);
  acoef = c_y->size[0] * c_y->size[1];
  c_y->size[0] = cfs->size[0];
  c_y->size[1] = cfs->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(c_y, acoef, &f_emlrtRTEI);
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_11", __LINE__,
                   (nx - 1) + 1, "");
  for (int32_T k{0}; k < nx; k++) {
    nvtxMarkA("#rt_hypotd_snf#" MW_AT_LINE);
    c_y->data[k] = rt_hypotd_snf(cfs->data[k].re, cfs->data[k].im);
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cfs);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&d_y, 2, &nd_emlrtRTEI, true);
  acoef = d_y->size[0] * d_y->size[1];
  d_y->size[0] = c_y->size[0];
  d_y->size[1] = c_y->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(d_y, acoef, &h_emlrtRTEI);
  nx = c_y->size[0] * c_y->size[1];
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_12", __LINE__,
                   (nx - 1) + 1, "");
  for (int32_T k{0}; k < nx; k++) {
    d_y->data[k] = c_y->data[k] * c_y->data[k];
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_y);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&abswt2S, 2, &fd_emlrtRTEI, true);
  if (d_y->size[0] == self->Scales->size[1]) {
    acoef = abswt2S->size[0] * abswt2S->size[1];
    abswt2S->size[0] = d_y->size[0];
    abswt2S->size[1] = d_y->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(abswt2S, acoef, &fd_emlrtRTEI);
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_13", __LINE__,
                     (d_y->size[1] - 1) + 1, "");
    for (acoef = 0; acoef < d_y->size[1]; acoef++) {
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_14", __LINE__,
                       (d_y->size[0] - 1) + 1, "");
      for (u1 = 0; u1 < d_y->size[0]; u1++) {
        abswt2S->data[u1 + abswt2S->size[0] * acoef] =
            d_y->data[u1 + d_y->size[0] * acoef] / self->Scales->data[u1];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
  } else {
    nvtxMarkA("#binary_expand_op_6#" MW_AT_LINE);
    binary_expand_op_6(abswt2S, d_y, self);
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&d_y);
  nx = static_cast<int32_T>(defaultSL_idx_1);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_y, 2, &gd_emlrtRTEI, true);
  abscfssq_outdatedOnGpu = false;
  acoef = cpu_y->size[0] * cpu_y->size[1];
  cpu_y->size[0] = static_cast<int32_T>(defaultSL_idx_1);
  cpu_y->size[1] = abswt2S->size[1];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(cpu_y, acoef, &gd_emlrtRTEI);
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_15", __LINE__,
                   (abswt2S->size[1] - 1) + 1, "");
  for (acoef = 0; acoef < abswt2S->size[1]; acoef++) {
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_16", __LINE__,
                     (nx - 1) + 1, "");
    for (u1 = 0; u1 < nx; u1++) {
      cpu_y->data[u1 + cpu_y->size[0] * acoef] =
          abswt2S->data[u1 + abswt2S->size[0] * acoef];
      abscfssq_outdatedOnGpu = true;
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_c, 1, &ed_emlrtRTEI, true);
  if ((static_cast<int32_T>(defaultSL_idx_1) == 0) && (abswt2S->size[1] == 0)) {
    if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
      b_cpu_z = self->Scales->data[0] * 0.0;
    } else {
      b_cpu_z = 0.0;
    }
    acoef = cpu_savgp->size[0] * cpu_savgp->size[1];
    cpu_savgp->size[0] = 1;
    cpu_savgp->size[1] = 1;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_savgp, acoef, &hd_emlrtRTEI);
    cpu_savgp->data[0] = b_cpu_z;
    *savgp_outdatedOnCpu = false;
    *savgp_outdatedOnGpu = true;
  } else {
    *savgp_outdatedOnCpu = false;
    *savgp_outdatedOnGpu = false;
    acoef = cpu_savgp->size[0] * cpu_savgp->size[1];
    cpu_savgp->size[0] = 1;
    cpu_savgp->size[1] = abswt2S->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_savgp, acoef, &hd_emlrtRTEI);
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_17", __LINE__,
                     (abswt2S->size[1] - 1) + 1, "");
    for (acoef = 0; acoef < abswt2S->size[1]; acoef++) {
      cpu_savgp->data[acoef] = 0.0;
      *savgp_outdatedOnGpu = true;
    }
    profileLoopEnd();
    if (static_cast<int32_T>(defaultSL_idx_1) <= 1) {
      if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
        c1 = self->Scales->data[0];
        if (std::isinf(c1) || std::isnan(c1)) {
          *savgp_outdatedOnGpu = false;
          acoef = cpu_savgp->size[0] * cpu_savgp->size[1];
          cpu_savgp->size[0] = 1;
          cpu_savgp->size[1] = abswt2S->size[1];
          nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
          emxEnsureCapacity_real_T(cpu_savgp, acoef, &hd_emlrtRTEI);
          profileLoopStart("cwtfilterbank_scaleSpectrum_loop_20", __LINE__,
                           (abswt2S->size[1] - 1) + 1, "");
          for (acoef = 0; acoef < abswt2S->size[1]; acoef++) {
            cpu_savgp->data[acoef] = rtNaN;
            *savgp_outdatedOnGpu = true;
          }
          profileLoopEnd();
        }
      }
    } else {
      if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
        c1 = self->Scales->data[0];
        acoef = c_cpu_c->size[0];
        c_cpu_c->size[0] = static_cast<int32_T>(defaultSL_idx_1);
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(c_cpu_c, acoef, &ed_emlrtRTEI);
        profileLoopStart("cwtfilterbank_scaleSpectrum_loop_19", __LINE__,
                         (nx - 1) + 1, "");
        for (acoef = 0; acoef < nx; acoef++) {
          c_cpu_c->data[acoef] = c1;
        }
        profileLoopEnd();
        c1 = 0.5 * self->Scales->data[0];
        c_cpu_c->data[0] = c1;
        c_cpu_c->data[static_cast<int32_T>(defaultSL_idx_1) - 1] = c1;
      } else {
        acoef = c_cpu_c->size[0];
        c_cpu_c->size[0] = static_cast<int32_T>(defaultSL_idx_1);
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(c_cpu_c, acoef, &dd_emlrtRTEI);
        c_cpu_c->data[0] =
            0.5 * (self->Scales->data[1] - self->Scales->data[0]);
        profileLoopStart("cwtfilterbank_scaleSpectrum_loop_18", __LINE__,
                         (nx - 3) + 1, "");
        for (int32_T k{0}; k <= nx - 3; k++) {
          c_cpu_c->data[k + 1] =
              0.5 * (self->Scales->data[k + 2] - self->Scales->data[k]);
        }
        profileLoopEnd();
        c_cpu_c->data[static_cast<int32_T>(defaultSL_idx_1) - 1] =
            0.5 *
            (self->Scales->data[static_cast<int32_T>(defaultSL_idx_1) - 1] -
             self->Scales->data[static_cast<int32_T>(defaultSL_idx_1) - 2]);
      }
      if (abswt2S->size[1] >= 1) {
        c1 = 0.0;
        alpha1 = 1.0;
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, !abscfssq_outdatedOnGpu);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(c_cpu_c, &b_gpu_c, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real_T(cpu_savgp, gpu_savgp,
                                    !*savgp_outdatedOnGpu);
        if (abscfssq_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_y, cpu_y);
        }
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_c, c_cpu_c);
        if (*savgp_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real_T(gpu_savgp, cpu_savgp);
        }
        nvtxMarkA("#cublasCheck#" MW_AT_LINE);
        cublasCheck(cublasDgemv(getCublasGlobalHandle(), CUBLAS_OP_T,
                                static_cast<int32_T>(defaultSL_idx_1),
                                abswt2S->size[1], (double *)&alpha1,
                                (double *)&gpu_y.data[0],
                                static_cast<int32_T>(defaultSL_idx_1),
                                (double *)&b_gpu_c.data[0], 1, (double *)&c1,
                                (double *)&gpu_savgp->data[0], 1),
                    __FILE__, __LINE__);
        *savgp_outdatedOnGpu = false;
        *savgp_outdatedOnCpu = true;
      }
    }
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_c);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_y);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&abswt2S);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_abscfssq);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_z);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_c);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(b_gpu_z), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_c);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_c);
  nvtxRangePop();
}

} // namespace coder

// End of code generation (scaleSpectrum.cu)
