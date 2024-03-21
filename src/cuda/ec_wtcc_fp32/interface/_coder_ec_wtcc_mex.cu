//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_wtcc_mex.cu
//
// Code generation for function '_coder_ec_wtcc_mex'
//

// Include files
#include "_coder_ec_wtcc_mex.h"
#include "ec_wtcc.h"
#include "ec_wtcc_types.h"
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
  ec_wtccStackData *ec_wtccStackDataGlobal{nullptr};
  ec_wtccStackDataGlobal =
      static_cast<ec_wtccStackData *>(new ec_wtccStackData);
  mexAtExit(&ec_wtcc_atexit);
  // Module initialization.
  ec_wtcc_initialize();
  try { // Dispatch the entry-point.
    unsafe_ec_wtcc_mexFunction(ec_wtccStackDataGlobal, nlhs, plhs, nrhs, prhs);
    // Module termination.
    ec_wtcc_terminate();
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }
  delete ec_wtccStackDataGlobal;
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           (void *)&emlrtExceptionBridge, "UTF-8", true);
  return emlrtRootTLSGlobal;
}

void unsafe_ec_wtcc_mexFunction(ec_wtccStackData *SD, int32_T nlhs,
                                mxArray *plhs[2], int32_T nrhs,
                                const mxArray *prhs[6])
{
  const mxArray *outputs[2];
  int32_T b;
  // Check for proper number of arguments.
  if (nrhs != 6) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:WrongNumberOfInputsFAVDefaultValues", 5,
                        12, 6, 4, 7, "ec_wtcc");
  }
  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 7,
                        "ec_wtcc");
  }
  // Call the function.
  b_ec_wtcc_api(SD, prhs, nlhs, outputs);
  // Copy over outputs to the caller.
  if (nlhs < 1) {
    b = 1;
  } else {
    b = nlhs;
  }
  emlrtReturnArrays(b, &plhs[0], &outputs[0]);
}

// End of code generation (_coder_ec_wtcc_mex.cu)
