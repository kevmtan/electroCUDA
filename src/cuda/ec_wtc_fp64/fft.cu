//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// fft.cu
//
// Code generation for function 'fft'
//

// Include files
#include "fft.h"
#include "ec_wtc_fp_data.h"
#include "ec_wtc_fp_emxutil.h"
#include "ec_wtc_fp_mexutil.h"
#include "ec_wtc_fp_types.h"
#include "rt_nonfinite.h"
#include "MWCUFFTPlanManager.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "cufft.h"
#include "nvtx3/nvToolsExt.h"

// Variable Definitions
static emlrtRTEInfo td_emlrtRTEI{
    63,                                                             // lineNo
    5,                                                              // colNo
    "fft",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/fft.m" // pName
};

// Function Declarations
static __global__ void fft_kernel27(const uint32_T xSize_dim1, const int32_T b,
                                    emxArray_creal_T y);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void fft_kernel27(
    const uint32_T xSize_dim1, const int32_T b, emxArray_creal_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    y.data[(static_cast<int32_T>(xSize_dim1) - i) - 1].re = y.data[i + 1].re;
    y.data[(static_cast<int32_T>(xSize_dim1) - i) - 1].im = -y.data[i + 1].im;
  }
}

//
//
namespace coder {
void fft(emxArray_real_T *cpu_x, boolean_T *x_outdatedOnCpu,
         emxArray_real_T *gpu_x, boolean_T *x_outdatedOnGpu,
         emxArray_creal_T *cpu_y, boolean_T *y_outdatedOnCpu,
         emxArray_creal_T *gpu_y, boolean_T *y_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  nvtxRangePushA("#fcn#fft#" MW_AT_LOCATION);
  if (cpu_x->size[1] == 0) {
    *y_outdatedOnCpu = false;
    cpu_y->size[0] = 1;
    cpu_y->size[1] = 0;
  } else if (cpu_x->size[1] - (static_cast<int32_T>(
                                   static_cast<uint32_T>(cpu_x->size[1]) >> 1)
                               << 1) ==
             1) {
    cufftHandle b_fftPlanHandle;
    int32_T i;
    *y_outdatedOnGpu = false;
    i = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = 1;
    cpu_y->size[1] = cpu_x->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_y, i, &td_emlrtRTEI);
    profileLoopStart("fft_loop_0", __LINE__, (cpu_x->size[1] - 1) + 1, "");
    for (i = 0; i < cpu_x->size[1]; i++) {
      if (*x_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_x, gpu_x);
      }
      *x_outdatedOnCpu = false;
      cpu_y->data[i].re = cpu_x->data[i];
      cpu_y->data[i].im = 0.0;
      *y_outdatedOnGpu = true;
    }
    int32_T midpoint;
    profileLoopEnd();
    midpoint = cpu_y->size[1];
    b_fftPlanHandle =
        acquireCUFFTPlan(1, &midpoint, &midpoint, 1, 1, CUFFT_Z2Z, 1);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_y, gpu_y, !*y_outdatedOnGpu);
    if (*y_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(gpu_y, cpu_y);
    }
    cufftExecZ2Z(b_fftPlanHandle, (cufftDoubleComplex *)&gpu_y->data[0],
                 (cufftDoubleComplex *)&gpu_y->data[0], CUFFT_FORWARD);
    *y_outdatedOnCpu = true;
  } else {
    cufftHandle fftPlanHandle;
    int32_T i;
    int32_T midpoint;
    uint32_T xSize[2];
    boolean_T validLaunchParams;
    midpoint = cpu_x->size[1];
    xSize[1] = static_cast<uint32_T>(cpu_x->size[1]);
    i = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = 1;
    cpu_y->size[1] = cpu_x->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_y, i, &ud_emlrtRTEI);
    fftPlanHandle =
        acquireCUFFTPlan(1, &midpoint, &midpoint, 1, 1, CUFFT_D2Z, 1);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_x, gpu_x, !*x_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_y, gpu_y, true);
    if (*x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_x, cpu_x);
    }
    *x_outdatedOnGpu = false;
    cufftExecD2Z(fftPlanHandle, (cufftDoubleReal *)&gpu_x->data[0],
                 (cufftDoubleComplex *)&gpu_y->data[0]);
    midpoint =
        static_cast<int32_T>(static_cast<real_T>(cpu_x->size[1] + 1) / 2.0);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(midpoint - 2), &grid, &block,
                            2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#fft_kernel27#" MW_AT_LINE);
      fft_kernel27<<<grid, block>>>(xSize[1], midpoint - 2, *gpu_y);
    }
    *y_outdatedOnCpu = true;
  }
  *y_outdatedOnGpu = false;
  nvtxRangePop();
}

} // namespace coder

// End of code generation (fft.cu)
