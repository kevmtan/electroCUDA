//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// filtfilt_mexutil.cu
//
// Code generation for function 'filtfilt_mexutil'
//

// Include files
#include "filtfilt_mexutil.h"
#include "filtfilt_data.h"
#include "filtfilt_types.h"
#include "rt_nonfinite.h"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cstring>

// Function Definitions
void checkCudaError(cudaError_t errorCode, const char_T *file, int32_T b_line)
{
  nvtxRangePushA("#fcn#checkCudaError#" MW_AT_LOCATION);
  if (errorCode != cudaSuccess) {
    nvtxMarkA("#gpuThrowError#" MW_AT_LINE);
    gpuThrowError(errorCode, cudaGetErrorName(errorCode),
                  cudaGetErrorString(errorCode), file, b_line);
  }
  nvtxRangePop();
}

int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride)
{
  int64_T newEnd;
  nvtxRangePushA("#fcn#computeEndIdx#" MW_AT_LOCATION);
  newEnd = -1L;
  if ((stride > 0L) && (start <= end)) {
    newEnd = (end - start) / stride;
  } else if ((stride < 0L) && (end <= start)) {
    newEnd = (start - end) / -stride;
  }
  nvtxRangePop();
  return newEnd;
}

void gpuEmxFree_real32_T(emxArray_real32_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxFree_real32_T#" MW_AT_LOCATION);
  if (gpu->data && gpu->canFreeData && (gpu->data != (void *)4207599121UL)) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
  nvtxRangePop();
}

void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
                                   emxArray_real32_T *gpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA(
      "#loop#gpuEmxMemcpyGpuToCpu_real32_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    actualSize *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (gpu->data) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
    checkCudaError(
        cudaMemcpy(cpu->data, gpu->data,
                   static_cast<uint32_T>(actualSize) * sizeof(real32_T),
                   cudaMemcpyDeviceToHost),
        __FILE__, __LINE__);
  }
  nvtxRangePop();
}

void gpuEmxReset_real32_T(emxArray_real32_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxReset_real32_T#" MW_AT_LOCATION);
  std::memset(gpu, 0, sizeof(emxArray_real32_T));
  nvtxRangePop();
}

void gpuThrowError(uint32_T errorCode, const char_T *errorName,
                   const char_T *errorString, const char_T *file,
                   int32_T b_line)
{
  emlrtRTEInfo rtInfo;
  nvtxRangePushA("#fcn#gpuThrowError#" MW_AT_LOCATION);
  rtInfo.lineNo = b_line;
  rtInfo.colNo = 0;
  rtInfo.fName = "";
  rtInfo.pName = file;
  emlrtCUDAError(errorCode, (char_T *)errorName, (char_T *)errorString, &rtInfo,
                 emlrtRootTLSGlobal);
  nvtxRangePop();
}

// End of code generation (filtfilt_mexutil.cu)
