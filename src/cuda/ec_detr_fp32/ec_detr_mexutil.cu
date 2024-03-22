//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detr_mexutil.cu
//
// Code generation for function 'ec_detr_mexutil'
//

// Include files
#include "ec_detr_mexutil.h"
#include "ec_detr_data.h"
#include "ec_detr_types.h"
#include "rt_nonfinite.h"
#include "MWCudaMemoryFunctions.hpp"
#include "MWErrorCodeUtils.hpp"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include <cstdlib>
#include <cstring>

// Function Definitions
void b_raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                      const char_T *errorName, const char_T *errorString)
{
  emlrtRTEInfo rtInfo;
  uint64_T len;
  char_T *brk;
  char_T *fn;
  char_T *pn;
  len = strlen(file);
  pn = static_cast<char_T *>(calloc(len + 1UL, 1UL));
  fn = static_cast<char_T *>(calloc(len + 1UL, 1UL));
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
}

void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T b_line)
{
  if (errCode != cudaSuccess) {
    b_raiseCudaError(errCode, file, b_line, cudaGetErrorName(errCode),
                     cudaGetErrorString(errCode));
  }
}

int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride)
{
  int64_T newEnd;
  newEnd = -1L;
  if ((stride > 0L) && (start <= end)) {
    newEnd = (end - start) / stride;
  } else if ((stride < 0L) && (end <= start)) {
    newEnd = (start - end) / -stride;
  }
  return newEnd;
}

uint64_T computeNumIters(int32_T ub, int32_T b_ub)
{
  uint64_T n;
  uint64_T numIters;
  n = 0UL;
  if (ub >= 0) {
    n = static_cast<uint64_T>(ub + 1);
  }
  numIters = n;
  n = 0UL;
  if (b_ub >= 0) {
    n = static_cast<uint64_T>(b_ub + 1);
  }
  numIters *= n;
  return numIters;
}

uint64_T computeNumIters(int32_T ub)
{
  uint64_T numIters;
  numIters = 0UL;
  if (ub >= 0) {
    numIters = static_cast<uint64_T>(ub + 1);
  }
  return numIters;
}

void cublasCheck(cublasStatus_t errCode, const char_T *file, uint32_T b_line)
{
  const char *errName;
  const char *errString;
  if (errCode != CUBLAS_STATUS_SUCCESS) {
    cublasGetErrorName(errCode, &errName);
    cublasGetErrorString(errCode, &errString);
    raiseCudaError(errCode, file, b_line, errName, errString);
  }
}

void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
                                  emxArray_int32_T *gpu, boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  int32_T *newData;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < totalSizeCpu) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(int32_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(int32_T),
                     cudaMemcpyDeviceToDevice),
          __FILE__, __LINE__);
    }
    if (gpu->canFreeData) {
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }
    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
}

void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
                                   emxArray_real32_T *gpu, boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  real32_T *newData;
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < totalSizeCpu) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(real32_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(real32_T),
                     cudaMemcpyDeviceToDevice),
          __FILE__, __LINE__);
    }
    if (gpu->canFreeData) {
      checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
    }
    gpu->data = newData;
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
  }
}

void gpuEmxFree_int32_T(emxArray_int32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
}

void gpuEmxFree_real32_T(emxArray_real32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
}

void gpuEmxMemcpyCpuToGpu_int32_T(emxArray_int32_T *gpu,
                                  const emxArray_int32_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(cudaMemcpy(gpu->data, cpu->data,
                            static_cast<uint32_T>(actualSize) * sizeof(int32_T),
                            cudaMemcpyHostToDevice),
                 __FILE__, __LINE__);
}

void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                   const emxArray_real32_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(
      cudaMemcpy(gpu->data, cpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(real32_T),
                 cudaMemcpyHostToDevice),
      __FILE__, __LINE__);
}

void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
                                   emxArray_real32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(
      cudaMemcpy(cpu->data, gpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(real32_T),
                 cudaMemcpyDeviceToHost),
      __FILE__, __LINE__);
}

void gpuEmxReset_int32_T(emxArray_int32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_int32_T));
}

void gpuEmxReset_real32_T(emxArray_real32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real32_T));
}

void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
                    const char_T *errorName, const char_T *errorString)
{
  emlrtRTEInfo rtInfo;
  uint64_T len;
  char_T *brk;
  char_T *fn;
  char_T *pn;
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
}

// End of code generation (ec_detr_mexutil.cu)
