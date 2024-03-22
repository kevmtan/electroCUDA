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
#include "ec_cwt_data.h"
#include "ec_cwt_emxutil.h"
#include "ec_cwt_mexutil.h"
#include "ec_cwt_types.h"
#include "rt_nonfinite.h"
#include "MWCUFFTPlanManager.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "cufft.h"
#include <cstring>

// Variable Definitions
static emlrtRTEInfo xc_emlrtRTEI{
    102,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo yc_emlrtRTEI{
    135,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo ad_emlrtRTEI{
    143,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo bd_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "cuFFTNDCallback", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "cuFFTNDCallback.p" // pName
};

static emlrtRTEInfo cd_emlrtRTEI{
    138,  // lineNo
    19,   // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo dd_emlrtRTEI{
    138,  // lineNo
    6,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo ed_emlrtRTEI{
    161,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo fd_emlrtRTEI{
    180,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo gd_emlrtRTEI{
    151,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

// Function Declarations
static __global__ void cwtfilterbank_wt_kernel11(const int32_T i,
                                                 const int32_T b,
                                                 emxArray_real32_T x);

static __global__ void cwtfilterbank_wt_kernel12(const uint32_T xSize_dim1,
                                                 const int32_T b,
                                                 emxArray_creal32_T xposdft);

static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void cwtfilterbank_wt_kernel11(
    const int32_T i, const int32_T b, emxArray_real32_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_j1;
    int32_T j2;
    real32_T xtmp;
    b_j1 = static_cast<int32_T>(idx);
    j2 = i - b_j1;
    xtmp = x.data[b_j1];
    x.data[b_j1] = x.data[j2 - 1];
    x.data[j2 - 1] = xtmp;
  }
}

static __global__ __launch_bounds__(1024, 1) void cwtfilterbank_wt_kernel12(
    const uint32_T xSize_dim1, const int32_T b, emxArray_creal32_T xposdft)
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

static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(
      cudaMemcpy(cpu->data, gpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(creal32_T),
                 cudaMemcpyDeviceToHost),
      __FILE__, __LINE__);
}

//
//
namespace coder {
void cwtfilterbank_wt(const cwtfilterbank *self, const emxArray_real32_T *x,
                      emxArray_creal32_T *varargout_1)
{
  dim3 block;
  dim3 grid;
  emxArray_creal32_T gpu_cfsposdft;
  emxArray_creal32_T gpu_xposdft;
  emxArray_creal32_T *cpu_cfsposdft;
  emxArray_creal32_T *cpu_xposdft;
  emxArray_real32_T gpu_x;
  emxArray_real32_T gpu_xv;
  emxArray_real32_T *cpu_x;
  emxArray_real32_T *cpu_xv;
  emxArray_real32_T *psihat;
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
  gpuEmxReset_creal32_T(&gpu_cfsposdft);
  gpuEmxReset_real32_T(&gpu_x);
  gpuEmxReset_creal32_T(&gpu_xposdft);
  gpuEmxReset_real32_T(&gpu_xv);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real32_T(&psihat, 2, &xc_emlrtRTEI, true);
  bcoef = psihat->size[0] * psihat->size[1];
  psihat->size[0] = self->PsiDFT->size[0];
  psihat->size[1] = self->PsiDFT->size[1];
  emxEnsureCapacity_real32_T(psihat, bcoef, &xc_emlrtRTEI);
  for (bcoef = 0; bcoef < self->PsiDFT->size[0] * self->PsiDFT->size[1];
       bcoef++) {
    psihat->data[bcoef] = static_cast<real32_T>(self->PsiDFT->data[bcoef]);
  }
  emxInit_real32_T(&cpu_xv, 2, &yc_emlrtRTEI, true);
  xv_outdatedOnGpu = false;
  bcoef = cpu_xv->size[0] * cpu_xv->size[1];
  cpu_xv->size[0] = 1;
  cpu_xv->size[1] = x->size[0];
  emxEnsureCapacity_real32_T(cpu_xv, bcoef, &yc_emlrtRTEI);
  for (bcoef = 0; bcoef < x->size[0]; bcoef++) {
    cpu_xv->data[bcoef] = x->data[bcoef];
    xv_outdatedOnGpu = true;
  }
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
    emxInit_real32_T(&cpu_x, 2, &cd_emlrtRTEI, true);
    xv_outdatedOnGpu = false;
    bcoef = cpu_x->size[0] * cpu_x->size[1];
    cpu_x->size[0] = 1;
    cpu_x->size[1] = i;
    emxEnsureCapacity_real32_T(cpu_x, bcoef, &cd_emlrtRTEI);
    for (bcoef = 0; bcoef < i; bcoef++) {
      cpu_x->data[bcoef] = x->data[bcoef];
      xv_outdatedOnGpu = true;
    }
    mwGetLaunchParameters1D(computeNumIters((i >> 1) - 1), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_x, &gpu_x, !xv_outdatedOnGpu);
    if (xv_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      cwtfilterbank_wt_kernel11<<<grid, block>>>(i, (i >> 1) - 1, gpu_x);
    }
    x_outdatedOnCpu = true;
    xv_outdatedOnGpu = false;
    bcoef = cpu_xv->size[0] * cpu_xv->size[1];
    cpu_xv->size[0] = 1;
    cpu_xv->size[1] =
        ((x->size[0] + cpu_x->size[1]) + div_s32(i3 - csz_idx_1, i2)) + 1;
    emxEnsureCapacity_real32_T(cpu_xv, bcoef, &dd_emlrtRTEI);
    acoef = cpu_x->size[1];
    for (bcoef = 0; bcoef < acoef; bcoef++) {
      if (x_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_x, &gpu_x);
      }
      x_outdatedOnCpu = false;
      cpu_xv->data[bcoef] = cpu_x->data[bcoef];
      xv_outdatedOnGpu = true;
    }
    acoef = x->size[0];
    for (bcoef = 0; bcoef < acoef; bcoef++) {
      cpu_xv->data[bcoef + cpu_x->size[1]] = x->data[bcoef];
      xv_outdatedOnGpu = true;
    }
    acoef = div_s32(i3 - csz_idx_1, i2);
    for (bcoef = 0; bcoef <= acoef; bcoef++) {
      cpu_xv->data[(bcoef + x->size[0]) + cpu_x->size[1]] =
          x->data[csz_idx_1 + i2 * bcoef];
      xv_outdatedOnGpu = true;
    }
    emxFree_real32_T(&cpu_x);
  }
  emxInit_creal32_T(&cpu_xposdft, 2, &ad_emlrtRTEI, true);
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
    emxEnsureCapacity_creal32_T(cpu_xposdft, bcoef, &ad_emlrtRTEI);
    for (bcoef = 0; bcoef < cpu_xv->size[1]; bcoef++) {
      cpu_xposdft->data[bcoef].re = cpu_xv->data[bcoef];
      cpu_xposdft->data[bcoef].im = 0.0F;
      xv_outdatedOnGpu = true;
    }
    nd2 = cpu_xposdft->size[1];
    b_fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, 1, 1, CUFFT_C2C, 1);
    gpuEmxEnsureCapacity_creal32_T(cpu_xposdft, &gpu_xposdft,
                                   !xv_outdatedOnGpu);
    if (xv_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_xposdft, cpu_xposdft);
    }
    cufftExecC2C(b_fftPlanHandle, (cufftComplex *)&gpu_xposdft.data[0],
                 (cufftComplex *)&gpu_xposdft.data[0], CUFFT_FORWARD);
    xv_outdatedOnGpu = true;
  } else {
    cufftHandle fftPlanHandle;
    nd2 = cpu_xv->size[1];
    xSize[1] = static_cast<uint32_T>(cpu_xv->size[1]);
    bcoef = cpu_xposdft->size[0] * cpu_xposdft->size[1];
    cpu_xposdft->size[0] = 1;
    cpu_xposdft->size[1] = cpu_xv->size[1];
    emxEnsureCapacity_creal32_T(cpu_xposdft, bcoef, &bd_emlrtRTEI);
    fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, 1, 1, CUFFT_R2C, 1);
    gpuEmxEnsureCapacity_real32_T(cpu_xv, &gpu_xv, !xv_outdatedOnGpu);
    gpuEmxEnsureCapacity_creal32_T(cpu_xposdft, &gpu_xposdft, true);
    if (xv_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_xv, cpu_xv);
    }
    cufftExecR2C(fftPlanHandle, (cufftReal *)&gpu_xv.data[0],
                 (cufftComplex *)&gpu_xposdft.data[0]);
    nd2 = static_cast<int32_T>(static_cast<real_T>(cpu_xv->size[1] + 1) / 2.0);
    mwGetLaunchParameters1D(computeNumIters(nd2 - 2), &grid, &block,
                            2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      cwtfilterbank_wt_kernel12<<<grid, block>>>(xSize[1], nd2 - 2,
                                                 gpu_xposdft);
    }
    xv_outdatedOnGpu = true;
  }
  emxFree_real32_T(&cpu_xv);
  nd2 = psihat->size[1];
  i = cpu_xposdft->size[1];
  if (nd2 <= i) {
    i = nd2;
  }
  if (psihat->size[1] == 1) {
    csz_idx_1 = cpu_xposdft->size[1];
  } else if (cpu_xposdft->size[1] == 1) {
    csz_idx_1 = psihat->size[1];
  } else if (cpu_xposdft->size[1] == psihat->size[1]) {
    csz_idx_1 = cpu_xposdft->size[1];
  } else {
    csz_idx_1 = i;
  }
  emxInit_creal32_T(&cpu_cfsposdft, 2, &gd_emlrtRTEI, true);
  x_outdatedOnCpu = false;
  bcoef = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1];
  cpu_cfsposdft->size[0] = psihat->size[0];
  nd2 = psihat->size[1];
  i = cpu_xposdft->size[1];
  if (nd2 <= i) {
    i = nd2;
  }
  if (psihat->size[1] == 1) {
    cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
  } else if (cpu_xposdft->size[1] == 1) {
    cpu_cfsposdft->size[1] = psihat->size[1];
  } else if (cpu_xposdft->size[1] == psihat->size[1]) {
    cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
  } else {
    cpu_cfsposdft->size[1] = i;
  }
  emxEnsureCapacity_creal32_T(cpu_cfsposdft, bcoef, &wc_emlrtRTEI);
  if ((psihat->size[0] != 0) && (csz_idx_1 != 0)) {
    acoef = (cpu_xposdft->size[1] != 1);
    bcoef = (psihat->size[1] != 1);
    csz_idx_1--;
    nd2 = (psihat->size[0] != 1);
    for (int32_T k{0}; k <= csz_idx_1; k++) {
      i = acoef * k;
      i2 = bcoef * k;
      i3 = cpu_cfsposdft->size[0] - 1;
      for (int32_T b_k{0}; b_k <= i3; b_k++) {
        if (xv_outdatedOnGpu) {
          gpuEmxMemcpyGpuToCpu_creal32_T(cpu_xposdft, &gpu_xposdft);
        }
        cpu_cfsposdft->data[b_k + cpu_cfsposdft->size[0] * k].re =
            psihat->data[nd2 * b_k + psihat->size[0] * i2] *
            cpu_xposdft->data[i].re;
        xv_outdatedOnGpu = false;
        cpu_cfsposdft->data[b_k + cpu_cfsposdft->size[0] * k].im =
            psihat->data[nd2 * b_k + psihat->size[0] * i2] *
            cpu_xposdft->data[i].im;
        x_outdatedOnCpu = true;
      }
    }
  }
  emxFree_creal32_T(&cpu_xposdft);
  emxFree_real32_T(&psihat);
  if ((cpu_cfsposdft->size[0] == 0) || (cpu_cfsposdft->size[1] == 0)) {
    xSize[0] = static_cast<uint32_T>(cpu_cfsposdft->size[0]);
    xSize[1] = static_cast<uint32_T>(cpu_cfsposdft->size[1]);
    bcoef = varargout_1->size[0] * varargout_1->size[1];
    varargout_1->size[0] = cpu_cfsposdft->size[0];
    varargout_1->size[1] = cpu_cfsposdft->size[1];
    emxEnsureCapacity_creal32_T(varargout_1, bcoef, &ed_emlrtRTEI);
    if (static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) - 1 >=
        0) {
      std::memset(&varargout_1->data[0], 0,
                  static_cast<uint32_T>(static_cast<int32_T>(xSize[0]) *
                                        static_cast<int32_T>(xSize[1])) *
                      sizeof(creal32_T));
    }
  } else {
    cufftHandle c_fftPlanHandle;
    real32_T cfsposdft_re;
    nd2 = cpu_cfsposdft->size[1];
    c_fftPlanHandle = acquireCUFFTPlan(1, &nd2, &nd2, cpu_cfsposdft->size[0], 1,
                                       CUFFT_C2C, cpu_cfsposdft->size[0]);
    gpuEmxEnsureCapacity_creal32_T(cpu_cfsposdft, &gpu_cfsposdft,
                                   !x_outdatedOnCpu);
    if (x_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_cfsposdft, cpu_cfsposdft);
    }
    cufftExecC2C(c_fftPlanHandle, (cufftComplex *)&gpu_cfsposdft.data[0],
                 (cufftComplex *)&gpu_cfsposdft.data[0], CUFFT_INVERSE);
    xv_outdatedOnGpu = true;
    bcoef = varargout_1->size[0] * varargout_1->size[1];
    varargout_1->size[0] = cpu_cfsposdft->size[0];
    varargout_1->size[1] = cpu_cfsposdft->size[1];
    emxEnsureCapacity_creal32_T(varargout_1, bcoef, &ed_emlrtRTEI);
    cfsposdft_re = static_cast<real32_T>(cpu_cfsposdft->size[1]);
    for (bcoef = 0; bcoef < cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1];
         bcoef++) {
      real32_T ai;
      real32_T ar;
      if (xv_outdatedOnGpu) {
        gpuEmxMemcpyGpuToCpu_creal32_T(cpu_cfsposdft, &gpu_cfsposdft);
      }
      ar = cpu_cfsposdft->data[bcoef].re;
      xv_outdatedOnGpu = false;
      ai = cpu_cfsposdft->data[bcoef].im;
      if (ai == 0.0F) {
        varargout_1->data[bcoef].re = ar / cfsposdft_re;
        varargout_1->data[bcoef].im = 0.0F;
      } else if (ar == 0.0F) {
        varargout_1->data[bcoef].re = 0.0F;
        varargout_1->data[bcoef].im = ai / cfsposdft_re;
      } else {
        varargout_1->data[bcoef].re = ar / cfsposdft_re;
        varargout_1->data[bcoef].im = ai / cfsposdft_re;
      }
    }
  }
  emxFree_creal32_T(&cpu_cfsposdft);
  if (self->SignalPad > 0.0) {
    real_T d3;
    d = self->SignalPad + 1.0;
    d3 = self->SignalPad + self->SignalLength;
    if (d > d3) {
      nd2 = 0;
      i = 0;
    } else {
      nd2 = static_cast<int32_T>(d) - 1;
      i = static_cast<int32_T>(d3);
    }
    csz_idx_1 = varargout_1->size[0];
    acoef = i - nd2;
    for (bcoef = 0; bcoef < acoef; bcoef++) {
      for (i2 = 0; i2 < csz_idx_1; i2++) {
        varargout_1->data[i2 + csz_idx_1 * bcoef] =
            varargout_1->data[i2 + varargout_1->size[0] * (nd2 + bcoef)];
      }
    }
    bcoef = varargout_1->size[0] * varargout_1->size[1];
    varargout_1->size[1] = i - nd2;
    emxEnsureCapacity_creal32_T(varargout_1, bcoef, &fd_emlrtRTEI);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real32_T(&gpu_xv);
  gpuEmxFree_creal32_T(&gpu_xposdft);
  gpuEmxFree_real32_T(&gpu_x);
  gpuEmxFree_creal32_T(&gpu_cfsposdft);
}

} // namespace coder

// End of code generation (wt.cu)
