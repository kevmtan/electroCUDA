//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// circshift.cu
//
// Code generation for function 'circshift'
//

// Include files
#include "circshift.h"
#include "ec_wtcc_mexutil.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"

// Function Declarations
static __global__ void circshift_kernel205(const int32_T shiftLen,
                                           const int32_T b, int32_T a[2]);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void circshift_kernel205(
    const int32_T shiftLen, const int32_T b, int32_T a[2])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i2;
    i2 = a[0];
    a[0] = a[1 - shiftLen];
    a[1 - shiftLen] = i2;
  }
}

//
//
namespace coder {
void circshift(int32_T cpu_a[2], boolean_T *a_outdatedOnCpu, int32_T gpu_a[2],
               boolean_T *a_outdatedOnGpu, int32_T p)
{
  dim3 block;
  dim3 grid;
  int32_T shiftLen;
  shiftLen = p;
  if (p < 0) {
    shiftLen = 1;
  }
  if (shiftLen < 2 - shiftLen) {
    boolean_T validLaunchParams;
    mwGetLaunchParameters1D(
        computeNumIters(
            static_cast<int32_T>(static_cast<real_T>(2 - shiftLen) / 2.0) - 1),
        &grid, &block, 2147483647U);
    if (*a_outdatedOnGpu) {
      checkCudaError(cudaMemcpy(gpu_a, cpu_a, 8UL, cudaMemcpyHostToDevice),
                     __FILE__, __LINE__);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      circshift_kernel205<<<grid, block>>>(
          shiftLen,
          static_cast<int32_T>(static_cast<real_T>(2 - shiftLen) / 2.0) - 1,
          gpu_a);
    }
    *a_outdatedOnCpu = true;
  }
  if (*a_outdatedOnCpu) {
    checkCudaError(cudaMemcpy(cpu_a, gpu_a, 8UL, cudaMemcpyDeviceToHost),
                   __FILE__, __LINE__);
  }
  shiftLen = cpu_a[0];
  cpu_a[0] = cpu_a[1];
  cpu_a[1] = shiftLen;
  *a_outdatedOnCpu = false;
  *a_outdatedOnGpu = true;
}

} // namespace coder

// End of code generation (circshift.cu)
