//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt_terminate.cu
//
// Code generation for function 'ec_filtfilt_terminate'
//

// Include files
#include "ec_filtfilt_terminate.h"
#include "_coder_ec_filtfilt_mex.h"
#include "ec_filtfilt_data.h"
#include "rt_nonfinite.h"
#include "MWMemoryManager.hpp"

// Function Definitions
void ec_filtfilt_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void ec_filtfilt_terminate()
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

// End of code generation (ec_filtfilt_terminate.cu)
