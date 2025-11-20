//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// filtfilt_terminate.cu
//
// Code generation for function 'filtfilt_terminate'
//

// Include files
#include "filtfilt_terminate.h"
#include "_coder_filtfilt_mex.h"
#include "filtfilt_data.h"
#include "rt_nonfinite.h"
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

void filtfilt_atexit()
{
  nvtxRangePushA("#termFcn#filtfilt_atexit#" MW_AT_LOCATION);
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
  nvtxRangePop();
}

void filtfilt_terminate()
{
  nvtxRangePushA("#fcn#filtfilt_terminate#" MW_AT_LOCATION);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  checkCudaError(cudaGetLastError());
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  nvtxRangePop();
}

// End of code generation (filtfilt_terminate.cu)
