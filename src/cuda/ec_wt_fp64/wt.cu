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
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "rt_nonfinite.h"
#include "vvarstd.h"
#include "MWCUFFTPlanManager.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "cufft.h"
#include "nvtx3/nvToolsExt.h"
#include <cstring>

// Variable Definitions
static emlrtRTEInfo
    ad_emlrtRTEI{
        105,      // lineNo
        20,       // colNo
        "varstd", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/private/"
        "varstd.m" // pName
    };

static emlrtRTEInfo bd_emlrtRTEI{
    135,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo cd_emlrtRTEI{
    143,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo dd_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "cuFFTNDCallback", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "cuFFTNDCallback.p" // pName
};

static emlrtRTEInfo ed_emlrtRTEI{
    138,  // lineNo
    19,   // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo fd_emlrtRTEI{
    138,  // lineNo
    6,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo gd_emlrtRTEI{
    161,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo hd_emlrtRTEI{
    180,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo id_emlrtRTEI{
    151,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

// Function Declarations
static __global__ void
cwtfilterbank_wt_kernel26(const int32_T i, const int32_T b, emxArray_real_T x);

static __global__ void cwtfilterbank_wt_kernel27(const uint32_T xSize_dim1,
                                                 const int32_T b,
                                                 emxArray_creal_T xposdft);

static void gpuEmxMemcpyGpuToCpu_creal_T(emxArray_creal_T *cpu,
                                         emxArray_creal_T *gpu);

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

static __global__ __launch_bounds__(1024, 1) void cwtfilterbank_wt_kernel27(
    const uint32_T xSize_dim1, const int32_T b, emxArray_creal_T xposdft)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_j1;
    b_j1 = static_cast<int32_T>(idx);
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - b_j1) - 1].re =
        xposdft.data[b_j1 + 1].re;
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - b_j1) - 1].im =
        -xposdft.data[b_j1 + 1].im;
  }
}

