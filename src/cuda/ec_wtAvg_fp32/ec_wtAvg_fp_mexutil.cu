//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wtAvg_fp_mexutil.cu
//
// Code generation for function 'ec_wtAvg_fp_mexutil'
//

// Include files
#include "ec_wtAvg_fp_mexutil.h"
#include "ec_wtAvg_fp_data.h"
#include "ec_wtAvg_fp_types.h"
#include "rt_nonfinite.h"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include <cmath>
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
  nvtxRangePushA("#fcn#b_raiseCudaError#" MW_AT_LOCATION);
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
  nvtxRangePop();
}

void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T b_line)
{
  nvtxRangePushA("#fcn#checkCudaError#" MW_AT_LOCATION);
  if (errCode != cudaSuccess) {
    nvtxMarkA("#b_raiseCudaError#" MW_AT_LINE);
    b_raiseCudaError(errCode, file, b_line, cudaGetErrorName(errCode),
                     cudaGetErrorString(errCode));
  }
  nvtxRangePop();
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

real_T d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  real_T ret;
  nvtxRangePushA("#fcn#d_emlrt_marshallIn#" MW_AT_LOCATION);
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 0U,
                          (const void *)&dims);
  ret = *static_cast<real_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  nvtxRangePop();
  return ret;
}

int32_T div_s32(int32_T numerator, int32_T denominator)
{
  int32_T quotient;
  nvtxRangePushA("#fcn#div_s32#" MW_AT_LOCATION);
  if (denominator == 0) {
    emlrtDivisionByZeroErrorR2012b(nullptr, emlrtRootTLSGlobal);
  } else {
    uint32_T b;
    uint32_T tempAbsQuotient;
    if (numerator < 0) {
      tempAbsQuotient = ~static_cast<uint32_T>(numerator) + 1U;
    } else {
      tempAbsQuotient = static_cast<uint32_T>(numerator);
    }
    if (denominator < 0) {
      b = ~static_cast<uint32_T>(denominator) + 1U;
    } else {
      b = static_cast<uint32_T>(denominator);
    }
    tempAbsQuotient /= b;
    if ((numerator < 0) != (denominator < 0)) {
      quotient = -static_cast<int32_T>(tempAbsQuotient);
    } else {
      quotient = static_cast<int32_T>(tempAbsQuotient);
    }
  }
  nvtxRangePop();
  return quotient;
}

real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *parentId)
{
  real_T y;
  nvtxRangePushA("#fcn#emlrt_marshallIn#" MW_AT_LOCATION);
  nvtxMarkA("#d_emlrt_marshallIn#" MW_AT_LINE);
  y = d_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  nvtxRangePop();
  return y;
}

real_T emlrt_marshallIn(const mxArray *a__output_of_length_,
                        const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  nvtxRangePushA("#fcn#emlrt_marshallIn#" MW_AT_LOCATION);
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  nvtxMarkA("#emlrt_marshallIn#" MW_AT_LINE);
  y = emlrt_marshallIn(emlrtAlias(a__output_of_length_), &thisId);
  emlrtDestroyArray(&a__output_of_length_);
  nvtxRangePop();
  return y;
}

void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
                                    emxArray_creal32_T *gpu,
                                    boolean_T needsCopy)
{
  creal32_T *newData;
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  nvtxRangePushA("#fcn#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LOCATION);
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  i = 0;
  nvtxRangePushA(
      "#loop#gpuEmxEnsureCapacity_creal32_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (gpu->allocatedSize < totalSizeCpu) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(creal32_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(creal32_T),
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

void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
                                   emxArray_real32_T *gpu, boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  real32_T *newData;
  nvtxRangePushA("#fcn#gpuEmxEnsureCapacity_real32_T#" MW_AT_LOCATION);
  if (gpu->numDimensions == 0) {
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  }
  totalSizeCpu = 1;
  totalSizeGpu = 1;
  i = 0;
  nvtxRangePushA(
      "#loop#gpuEmxEnsureCapacity_real32_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    totalSizeGpu *= gpu->size[i];
    totalSizeCpu *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (gpu->allocatedSize < totalSizeCpu) {
    i = cpu->allocatedSize;
    if (i < totalSizeCpu) {
      i = totalSizeCpu;
    }
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
    checkCudaError(
        mwCudaMalloc(&newData, static_cast<uint32_T>(i) * sizeof(real32_T)),
        __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      nvtxMarkA("#checkCudaError#" MW_AT_LINE);
      nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
      checkCudaError(
          cudaMemcpy(newData, gpu->data,
                     static_cast<uint32_T>(totalSizeGpu) * sizeof(real32_T),
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

void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxFree_creal32_T#" MW_AT_LOCATION);
  if (gpu->data != (void *)4207599121UL) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
  nvtxRangePop();
}

void gpuEmxFree_real32_T(emxArray_real32_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxFree_real32_T#" MW_AT_LOCATION);
  if (gpu->data != (void *)4207599121UL) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }
  emlrtFreeMex(gpu->size);
  nvtxRangePop();
}

void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu,
                                    const emxArray_creal32_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA(
      "#loop#gpuEmxMemcpyCpuToGpu_creal32_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    actualSize *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
  checkCudaError(
      cudaMemcpy(gpu->data, cpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(creal32_T),
                 cudaMemcpyHostToDevice),
      __FILE__, __LINE__);
  nvtxRangePop();
}

void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                   const emxArray_real32_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA(
      "#loop#gpuEmxMemcpyCpuToGpu_real32_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    actualSize *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
  checkCudaError(
      cudaMemcpy(gpu->data, cpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(real32_T),
                 cudaMemcpyHostToDevice),
      __FILE__, __LINE__);
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
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
  checkCudaError(
      cudaMemcpy(cpu->data, gpu->data,
                 static_cast<uint32_T>(actualSize) * sizeof(real32_T),
                 cudaMemcpyDeviceToHost),
      __FILE__, __LINE__);
  nvtxRangePop();
}

void gpuEmxReset_creal32_T(emxArray_creal32_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxReset_creal32_T#" MW_AT_LOCATION);
  std::memset(gpu, 0, sizeof(emxArray_creal32_T));
  nvtxRangePop();
}

void gpuEmxReset_real32_T(emxArray_real32_T *gpu)
{
  nvtxRangePushA("#fcn#gpuEmxReset_real32_T#" MW_AT_LOCATION);
  std::memset(gpu, 0, sizeof(emxArray_real32_T));
  nvtxRangePop();
}

real_T rt_powd_snf(real_T u0, real_T u1)
{
  real_T y;
  nvtxRangePushA("#fcn#rt_powd_snf#" MW_AT_LOCATION);
  if (std::isnan(u0) || std::isnan(u1)) {
    y = rtNaN;
  } else {
    real_T b;
    real_T c;
    b = std::abs(u0);
    c = std::abs(u1);
    if (std::isinf(u1)) {
      if (b == 1.0) {
        y = 1.0;
      } else if (b > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (c == 0.0) {
      y = 1.0;
    } else if (c == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = std::sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > std::floor(u1))) {
      y = rtNaN;
    } else {
      y = std::pow(u0, u1);
    }
  }
  nvtxRangePop();
  return y;
}

// End of code generation (ec_wtAvg_fp_mexutil.cu)
