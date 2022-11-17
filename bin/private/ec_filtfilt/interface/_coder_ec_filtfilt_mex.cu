//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_filtfilt_mex.cu
//
// Code generation for function '_coder_ec_filtfilt_mex'
//

// Include files
#include "_coder_ec_filtfilt_mex.h"
#include "ec_filtfilt.h"
#include "rt_nonfinite.h"
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
  mexAtExit(&ec_filtfilt_atexit);
  // Module initialization.
  ec_filtfilt_initialize();
  try {
    // Dispatch the entry-point.
    unsafe_ec_filtfilt_mexFunction(nlhs, plhs, nrhs, prhs);
    // Module termination.
    ec_filtfilt_terminate();
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           (void *)&emlrtExceptionBridge, "UTF-8", true);
  return emlrtRootTLSGlobal;
}

void unsafe_ec_filtfilt_mexFunction(int32_T nlhs, mxArray *plhs[1],
                                    int32_T nrhs, const mxArray *prhs[2])
{
  const mxArray *outputs[1];
  // Check for proper number of arguments.
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 2, 4, 11, "ec_filtfilt");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 11,
                        "ec_filtfilt");
  }
  // Call the function.
  ec_filtfilt_api(prhs, outputs);
  // Copy over outputs to the caller.
  emlrtReturnArrays(1, &plhs[0], &outputs[0]);
}

// End of code generation (_coder_ec_filtfilt_mex.cu)
