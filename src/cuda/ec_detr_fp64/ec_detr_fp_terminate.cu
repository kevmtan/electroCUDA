//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detr_fp_terminate.cu
//
// Code generation for function 'ec_detr_fp_terminate'
//

// Include files
#include "ec_detr_fp_terminate.h"
#include "_coder_ec_detr_fp_mex.h"
#include "ec_detr_fp_data.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCUSOLVERUtils.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Declarations
static void checkCudaError(cudaError_t errorCode);

static void emlrtExitTimeCleanupDtorFcn(const void *r);

static void gpuThrowError(uint32_T errorCode, const char_T *errorName,
                          const char_T *errorString);

// Function Definitions
static void checkCudaError(cudaError_t errorCode)
{
  nvtxRangePushA("#fcn#checkCudaError#" MW_AT_LOCATION);
  if (errorCode != cudaSuccess) {
    nvtxMarkA("#gpuThrowError#" MW_AT_LINE);
    gpuThrowError(errorCode, cudaGetErrorName(errorCode),
                  cudaGetErrorString(errorCode));
  }
  nvtxRangePop();
}

static void emlrtExitTimeCleanupDtorFcn(const void *r)
{
  nvtxRangePushA("#fcn#emlrtExitTimeCleanupDtorFcn#" MW_AT_LOCATION);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  nvtxRangePop();
}

static void gpuThrowError(uint32_T errorCode, const char_T *errorName,
                          const char_T *errorString)
{
  nvtxRangePushA("#fcn#gpuThrowError#" MW_AT_LOCATION);
  emlrtThinCUDAError(errorCode, (char_T *)errorName, (char_T *)errorString,
                     (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  nvtxRangePop();
}

void ec_detr_fp_atexit()
{
  nvtxRangePushA("#termFcn#ec_detr_fp_atexit#" MW_AT_LOCATION);
  nvtxMarkA("#mexFunctionCreateRootTLS#" MW_AT_LINE);
  mexFunctionCreateRootTLS();
  try {
    emlrtPushHeapReferenceStackR2021a(emlrtRootTLSGlobal, false, nullptr,
                                      (void *)&emlrtExitTimeCleanupDtorFcn,
                                      nullptr, nullptr, nullptr);
    emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
    emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
    emlrtExitTimeCleanup(&emlrtContextGlobal);
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }
  cusolverDestroyWorkspace();
  cusolverEnsureDestruction();
  nvtxRangePop();
}

void ec_detr_fp_terminate()
{
  nvtxRangePushA("#fcn#ec_detr_fp_terminate#" MW_AT_LOCATION);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  checkCudaError(cudaGetLastError());
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  cublasEnsureDestruction();
  nvtxRangePop();
}

// End of code generation (ec_detr_fp_terminate.cu)
