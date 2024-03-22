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
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "numCpsi.h"
#include "rt_nonfinite.h"
#include "vvarstd.h"
#include "wt.h"
#include "MWCUBLASUtils.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWErrorCodeUtils.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo ed_emlrtRTEI{
    12,                                                               // lineNo
    5,                                                                // colNo
    "trapz",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m" // pName
};

static emlrtRTEInfo fd_emlrtRTEI{
    211,                                                              // lineNo
    24,                                                               // colNo
    "trapz",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m" // pName
};

static emlrtRTEInfo gd_emlrtRTEI{
    96,                                                               // lineNo
    5,                                                                // colNo
    "trapz",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m" // pName
};

static emlrtRTEInfo id_emlrtRTEI{
    298,             // lineNo
    18,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo jd_emlrtRTEI{
    297,             // lineNo
    5,               // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

static emlrtRTEInfo kd_emlrtRTEI{
    12,            // lineNo
    12,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo ld_emlrtRTEI{
    22,            // lineNo
    32,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo md_emlrtRTEI{
    12,            // lineNo
    1,             // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo nd_emlrtRTEI{
    26,            // lineNo
    43,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo od_emlrtRTEI{
    26,            // lineNo
    37,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo pd_emlrtRTEI{
    293,             // lineNo
    14,              // colNo
    "scaleSpectrum", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "scaleSpectrum.m" // pName
};

// Function Declarations
static __global__ void c_cwtfilterbank_scaleSpectrum_k(const real32_T c1,
                                                       emxArray_real32_T c);

static void cublasCheck(cublasStatus_t errCode, const char_T *file,
                        uint32_T b_line);

static __global__ void d_cwtfilterbank_scaleSpectrum_k(
    const real32_T c1, const uint32_T defaultSL_idx_1, emxArray_real32_T c);

static __global__ void e_cwtfilterbank_scaleSpectrum_k(const real32_T c1,
                                                       emxArray_real32_T c);

static __global__ void f_cwtfilterbank_scaleSpectrum_k(const real32_T c1,
                                                       emxArray_real32_T c,
                                                       int32_T z_dim0);

static real32_T rt_hypotf_snf(real32_T u0, real32_T u1);

// Function Definitions
static __global__ __launch_bounds__(32, 1) void c_cwtfilterbank_scaleSpectrum_k(
    const real32_T c1, emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = c1;
  }
}

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

static __global__ __launch_bounds__(32, 1) void d_cwtfilterbank_scaleSpectrum_k(
    const real32_T c1, const uint32_T defaultSL_idx_1, emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[static_cast<int32_T>(defaultSL_idx_1) - 1] = c1;
  }
}

static __global__ __launch_bounds__(32, 1) void e_cwtfilterbank_scaleSpectrum_k(
    const real32_T c1, emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = c1;
  }
}

static __global__ __launch_bounds__(32, 1) void f_cwtfilterbank_scaleSpectrum_k(
    const real32_T c1, emxArray_real32_T c, int32_T z_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[z_dim0 - 1] = c1;
  }
}

static real32_T rt_hypotf_snf(real32_T u0, real32_T u1)
{
  real32_T a;
  real32_T b;
  real32_T y;
  nvtxRangePushA("#fcn#rt_hypotf_snf#" MW_AT_LOCATION);
  a = std::abs(u0);
  b = std::abs(u1);
  if (a < b) {
    a /= b;
    y = b * std::sqrt(a * a + 1.0F);
  } else if (a > b) {
    b /= a;
    y = a * std::sqrt(b * b + 1.0F);
  } else if (std::isnan(b)) {
    y = rtNaNF;
  } else {
    y = a * 1.41421354F;
  }
  nvtxRangePop();
  return y;
}

//
//
namespace coder {
void cwtfilterbank_scaleSpectrum(cwtfilterbank *self,
                                 const emxArray_real32_T *x,
                                 emxArray_real32_T *cpu_savgp,
                                 boolean_T *savgp_outdatedOnCpu,
                                 emxArray_real32_T *gpu_savgp,
                                 boolean_T *savgp_outdatedOnGpu)
{
  emxArray_creal32_T *cfs;
  emxArray_real32_T b_gpu_c;
  emxArray_real32_T gpu_c;
  emxArray_real32_T gpu_y;
  emxArray_real32_T gpu_z;
  emxArray_real32_T *Scales;
  emxArray_real32_T *a;
  emxArray_real32_T *abscfssq;
  emxArray_real32_T *abswt2S;
  emxArray_real32_T *b_cpu_c;
  emxArray_real32_T *c_y;
  emxArray_real32_T *cpu_c;
  emxArray_real32_T *cpu_y;
  emxArray_real32_T *cpu_z;
  emxArray_real32_T *d_y;
  emxArray_real32_T *y;
  emxArray_real_T *c;
  emxArray_uint32_T *b_y;
  int32_T nx;
  int32_T u1;
  int32_T vstride;
  real32_T alpha1;
  real32_T b_c1;
  real32_T cpu_b;
  real32_T normfac;
  real32_T *gpu_b;
  uint32_T defaultSL_idx_1;
  boolean_T b_outdatedOnCpu;
  boolean_T c_needsGpuEnsureCapacity;
  boolean_T c_outdatedOnGpu;
  boolean_T z_needsGpuEnsureCapacity;
  boolean_T z_outdatedOnGpu;
  nvtxRangePushA("#fcn#cwtfilterbank_scaleSpectrum#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_c);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&b_gpu_c);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_b, 4UL), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_z);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  defaultSL_idx_1 = static_cast<uint32_T>(self->Scales->size[1]);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&Scales, 2, &e_emlrtRTEI, true);
  vstride = Scales->size[0] * Scales->size[1];
  Scales->size[0] = 1;
  Scales->size[1] = self->Scales->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(Scales, vstride, &e_emlrtRTEI);
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_0", __LINE__,
                   (self->Scales->size[1] - 1) + 1, "");
  for (vstride = 0; vstride < self->Scales->size[1]; vstride++) {
    Scales->data[vstride] = static_cast<real32_T>(self->Scales->data[vstride]);
  }
  profileLoopEnd();
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cfs, 2, &ab_emlrtRTEI, true);
  nvtxMarkA("#cwtfilterbank_wt#" MW_AT_LINE);
  cwtfilterbank_wt(self, x, cfs);
  nvtxMarkA("#vvarstd#" MW_AT_LINE);
  normfac = vvarstd(x, x->size[0]);
  nx = cfs->size[0] * cfs->size[1];
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&y, 2, &kd_emlrtRTEI, true);
  vstride = y->size[0] * y->size[1];
  y->size[0] = cfs->size[0];
  y->size[1] = cfs->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(y, vstride, &j_emlrtRTEI);
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_1", __LINE__, (nx - 1) + 1,
                   "");
  for (int32_T k{0}; k < nx; k++) {
    nvtxMarkA("#rt_hypotf_snf#" MW_AT_LINE);
    y->data[k] = rt_hypotf_snf(cfs->data[k].re, cfs->data[k].im);
  }
  profileLoopEnd();
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&a, 2, &ld_emlrtRTEI, true);
  vstride = a->size[0] * a->size[1];
  a->size[0] = y->size[0];
  a->size[1] = y->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(a, vstride, &m_emlrtRTEI);
  nx = y->size[0] * y->size[1];
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_2", __LINE__, (nx - 1) + 1,
                   "");
  for (int32_T k{0}; k < nx; k++) {
    a->data[k] = y->data[k] * y->data[k];
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&y);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&abscfssq, 2, &md_emlrtRTEI, true);
  vstride = abscfssq->size[0] * abscfssq->size[1];
  nx = Scales->size[1];
  u1 = a->size[0];
  if (nx <= u1) {
    u1 = nx;
  }
  if (Scales->size[1] == 1) {
    abscfssq->size[0] = a->size[0];
  } else if (a->size[0] == 1) {
    abscfssq->size[0] = Scales->size[1];
  } else if (a->size[0] == Scales->size[1]) {
    abscfssq->size[0] = a->size[0];
  } else {
    abscfssq->size[0] = u1;
  }
  abscfssq->size[1] = a->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(abscfssq, vstride, &p_emlrtRTEI);
  nx = Scales->size[1];
  u1 = a->size[0];
  if (nx <= u1) {
    u1 = nx;
  }
  if (Scales->size[1] == 1) {
    u1 = a->size[0];
  } else if (a->size[0] == 1) {
    u1 = Scales->size[1];
  } else if (a->size[0] == Scales->size[1]) {
    u1 = a->size[0];
  }
  if ((u1 != 0) && (a->size[1] != 0)) {
    int32_T acoef;
    int32_T bcoef;
    nx = (a->size[1] != 1);
    u1 = a->size[1] - 1;
    acoef = (a->size[0] != 1);
    bcoef = (Scales->size[1] != 1);
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_3", __LINE__, u1 + 1,
                     "");
    for (int32_T k{0}; k <= u1; k++) {
      int32_T i1;
      vstride = nx * k;
      i1 = abscfssq->size[0] - 1;
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_4", __LINE__, i1 + 1,
                       "");
      for (int32_T b_k{0}; b_k <= i1; b_k++) {
        abscfssq->data[b_k + abscfssq->size[0] * k] =
            a->data[acoef * b_k + a->size[0] * vstride] /
            Scales->data[bcoef * b_k];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&a);
  nvtxMarkA("#emxInit_uint32_T#" MW_AT_LINE);
  emxInit_uint32_T(&b_y, 2, &nd_emlrtRTEI, true);
  if (abscfssq->size[1] < 1) {
    b_y->size[0] = 1;
    b_y->size[1] = 0;
  } else {
    uint32_T u;
    u = static_cast<uint32_T>(abscfssq->size[1]);
    vstride = b_y->size[0] * b_y->size[1];
    b_y->size[0] = 1;
    b_y->size[1] = abscfssq->size[1];
    nvtxMarkA("#emxEnsureCapacity_uint32_T#" MW_AT_LINE);
    emxEnsureCapacity_uint32_T(b_y, vstride, &ib_emlrtRTEI);
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_5", __LINE__,
                     (static_cast<int32_T>(u) - 1) + 1, "");
    for (vstride = 0; vstride < static_cast<int32_T>(u); vstride++) {
      b_y->data[vstride] = static_cast<uint32_T>(vstride) + 1U;
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_z, 1, &od_emlrtRTEI, true);
  z_outdatedOnGpu = false;
  vstride = cpu_z->size[0];
  cpu_z->size[0] = abscfssq->size[0];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(cpu_z, vstride, &ed_emlrtRTEI);
  z_needsGpuEnsureCapacity = true;
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_6", __LINE__,
                   (abscfssq->size[0] - 1) + 1, "");
  for (vstride = 0; vstride < abscfssq->size[0]; vstride++) {
    cpu_z->data[vstride] = 0.0F;
    z_outdatedOnGpu = true;
  }
  profileLoopEnd();
  if (abscfssq->size[1] > 1) {
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&c, 1, &gd_emlrtRTEI, true);
    if (b_y->size[1] == 1) {
      nx = abscfssq->size[1];
      vstride = c->size[0];
      c->size[0] = abscfssq->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(c, vstride, &gd_emlrtRTEI);
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_7", __LINE__,
                       (nx - 1) + 1, "");
      for (vstride = 0; vstride < nx; vstride++) {
        c->data[vstride] = b_y->data[0];
      }
      real_T c1;
      profileLoopEnd();
      c1 = 0.5 * static_cast<real_T>(b_y->data[0]);
      c->data[0] = c1;
      c->data[abscfssq->size[1] - 1] = c1;
    } else {
      vstride = c->size[0];
      c->size[0] = abscfssq->size[1];
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(c, vstride, &fd_emlrtRTEI);
      c->data[0] =
          0.5 * static_cast<real_T>(static_cast<int32_T>(b_y->data[1]) -
                                    static_cast<int32_T>(b_y->data[0]));
      nx = abscfssq->size[1];
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_8", __LINE__,
                       (nx - 3) + 1, "");
      for (int32_T k{0}; k <= nx - 3; k++) {
        c->data[k + 1] =
            0.5 * static_cast<real_T>(static_cast<int32_T>(b_y->data[k + 2]) -
                                      static_cast<int32_T>(b_y->data[k]));
      }
      profileLoopEnd();
      c->data[abscfssq->size[1] - 1] =
          0.5 * static_cast<real_T>(
                    static_cast<int32_T>(b_y->data[abscfssq->size[1] - 1]) -
                    static_cast<int32_T>(b_y->data[abscfssq->size[1] - 2]));
    }
    vstride = abscfssq->size[0];
    if (abscfssq->size[0] != 0) {
      int64_T b;
      nx = abscfssq->size[0];
      std::memset(&cpu_z->data[0], 0,
                  static_cast<uint32_T>(nx) * sizeof(real32_T));
      z_outdatedOnGpu = true;
      nx = 0;
      u1 = abscfssq->size[0] * (abscfssq->size[1] - 1) + 1;
      nvtxMarkA("#computeEndIdx#" MW_AT_LINE);
      b = computeEndIdx(1L, static_cast<int64_T>(u1),
                        static_cast<int64_T>(vstride));
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_13", __LINE__, b + 1L,
                       "");
      for (int64_T iac{0L}; iac <= b; iac++) {
        int64_T d;
        nvtxMarkA("#computeEndIdx#" MW_AT_LINE);
        d = computeEndIdx(
            static_cast<int64_T>(static_cast<int32_T>(iac * vstride + 1L)),
            static_cast<int64_T>(
                (static_cast<int32_T>(iac * vstride + 1L) + vstride) - 1),
            1L);
        profileLoopStart("cwtfilterbank_scaleSpectrum_loop_14", __LINE__,
                         d + 1L, "");
        for (int64_T ia{0L}; ia <= d; ia++) {
          cpu_z->data[static_cast<int32_T>(ia)] +=
              abscfssq
                  ->data[static_cast<int32_T>(
                             static_cast<int32_T>(iac * vstride + 1L) + ia) -
                         1] *
              static_cast<real32_T>(c->data[nx]);
        }
        profileLoopEnd();
        nx++;
      }
      profileLoopEnd();
    }
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&c);
  }
  nvtxMarkA("#emxFree_uint32_T#" MW_AT_LINE);
  emxFree_uint32_T(&b_y);
  cpu_b = 0.0F;
  b_outdatedOnCpu = false;
  if (cpu_z->size[0] <= 1) {
    if ((Scales->size[1] == 1) &&
        (std::isinf(Scales->data[0]) || std::isnan(Scales->data[0]))) {
      cpu_b = rtNaNF;
    }
  } else {
    nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
    emxInit_real32_T(&cpu_c, 1, &gd_emlrtRTEI, true);
    if (Scales->size[1] == 1) {
      nx = cpu_z->size[0];
      c_outdatedOnGpu = false;
      vstride = cpu_c->size[0];
      cpu_c->size[0] = cpu_z->size[0];
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(cpu_c, vstride, &gd_emlrtRTEI);
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_10", __LINE__,
                       (nx - 1) + 1, "");
      for (vstride = 0; vstride < nx; vstride++) {
        cpu_c->data[vstride] = Scales->data[0];
        c_outdatedOnGpu = true;
      }
      profileLoopEnd();
      b_c1 = 0.5F * Scales->data[0];
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_c, &b_gpu_c, !c_outdatedOnGpu);
      if (c_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_c, cpu_c);
      }
      nvtxMarkA("#e_cwtfilterbank_scaleSpectrum_k#" MW_AT_LINE);
      e_cwtfilterbank_scaleSpectrum_k<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
          b_c1, b_gpu_c);
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z, !z_outdatedOnGpu);
      z_needsGpuEnsureCapacity = false;
      c_needsGpuEnsureCapacity = false;
      if (z_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
      }
      z_outdatedOnGpu = false;
      nvtxMarkA("#f_cwtfilterbank_scaleSpectrum_k#" MW_AT_LINE);
      f_cwtfilterbank_scaleSpectrum_k<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
          b_c1, b_gpu_c, cpu_z->size[0U]);
      c_outdatedOnGpu = false;
    } else {
      vstride = cpu_c->size[0];
      cpu_c->size[0] = cpu_z->size[0];
      nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
      emxEnsureCapacity_real32_T(cpu_c, vstride, &fd_emlrtRTEI);
      cpu_c->data[0] = 0.5F * (Scales->data[1] - Scales->data[0]);
      nx = cpu_z->size[0];
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_9", __LINE__,
                       (nx - 3) + 1, "");
      for (int32_T k{0}; k <= nx - 3; k++) {
        cpu_c->data[k + 1] = 0.5F * (Scales->data[k + 2] - Scales->data[k]);
      }
      profileLoopEnd();
      cpu_c->data[cpu_z->size[0] - 1] =
          0.5F *
          (Scales->data[cpu_z->size[0] - 1] - Scales->data[cpu_z->size[0] - 2]);
      c_outdatedOnGpu = true;
      c_needsGpuEnsureCapacity = true;
    }
    b_c1 = 0.0F;
    alpha1 = 1.0F;
    if (z_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z, !z_outdatedOnGpu);
    }
    if (c_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real32_T(cpu_c, &b_gpu_c, !c_outdatedOnGpu);
    }
    if (z_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
    }
    if (c_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_c, cpu_c);
    }
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
    checkCudaError(cudaMemcpy(gpu_b, &cpu_b, 4UL, cudaMemcpyHostToDevice),
                   __FILE__, __LINE__);
    nvtxMarkA("#cublasCheck#" MW_AT_LINE);
    cublasCheck(cublasSgemv(getCublasGlobalHandle(), CUBLAS_OP_T,
                            cpu_z->size[0], 1, (float *)&alpha1,
                            (float *)&gpu_z.data[0], cpu_z->size[0],
                            (float *)&b_gpu_c.data[0], 1, (float *)&b_c1,
                            (float *)gpu_b, 1),
                __FILE__, __LINE__);
    b_outdatedOnCpu = true;
    nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
    emxFree_real32_T(&cpu_c);
  }
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_z);
  if (!(normfac == 0.0F)) {
    if (b_outdatedOnCpu) {
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
      checkCudaError(cudaMemcpy(&cpu_b, gpu_b, 4UL, cudaMemcpyDeviceToHost),
                     __FILE__, __LINE__);
    }
    nvtxMarkA("#numCpsi#" MW_AT_LINE);
    b_c1 = std::sqrt(
        normfac /
        (static_cast<real32_T>(2.0 /
                               wavelet::internal::cwt::numCpsi(
                                   self->Wavelet, self->Gamma, self->Beta) /
                               static_cast<real_T>(abscfssq->size[1])) *
         cpu_b));
    vstride = cfs->size[0] * cfs->size[1];
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_11", __LINE__,
                     (vstride - 1) + 1, "");
    for (u1 = 0; u1 < vstride; u1++) {
      cfs->data[u1].re *= b_c1;
      cfs->data[u1].im *= b_c1;
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&abscfssq);
  nx = cfs->size[0] * cfs->size[1];
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&c_y, 2, &pd_emlrtRTEI, true);
  vstride = c_y->size[0] * c_y->size[1];
  c_y->size[0] = cfs->size[0];
  c_y->size[1] = cfs->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(c_y, vstride, &j_emlrtRTEI);
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_12", __LINE__,
                   (nx - 1) + 1, "");
  for (int32_T k{0}; k < nx; k++) {
    nvtxMarkA("#rt_hypotf_snf#" MW_AT_LINE);
    c_y->data[k] = rt_hypotf_snf(cfs->data[k].re, cfs->data[k].im);
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cfs);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&d_y, 2, &pd_emlrtRTEI, true);
  vstride = d_y->size[0] * d_y->size[1];
  d_y->size[0] = c_y->size[0];
  d_y->size[1] = c_y->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(d_y, vstride, &m_emlrtRTEI);
  nx = c_y->size[0] * c_y->size[1];
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_15", __LINE__,
                   (nx - 1) + 1, "");
  for (int32_T k{0}; k < nx; k++) {
    d_y->data[k] = c_y->data[k] * c_y->data[k];
  }
  profileLoopEnd();
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&c_y);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&abswt2S, 2, &hd_emlrtRTEI, true);
  if (d_y->size[0] == Scales->size[1]) {
    vstride = abswt2S->size[0] * abswt2S->size[1];
    abswt2S->size[0] = d_y->size[0];
    abswt2S->size[1] = d_y->size[1];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(abswt2S, vstride, &hd_emlrtRTEI);
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_16", __LINE__,
                     (d_y->size[1] - 1) + 1, "");
    for (vstride = 0; vstride < d_y->size[1]; vstride++) {
      profileLoopStart("cwtfilterbank_scaleSpectrum_loop_17", __LINE__,
                       (d_y->size[0] - 1) + 1, "");
      for (u1 = 0; u1 < d_y->size[0]; u1++) {
        abswt2S->data[u1 + abswt2S->size[0] * vstride] =
            d_y->data[u1 + d_y->size[0] * vstride] / Scales->data[u1];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
  } else {
    nvtxMarkA("#binary_expand_op_6#" MW_AT_LINE);
    binary_expand_op_6(abswt2S, d_y, Scales);
  }
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&d_y);
  nx = static_cast<int32_T>(defaultSL_idx_1);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_y, 2, &id_emlrtRTEI, true);
  b_outdatedOnCpu = false;
  vstride = cpu_y->size[0] * cpu_y->size[1];
  cpu_y->size[0] = static_cast<int32_T>(defaultSL_idx_1);
  cpu_y->size[1] = abswt2S->size[1];
  nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
  emxEnsureCapacity_real32_T(cpu_y, vstride, &id_emlrtRTEI);
  profileLoopStart("cwtfilterbank_scaleSpectrum_loop_18", __LINE__,
                   (abswt2S->size[1] - 1) + 1, "");
  for (vstride = 0; vstride < abswt2S->size[1]; vstride++) {
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_19", __LINE__,
                     (nx - 1) + 1, "");
    for (u1 = 0; u1 < nx; u1++) {
      cpu_y->data[u1 + cpu_y->size[0] * vstride] =
          abswt2S->data[u1 + abswt2S->size[0] * vstride];
      b_outdatedOnCpu = true;
    }
    profileLoopEnd();
  }
  profileLoopEnd();
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_c, 1, &gd_emlrtRTEI, true);
  if ((static_cast<int32_T>(defaultSL_idx_1) == 0) && (abswt2S->size[1] == 0)) {
    if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
      b_c1 = Scales->data[0] * 0.0F;
    } else {
      b_c1 = 0.0F;
    }
    vstride = cpu_savgp->size[0] * cpu_savgp->size[1];
    cpu_savgp->size[0] = 1;
    cpu_savgp->size[1] = 1;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_savgp, vstride, &jd_emlrtRTEI);
    cpu_savgp->data[0] = b_c1;
    *savgp_outdatedOnCpu = false;
    *savgp_outdatedOnGpu = true;
  } else {
    *savgp_outdatedOnCpu = false;
    *savgp_outdatedOnGpu = false;
    vstride = cpu_savgp->size[0] * cpu_savgp->size[1];
    cpu_savgp->size[0] = 1;
    cpu_savgp->size[1] = abswt2S->size[1];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_savgp, vstride, &jd_emlrtRTEI);
    profileLoopStart("cwtfilterbank_scaleSpectrum_loop_20", __LINE__,
                     (abswt2S->size[1] - 1) + 1, "");
    for (vstride = 0; vstride < abswt2S->size[1]; vstride++) {
      cpu_savgp->data[vstride] = 0.0F;
      *savgp_outdatedOnGpu = true;
    }
    profileLoopEnd();
    if (static_cast<int32_T>(defaultSL_idx_1) <= 1) {
      if ((static_cast<int32_T>(defaultSL_idx_1) == 1) &&
          (std::isinf(Scales->data[0]) || std::isnan(Scales->data[0]))) {
        *savgp_outdatedOnGpu = false;
        vstride = cpu_savgp->size[0] * cpu_savgp->size[1];
        cpu_savgp->size[0] = 1;
        cpu_savgp->size[1] = abswt2S->size[1];
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(cpu_savgp, vstride, &jd_emlrtRTEI);
        profileLoopStart("cwtfilterbank_scaleSpectrum_loop_23", __LINE__,
                         (abswt2S->size[1] - 1) + 1, "");
        for (vstride = 0; vstride < abswt2S->size[1]; vstride++) {
          cpu_savgp->data[vstride] = rtNaNF;
          *savgp_outdatedOnGpu = true;
        }
        profileLoopEnd();
      }
    } else {
      if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
        c_outdatedOnGpu = false;
        vstride = b_cpu_c->size[0];
        b_cpu_c->size[0] = static_cast<int32_T>(defaultSL_idx_1);
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(b_cpu_c, vstride, &gd_emlrtRTEI);
        profileLoopStart("cwtfilterbank_scaleSpectrum_loop_22", __LINE__,
                         (nx - 1) + 1, "");
        for (vstride = 0; vstride < nx; vstride++) {
          b_cpu_c->data[vstride] = Scales->data[0];
          c_outdatedOnGpu = true;
        }
        profileLoopEnd();
        b_c1 = 0.5F * Scales->data[0];
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(b_cpu_c, &gpu_c, !c_outdatedOnGpu);
        if (c_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_c, b_cpu_c);
        }
        nvtxMarkA("#c_cwtfilterbank_scaleSpectrum_k#" MW_AT_LINE);
        c_cwtfilterbank_scaleSpectrum_k<<<dim3(1U, 1U, 1U),
                                          dim3(32U, 1U, 1U)>>>(b_c1, gpu_c);
        c_needsGpuEnsureCapacity = false;
        nvtxMarkA("#d_cwtfilterbank_scaleSpectrum_k#" MW_AT_LINE);
        d_cwtfilterbank_scaleSpectrum_k<<<dim3(1U, 1U, 1U),
                                          dim3(32U, 1U, 1U)>>>(
            b_c1, defaultSL_idx_1, gpu_c);
        c_outdatedOnGpu = false;
      } else {
        vstride = b_cpu_c->size[0];
        b_cpu_c->size[0] = static_cast<int32_T>(defaultSL_idx_1);
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(b_cpu_c, vstride, &fd_emlrtRTEI);
        b_cpu_c->data[0] = 0.5F * (Scales->data[1] - Scales->data[0]);
        profileLoopStart("cwtfilterbank_scaleSpectrum_loop_21", __LINE__,
                         (nx - 3) + 1, "");
        for (int32_T k{0}; k <= nx - 3; k++) {
          b_cpu_c->data[k + 1] = 0.5F * (Scales->data[k + 2] - Scales->data[k]);
        }
        profileLoopEnd();
        b_cpu_c->data[static_cast<int32_T>(defaultSL_idx_1) - 1] =
            0.5F * (Scales->data[static_cast<int32_T>(defaultSL_idx_1) - 1] -
                    Scales->data[static_cast<int32_T>(defaultSL_idx_1) - 2]);
        c_outdatedOnGpu = true;
        c_needsGpuEnsureCapacity = true;
      }
      if (abswt2S->size[1] >= 1) {
        b_c1 = 0.0F;
        alpha1 = 1.0F;
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_y, &gpu_y, !b_outdatedOnCpu);
        if (c_needsGpuEnsureCapacity) {
          nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_real32_T(b_cpu_c, &gpu_c, !c_outdatedOnGpu);
        }
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_savgp, gpu_savgp,
                                      !*savgp_outdatedOnGpu);
        if (b_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_y, cpu_y);
        }
        if (c_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_c, b_cpu_c);
        }
        if (*savgp_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
          gpuEmxMemcpyCpuToGpu_real32_T(gpu_savgp, cpu_savgp);
        }
        nvtxMarkA("#cublasCheck#" MW_AT_LINE);
        cublasCheck(cublasSgemv(getCublasGlobalHandle(), CUBLAS_OP_T,
                                static_cast<int32_T>(defaultSL_idx_1),
                                abswt2S->size[1], (float *)&alpha1,
                                (float *)&gpu_y.data[0],
                                static_cast<int32_T>(defaultSL_idx_1),
                                (float *)&gpu_c.data[0], 1, (float *)&b_c1,
                                (float *)&gpu_savgp->data[0], 1),
                    __FILE__, __LINE__);
        *savgp_outdatedOnGpu = false;
        *savgp_outdatedOnCpu = true;
      }
    }
  }
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_c);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_y);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&abswt2S);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&Scales);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_z);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_b), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&b_gpu_c);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_c);
  nvtxRangePop();
}

} // namespace coder

// End of code generation (scaleSpectrum.cu)
