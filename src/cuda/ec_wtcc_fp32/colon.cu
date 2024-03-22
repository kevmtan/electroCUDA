//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// colon.cu
//
// Code generation for function 'colon'
//

// Include files
#include "colon.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo xd_emlrtRTEI{
    320,                                                          // lineNo
    20,                                                           // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

// Function Declarations
static __global__ void eml_float_colon_kernel29(const real_T apnd,
                                                const int32_T n, const real_T a,
                                                const int32_T b,
                                                emxArray_real_T y);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void eml_float_colon_kernel29(
    const real_T apnd, const int32_T n, const real_T a, const int32_T b,
    emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k + 1] = a - (static_cast<real_T>(k) + 1.0);
    y.data[(n - k) - 2] = apnd - (-(static_cast<real_T>(k) + 1.0));
  }
}

//
//
namespace coder {
void eml_float_colon(real_T a, emxArray_real_T *cpu_y,
                     boolean_T *y_outdatedOnCpu, emxArray_real_T *gpu_y,
                     boolean_T *y_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  real_T apnd;
  real_T ndbl;
  int32_T nm1d2;
  ndbl = std::floor(-(1.0 - a) + 0.5);
  apnd = a - ndbl;
  if (std::abs(1.0 - apnd) <
      4.4408920985006262E-16 * std::fmax(std::abs(a), 1.0)) {
    ndbl++;
    apnd = 1.0;
  } else if (1.0 - apnd > 0.0) {
    apnd = a - (ndbl - 1.0);
  } else {
    ndbl++;
  }
  *y_outdatedOnGpu = false;
  nm1d2 = cpu_y->size[0] * cpu_y->size[1];
  cpu_y->size[0] = 1;
  cpu_y->size[1] = static_cast<int32_T>(ndbl);
  emxEnsureCapacity_real_T(cpu_y, nm1d2, &xd_emlrtRTEI);
  if (static_cast<int32_T>(ndbl) > 0) {
    cpu_y->data[0] = a;
    *y_outdatedOnGpu = true;
    if (static_cast<int32_T>(ndbl) > 1) {
      boolean_T validLaunchParams;
      cpu_y->data[static_cast<int32_T>(ndbl) - 1] = apnd;
      nm1d2 = (static_cast<int32_T>(ndbl) - 1) / 2;
      mwGetLaunchParameters1D(computeNumIters(nm1d2 - 2), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_y, gpu_y, false);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_y, cpu_y);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        eml_float_colon_kernel29<<<grid, block>>>(
            apnd, static_cast<int32_T>(ndbl), a, nm1d2 - 2, *gpu_y);
      }
      if (nm1d2 << 1 == static_cast<int32_T>(ndbl) - 1) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_y, gpu_y);
        cpu_y->data[nm1d2] = (a + apnd) / 2.0;
      } else {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_y, gpu_y);
        cpu_y->data[nm1d2] = a - static_cast<real_T>(nm1d2);
        cpu_y->data[nm1d2 + 1] = apnd - (-static_cast<real_T>(nm1d2));
      }
    }
  }
  *y_outdatedOnCpu = false;
}

} // namespace coder

// End of code generation (colon.cu)
