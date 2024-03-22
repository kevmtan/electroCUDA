//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_cwtAvg_terminate.cu
//
// Code generation for function 'ec_cwtAvg_terminate'
//

// Include files
#include "ec_cwtAvg_terminate.h"
#include "_coder_ec_cwtAvg_mex.h"
#include "ec_cwtAvg_data.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCUSOLVERUtils.hpp"

// Function Declarations
static void emlrtExitTimeCleanupDtorFcn(const void *r);

// Function Definitions
static void emlrtExitTimeCleanupDtorFcn(const void *r)
{
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void ec_cwtAvg_atexit()
{
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
}

void ec_cwtAvg_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode),
                       (char_T *)cudaGetErrorName(errCode),
                       (char_T *)cudaGetErrorString(errCode),
                       (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  cublasEnsureDestruction();
}

// End of code generation (ec_cwtAvg_terminate.cu)
