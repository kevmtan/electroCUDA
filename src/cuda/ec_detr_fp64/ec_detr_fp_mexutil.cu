//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detr_fp_mexutil.cu
//
// Code generation for function 'ec_detr_fp_mexutil'
//

// Include files
#include "ec_detr_fp_mexutil.h"
#include "ec_detr_fp_data.h"
#include "ec_detr_fp_types.h"
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

uint64_T computeNumIters(int32_T ub, int32_T b_ub)
{
  uint64_T n;
  uint64_T numIters;
  boolean_T overflow;
  nvtxRangePushA("#fcn#computeNumIters#" MW_AT_LOCATION);
  overflow = false;
  n = 0UL;
  if (ub >= 0) {
    n = static_cast<uint64_T>(ub + 1);
  }
  numIters = n;
  n = 0UL;
  if (b_ub >= 0) {
    n = static_cast<uint64_T>(b_ub + 1);
    overflow = (numIters > MAX_uint64_T / static_cast<uint64_T>(b_ub + 1));
  }
  numIters *= n;
  if (overflow) {
    nvtxMarkA("#gpuThrowError#" MW_AT_LINE);
    gpuThrowError(__FILE__, __LINE__);
  }
  nvtxRangePop();
  return numIters;
}

uint64_T computeNumIters(int32_T ub)
{
  uint64_T numIters;
  nvtxRangePushA("#fcn#computeNumIters#" MW_AT_LOCATION);
  numIters = 0UL;
  if (ub >= 0) {
    numIters = static_cast<uint64_T>(ub + 1);
  }
  nvtxRangePop();
  return numIters;
}

void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
                                  emxArray_int32_T *gpu, boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  int32_T *newData;
  nvtxRangePushA("#fcn#gpuEmxEnsureCapacity_int32_T#" MW_AT_LOCATION);
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  i = 0;
  nvtxRangePushA("#loop#gpuEmxEnsureCapacity_int32_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (((totalSizeCpu == 0) && (cpu->allocatedSize > 0)) ||
      (gpu->allocatedSize < totalSizeCpu)) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(int32_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && (totalSizeGpu > 0));
    if (needsCopy) {
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(int32_T),
                     cudaMemcpyDeviceToDevice),
          __FILE__, __LINE__);
    }
    if (gpu->canFreeData) {
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }
    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
  nvtxRangePop();
}

void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
                                 emxArray_real_T *gpu, boolean_T needsCopy)
{
  real_T *newData;
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  nvtxRangePushA("#fcn#gpuEmxEnsureCapacity_real_T#" MW_AT_LOCATION);
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  i = 0;
  nvtxRangePushA("#loop#gpuEmxEnsureCapacity_real_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (((totalSizeCpu == 0) && (cpu->allocatedSize > 0)) ||
      (gpu->allocatedSize < totalSizeCpu)) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(real_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && (totalSizeGpu > 0));
    if (needsCopy) {
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(real_T),
                     cudaMemcpyDeviceToDevice),
          __FILE__, __LINE__);
    }
    if (gpu->canFreeData) {
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }
    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
  nvtxRangePop();
}

void gpuEmxFree_int32_T(emxArray_int32_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxFree_int32_T#" MW_AT_LOCATION);
  if (gpu->data && gpu->canFreeData && (gpu->data != (void *)4207599121UL)) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
  nvtxRangePop();
}

void gpuEmxFree_real_T(emxArray_real_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxFree_real_T#" MW_AT_LOCATION);
  if (gpu->data && gpu->canFreeData && (gpu->data != (void *)4207599121UL)) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
  nvtxRangePop();
}

void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu,
                                  const emxArray_int32_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA("#loop#gpuEmxMemcpyCpuToGpu_int32_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    actualSize *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (cpu->data) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
    checkCudaError(
        cudaMemcpy(gpu->data, cpu->data,
                   static_cast<uint32_T>(actualSize) * sizeof(int32_T),
                   cudaMemcpyHostToDevice),
        __FILE__, __LINE__);
  }
  nvtxRangePop();
}

void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu,
                                 const emxArray_real_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA("#loop#gpuEmxMemcpyCpuToGpu_real_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    actualSize *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (cpu->data) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
    checkCudaError(
        cudaMemcpy(gpu->data, cpu->data,
                   static_cast<uint32_T>(actualSize) * sizeof(real_T),
                   cudaMemcpyHostToDevice),
        __FILE__, __LINE__);
  }
  nvtxRangePop();
}

void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T *gpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA("#loop#gpuEmxMemcpyGpuToCpu_real_T_whileloop_0##" MW_AT_LINE);
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
                   static_cast<uint32_T>(actualSize) * sizeof(real_T),
                   cudaMemcpyDeviceToHost),
        __FILE__, __LINE__);
  }
  nvtxRangePop();
}

void gpuEmxReset_int32_T(emxArray_int32_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxReset_int32_T#" MW_AT_LOCATION);
  std::memset(gpu, 0, sizeof(emxArray_int32_T));
  nvtxRangePop();
}

void gpuEmxReset_real_T(emxArray_real_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxReset_real_T#" MW_AT_LOCATION);
  std::memset(gpu, 0, sizeof(emxArray_real_T));
  nvtxRangePop();
}

void gpuThrowError(const char_T *file, int32_T b_line)
{
  emlrtRTEInfo rtInfo;
  nvtxRangePushA("#fcn#gpuThrowError#" MW_AT_LOCATION);
  rtInfo.lineNo = b_line;
  rtInfo.colNo = 0;
  rtInfo.fName = "";
  rtInfo.pName = file;
  emlrtCUDAError(
      0U, (char_T *)"_",
      (char_T
           *)"Unable to launch kernel. Loop nest contains too many iterations.",
      &rtInfo, emlrtRootTLSGlobal);
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

// End of code generation (ec_detr_fp_mexutil.cu)
