//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_cwtAvg_mex.cu
//
// Code generation for function '_coder_ec_cwtAvg_mex'
//

// Include files
#include "_coder_ec_cwtAvg_mex.h"
#include "ec_cwtAvg.h"
#include "ec_cwtAvg_types.h"
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
  ec_cwtAvgStackData *ec_cwtAvgStackDataGlobal{nullptr};
  ec_cwtAvgStackDataGlobal =
      static_cast<ec_cwtAvgStackData *>(new ec_cwtAvgStackData);
  mexAtExit(&ec_cwtAvg_atexit);
  // Module initialization.
  ec_cwtAvg_initialize();
  try { // Dispatch the entry-point.
    unsafe_ec_cwtAvg_mexFunction(ec_cwtAvgStackDataGlobal, nlhs, plhs, nrhs,
                                 prhs);
    // Module termination.
    ec_cwtAvg_terminate();
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }
  delete ec_cwtAvgStackDataGlobal;
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           (void *)&emlrtExceptionBridge, "UTF-8", true);
  return emlrtRootTLSGlobal;
}

void unsafe_ec_cwtAvg_mexFunction(ec_cwtAvgStackData *SD, int32_T nlhs,
                                  mxArray *plhs[2], int32_T nrhs,
                                  const mxArray *prhs[4])
{
  const mxArray *b_prhs[4];
  const mxArray *outputs[2];
  int32_T b;
  // Check for proper number of arguments.
  if (nrhs != 4) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 4, 4, 9, "ec_cwtAvg");
  }
  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 9,
                        "ec_cwtAvg");
  }
  // Call the function.
  b_prhs[0] = prhs[0];
  b_prhs[1] = prhs[1];
  b_prhs[2] = prhs[2];
  b_prhs[3] = prhs[3];
  ec_cwtAvg_api(SD, b_prhs, nlhs, outputs);
  // Copy over outputs to the caller.
  if (nlhs < 1) {
    b = 1;
  } else {
    b = nlhs;
  }
  emlrtReturnArrays(b, &plhs[0], &outputs[0]);
}

// End of code generation (_coder_ec_cwtAvg_mex.cu)
