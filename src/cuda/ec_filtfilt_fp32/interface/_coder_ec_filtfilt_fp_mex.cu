//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_filtfilt_fp_mex.cu
//
// Code generation for function '_coder_ec_filtfilt_fp_mex'
//

// Include files
#include "_coder_ec_filtfilt_fp_mex.h"
#include "_coder_ec_filtfilt_fp_api.h"
#include "ec_filtfilt_fp_data.h"
#include "ec_filtfilt_fp_initialize.h"
#include "ec_filtfilt_fp_terminate.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <stdexcept>

void emlrtExceptionBridge();
void emlrtExceptionBridge()
{
  throw std::runtime_error("");
}
// Function Definitions
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  nvtxRangePushA("#fcn#mexFunction#" MW_AT_LOCATION);
  nvtxMarkA("#mexAtExit#" MW_AT_LINE);
  mexAtExit(&ec_filtfilt_fp_atexit);
  // Module initialization.
  nvtxMarkA("#ec_filtfilt_fp_initialize#" MW_AT_LINE);
  ec_filtfilt_fp_initialize();
  try { // Dispatch the entry-point.
    nvtxMarkA("#unsafe_ec_filtfilt_fp_mexFunction#" MW_AT_LINE);
    unsafe_ec_filtfilt_fp_mexFunction(nlhs, plhs, nrhs, prhs);
    // Module termination.
    nvtxMarkA("#ec_filtfilt_fp_terminate#" MW_AT_LINE);
    ec_filtfilt_fp_terminate();
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }
  nvtxRangePop();
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCTX p;
  nvtxRangePushA("#fcn#mexFunctionCreateRootTLS#" MW_AT_LOCATION);
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           (void *)&emlrtExceptionBridge, "UTF-8", true);
  p = emlrtRootTLSGlobal;
  nvtxRangePop();
  return p;
}

void unsafe_ec_filtfilt_fp_mexFunction(int32_T nlhs, mxArray *plhs[1],
                                       int32_T nrhs, const mxArray *prhs[6])
{
  const mxArray *outputs[1];
  nvtxRangePushA("#fcn#unsafe_ec_filtfilt_fp_mexFunction#" MW_AT_LOCATION);
  // Check for proper number of arguments.
  if (nrhs != 6) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 6, 4, 14, "ec_filtfilt_fp");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 14,
                        "ec_filtfilt_fp");
  }
  // Call the function.
  nvtxMarkA("#ec_filtfilt_fp_api#" MW_AT_LINE);
  ec_filtfilt_fp_api(prhs, outputs);
  // Copy over outputs to the caller.
  emlrtReturnArrays(1, &plhs[0], &outputs[0]);
  nvtxRangePop();
}

// End of code generation (_coder_ec_filtfilt_fp_mex.cu)
