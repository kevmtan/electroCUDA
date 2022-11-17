//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_CWTsingle_mex.cu
//
// Code generation for function '_coder_ec_CWTsingle_mex'
//

// Include files
#include "_coder_ec_CWTsingle_mex.h"
#include "ec_CWTsingle.h"
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
  mexAtExit(&ec_CWTsingle_atexit);
  // Module initialization.
  ec_CWTsingle_initialize();
  try {
    // Dispatch the entry-point.
    unsafe_ec_CWTsingle_mexFunction(nlhs, plhs, nrhs, prhs);
    // Module termination.
    ec_CWTsingle_terminate();
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

void unsafe_ec_CWTsingle_mexFunction(int32_T nlhs, mxArray *plhs[3],
                                     int32_T nrhs, const mxArray *prhs[5])
{
  const mxArray *outputs[3];
  int32_T b;
  // Check for proper number of arguments.
  if (nrhs != 5) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 5, 4, 12, "ec_CWTsingle");
  }
  if (nlhs > 3) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 12,
                        "ec_CWTsingle");
  }
  // Call the function.
  ec_CWTsingle_api(prhs, nlhs, outputs);
  // Copy over outputs to the caller.
  if (nlhs < 1) {
    b = 1;
  } else {
    b = nlhs;
  }
  emlrtReturnArrays(b, &plhs[0], &outputs[0]);
}

// End of code generation (_coder_ec_CWTsingle_mex.cu)
