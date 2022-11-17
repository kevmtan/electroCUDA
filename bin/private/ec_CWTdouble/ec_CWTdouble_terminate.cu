//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTdouble_terminate.cu
//
// Code generation for function 'ec_CWTdouble_terminate'
//

// Include files
#include "ec_CWTdouble_terminate.h"
#include "_coder_ec_CWTdouble_mex.h"
#include "cwt.h"
#include "ec_CWTdouble_data.h"
#include "rt_nonfinite.h"
#include "MWMemoryManager.hpp"

// Function Definitions
void ec_CWTdouble_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  cwt_free();
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void ec_CWTdouble_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode),
                       (char_T *)cudaGetErrorString(errCode),
                       (char_T *)cudaGetErrorName(errCode),
                       (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  mwMemoryManagerTerminate();
}

// End of code generation (ec_CWTdouble_terminate.cu)
