//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt_fp_initialize.cu
//
// Code generation for function 'ec_filtfilt_fp_initialize'
//

// Include files
#include "ec_filtfilt_fp_initialize.h"
#include "_coder_ec_filtfilt_fp_mex.h"
#include "ec_filtfilt_fp_data.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Function Declarations
static void ec_filtfilt_fp_once();

// Function Definitions
static void ec_filtfilt_fp_once()
{
  mex_InitInfAndNan();
  nvtxRangePushA("#initFcn#ec_filtfilt_fp_once#" MW_AT_LOCATION);
  // Initialize GPU by calling cudaFree(nullptr)
  nvtxMarkA("#cudaFree#" MW_AT_LINE);
  cudaFree(nullptr);
  nvtxRangePop();
}

void ec_filtfilt_fp_initialize()
{
  nvtxRangePushA("#fcn#ec_filtfilt_fp_initialize#" MW_AT_LOCATION);
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
    nvtxMarkA("#ec_filtfilt_fp_once#" MW_AT_LINE);
    ec_filtfilt_fp_once();
  }
  nvtxRangePop();
}

// End of code generation (ec_filtfilt_fp_initialize.cu)