static void gpuEmxMemcpyGpuToCpu_creal_T(emxArray_creal_T *cpu,
                                         emxArray_creal_T *gpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA("#loop#gpuEmxMemcpyGpuToCpu_creal_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    actualSize *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
  checkCudaError(cudaMemcpy(cpu->data, gpu->data,
                            static_cast<uint32_T>(actualSize) * sizeof(creal_T),
                            cudaMemcpyDeviceToHost),
                 __FILE__, __LINE__);
  nvtxRangePop();
}

//
//
namespace coder {
void cwtfilterbank_wt(cwtfilterbank *self, const emxArray_real_T *x,
                      emxArray_creal_T *varargout_1)
{
  dim3 block;
  dim3 grid;
  emxArray_creal_T gpu_cfsposdft;
  emxArray_creal_T gpu_xposdft;
  emxArray_creal_T *cpu_cfsposdft;
  emxArray_creal_T *cpu_xposdft;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xv;
  emxArray_real_T *b_x;
  emxArray_real_T *cpu_x;
  emxArray_real_T *cpu_xv;
  real_T ai;
  real_T d;
  int32_T acoef;
  int32_T bcoef;
  int32_T csz_idx_1;
  int32_T i;
  int32_T i2;
  int32_T i3;
  int32_T nd2;
  uint32_T xSize[2];
  boolean_T validLaunchParams;
  boolean_T x_outdatedOnCpu;
  boolean_T xv_outdatedOnGpu;
  nvtxRangePushA("#fcn#cwtfilterbank_wt#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_cfsposdft);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_x);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_xposdft);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_xv);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nd2 = x->size[0];
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_x, 1, &ad_emlrtRTEI, true);
  bcoef = b_x->size[0];
  b_x->size[0] = x->size[0];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(b_x, bcoef, &ad_emlrtRTEI);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_xv, 2, &bd_emlrtRTEI, true);
  xv_outdatedOnGpu = false;
  bcoef = cpu_xv->size[0] * cpu_xv->size[1];
  cpu_xv->size[0] = 1;
  cpu_xv->size[1] = x->size[0];
  nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
  emxEnsureCapacity_real_T(cpu_xv, bcoef, &bd_emlrtRTEI);
  profileLoopStart("cwtfilterbank_wt_loop_0", __LINE__, (nd2 - 1) + 1, "");
  for (bcoef = 0; bcoef < nd2; bcoef++) {
    b_x->data[bcoef] = x->data[bcoef];
    cpu_xv->data[bcoef] = x->data[bcoef];
    xv_outdatedOnGpu = true;
  }
  profileLoopEnd();
  nvtxMarkA("#vvarstd#" MW_AT_LINE);
  self->sigvar = vvarstd(b_x, x->size[0]);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_x);
  if (self->SignalPad > 0.0) {
    d = self->SignalPad;
    if (d < 1.0) {
      i = 0;
    } else {
      i = static_cast<int32_T>(d);
    }
    d = (static_cast<real_T>(x->size[0]) - self->SignalPad) + 1.0;
    if (d > x->size[0]) {
      csz_idx_1 = 0;
      i2 = 1;
      i3 = -1;
    } else {
      csz_idx_1 = x->size[0] - 1;
      i2 = -1;
      i3 = static_cast<int32_T>(d) - 1;
    }
    nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
    emxInit_real_T(&cpu_x, 2, &ed_emlrtRTEI, true);
    xv_outdatedOnGpu = false;
    bcoef = cpu_x->size[0] * cpu_x->size[1];
    cpu_x->size[0] = 1;
    cpu_x->size[1] = i;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_x, bcoef, &ed_emlrtRTEI);
    profileLoopStart("cwtfilterbank_wt_loop_2", __LINE__, (i - 1) + 1, "");
    for (bcoef = 0; bcoef < i; bcoef++) {
      cpu_x->data[bcoef] = x->data[bcoef];
      xv_outdatedOnGpu = true;
    }
    profileLoopEnd();
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters((i >> 1) - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_x, &gpu_x, !xv_outdatedOnGpu);
    if (xv_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwtfilterbank_wt_kernel26#" MW_AT_LINE);
      cwtfilterbank_wt_kernel26<<<grid, block>>>(i, (i >> 1) - 1, gpu_x);
    }
    x_outdatedOnCpu = true;
    xv_outdatedOnGpu = false;
    bcoef = cpu_xv->size[0] * cpu_xv->size[1];
    cpu_xv->size[0] = 1;
    nvtxMarkA("#div_s32#" MW_AT_LINE);
    cpu_xv->size[1] =
        ((x->size[0] + cpu_x->size[1]) + div_s32(i3 - csz_idx_1, i2)) + 1;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_xv, bcoef, &fd_emlrtRTEI);
    acoef = cpu_x->size[1];
    profileLoopStart("cwtfilterbank_wt_loop_4", __LINE__, (acoef - 1) + 1, "");
    for (bcoef = 0; bcoef < acoef; bcoef++) {
      if (x_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_x, &gpu_x);
      }
      x_outdatedOnCpu = false;
      cpu_xv->data[bcoef] = cpu_x->data[bcoef];
      xv_outdatedOnGpu = true;
    }
    profileLoopEnd();
    acoef = x->size[0];
    profileLoopStart("cwtfilterbank_wt_loop_6", __LINE__, (acoef - 1) + 1, "");
    for (bcoef = 0; bcoef < acoef; bcoef++) {
      cpu_xv->data[bcoef + cpu_x->size[1]] = x->data[bcoef];
      xv_outdatedOnGpu = true;
    }
    profileLoopEnd();
    nvtxMarkA("#div_s32#" MW_AT_LINE);
    acoef = div_s32(i3 - csz_idx_1, i2);
    profileLoopStart("cwtfilterbank_wt_loop_7", __LINE__, acoef + 1, "");
    for (bcoef = 0; bcoef <= acoef; bcoef++) {
      cpu_xv->data[(bcoef + x->size[0]) + cpu_x->size[1]] =
          x->data[csz_idx_1 + i2 * bcoef];
      xv_outdatedOnGpu = true;
    }
    profileLoopEnd();
    nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
    emxFree_real_T(&cpu_x);
  }
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_xposdft, 2, &cd_emlrtRTEI, true);
  if (cpu_xv->size[1] == 0) {
    xv_outdatedOnGpu = false;
    cpu_xposdft->size[0] = 1;
    cpu_xposdft->size[1] = 0;
  } else if (cpu_xv->size[1] - (static_cast<int32_T>(
                                    static_cast<uint32_T>(cpu_xv->size[1]) >> 1)
                                << 1) ==
             1) {
    cufftHandle b_fftPlanHandle;
    xv_outdatedOnGpu = false;
    bcoef = cpu_xposdft->size[0] * cpu_xposdft->size[1];
    cpu_xposdft->size[0] = 1;
    cpu_xposdft->size[1] = cpu_xv->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_xposdft, bcoef, &cd_emlrtRTEI);
    profileLoopStart("cwtfilterbank_wt_loop_1", __LINE__,
                     (cpu_xv->size[1] - 1) + 1, "");
    for (bcoef = 0; bcoef < cpu_xv->size[1]; bcoef++) {
      cpu_xposdft->data[bcoef].re = cpu_xv->data[bcoef];
      cpu_xposdft->data[bcoef].im = 0.0;
      xv_outdatedOnGpu = true;
    }
    profileLoopEnd();
    nd2 = cpu_xposdft->size[1];
    b_fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, 1, 1, CUFFT_Z2Z, 1);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_xposdft, &gpu_xposdft, !xv_outdatedOnGpu);
    if (xv_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_xposdft, cpu_xposdft);
    }
    cufftExecZ2Z(b_fftPlanHandle, (cufftDoubleComplex *)&gpu_xposdft.data[0],
                 (cufftDoubleComplex *)&gpu_xposdft.data[0], CUFFT_FORWARD);
    xv_outdatedOnGpu = true;
  } else {
    cufftHandle fftPlanHandle;
    nd2 = cpu_xv->size[1];
    xSize[1] = static_cast<uint32_T>(cpu_xv->size[1]);
    bcoef = cpu_xposdft->size[0] * cpu_xposdft->size[1];
    cpu_xposdft->size[0] = 1;
    cpu_xposdft->size[1] = cpu_xv->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_xposdft, bcoef, &dd_emlrtRTEI);
    fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, 1, 1, CUFFT_D2Z, 1);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_xv, &gpu_xv, !xv_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_xposdft, &gpu_xposdft, true);
    if (xv_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, cpu_xv);
    }
    cufftExecD2Z(fftPlanHandle, (cufftDoubleReal *)&gpu_xv.data[0],
                 (cufftDoubleComplex *)&gpu_xposdft.data[0]);
    nd2 = static_cast<int32_T>(static_cast<real_T>(cpu_xv->size[1] + 1) / 2.0);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nd2 - 2), &grid, &block,
                            2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#cwtfilterbank_wt_kernel27#" MW_AT_LINE);
      cwtfilterbank_wt_kernel27<<<grid, block>>>(xSize[1], nd2 - 2,
                                                 gpu_xposdft);
    }
    xv_outdatedOnGpu = true;
  }
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_xv);
  nd2 = self->PsiDFT->size[1];
  i = cpu_xposdft->size[1];
  if (nd2 <= i) {
    i = nd2;
  }
  if (self->PsiDFT->size[1] == 1) {
    csz_idx_1 = cpu_xposdft->size[1];
  } else if (cpu_xposdft->size[1] == 1) {
    csz_idx_1 = self->PsiDFT->size[1];
  } else if (cpu_xposdft->size[1] == self->PsiDFT->size[1]) {
    csz_idx_1 = cpu_xposdft->size[1];
  } else {
    csz_idx_1 = i;
  }
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_cfsposdft, 2, &id_emlrtRTEI, true);
  x_outdatedOnCpu = false;
  bcoef = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1];
  cpu_cfsposdft->size[0] = self->PsiDFT->size[0];
  nd2 = self->PsiDFT->size[1];
  i = cpu_xposdft->size[1];
  if (nd2 <= i) {
    i = nd2;
  }
  if (self->PsiDFT->size[1] == 1) {
    cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
  } else if (cpu_xposdft->size[1] == 1) {
    cpu_cfsposdft->size[1] = self->PsiDFT->size[1];
  } else if (cpu_xposdft->size[1] == self->PsiDFT->size[1]) {
    cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
  } else {
    cpu_cfsposdft->size[1] = i;
  }
  nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
  emxEnsureCapacity_creal_T(cpu_cfsposdft, bcoef, &l_emlrtRTEI);
  if ((self->PsiDFT->size[0] != 0) && (csz_idx_1 != 0)) {
    acoef = (cpu_xposdft->size[1] != 1);
    bcoef = (self->PsiDFT->size[1] != 1);
    csz_idx_1--;
    nd2 = (self->PsiDFT->size[0] != 1);
    profileLoopStart("cwtfilterbank_wt_loop_3", __LINE__, csz_idx_1 + 1, "");
    for (int32_T k{0}; k <= csz_idx_1; k++) {
      i = acoef * k;
      i2 = bcoef * k;
      i3 = cpu_cfsposdft->size[0] - 1;
      profileLoopStart("cwtfilterbank_wt_loop_5", __LINE__, i3 + 1, "");
      for (int32_T b_k{0}; b_k <= i3; b_k++) {
        if (xv_outdatedOnGpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_creal_T(cpu_xposdft, &gpu_xposdft);
        }
        cpu_cfsposdft->data[b_k + cpu_cfsposdft->size[0] * k].re =
            self->PsiDFT->data[nd2 * b_k + self->PsiDFT->size[0] * i2] *
            cpu_xposdft->data[i].re;
        xv_outdatedOnGpu = false;
        cpu_cfsposdft->data[b_k + cpu_cfsposdft->size[0] * k].im =
            self->PsiDFT->data[nd2 * b_k + self->PsiDFT->size[0] * i2] *
            cpu_xposdft->data[i].im;
        x_outdatedOnCpu = true;
      }
      profileLoopEnd();
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_xposdft);
  if ((cpu_cfsposdft->size[0] == 0) || (cpu_cfsposdft->size[1] == 0)) {
    xSize[0] = static_cast<uint32_T>(cpu_cfsposdft->size[0]);
    xSize[1] = static_cast<uint32_T>(cpu_cfsposdft->size[1]);
    bcoef = varargout_1->size[0] * varargout_1->size[1];
    varargout_1->size[0] = cpu_cfsposdft->size[0];
    varargout_1->size[1] = cpu_cfsposdft->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(varargout_1, bcoef, &gd_emlrtRTEI);
    if (static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) - 1 >=
        0) {
      std::memset(&varargout_1->data[0], 0,
                  static_cast<uint32_T>(static_cast<int32_T>(xSize[0]) *
                                        static_cast<int32_T>(xSize[1])) *
                      sizeof(creal_T));
    }
  } else {
    cufftHandle c_fftPlanHandle;
    nd2 = cpu_cfsposdft->size[1];
    c_fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, cpu_cfsposdft->size[0], 1,
                                       CUFFT_Z2Z, cpu_cfsposdft->size[0]);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_cfsposdft, &gpu_cfsposdft,
                                 !x_outdatedOnCpu);
    if (x_outdatedOnCpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_cfsposdft, cpu_cfsposdft);
    }
    cufftExecZ2Z(c_fftPlanHandle, (cufftDoubleComplex *)&gpu_cfsposdft.data[0],
                 (cufftDoubleComplex *)&gpu_cfsposdft.data[0], CUFFT_INVERSE);
    xv_outdatedOnGpu = true;
    bcoef = varargout_1->size[0] * varargout_1->size[1];
    varargout_1->size[0] = cpu_cfsposdft->size[0];
    varargout_1->size[1] = cpu_cfsposdft->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(varargout_1, bcoef, &gd_emlrtRTEI);
    nd2 = cpu_cfsposdft->size[1];
    profileLoopStart("cwtfilterbank_wt_loop_8", __LINE__,
                     (cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1] - 1) + 1,
                     "");
    for (bcoef = 0; bcoef < cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1];
         bcoef++) {
      if (xv_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_creal_T(cpu_cfsposdft, &gpu_cfsposdft);
      }
      d = cpu_cfsposdft->data[bcoef].re;
      xv_outdatedOnGpu = false;
      ai = cpu_cfsposdft->data[bcoef].im;
      if (ai == 0.0) {
        varargout_1->data[bcoef].re = d / static_cast<real_T>(nd2);
        varargout_1->data[bcoef].im = 0.0;
      } else if (d == 0.0) {
        varargout_1->data[bcoef].re = 0.0;
        varargout_1->data[bcoef].im = ai / static_cast<real_T>(nd2);
      } else {
        varargout_1->data[bcoef].re = d / static_cast<real_T>(nd2);
        varargout_1->data[bcoef].im = ai / static_cast<real_T>(nd2);
      }
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_cfsposdft);
  if (self->SignalPad > 0.0) {
    d = self->SignalPad + 1.0;
    ai = self->SignalPad + self->SignalLength;
    if (d > ai) {
      nd2 = 0;
      i = 0;
    } else {
      nd2 = static_cast<int32_T>(d) - 1;
      i = static_cast<int32_T>(ai);
    }
    csz_idx_1 = varargout_1->size[0];
    acoef = i - nd2;
    profileLoopStart("cwtfilterbank_wt_loop_9", __LINE__, (acoef - 1) + 1, "");
    for (bcoef = 0; bcoef < acoef; bcoef++) {
      profileLoopStart("cwtfilterbank_wt_loop_10", __LINE__,
                       (csz_idx_1 - 1) + 1, "");
      for (i2 = 0; i2 < csz_idx_1; i2++) {
        varargout_1->data[i2 + csz_idx_1 * bcoef] =
            varargout_1->data[i2 + varargout_1->size[0] * (nd2 + bcoef)];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    bcoef = varargout_1->size[0] * varargout_1->size[1];
    varargout_1->size[1] = i - nd2;
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(varargout_1, bcoef, &hd_emlrtRTEI);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_xv);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_xposdft);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_x);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_cfsposdft);
  nvtxRangePop();
}

} // namespace coder

// End of code generation (wt.cu)
