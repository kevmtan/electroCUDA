//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_filtfilt_mex.cu
//
// Code generation for function '_coder_filtfilt_mex'
//

// Include files
#include "_coder_filtfilt_mex.h"
#include "_coder_filtfilt_api.h"
#include "filtfilt_data.h"
#include "filtfilt_initialize.h"
#include "filtfilt_terminate.h"
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
  mexAtExit(&filtfilt_atexit);
  nvtxMarkA("#filtfilt_initialize#" MW_AT_LINE);
  filtfilt_initialize();
  try {
    nvtxMarkA("#unsafe_filtfilt_mexFunction#" MW_AT_LINE);
    unsafe_filtfilt_mexFunction(nlhs, plhs, nrhs, prhs);
    nvtxMarkA("#filtfilt_terminate#" MW_AT_LINE);
    filtfilt_terminate();
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

void unsafe_filtfilt_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
                                 const mxArray *prhs[3])
{
  const mxArray *outputs[1];
  nvtxRangePushA("#fcn#unsafe_filtfilt_mexFunction#" MW_AT_LOCATION);
  // Check for proper number of arguments.
  if (nrhs != 3) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 3, 4, 8, "filtfilt");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 8,
                        "filtfilt");
  }
  // Call the function.
  nvtxMarkA("#filtfilt_api#" MW_AT_LINE);
  filtfilt_api(prhs, outputs);
  // Copy over outputs to the caller.
  emlrtReturnArrays(1, &plhs[0], &outputs[0]);
  nvtxRangePop();
}

// End of code generation (_coder_filtfilt_mex.cu)
