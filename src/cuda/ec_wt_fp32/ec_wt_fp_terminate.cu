//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_wt_fp_terminate.cu
//
// Code generation for function 'ec_wt_fp_terminate'
//

// Include files
#include "ec_wt_fp_terminate.h"
#include "_coder_ec_wt_fp_mex.h"
#include "cwt.h"
#include "ec_wt_fp_data.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Declarations
static void cwt_emx_free_dtor_fcn(const void *r);

static void emlrtExitTimeCleanupDtorFcn(const void *r);

// Function Definitions
static void cwt_emx_free_dtor_fcn(const void *r)
{
  nvtxRangePushA("#fcn#cwt_emx_free_dtor_fcn#" MW_AT_LOCATION);
  nvtxMarkA("#cwt_emx_free#" MW_AT_LINE);
  cwt_emx_free();
  nvtxRangePop();
}

static void emlrtExitTimeCleanupDtorFcn(const void *r)
{
  nvtxRangePushA("#fcn#emlrtExitTimeCleanupDtorFcn#" MW_AT_LOCATION);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
  nvtxRangePop();
}

void ec_wt_fp_atexit()
{
  nvtxRangePushA("#termFcn#ec_wt_fp_atexit#" MW_AT_LOCATION);
  nvtxMarkA("#mexFunctionCreateRootTLS#" MW_AT_LINE);
  mexFunctionCreateRootTLS();
  try {
    emlrtPushHeapReferenceStackR2021a(emlrtRootTLSGlobal, false, nullptr,
                                      (void *)&emlrtExitTimeCleanupDtorFcn,
                                      nullptr, nullptr, nullptr);
    emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
    emlrtPushHeapReferenceStackR2021a(emlrtRootTLSGlobal, false, nullptr,
                                      (void *)&cwt_emx_free_dtor_fcn, nullptr,
                                      nullptr, nullptr);
    nvtxMarkA("#cwt_emx_free#" MW_AT_LINE);
    cwt_emx_free();
    emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
    emlrtExitTimeCleanup(&emlrtContextGlobal);
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }
  nvtxRangePop();
}

void ec_wt_fp_terminate()
{
  cudaError_t errCode;
  nvtxRangePushA("#fcn#ec_wt_fp_terminate#" MW_AT_LOCATION);
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode),
                       (char_T *)cudaGetErrorName(errCode),
                       (char_T *)cudaGetErrorString(errCode),
                       (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  nvtxRangePop();
}

// End of code generation (ec_wt_fp_terminate.cu)
