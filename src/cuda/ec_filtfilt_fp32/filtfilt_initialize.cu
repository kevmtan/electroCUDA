//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// filtfilt_initialize.cu
//
// Code generation for function 'filtfilt_initialize'
//

// Include files
#include "filtfilt_initialize.h"
#include "_coder_filtfilt_mex.h"
#include "filtfilt_data.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Declarations
static void filtfilt_once();

// Function Definitions
static void filtfilt_once()
{
  mex_InitInfAndNan();
  nvtxRangePushA("#initFcn#filtfilt_once#" MW_AT_LOCATION);
  // Initialize GPU by calling cudaFree(nullptr)
  nvtxMarkA("#cudaFree#" MW_AT_LINE);
  cudaFree(nullptr);
  nvtxRangePop();
}

void filtfilt_initialize()
{
  nvtxRangePushA("#fcn#filtfilt_initialize#" MW_AT_LOCATION);
  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
  nvtxMarkA("#mexFunctionCreateRootTLS#" MW_AT_LINE);
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
                          "EMLRT:runTime:MexFunctionNeedsLicense",
                          "distrib_computing_toolbox", 2);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    nvtxMarkA("#filtfilt_once#" MW_AT_LINE);
    filtfilt_once();
  }
  nvtxRangePop();
}

// End of code generation (filtfilt_initialize.cu)
